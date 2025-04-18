drop table if exists dbo.Employees2;
CREATE TABLE dbo.Employees2(
	EmployeeID int IDENTITY(1,1) NOT NULL,
	LastName nvarchar(20) NOT NULL,
	MiddleName nvarchar(10) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	Title nvarchar(30) ,
	TitleOfCourtesy nvarchar(25) ,
	BirthDate datetime NULL,
	HireDate datetime NULL,
	Address nvarchar(60) ,
	City nvarchar(15) ,
	Region nvarchar(15) ,
	PostalCode nvarchar(10) ,
	Country nvarchar(15) ,
	HomePhone nvarchar(24) ,
	Extension nvarchar(4) ,
	Photo varbinary(max) NULL,
	Notes nvarchar(max) ,
	ReportsTo int NULL,
	PhotoPath nvarchar(255) 
) 

