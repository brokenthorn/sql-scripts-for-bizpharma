-- numar de carduri vip
-- cate carduri au fost folosite in ultimele 3 luni cel putin 1 data

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT count(DISTINCT C.NumarCard) AS CarduriUniceFolosite,
       (SELECT count(NumarCard) FROM Carduri WHERE NumeSerie = 'Black 50 temporare') as NumarCarduri
FROM CardXOperatie CXO
         JOIN Carduri C ON CXO.NumarCard = C.NumarCard
WHERE C.NumeSerie = 'Black 50 temporare'
  AND CXO.DataOperatie BETWEEN (GETDATE() - 90) AND GETDATE()