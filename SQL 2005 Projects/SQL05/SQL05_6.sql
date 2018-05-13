CREATE TABLE products(ID INT IDENTITY PRIMARY KEY
,Title  VARCHAr(50))
GO
CREATE TABLE sales(SID INT IDENTITY PRIMARY KEY,pid INT,qty INT)
GO
INSERT INTO products (title)VALUES('cd')
INSERT INTO products (title)VALUES('dvd')

INSERT INTO sales (pid,qty)VALUES(1,3)
INSERT INTO sales (pid,qty)VALUES(1,2)
INSERT INTO sales (pid,qty)VALUES(2,3)
INSERT INTO sales (pid,qty)VALUES(2,2)

CREATE VIEW vw AS
SELECt products.id,products.title,sales.sid,sales.qty
FROM products INNER JOIN sales
ON sales.pid=products.id

SELECT * FROM vw
UPDATE vw SET id=4 WHERE sid=1