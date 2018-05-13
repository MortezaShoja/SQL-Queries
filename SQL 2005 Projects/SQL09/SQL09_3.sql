CREATE VIEW Available_Records AS
	SELECT * FROM MySampleProducts
	WHERE deleted=0

CREATE VIEW Deleted_Records AS
	SELECT * FROM MySampleProducts
	WHERE deleted=1

CREATE TRIGGER TGI_DEL ON MySampleProducts INSTEAD OF DELETE AS
	UPDATE MySampleProducts
	SET Deleted=1
	WHERE productid IN(
	SELECT productid 
	FROM DELETED)

DELETE MySampleProducts WHERE name LIKE 's%'

SELECT * FROM Available_Records
SELECT * FROM Deleted_Records

SELECT * INTO MyOrders FROM sales.salesorderdetail

CREATE VIEW P_O AS
	SELECT p.productid,p.name,
	o.orderqty
	FROM mysampleproducts p INNER JOIN 
	MyOrders o 
	ON p.productid=o.productid

SELECT * FROM P_O

CREATE TRIGGER TG_INS_P_O ON P_O INSTEAD OF INSERT AS
	INSERT INTO MySampleProducts(productid,name)
	SELECT productid,
	[name] FROM INSERTED

	INSERT INTO MyOrders(productid,orderqty)
	SELECT productid,orderqty
	FROM INSERTED

SELECT * FROM mysampleproducts WHERE productid=1000

SELECT * FROM myorders WHERE productid=1000

CREATE TRIGGER TG_DEL_P_O ON P_O INSTEAD OF DELETE AS
	DELETE mysampleproducts
	WHERE productid IN(SELECT productid FROM DELETED)

	DELETE MyOrders
	WHERE productid IN(SELECT productid FROM DELETED)



