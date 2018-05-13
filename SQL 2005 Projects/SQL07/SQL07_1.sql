CREATE DATABASE eShop 
ON(
Name='eShop_Data',
FILENAME='C:\eShop_data.mdf',
SIZE=20
)
LOG ON (
Name='eShop_Log',
FILENAME='C:\eShop_Log.ldf',
SIZE=10
)
GO
CREATE TABLE Orders(
OID INT IDENTITY PRIMARY KEY,
OD DATETIME DEFAULT GETDATE(),
CID INT,
CLOSED BIT DEFAULT 0
)
GO
CREATE TABLE Details(
OID INT,
PID INT,
QTY INT,
UP MONEY,
PRIMARY KEY (OID,PID)
)
GO
CREATE PROC GetOID @CID INT,@OID INT OUTPUT AS
	IF EXISTS(SELECT * FROM Orders
	WHERE CID=@CID AND CLOSED=0)
		SELECT @OID=OID FROM Orders
		WHERE CID=@CID AND CLOSED=0
	ELSE
		BEGIN 
			INSERT INTO Orders(CID)
			VALUES(@CID)
			SELECT @OID=OID FROM Orders
			WHERE CID=@CID AND CLOSED=0
		END	
	RETURN @@ERROR
GO
CREATE PROC BUY @CID INT,@PID INT,@QTY INT,@UP MONEY AS
BEGIN
	DECLARE @OID INT
	EXEC GetOID @CID,@OID OUTPUT
	INSERT INTO Details(OID,PID,QTY,UP)
	VALUES(@OID,@PID,@QTY,@UP)
	RETURN @@ERROR 
END
GO
EXEC BUY 1002,4002,4,$30

------------------------------------------
BEGIN TRAN
	INSERT INTO Orders(CID)
	VALUES(1004)
COMMIT TRAN
ROLLBACK TRAN

BEGIN TRAN
	INSERT INTO Orders(CID)
	VALUES(1004)
SAVE TRAN L0
	INSERT INTO Orders(CID)
	VALUES(1005)	
ROLLBACK TRAN L0
COMMIT TRAN

BEGIN TRAN 
	PRINT @@TRANCOUNT
	BEGIN TRAN
		PRINT @@TRANCOUNT
	COMMIT TRAN
	PRINT @@TRANCOUNT
	BEGIN TRAN
	SAVE TRAN L1
	BEGIN TRAN
	PRINT @@TRANCOUNT
	ROLLBACK TRAN L1	
	PRINT @@TRANCOUNT
	ROLLBACK TRAN
	PRINT @@TRANCOUNT

--------------------------------
CREATE TABLE Customers(
CID INT IDENTITY PRIMARY KEY,
BALANCE MONEY DEFAULT 0
)
GO
INSERT INTO Customers(BALANCE)
VALUES($50)
GO
DROP PROC BUY
GO
CREATE PROC BUY @CID INT,@PID INT,@QTY INT,@UP MONEY AS
BEGIN
	BEGIN TRAN
		DECLARE @OID INT
		EXEC GetOID @CID,@OID OUTPUT
		INSERT INTO Details(OID,PID,QTY,UP)
		VALUES(@OID,@PID,@QTY,@UP)
		UPDATE Customers SET BALANCE=BALANCE-(@QTY*@UP)
		DECLARE @B MONEY
		SELECT @B=BALANCE 
		FROM Customers
		WHERE CID=@CID
		IF @B<0
			ROLLBACK TRAN
		ELSE
			COMMIT TRAN
		RETURN @@ERROR 
END
GO
EXEC BUY 3,4002,1,$30

DECLARE  @ID INT
EXEC GETOID 3,@ID OUTPUT
SELECT @ID
----------------------------------------
DROP PROC BUY
GO
CREATE PROC BUY @CID INT,@PID INT,@QTY INT,@UP MONEY AS
BEGIN
	BEGIN TRAN
		DECLARE @OID INT
		EXEC GetOID @CID,@OID OUTPUT
		INSERT INTO Details(OID,PID,QTY,UP)
		VALUES(@OID,@PID,@QTY,@UP)
		IF EXISTS(SELECT c.cid,c.balance,
		o.oid,o.od
		FROM customers c INNER JOIN orders o
		ON c.CID=o.CID
		WHERE o.cid=@cid)
			COMMIT TRAN
		ELSE
			ROLLBACK TRAN
	RETURN @@ERROR 
END
GO
EXEC BUY 1002,4002,4,$30
EXEC BUY 3,4004,1,$30

CREATE TRIGGER tg_Customers ON customers FOR DELETE AS
	ROLLBACK TRAN
CREATE TRIGGER tg_Customers01 ON customers FOR UPDATE AS
	ROLLBACK
CREATE TRIGGER tg_Customers02 ON customers FOR INSERT,UPDATE,DELETE AS
	PRINT @@ROWCOUNT
DROP TRIGGER tg_Customers02

SELECT * FROM sys.triggers

DELETE Customers WHERE cid=3
INSERT INTO customers (BALANCE)
VALUES($90)

CREATE TRIGGER tg_00 ON customers FOR DELETE AS
	PRINT '00'
GO
CREATE TRIGGER tg_01 ON customers FOR DELETE AS
	PRINT '01'
GO
CREATE TRIGGER tg_02 ON customers FOR DELETE AS
	PRINT '02'
GO
DELETE Customers WHERE cid=7

sp_settriggerorder @triggername= 'tg_01', @order='First', @stmttype = 'DELETE';
sp_settriggerorder @triggername= 'tg_00', @order='last', @stmttype = 'DELETE';


--------------------------------
DROP PROC BUY

CREATE PROC BUY @CID INT,@PID INT,@QTY INT,@UP MONEY AS
BEGIN
		DECLARE @OID INT
		EXEC GetOID @CID,@OID OUTPUT
		INSERT INTO Details(OID,PID,QTY,UP)
		VALUES(@OID,@PID,@QTY,@UP)
		RETURN @@ERROR 
END
GO
EXEC BUY 1009,4002,4,$30

CREATE TRIGGER tg_Del ON Details FOR DELETE AS
	SELECT * FROM DELETED
DROP TRIGGER tg_Del

DELETE Details

CREATE TRIGGER tg_Del ON Customers FOR DELETE AS
	DELETE  FROM Orders
	WHERE CID IN( SELECT CID FROM DELETED )
SET IDENTITY_INSERT  customers ON
INSERT INTO customers(cid,balance)
VALUES(3,$60)