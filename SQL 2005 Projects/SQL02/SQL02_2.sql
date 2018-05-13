SELECT productid,[name] FROM production.product
SELECT ROW_NUMBER() OVER (ORDER BY [name]),[name] 
FROM production.product
PRINT DATEPART(mm,GETDATE())
SELECT * FROM humanresources.employee
SELECT row_number() OVER (ORDER BY DATEPART(mm,hiredate)),
employeeid,title,hiredate
FROM humanresources.employee
SELECT * FROM production.product
WHERE [name] LIKE'%\[]%' ESCAPE '\'
SELECT * FROM sales.salesorderdetail
ORDER BY productid
-----------------------------------------------

SELECT TOP  10 PERCENT ROW_NUMBER() OVER (ORDER BY SUM(orderqty) DESC),productid
,SUM(orderqty) 'Sum'
FROM sales.salesorderdetail
GROUP BY productid

SELECT TOP 10 ROW_NUMBER() OVER (ORDER BY unitprice),[name],unitprice
FROM production.product

SELECT * FROM 

SELECT TOP 10 * FROM production.product
ORDER BY [name]

SELECT TOP 10 ROW_NUMBER() OVER (ORDER BY   unitprice DESC), productid 
,unitprice FROM sales.salesorderdetail

SELECT DISTINCT productid FROM sales.salesorderdetail

--ORDER BY SUM(orderqty)

SELECT ROW_NUMBER() OVER (ORDER BY SUM(orderqty)) productid,SUM(orderqty)'sum'
FROM sales.salesorderdetail
GROUP BY productid
HAVING SUM(orderqty)<100

-------------------------------
SELECT productid,SUM(orderqty)'Sum',
--CAST(SUM(orderqty) AS VARCHAR(50))+' Times Saled'
CONVERT(VARCHAR(50),SUM(orderqty))+' Times Saled'
FROM sales.salesorderdetail
GROUP BY productid
----------------------------------
SELECT employeeid,CAST(DATEPART(yy,hiredate)-621 AS VARCHAR(50))+'/'+
CAST(DATEPART(mm,hiredate)-3 AS VARCHAR(50))+'/'+
CAST(DATEPART(dd,hiredate)-10 AS VARCHAR(50)) AS 'Persian Date'
FROM humanresources.employee
--------------------------------------
SELECT [name]
FROM production.product
WHERE productid IN(SELECT DISTINCT productid FROM sales.salesorderdetail)

SELECT [name]
FROM production.product
WHERE productid NOT IN(
SELECT DISTINCT productid FROM sales.salesorderdetail)

