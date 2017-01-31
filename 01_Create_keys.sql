Use Client
go
--Create DMK
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '$tr0nGPa$$w0rd'
GO

-- Создание асимметричного ключа, зашифрованного парольной фразой StrongPa$$w0rd!
CREATE ASYMMETRIC KEY MyAsymmetricKey
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'StrongPa$$w0rd!'
GO

-- Создание симметричного ключа, зашифрованного асимметричным ключом.
CREATE SYMMETRIC KEY MySymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY ASYMMETRIC KEY MyAsymmetricKey
GO

Select * from Employee