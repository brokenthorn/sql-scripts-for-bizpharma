use BizPharmaHO;
GO

-- Cauta reteta:
select L.Nume,
       R.*
from CasReteta R
       join Locatie L on R.IdLocatie = L.IdLocatie
where NumarReteta = '2741'
  and SerieReteta = 'NTLGCF';
GO

-- Cauta eliberarea:
declare
  @IdCasReteta int,
  @IdLocatie   int;

select top 1 @IdLocatie = R.IdLocatie,
             @IdCasReteta = R.IdCasReteta
from CasReteta R
where NumarReteta = '2741'
  and SerieReteta = 'NTLGCF';

select L.Nume, E.*
from CasEliberare E
       join Locatie L on E.IdLocatie = L.IdLocatie
where E.IdCasReteta = @IdCasReteta
  and E.IdLocatie = @IdLocatie;
GO