SELECT s.*,m.*
FROM student s LEFT OUTER JOIN 
mark m ON  s.sid=m.sid
LEFT OUTER JOIN course c
ON m.cid=c.cid
---------------------------------------
WITH tbl AS(SELECT student.*,mark.mark,mark.cid
FROM student LEFT OUTER JOIN mark
ON student.sid=mark.sid)
SELECT tbl.*,c.* FROM tbl
LEFT OUTER  JOIN course c
ON tbl.cid=c.cid
---------------------------------------
WITH samplesearch AS (SELECT * FROM production.product 
WHERE [name] LIKE 'f%')
SELECT TOP 10 PERCENT * FROM  samplesearch
----------------------------------------
SELECT m.*,c.* FROM 
mark m RIGHT OUTER JOIN course c
ON m.cid=c.cid
-----------------------------
SELECT s.sid,s.family,s.[name],
CASE 
WHEN city='TEHRAN' THEN 'LOCAL'
WHEN city IS NULL THEN 'nothing'
ELSE city --'Not Around Here !'
END 'city'
FROM student s

-----------------------------
WITH tbl AS(
SELECT p.productid,p.[name],
CASE 
WHEN color='Red' THEN 'red product'
WHEN color IS NULL THEN 'no color'
ELSE color
END 'mycolor'
FROM production.product p)

SELECT mycolor,COUNT(mycolor)
FROM tbl GROUP BY mycolor

--SELECT * FROM tbl WHERE mycolor='no color'
-------------------------------------
SELECT s.*,m.*
FROM student s LEFT OUTER JOIN mark m
ON s.sid=m.sid

WITH tbl AS (SELECT s.sid,s.family,s.[name],s.city
,m.sid 'New SID',m.mark,m.cid
FROM student s LEFT OUTER JOIN mark m
ON s.sid=m.sid)
SELECT * FROM tbl

------------------------
SELECT  [name],productid,productnumber  'pn'
FROM production.product
--WHERE pn LIKE 'A%'
ORDER BY pn

-------------------------------------

SELECT m.*,c.*
FROM mark m LEFT OUTER JOIN 
course c ON m.cid=c.cid AND m.grp=c.grp

-----------------------------------------------
SELECT e.*,m.*
FROM employee e LEFT OUTER JOIN employee m
ON e.mid=m.eid

------------------------------------------------
SELECT * FROM production.product p
WHERE EXISTS(SELECT * FROM sales.salesorderdetail  o
WHERE o.productid=p.productid)

IF  EXISTS(SELECT 1 / 0) PRINT 'No calculation'

SELECT p.* ,o.* FROM production.product p
INNER JOIN sales.salesorderdetail o
ON p.productid=o.productid

DECLARE @I INT,@J  INT
SET @I=12
SET @J=9
WHILE (@I % @J !=0)
BEGIN
	DECLARE @T INT
	SELECT @T=@I
	SET @I=@J
	SET @J=@T % @J
END
PRINT CAST(@J AS VARCHAR(50))
