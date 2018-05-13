CREATE PROC GetInfo @tbl VARCHAR(50) AS
EXEC sp_spaceused @tbl

EXEC GetInfo 'Students'

CREATE PROC GetRecords @tbl VARCHAR(50) AS
EXEC('SELECT * FROM '+@tbl)

GetRecords 'Students'
GetRecords 'Marks'

CREATE PROC Run @cmd VARCHAR(50) AS
EXEC(@cmd)

Run 'SELECT * FROM sysobjects'
Run 'DROP TABLE Students'

DECLARE @name VARCHAR(50)
SELECT TOP 1 @name=name 
FROM Production.product
PRINT @name

-------------------------------

DECLARE c CURSOR FOR
SELECT name 
FROM sysobjects 
WHERE type='u'

DECLARE @n VARCHAR(50)
OPEN  c
FETCH NEXT FROM c INTO @n 
EXEC('sp_spaceused '+@n)
WHILE @@FETCH_STATUS=0
BEGIN
FETCH NEXT FROM c INTO @n 
EXEC('sp_spaceused '+@n)	
END
CLOSE c
DEALLOCATE c



