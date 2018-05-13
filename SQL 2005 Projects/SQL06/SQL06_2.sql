CREATE VIEW p_s WITH ENCRYPTION AS
SELECT p.title,s.pid,s.sid
FROM products p INNER JOIN 
Sales s 
ON p.pid=s.pid
-----------------------------
CREATE VIEW vw_d  AS
SELECT * FROM products 
WHERE title LIKE '%d%'WITH CHECK OPTION 
GO 
SELECT * FROM  vw_d 

INSERT INTO vw_d VALUES(9,'sample')
INSERT INTO vw_d VALUES(9,'sampled')

USE adventureworks
GO

DROP VIEW vw_i
GO

CREATE VIEW vw_i WITH SCHEMABINDING AS
SELECT p.productid,p.[name],SUM(orderqty)'Sum',COUNT_BIG(*)'Count'
FROM production.product p
INNER JOIN sales.salesorderdetail s
ON p.productid=s.productid
GROUP BY p.productid,p.[name]

SELECT * FROM vw_i

CREATE UNIQUE CLUSTERED INDEX IX_p ON vw_i([name])

CREATE TABLE sampletbl(id INT PRIMARY KEY,title VARCHAR (50)NULL)
GO
ALTER TABLE sampletbl ADD CONSTRAINT uq_title UNIQUE(title)
INSERT INTO sampletbl VALUES(1,'new')
INSERT INTO sampletbl VALUES(2,'new')

INSERT INTO sampletbl VALUES(3,NULL)
INSERT INTO sampletbl VALUES(2,'new')
DROP TABLE tbl
CREATE TABLE tbl(id INT,title VARCHAR(50) NULL)
GO
CREATE VIEW vw_uq WITH SCHEMABINDING AS
SELECT t.id,t.title 
FROM dbo.tbl t
WHERE title IS NOT NULL
GO
CREATE UNIQUE CLUSTERED INDEX IX_uq ON vw_uq(title)
GO

INSERT INTO tbl VALUES(1,NULL)
INSERT INTO tbl VALUES(2,NULL)
INSERT INTO tbl VALUES(5,'sample00')
INSERT INTO tbl VALUES(6,'sample01')

SELECT * FROM vw_uq

SELECT productid,[name],color INTO MyProducts
FROM adventureworks.production.product

CREATE PROC P_Del AS
DELETE Myproducts
WHERE productid=1

EXEC P_Del 

CREATE PROC myp_Del @pid INT AS
BEGIN
	DELETE myproducts 
	WHERE productid=@pid
	RETURN @@ERROR
END

EXEC myp_del 3

SELECT * FROM sysobjects WHERE  name='myp_Del'

CREATE PROC GetInfo @pid INT AS
SELECT p.productid,p.[name],sum(s.orderqty)
FROM adventureworks.production.product p
INNER JOIN adventureworks.sales.salesorderdetail s
ON p.productid=s.productid
WHERE p.productid=@pid
GROUP BY p.productid,p.[name]

EXEC GetInfo 777

CREATE PROC usp_order @param SYSNAME AS
SELECT 
	CASE @param
	WHEN color THEN	
	productid ,[name],color
	FROM adventureworks.production.product ORDER BY color
	WHEN name THEN 
	productid ,[name],color
	FROM adventureworks.production.product ORDER BY name
	END
DROP PROC usp_order

CREATE PROC usp_order @param SYSNAME AS
BEGIN
SELECT 	productid ,[name],color
	FROM adventureworks.production.product
	ORDER BY
	CASE @param 
	WHEN 'color' THEN
	CAST(@param AS SQL_VARIANT)
	WHEN 'name' THEN
	CAST(@param AS SQL_VARIANT)
	END	
END



EXEC usp_order 'Color'

CREATE PROC usp_order @param SYSNAME AS
	SELECT productid,[name],color
	FROM adventureworks.production.product
	ORDER BY CASE @param
	WHEN 'Name' THEN CAST(@param AS SQL_VARIANT)
	WHEN 'Color' THEN CAST(@param AS SQL_VARIANT)
	END


DROP PROC usp_sort

CREATE PROC usp_sort @o CHAR(1) AS
BEGIN
IF @o<>'A' AND @o<>'D'
BEGIN
	RAISERROR('Invalid out Put !',16,1)
	RETURN -1
END
ELSE
BEGIN
IF @o='A'
SELECT * FROM myproducts
ORDER BY [name] 
ELSE
SELECT * FROM myproducts
ORDER BY [name] DESC


END
END

EXEC usp_sort 'B'
DROP PROC usp_order
CREATE PROC usp_order @param VARCHAR(MAX) AS
BEGIN
	IF @param='Name'
		SELECT * FROM myproducts
		ORDER BY [name]
		RETURN 0
	IF @param='Color'
		SELECT * FROM myproducts
		ORDER BY color
	ELSE
		SELECT * FROM myproducts	
END
DECLARE @i INT
EXEC @i=usp_order 'Name'
PRINT CAST(@i AS VARCHAR(20))

DROP PROC GetSum

CREATE PROC GetSum @pid INT,@c INT OUTPUT AS
BEGIN
	SELECT @c=SUM(orderqty)
	FROM production.product p 
	INNER JOIN sales.salesorderdetail s
	ON p.productid=s.productid
	WHERE p.productid=@pid
	GROUP BY p.productid
	RETURN @@ERROR
END

DECLARE @count INT
DECLARE  @e INT
EXEC @e=GetSum  777,@count OUTPUT 
PRINT @count

SELECT TOP 29 * INTO Nested FROM myproducts

DROP PROC Ins_Nested
-----------------------------------------------------------------
CREATE PROC Ins_Nested @n VARCHAR(50),@c VARCHAR(50) AS
BEGIN
	DECLARE @c2 INT
	EXEC GetBound @c2 OUTPUT
	IF @c2<31
		BEGIN
			INSERT INTO nested ([name],color)
			VALUES(@n,@c)
			IF @@ROWCOUNT >0
				RETURN 0
			ELSE
				BEGIN
					RAISERROR('Fail !',16,1)
					RETURN -1
				END	
		END
	ELSE
		BEGIN 
			RAISERROR('Full Of Products !',16,1)
			RETURN -1
		END
END

SELECT COUNT(*) FROM nested

DECLARE @e INT
EXEC @e= Ins_Nested 'newp','green'
PRINT CAST (@e AS VARCHAR(50))

CREATE PROC GetBound @count INT OUTPUT AS
BEGIN
	SELECT @count=COUNT(productid) FROM nested	
	RETURN @@ERROR
END

DECLARE @c INT
EXEC GetBound @c OUTPUT
PRINT CAST(@c AS VARCHAR(50))