-- Scriptul este menit să fie rulat periodic de către SQL Agent.
-- La depășirea pragului setat, va trimite email pentru alertare.

-- Setează pragul de număr de pachete la care se declanșează alerta
DECLARE
  @threshold INT = 500;

DECLARE
  @statistica TABLE
              (
                from_service_name VARCHAR(MAX) NOT NULL,
                to_service_name   VARCHAR(MAX) NOT NULL,
                pachete_in_coada  INT          NOT NULL
              );

INSERT INTO @statistica (from_service_name, to_service_name, pachete_in_coada)
SELECT from_service_name,
       to_service_name,
       count(*) AS pachete_in_coada
FROM BizPharmaHO.sys.transmission_queue WITH (NOLOCK)
     -- Exclude locatiile inchise, in renovare, samd.:
WHERE BizPharmaHO.sys.transmission_queue.from_service_name NOT LIKE '%Depozit1%'
  AND BizPharmaHO.sys.transmission_queue.to_service_name NOT LIKE '%Depozit1%'
  AND BizPharmaHO.sys.transmission_queue.from_service_name NOT LIKE '%Mamaia%'
  AND BizPharmaHO.sys.transmission_queue.to_service_name NOT LIKE '%Mamaia%'
  AND BizPharmaHO.sys.transmission_queue.from_service_name NOT LIKE '%Eden2%'
  AND BizPharmaHO.sys.transmission_queue.to_service_name NOT LIKE '%Eden2%'
GROUP BY to_service_name, from_service_name
HAVING count(*) >= @threshold;

DECLARE
  @mesaj VARCHAR(8000) = '<h3>Status cozi de mesaje la data de ' + CONVERT(VARCHAR(24), GETDATE(), 113) +
                         '<h3><table style="border-collapse:collapse;" border="1">' +
                         '<thead><tr><th>from</th><th>to</th><th>pachete</th></tr></thead><tbody>';
DECLARE
  @from VARCHAR(100);
DECLARE
  @to VARCHAR(100);
DECLARE
  @packets VARCHAR(100);

DECLARE c CURSOR FOR
  SELECT from_service_name, to_service_name, pachete_in_coada
  FROM @statistica
  ORDER BY pachete_in_coada DESC;

OPEN c;

FETCH NEXT FROM c INTO @from, @to, @packets;

WHILE @@FETCH_STATUS = 0
BEGIN
  -- WARN: Escape unsafe HTML/XML characters from data!
  SET @mesaj += ('<tr><td>' + (SELECT @from FOR XML PATH ('')) + '</td><td>' + (SELECT @to FOR XML PATH ('')) +
                 '</td><td>' + (SELECT @packets FOR XML PATH ('')) + '</td></tr>');
  FETCH NEXT FROM c INTO @from, @to, @packets;
END

CLOSE c;
DEALLOCATE c;

SET @mesaj += '</tbody></table>';

DECLARE
  @tripped_count INT;

SELECT @tripped_count = count(*)
FROM @statistica;

IF @tripped_count > 0
  EXEC msdb.dbo.sp_send_dbmail
       @profile_name = 'Verificare replicari', -- numele profilului de dbmail (trebuie creat anterior)
       @recipients='it@minifarm.ro;contabilitate@minifarm.ro',
       @subject='Alertă replicări Scraps',
       @body=@mesaj,
       @body_format='HTML';
GO