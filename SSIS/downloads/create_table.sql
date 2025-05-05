create table [dbo].[Address] (		
    [AddressID] smallint NOT NULL,	
    [AddressLine1] varchar(39) NOT NULL,	
    [AddressLine2] varchar(22) NULL,	
    [City] varchar(17) NOT NULL,	
    [StateProvince] varchar(16) NOT NULL,	
    [CountryRegion] varchar(14) NOT NULL,	
    [PostalCode] varchar(10) NOT NULL)
    
create table dbo.[Customer] (		
    [CustomerID] smallint NOT NULL,	
    [NameStyle] bit NOT NULL,	
    [Title] varchar(4) NULL,	
    [FirstName] varchar(24) NOT NULL,	
    [MiddleName] varchar(20) NULL, 
    [LastName] varchar(22) NOT NULL,	
    [Suffix] varchar(22) NULL, 
    [CompanyName] varchar(41) NOT NULL,	
    [SalesPerson] varchar(24) NOT NULL,	
    [EmailAddress] varchar(43) NOT NULL,	
    [Phone] varchar(19) NOT NULL)

create table dbo.[CustomerAddress] (		
    [CustomerID] smallint NOT NULL,	
    [AddressID] smallint NOT NULL,	
    [AddressType] varchar(11) NOT NULL)
    
create table dbo.[Output01] (		
    [CustomerID] smallint NOT NULL,	
    [NameStyle] bit NOT NULL,	
    [Title] varchar(4) NULL,	
    [FirstName] varchar(24) NOT NULL,	
    [LastName] varchar(22) NOT NULL,	
    [CompanyName] varchar(41) NOT NULL,	
    [SalesPerson] varchar(24) NOT NULL,	
    [EmailAddress] varchar(43) NOT NULL,	
    [Phone] varchar(19) NOT NULL)


create table [dbo].[Result01] (		
    [AddressID] smallint NOT NULL,	
    [AddressLine1] varchar(39) NOT NULL,	
    [AddressLine2] varchar(22) NULL,	
    [City] varchar(17) NOT NULL,	
    [StateProvince] varchar(16) NOT NULL,	
    [CountryRegion] varchar(14) NOT NULL,	
    [PostalCode] varchar(10) NOT NULL)


create table dbo.[Output02] (		
    [CustomerID] char(5) NOT NULL,	
    [Title] varchar(4) NULL,	
    [FirstName] varchar(24) NOT NULL,	
    [LastName] varchar(22) NOT NULL,	
    [CompanyName] varchar(41) NOT NULL,	
    [SalesPerson] varchar(24) NOT NULL,	
    [EmailAddress] varchar(43) NOT NULL,	
    [Phone] varchar(19) NOT NULL)


create table [dbo].[Result02] (		
    [AddressID] char(5) NOT NULL,	
    [AddressLine1] varchar(39) NOT NULL,	
    [AddressLine2] varchar(22) NULL,	
    [City] varchar(17) NOT NULL,	
    [StateProvince] varchar(16) NOT NULL,	
    [CountryRegion] varchar(14) NOT NULL,	
    [PostalCode] varchar(10) NOT NULL)


create table [dbo].[Output03] (		
    [SalesPerson] varchar(24) NOT NULL,	
    [SalesPersonCount] smallint NOT NULL)


create table [dbo].[Result03] (		
    [CountryRegion] varchar(14) NOT NULL,	
    [StateProvince] varchar(16) NOT NULL,	
    [StateCountryCount] tinyint NULL)


create table dbo.[Input01] (		
    [CustomerID] smallint NOT NULL,	
    [NameStyle] bit NOT NULL,	
    [Title] varchar(4) NULL,	
    [FirstName] varchar(24) NOT NULL,	
    [LastName] varchar(22) NOT NULL,	
    [CompanyName] varchar(41) NOT NULL,	
    [SalesPerson] varchar(24) NOT NULL,	
    [EmailAddress] varchar(43) NOT NULL,	
    [Phone] varchar(19) NOT NULL)

create table dbo.[Input02] (		
    [CustomerID] smallint NOT NULL,	
    [NameStyle] bit NOT NULL,	
    [Title] varchar(4) NULL,	
    [FirstName] varchar(24) NOT NULL,	
    [LastName] varchar(22) NOT NULL,	
    [CompanyName] varchar(41) NOT NULL,	
    [SalesPerson] varchar(24) NOT NULL,	
    [EmailAddress] varchar(43) NOT NULL,	
    [Phone] varchar(19) NOT NULL)