USE new
GO


BEGIN TRAN
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
GO
SELECT * FROM tbl10
SET TRANSACTION ISOLATION LEVEL READ COMMITTED