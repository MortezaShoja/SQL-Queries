SELECT * FROM sysobjects WHERE type='u'

IF  OBJECT_ID('phones') IS NOT NULL
	DROP TABLE phones
GO
CREATE TABLE Phones(
Family VARCHAR(50) NOT NULL,
Name VARCHAR(50) NOT NULL,
Phone VARCHAR(50) DEFAULT '+9821',
PRIMARY KEY(family,[name]))
PRINT OBJECT_ID('phones')

SELECT [name],OBJECT_ID(QUOTENAME([name],''''))
FROM sysobjects WHERE type='u'