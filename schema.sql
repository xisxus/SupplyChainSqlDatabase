USE master 
GO


DROP DATABASE IF EXISTS SupplyChainDB
GO

CREATE DATABASE SupplyChainDB
ON (
	Name= 'SupplyChainDB_Data_1',
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SupplyChainDB_Data_1.mdf',
	Size= 25MB,
	MaxSize= 100MB,
	FileGrowth= 5%
)
LOG ON (
	Name= 'SupplyChainDB_Log_1',
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SupplyChainDB_Log_1.ldf',
	Size= 2MB,
	MaxSize= 25MB,
	FileGrowth= 1%
)
GO

USE SupplyChainDB
GO 

IF OBJECT_ID('Terms') IS NOT NULL
	DROP TABLE Terms
GO 

CREATE TABLE Terms
	(TermsID int IDENTITY PRIMARY KEY NONCLUSTERED,
	TermsDescription varchar(50) NOT NULL,
	TermsDueDays int NOT NULL)
GO

DROP TABLE IF EXISTS Product
GO 

CREATE TABLE Product
	(ProductID int PRIMARY KEY ,
	ProductName varchar(50) NOT NULL)
GO


DROP TABLE IF EXISTS Supplier
GO 

CREATE TABLE Supplier
	(SupplierID int PRIMARY KEY ,
	SupplierName varchar(50) NOT NULL,
	SupplierAddress varchar(50) NOT NULL,
	SupplierPhone varchar(50) NOT NULL,
	DefaultTermsID int REFERENCES Terms(TermsID) ON DELETE CASCADE ON UPDATE CASCADE)
GO


DROP TABLE IF EXISTS Buyer
GO 

CREATE TABLE Buyer
	(BuyerID int PRIMARY KEY ,
	BuyerName varchar(50) NOT NULL,
	WareHouseAddress varchar(50) NOT NULL,
	BuyerPhone varchar(50) NOT NULL,
	DefaultTermsID int REFERENCES Terms(TermsID))
GO

DROP TABLE IF EXISTS Batch
GO 

CREATE TABLE Batch
	(BatchID varchar(20) UNIQUE ,
	SupplierID int REFERENCES Supplier(SupplierID) ON DELETE CASCADE ON UPDATE CASCADE,
	SupplyDate Date NOT NULL,
	PRIMARY KEY (BatchID,SupplierID,SupplyDate))
GO

DROP TABLE IF EXISTS BatchLineItem
GO 

CREATE TABLE BatchLineItem
	(BatchID varchar(20) REFERENCES Batch(BatchID),
	BatchSequence int NOT NULL,
	ProductID int REFERENCES Product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	Qty int NOT NULL,
	PRIMARY KEY (BatchID,BatchSequence))
GO

DROP TABLE IF EXISTS Invoices
GO 

CREATE TABLE Invoices
	(InvoiceID int PRIMARY KEY IDENTITY ,
	BuyerID int REFERENCES Buyer(BuyerID),
	InvoiceNumber int NOT NULL,
	InvoiceDate date NOT NULL,
	InvoiceTotal money NOT NULL,
	TermsId int REFERENCES Terms(TermsID),
	PaymentDate date,
	Po_Number varchar(20) NOT NULL,
	Batch_ID varchar(20) REFERENCES Batch(BatchID))
GO

DROP TABLE IF EXISTS InvoiceLineItem
GO 

