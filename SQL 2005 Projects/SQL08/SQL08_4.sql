CREATE VIEW s_m AS
SELECT s.sid,s.family,s.name,s.city,m.cid,m.mark
FROM students s INNER JOIN marks m ON
s.sid=m.sid

CREATE TRIGGER TG_INS_s_m ON s_m INSTEAD OF INSERT AS
INSERT INTO students(sid,family,name,city)
SELECT sid,family,name,city FROM INSERTED

INSERT INTO marks(sid,cid,mark)
SELECT sid,cid,mark FROM INSERTED

