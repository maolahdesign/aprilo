CREATE TABLE Users (
    UserID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    UserName NVARCHAR(100) NOT NULL
);

-- 插入資料時自動產生唯一識別碼
INSERT INTO Users (UserName) VALUES ('Alice');
INSERT INTO Users (UserName) VALUES ('Bob');

-- 查詢
SELECT UserID, UserName FROM Users;
