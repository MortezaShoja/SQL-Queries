SELECT 'SELECT * FROM '+[name]+'.dbo.sysobjects WHERE type=''u''' 
FROM sysdatabases


SELECT 'SELECT * FROM '+[name]+'.dbo.sysobjects WHERE type=''u'' UNION ' 
FROM sysdatabases
------------------------------------------------------

CREATE DATABASE db06
ON(
NAME='db06_DATA',
FILENAME='C:\db06.mdf',
SIZE=20,
MAXSIZE=UNLIMITED
)
LOG ON(
NAME='db06_LOG',
FILENAME='C:\db06.ldf',
SIZE=10,
MAXSIZE=UNLIMITED
)
USE db06
GO
GO
CREATE TABLE Products(
PID INT PRIMARY KEY,
Title VARCHAR(50))
GO
INSERT INTO Products VALUES(1,'CD')
INSERT INTO Products VALUES(2,'DVD')
CREATE TABLE Sales(
SID INT NOT NULL,
PID INT NOT NULL,
PRIMARY KEY(SID,PID))
GO
INSERT INTO Sales VALUES(1001,1)
INSERT INTO Sales VALUES(1001,2)
INSERT INTO Sales VALUES(1002,1)
INSERT INTO Sales VALUES(1002,2)
GO
CREATE VIEW vw_PS AS
SELECT p.title,s.sid,s.pid
FROM products p FULL OUTER JOIN 
Sales s ON p.pid=s.pid
GO
SELECT * FROM vw_PS

UPDATE vw_ps SET title= 'flopy' WHERE sid=1001 AND pid=1
GO
SELECT * FROM vw_ps
GO

------------------------------------------------------

DELETE vw_ps WHERE pid=1
USE  adventureworks
GO
CREATE VIEW vw_o AS
SELECT TOP 100 PERCENT [name],productid
FROM production.product
ORDER BY [name]
SELECT * FROM vw_o ORDER BY [name]

-----------------------------------------------------
USE db06
GO
CREATE VIEW vw_SCHEMABINDING WITH SCHEMABINDING AS
SELECT s.pid,s.sid,s.new
FROM dbo.Sales s

ALTER TABLE sales DROP COLUMN new

