SELECT * INTO MySampleProducts 
FROm production.product

SELECT COUNT(*) FROM MySampleProducts 
WHERE name LIKE 'p%'

CREATE PROC DEL @Begin CHAR(1) AS
	BEGIN 
		DECLARE @Count INT
		SELECT @Count=COUNT(*)
		FROM MySampleProducts  
		WHERE name LIKE @Begin+'%'

		DELETE MySampleProducts 
		WHERE name LIKE @Begin+'%'

		DECLARE @e INT,@rc INT

		SELECT @rc=@@ROWCOUNT,@e=@@ERROR
		
		IF @e=0 AND @rc=@Count
			PRINT 'Successfull'
		ELSE
			PRINT 'Error Occured !'
	END

EXEC DEL 'd'

DROP PROC DEl

SELECT 1/0
PRINT 'Err'

SELECT 'p'+10
PRINT 'Err'

CREATE PROC Sample @I INT,@J INT AS
BEGIN
	BEGIN TRY
		PRINT CAST((@I/@J) AS VARCHAR(MAX))
	END TRY
		
	BEGIN CATCH
		--PRINT 'Error'
		SELECT ERROR_PROCEDURE() 'ERR_PR'
	END CATCH
END

DROP PROC sample

EXEC sample 10,0
EXEC sample 10,2

USE MASTER 
GO
SELECT * FROM sys.messages
SELECT COUNT_BIG(*) FROM sys.messages
INSERT INTO sys.messages VALUES(90000,1033,16,0,'new')
DELETE sys.messages WHERE text LIKE 'sample'

