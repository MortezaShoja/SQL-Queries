SELECT productid,[name],'color: ' + ISNULL(color,'No Color')
FROM mynewproducts
SELECT SUM(ISNULL(unitprice,1))
FROM mynewproducts

SELECT COUNT(*) FROM mynewproducts 

SELECT * FROM mynewproducts 

UPDATE mynewproducts
SET [name]='new name1',
Color='red'
WHERE [name]='new name'

UPDATE mynewproducts
SET unitprice=1
WHERE unitprice IS NULL

UPDATE mynewproducts 
SET unitprice=2
WHERE unitprice IS  NULL

SELECT * FROM mynewproducts 
WHERE [name] LIKE '[^a,f]%'

TRUNCATE TABLE mynewproducts

INSERT INTO mynewproducts([name],color,unitprice)
VALUES('newp2','red',$10)

SELECT * FROM mynewproducts 
DELETE mynewproducts
WHERE productid>6

DELETE mynewproducts 

DBCC CHECKIDENT('mynewproducts',NORESEED)

SELECT mp.*,nd.*,p.*
FROM mynewproducts mp CROSS JOIN
newd nd CROSS JOIN marks p

SELECT * INTO jProducts
FROM production.product

SELECT * INTO jDetails
FROM sales.salesorderdetail

SELECT * FROM  jDetails
DELETE jProducts WHERE productid=776

SELECT jproducts.*,jdetails.*
FROM jproducts RIGHT JOIN jdetails
ON jproducts.productid=jdetails.productid

DELETE jdetails WHERE productid=777


SELECT jproducts.*,jdetails.*
FROM jproducts LEFT JOIN jdetails
ON jproducts.productid=jdetails.productid
WHERE jproducts.productid=777


SELECT jproducts.*,jdetails.*
FROM jproducts  FULL OUTER JOIN jdetails
ON jproducts.productid=jdetails.productid

SELECT * FROM jdetails
WHERE productid=777

SELECT jproducts.*,jdetails.*
FROM jproducts LEFT JOIN jdetails
ON jproducts.productid=jdetails.productid
WHERE jproducts.productid=777

SELECT jproducts.*,jdetails.*
FROM jproducts RIGHT JOIN jdetails
ON jproducts.productid=jdetails.productid
WHERE jdetails.productid=776

SELECT jproducts.*,jdetails.*
FROM jproducts FULL OUTER  JOIN jdetails
ON jproducts.productid=jdetails.productid
WHERE jdetails.productid=776 OR jproducts.productid=777
