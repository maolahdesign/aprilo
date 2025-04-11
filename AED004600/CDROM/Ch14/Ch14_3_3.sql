USE 毙叭╰参
GO
CREATE PROCEDURE ㊣祘
   @proc_name varchar(30)
AS
PRINT '秨﹍糷计: ' + CAST(@@NESTLEVEL AS char)
EXEC @proc_name
PRINT '挡糷计: ' + CAST(@@NESTLEVEL AS char)
GO
CREATE PROCEDURE 代刚祘
AS
PRINT '糷计: ' + CAST(@@NESTLEVEL AS char)