CREATE TABLE InvoiceLineItem
	(InvoiceID int REFERENCES Invoices(InvoiceID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	InvoiceSequence int NOT NULL,
	ProductID int REFERENCES Product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	Qty int NOT NULL,
	Rate Float NOT NULL)
GO

DROP TABLE IF EXISTS InvoiceArchieve
GO 

CREATE TABLE InvoiceArchieve
	(InvoiceID int  ,
	BuyerID int ,
	InvoiceNumber int NOT NULL,
	InvoiceDate date NOT NULL,
	InvoiceTotal money NOT NULL,
	TermsId int ,
	PaymentDate date,
	Po_Number varchar(20) NOT NULL,
	Batch_ID varchar(20) )
GO

DROP TABLE IF EXISTS ReturnToSupplier
GO 

CREATE TABLE ReturnToSupplier
	(ReturnID int PRIMARY KEY IDENTITY ,
	BatchID varchar(20) REFERENCES Batch(BatchID),
	SupplierID int REFERENCES Supplier(SupplierID),
	ReturnDate Date NOT NULL)
GO

DROP TABLE IF EXISTS ReturnToSupplierLineItem
GO 

CREATE TABLE ReturnToSupplierLineItem
	(BatchID varchar(20) REFERENCES Batch(BatchID),
	ItemSequence int NOT NULL,
	ProductID int REFERENCES Product(ProductID),
	Qty int NOT NULL
	PRIMARY KEY (BatchID,ItemSequence))
GO
---------------------------------------------------------------------------------
--  Create A view / Updateable VIEW with ENCRYPTION, SCHEMABINDING

CREATE OR ALTER VIEW Allinfo WITH ENCRYPTION, SCHEMABINDING  AS 
SELECT I.InvoiceDate, I.InvoiceNumber, I.Po_Number,I.Batch_ID, S.SupplierName,
		B.BuyerName, P.ProductName, IL.Qty, IL.Rate, I.InvoiceTotal 
	FROM dbo.Invoices AS I
	JOIN dbo.Buyer AS B ON I.BuyerID=B.BuyerID
	JOIN dbo.InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
	JOIN dbo.Product AS P ON P.ProductID=IL.ProductID
	JOIN dbo.Batch AS Ba ON I.Batch_ID=Ba.BatchID
	JOIN dbo.Supplier AS S ON S.SupplierID=Ba.SupplierID
GO




-------------------------------------------------------------------------
--NON UPDATEABLE VIEW 
CREATE OR ALTER VIEW InvoiceInfo WITH ENCRYPTION  AS 
SELECT BuyerName, SupplierName, COUNT(InvoiceNumber) AS TotalInvoices, 
		SUM(Qty) AS TotalQuentity FROM Allinfo
	WHERE ProductName='Duck Egg' OR ProductName= 'Quail Egg'
		GROUP BY BuyerName, SupplierName
GO


--------------------------------------------------------------------------------
--INDEX CLUSTERED / NON CLUSTERED

CREATE CLUSTERED INDEX ix_Terms
	ON Terms(TermsID)
GO
-----------------------------------------------
CREATE NONCLUSTERED INDEX ix_ReturnToSupplier
	ON ReturnToSupplier(BatchID)
GO


-------------------------------------------------------------------------------------------------
-- PROCEDURE FOR INSERT UPDATE DELETE AND OUTOUT PARAMETER

CREATE OR ALTER PROC spInsertUpdateDeleteOutput
	@Functionality varchar(10)='',
	@ProductID int,
	@ProductName varchar(50),
	@Count int output
AS 
BEGIN
		IF @Functionality='SELECT'
			SELECT * FROM Product
		IF @Functionality='INSERT'
			BEGIN TRY
				INSERT INTO Product 
					Values (@ProductID,@ProductName)
			END TRY
			BEGIN CATCH
			SELECT ERROR_LINE() AS ErrorLine,
					ERROR_MESSAGE() AS ErrorMessage,
					ERROR_SEVERITY() AS ErrorSeverity
			END CATCH
		IF @Functionality='UPDATE'
			BEGIN TRY
				UPDATE Product
					SET ProductName=@ProductName WHERE ProductID=@ProductID
			END TRY
			BEGIN CATCH
			SELECT ERROR_LINE() AS ErrorLine,
					ERROR_MESSAGE() AS ErrorMessage,
					ERROR_SEVERITY() AS ErrorSeverity
			END CATCH				
		IF @Functionality='DELETE'
			BEGIN TRY
				DELETE FROM Product
					WHERE ProductID=@ProductID
			END TRY
			BEGIN CATCH
			SELECT ERROR_LINE() AS ErrorLine,
					ERROR_MESSAGE() AS ErrorMessage,
					ERROR_SEVERITY() AS ErrorSeverity
			END CATCH	
					
		SET @Count=@@ROWCOUNT
END


------------------------------------------------------------------

-- CREATE CTE to Find out damage egg

WITH TotalSale AS
(SELECT Batch_ID,ProductID , SUM(Qty) AS TotalProductSale 
	FROM InvoiceLineItem IL 
	JOIN Invoices I ON I.InvoiceID=IL.InvoiceID
	GROUP BY Batch_ID,ProductID),
Damage AS
(SELECT InvoiceNumber,ProductName, 
		SUM(BL.Qty-RSI.Qty-TotalSale.TotalProductSale) AS Damaged
		FROM dbo.Invoices AS I
		JOIN dbo.InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
		JOIN dbo.Product AS P ON P.ProductID=IL.ProductID
		JOIN dbo.Batch AS Ba ON I.Batch_ID=Ba.BatchID
		JOIN dbo.BatchLineItem AS BL ON BL.BatchID=Ba.BatchID AND P.ProductID=BL.ProductID
		JOIN dbo.ReturnToSupplier AS RS ON RS.BatchID=Ba.BatchID 
		JOIN dbo.ReturnToSupplierLineItem AS RSI ON RSI.BatchID=RS.BatchID AND  P.ProductID=RSI.ProductID
		JOIN TotalSale  ON TotalSale.Batch_ID=I.Batch_ID AND P.ProductID=TotalSale.ProductID
		GROUP BY InvoiceNumber,ProductName)
SELECT * FROM Damage
GO

---------------------------------------------------------------------------------------
--Store Procedure With Raise Error

CREATE OR ALTER PROC spWithRaiseError
	@BatchID Varchar(20),
	@SupplierID int,
	@SupplyDate date
AS
BEGIN
	IF EXISTS (SELECT * FROM Supplier WHERE SupplierID=@SupplierID)
		INSERT INTO Batch
		VALUES (@BatchID ,@SupplierID ,@SupplyDate)
	ELSE 
		THROW 50001, 'This data Is not valid', 1;
END

BEGIN TRY
EXEC  spWithRaiseError 'Ba-1040',503,'2020-02-02';
END TRY

BEGIN CATCH 
PRINT Error_Message()
END CATCH
GO

---------------------------------------------------------------------------------------------------------------------
-- TRIGGER - HERE DELETING MORE THAN 1 ROW IS NOT ALLOWED

CREATE TRIGGER InvoicesDeleted
	ON Invoices
	AFTER DELETE
AS
BEGIN
	IF (SELECT COUNT(*) FROM deleted) > 1
		BEGIN
			Print 'Deleting more than one row at a time is not allowed.'
			
			ROLLBACK

			Print Convert(varchar,Error_Message())
		END
    ELSE
		BEGIN
			INSERT INTO InvoiceArchieve 
					(InvoiceID ,BuyerID ,InvoiceNumber,InvoiceDate,InvoiceTotal,TermsId,PaymentDate,Po_Number,Batch_ID)
			SELECT InvoiceID ,BuyerID ,InvoiceNumber,InvoiceDate,InvoiceTotal,TermsId,PaymentDate,Po_Number,Batch_ID FROM deleted
		END
END


GO

---------------------------------------------------------------------------------------------------------------------
-- TRIGGER AFTER Insert Update  - HERE DELETING MORE THAN 1 ROW IS NOT ALLOWED

CREATE TRIGGER InvoicesInsertedOrUpdated
	ON Invoices
	AFTER INSERT, UPDATE
AS
BEGIN
    INSERT INTO InvoiceArchieve 
        (InvoiceID, BuyerID, InvoiceNumber, InvoiceDate, InvoiceTotal, TermsId, PaymentDate, Po_Number, Batch_ID)
    SELECT  i.InvoiceID, i.BuyerID, i.InvoiceNumber, i.InvoiceDate, i.InvoiceTotal, i.TermsId, i.PaymentDate, i.Po_Number, i.Batch_ID
		FROM inserted i

    INSERT INTO InvoiceArchieve 
        (InvoiceID, BuyerID, InvoiceNumber, InvoiceDate, InvoiceTotal, TermsId, PaymentDate, Po_Number, Batch_ID)
    SELECT i.InvoiceID, i.BuyerID, i.InvoiceNumber, i.InvoiceDate, i.InvoiceTotal, i.TermsId, i.PaymentDate, i.Po_Number, i.Batch_ID
		 FROM inserted i
		 INNER JOIN deleted d ON i.InvoiceID = d.InvoiceID;

END;



GO

--------------------------------------------------------------------------------------------------------------------------
-------CREATE SQUENCE-----

CREATE SEQUENCE MySequnce
		START WITH 1
		INCREMENT BY 1
		MINVALUE 1
		MAXVALUE 10
		CYCLE CACHE 1
GO 


-------------------------------------------------------------------------------
--CREATE PROCUDURE TO INERST DATA IN INVOICE TABLE AND INVOICE LINE ITEM TABLE

CREATE TYPE LineItemType AS Table
(InvoiceSequence int ,
	ProductID int ,
	Qty int ,
	Rate Float )

CREATE OR ALTER PROC spInsertInvoiceAndLineItem
	@BuyerID int, @InvNum int, @invDate date, @TermsID int, @PoNum varchar(20), @BatchID varchar(20),
	@lineItem LineItemType READONLY
AS 
BEGIN 
	DECLARE @InvID int
	DECLARE @PaymentDate date

	SELECT @PaymentDate=DATEADD(day,TermsDueDays,@invDate) FROM Terms WHERE TermsID=@TermsID

	INSERT INTO Invoices
		VALUES(@BuyerID,@InvNum,@invDate,0,@TermsID,@PaymentDate,@PoNum,@BatchID)

		SET @InvID=@@IDENTITY

	INSERT INTO InvoiceLineItem
		SELECT @InvID , InvoiceSequence, ProductID , Qty, Rate FROM @lineItem

	UPDATE Invoices
		SET InvoiceTotal=(SELECT SUM(Qty*Rate) FROM InvoiceLineItem WHERE InvoiceID=@InvID)
		WHERE InvoiceID=@InvID
END




----------------------------------------------------------------------------------------------
--TABLE VALUED FUNCTION 

CREATE FUNCTION MyTableFunction(@InvMoney money = 0)
	RETURNS Table 
RETURN 
	(SELECT BuyerName, SUM(InvoiceTotal) TotalInv  
	FROM Invoices I JOIN Buyer B ON I.BuyerID=B.BuyerID
	GROUP BY BuyerName
	HAVING SUM(InvoiceTotal)>@InvMoney);

---------------------------------------------------------------------------------
--ALTER TABLE VALUED FUNCTION 

ALTER FUNCTION MyTableFunction(@InvMoney money = 0)
	RETURNS Table 
RETURN 
	(SELECT B.BuyerID , BuyerName, SUM(InvoiceTotal) TotalInv  
	FROM Invoices I JOIN Buyer B ON I.BuyerID=B.BuyerID
	GROUP BY BuyerName, B.BuyerID
	HAVING SUM(InvoiceTotal)>@InvMoney);
----------------------------------------------------------------------------------
--Sclar Function

CREATE OR ALTER FUNCTION DamageEGG(@ProductID int)
	Returns int
BEGIN
		RETURN (SELECT SUM(BL.Qty)-SUM(RSI.Qty)-SUM(IL.Qty)
				FROM dbo.Invoices AS I
				JOIN dbo.InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
				JOIN dbo.Product AS P ON P.ProductID=IL.ProductID
				JOIN dbo.Batch AS Ba ON I.Batch_ID=Ba.BatchID
				JOIN dbo.BatchLineItem AS BL ON BL.BatchID=Ba.BatchID AND P.ProductID=BL.ProductID
				JOIN dbo.ReturnToSupplier AS RS ON RS.BatchID=Ba.BatchID 
				JOIN dbo.ReturnToSupplierLineItem AS RSI ON RSI.BatchID=RS.BatchID AND  P.ProductID=RSI.ProductID
				WHERE P.ProductID=@ProductID)
END


