DECLARE @distance INT
DECLARE @gasite INT
DECLARE @maxDistance INT = 10
DECLARE @id1 INT
	,@id2 INT
	,@cod1 VARCHAR(50)
	,@cod2 VARCHAR(50)
	,@nume1 NVARCHAR(150)
	,@nume2 NVARCHAR(150)
	,@frac1 INT
	,@frac2 INT
DECLARE @rezultate TABLE (
	id1 INT
	,Cod1 VARCHAR(50)
	,Nume1 NVARCHAR(150)
	,frac1 INT
	,id2 INT
	,Cod2 VARCHAR(50)
	,Nume2 NVARCHAR(150)
	,frac2 INT
	,Distance INT
	)

DECLARE @cursorArticoleDubluri CURSOR SET @cursorArticoleDubluri = CURSOR
FOR
SELECT a.IdArticol
	,Cod
	,CASE 
		WHEN LEN(Nume) < 5
			THEN Nume
		ELSE LEFT(Nume, LEN(Nume) - 5)
		END AS Nume
	,p.CantNrBuc
FROM Articol a WITH (NOLOCK)
INNER JOIN Produs p WITH (NOLOCK) ON a.IdArticol = p.IdArticol
WHERE Nume LIKE '%[[]IVT]'

OPEN @cursorArticoleDubluri

FETCH NEXT
FROM @cursorArticoleDubluri
INTO @id1
	,@cod1
	,@nume1
	,@frac1

WHILE @@FETCH_STATUS = 0
BEGIN
	--Fara declarare aici a cursorului, nesting-ul cursorilor eroneaza variabila @@FETCH_STATUS pentru ca e globala.
	--Asa este rescrisa la sfarsitul fiecarui loop, de run-ul buclei care se termina,
	--practic evitand eronarea ei atunci cand ea trebuie verificata.
	DECLARE @cursorArticoleCorecte CURSOR SET @cursorArticoleCorecte = CURSOR
	FOR
	SELECT a.IdArticol
		,Cod
		,Nume
		,p.CantNrBuc
	FROM Articol a WITH (NOLOCK)
	INNER JOIN Produs p WITH (NOLOCK) ON a.IdArticol = p.IdArticol
	WHERE Nume NOT LIKE '%[[]IVT]'

	OPEN @cursorArticoleCorecte

	FETCH NEXT
	FROM @cursorArticoleCorecte
	INTO @id2
		,@cod2
		,@nume2
		,@frac2

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Incetineste query-ul, este doar de debugging:
		--print 'Comparing ' + @nume1 + ' <<>> ' + @nume2

		SELECT @distance = dbo.Levenshtein(@nume1, @nume2, @maxDistance)

		SET NOCOUNT ON

		IF @distance IS NOT NULL
			INSERT INTO @rezultate (
				id1
				,cod1
				,nume1
				,frac1
				,id2
				,cod2
				,nume2
				,frac2
				,distance
				)
			VALUES (
				@id1
				,@cod1
				,@nume1
				,@frac1
				,@id2
				,@cod2
				,@nume2
				,@frac2
				,@distance
				)

		SET NOCOUNT OFF

		FETCH NEXT
		FROM @cursorArticoleCorecte
		INTO @id2
			,@cod2
			,@nume2
			,@frac2
	END

	CLOSE @cursorArticoleCorecte

	DEALLOCATE @cursorArticoleCorecte

	FETCH NEXT
	FROM @cursorArticoleDubluri
	INTO @id1
		,@cod1
		,@nume1
		,@frac1

	SELECT @gasite = count(*)
	FROM @rezultate

	PRINT cast(@gasite AS VARCHAR(20)) + ' rezultate pana acum.'
		--if @gasite > 0 select * from @rezultate
END

CLOSE @cursorArticoleDubluri

DEALLOCATE @cursorArticoleDubluri

SELECT *
FROM @rezultate
