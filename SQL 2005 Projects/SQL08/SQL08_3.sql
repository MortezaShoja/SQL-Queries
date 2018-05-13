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