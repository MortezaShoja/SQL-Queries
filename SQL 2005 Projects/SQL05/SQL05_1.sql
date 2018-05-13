CREATE DATABASE newdb
ON(
FILENAME='C:\newdb_data.mdf',
NAME='newdb_data',
SIZE=10,
MAXSIZE=UNLIMITED,
FILEGROWTH=5
)
LOG ON(
FILENAME='C:\newdb_log.ldf',
NAME='newdb_log',
SIZE=5,
MAXSIZE=10,
FILEGROWTH=2
)
USE newdb
GO
CREATE TABLE Phones(
Family VARCHAR(50) NOT NULL,
Name VARCHAR(50) NOT NULL,
Phone VARCHAR(50) DEFAULT '+9821',
PRIMARY KEY(family,[name]))
ALTER TABLE Phones ADD CONSTRAINT pk_phones PRIMARY KEY(family,[name])
SP_HELP phones

CREATE TABLE ##sample(
tid INT IDENTITY PRIMARY KEY,
title VARCHAR(50)
)
GO
INSERT INTO ##sample(title)VALUES('new record2')
SELECT * FROM ##sample

SELECT * FROM sysobjects WHERE type='u'