CREATE VIEW s_m AS
SELECT s.sid,s.family,s.name,s.city,m.cid,m.mark
FROM students s INNER JOIN marks m ON
s.sid=m.sid

CREATE TRIGGER TG_INS_s_m ON s_m INSTEAD OF INSERT AS
INSERT INTO students(sid,family,name,city)
SELECT sid,family,name,city FROM INSERTED

INSERT INTO marks(sid,cid,mark)
SELECT sid,cid,mark FROM INSERTED

CREATE TRIGGER TG_DEL_s_m ON s_m INSTEAD OF DELETE AS

BEGIN
DECLARE @sid nchar (10)
DECLARE @cid nchar (10)
SELECT @sid=sid FROM DELETED
SELECT @cid=cid FROM DELETED
DELETE students
WHERE sid =@sid

DELETE marks
WHERE sid =@sid
AND cid=@cid
END
DROP TRIGGER TG_DEL_s_m

DELETE s_m WHERE sid=1001