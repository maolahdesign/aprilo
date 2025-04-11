USE master
GO
EXEC sp_execute_external_script 
@language = N'Python',
@script = N'
grade = 78
if grade >= 60:
    print("成績及格!", grade)
else:
    print("成績不及格!", grade)
'
GO  


