SELECT * FROM phones
USE master
SELECT * FROM sysdatabases
USE sql2005
GO
SELECT * FROM sysobjects
--WHERE name='phones'
WHERE type='u'

--------------------
DELETE phones
WHERE row=1
SELECT * FROM phones

TRUNCATE TABLE phones



DELETE mynewsales

TRUNCATE TABLE MyNewSales1

SELECT * INTO SQLProducts
FROM production.product
SELECT * FROM SQLProducts

SELECT * INTO daily
FROM humanresources.employee
WHERE  hiredate<GETDATE()

SELECT * FROM daily

SELECT * INTO MyProductionProduct
FROM production.product

SELECT * INTO MySalesorderdetail
FROM sales.salesorderdetail

ALTER TABLE MySalesorderdetail ADD CONSTRAINT pk_O PRIMARY KEY (SalesOrderID,SalesOrderDetailID)


DELETE MyProductionProduct
WHERE productid NOT IN (SELECT DISTINCT productid FROM MySalesorderdetail)

USE sql2005
GO

SET IDENTITY_INSERT phones ON
INSERT INTO phones(row,family,[name],phone)
VALUES(4,'ramezani','shahram','0912')

SELECT * FROM phones


INSERT INTO tbl SELECT productid,[name],color
FROM production.product

SELECT * FROM tbl

INSERT INTO phones (row,family,[name])VALUES(1,'ramezani','shahram')