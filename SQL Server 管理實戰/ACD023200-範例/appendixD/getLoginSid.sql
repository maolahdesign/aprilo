:connect n1
select @@servername serverName, name,sid,convert(varchar(256),password_hash,1) hashPwd from sys.sql_logins where name='login1'
go
:connect n2
select @@servername serverName, name,sid,convert(varchar(256),password_hash,1) hashPwd from sys.sql_logins where name='login1'
