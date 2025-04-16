create user u without login
go
drop table if exists tb
go
create table tb (
  pk int identity(1,1) primary key ,
  fullname varchar(100) masked with (function = 'partial(1, "x", 1)'),
  birthday date masked with(function='default()'),
  phone varchar(12) masked with (function = 'default()'),
  email varchar(100) masked with (function = 'email()'))
go
insert tb(fullname,birthday,phone,email) values('byron hu','20000101','123456789','byron.hu@mentortrust.com')
go
grant unmask on tb(phone,email) to u;  
grant select on tb to u;
exec('select * from tb') as user='u'