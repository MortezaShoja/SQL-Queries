SELECT * FROM sysobjects WHERE type='u'

DECLARE @t TABLE(id INT,title VARCHAR(50))
INSERT INTO @t VALUES(1,'new01')
INSERT INTO @t VALUES(2,'new02')
INSERT INTO @t VALUES(3,'new03')
INSERT INTO @t VALUES(4,'new04')
SELECT * FROM @t

IF OBJECT_ID('phones') IS NOT NULL 
	DROP TABLE phones
GO
CREATE TABLE Phones(
Family VARCHAR(50) NOT NULL,
Name VARCHAR(50) NOT NULL,
Phone VARCHAR(50) DEFAULT '+9821',
PRIMARY KEY(family,[name]))

ALTER TABLE phones  DROP CONSTRAINT PK__Phones__1273C1CD
ALTER TABLE phones DROP COLUMN [name]
ALTER TABLE phones ALTER COLUMN family VARCHAR(10)

SELECT * FROM [newdb].[dbo].[phones]

SELECT * FROM sys.master_files

CREATE TABLE Students(
SID INT IDENTITY PRIMARY KEY,
Family VARCHAR(50),
Name VARCHAR(50)
)
 INSERT INTO students(family,name)VALUES('01','01')
 INSERT INTO students(family,name)VALUES('02','02')

SELECT * FROM students

CREATE VIEW vw_students AS
SELECT sid 'Student Number',family + '  ' + name 'Info'
FROM students

SELECT * FROM vw_students