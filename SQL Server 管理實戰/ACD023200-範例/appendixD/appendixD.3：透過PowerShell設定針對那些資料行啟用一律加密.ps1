Import-Module SqlServer
# Set up connection and database SMO objects

$sqlConnectionString = "Data Source=sql2022;Initial Catalog=Northwind;Integrated Security=True;Connect Timeout=30;Encrypt=False;Packet Size=4096;Application Name=`"Microsoft SQL Server Management Studio`""
$smoDatabase = Get-SqlDatabase -ConnectionString $sqlConnectionString

# Change encryption schema

$encryptionChanges = @()

# Add changes for table [dbo].[Customers]
$encryptionChanges += New-SqlColumnEncryptionSettings -ColumnName dbo.Customers.ContactName -EncryptionType Deterministic -EncryptionKey "cek"
$encryptionChanges += New-SqlColumnEncryptionSettings -ColumnName dbo.Customers.Phone -EncryptionType Deterministic -EncryptionKey "cek"

Set-SqlColumnEncryption -ColumnEncryptionSettings $encryptionChanges -InputObject $smoDatabase  
