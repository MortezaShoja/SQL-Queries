begin tran
set transaction isolation level repeatable read
--update tbl 
--set name='sample10' where name='sample10'
select * from tbl
commit tran


