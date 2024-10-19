USE SupplyChainDB
GO

BEGIN TRY
INSERT INTO Terms
	VALUES	('Net Due 10 Days',10),
			('Net Due 20 Days',20),
			('Net Due 30 Days',30),
			('Net Due 40 Days',40)
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO Product
	VALUES	(101, 'Duck Egg'),
			(102, 'Organic Chicken Egg'),
			(103, 'Quail Egg')
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO Supplier
	VALUES	(801,'KamalEGG', '68 Station Road Tejgaon', '01581451256',1),
			(802,'ShohsgEGG', '31 Station Road Tejgaon', '0184454462',2)
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO Buyer
	VALUES	(501,'Chaldal', 'Shade-6, SKS , Mohakhali', '01685245202',3),
			(502,'PandaMart','Shade-7, SKS , Mohakhali','0186585562',4)
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO Batch
	VALUES		('BA-1025','801','2020-08-02'),
			   ('BA-1026', '801', '2020-08-07'),
			   ('BA-1027', '802', '2020-08-08'),
			   ('BA-1028', '801', '2020-08-10'),
			   ('BA-1029', '801', '2020-08-12'),
			   ('BA-1030', '801', '2020-08-15'),
			   ('BA-1031', '802', '2020-08-17'),
			   ('BA-1032', '801', '2020-08-18'),
			   ('BA-1033', '801', '2020-08-02')
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO BatchLineItem 
	VALUES ('BA-1025',1,101,258),
		   ('BA-1025',2,102,392),
		   ('BA-1025',3,103,210),

		   ('BA-1026',1,101,117),
		   ('BA-1026',2,102,150),
		   ('BA-1026',3,103,145),

		   ('BA-1027',1,101,115),
		   ('BA-1027',2,102,125),
		   ('BA-1027',3,103,109),

		   ('BA-1028',1,101,96),
		   ('BA-1028',2,102,160),
		   ('BA-1028',3,103,149),

		   ('BA-1029',1,101,100),
		   ('BA-1029',2,102,160),
		   ('BA-1029',3,103,101),

		   ('BA-1030',1,101,134),
		   ('BA-1030',2,102,128),
		   ('BA-1030',3,103,175),

		   ('BA-1031',1,102,261),
		   ('BA-1031',2,103,105),

		   ('BA-1032',1,101,111),
		   ('BA-1032',2,103,167),

		   ('BA-1033',1,102,157)
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO
			
BEGIN TRY
INSERT INTO Invoices
	VALUES	(501,1757,'2022-08-02',34995,3,'2022-09-02','PO-086546','BA-1025'),
			(502,1756,'2022-08-02',33473,4,'2022-09-12','PO-097721','BA-1025'),
			(501,1758,'2022-08-07',31190.2,3,'2022-09-07','PO-086589','BA-1026'),
			(502,1760,'2022-08-08',28449.96,4,'2022-09-18','PO-097735','BA-1027'),
			(501,1761,'2022-08-10',32038.8,3,'2022-09-10','PO-086599','BA-1028'),
			(502,1762,'2022-08-12',31130.08,4,'2022-09-22','PO-097745','BA-1029'),
			(501,1763,'2022-08-15',34510.2,3,'2022-09-15','PO-086604','BA-1030'),
			(502,1765,'2022-08-17',31864.64,4,'2022-09-27','PO-097764','BA-1031'),
			(501,1766,'2022-08-18',21034.2,3,'2022-09-18','PO-086632','BA-1032'),
			(501,1767,'2022-08-19',12877.2,3,'2022-09-19','PO-086645','BA-1033')
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO InvoiceLineItem
	VALUES	(1,1,101,110,88.20),
			(1,2,102,215,84.60),
			(1,3,103,96,74.00),

		   (2,1,101,124,94.44),
		   (2,2,102,154,90.66),
		   (2,3,103,98,79.60),

		   (3,1,101,105,88.20),
		   (3,2,102,142,84.60),
		   (3,3,103,134,74.00),

		   (4,1,101,102,94.44),
		   (4,2,102,118,90.66),
		   (4,3,103,102,79.60),

		   (5,1,101,90,90.60),
		   (5,2,102,148,87.60),
		   (5,3,103,140,78.00),

		   (6,1,101,92,96.78),
		   (6,2,102,152,93.66),
		   (6,3,103,94,85.00),

		   (7,1,101,121,90.60),
		   (7,2,102,121,87.60),
		   (7,3,103,166,78.00),

		   (8,2,102,254,93.66),
		   (8,3,103,95,85.00),

		   (9,1,101,97,90.60),
		   (9,3,103,157,78.00),

		   (10,2,102,147,87.60)
END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO ReturnToSupplier
	VALUES	
		('BA-1025', 801, '2022-08-02'),
		('BA-1026', 801, '2022-08-07'),
		('BA-1027', 802, '2022-08-08'),
		('BA-1028', 801, '2022-08-10'),
		('BA-1029', 802, '2022-08-12'),
		('BA-1030', 801, '2022-08-15'),
		('BA-1031', 802, '2022-08-17'),
		('BA-1032', 801, '2022-08-18'),
		('BA-1033', 801, '2022-08-19')

END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

BEGIN TRY
INSERT INTO ReturnToSupplierLineItem
	VALUES	
		('BA-1025', 1, 101, 20),
		('BA-1025', 2, 102, 19),
		('BA-1025', 3, 103, 16),

		('BA-1026', 1, 101, 8),
		('BA-1026', 2, 102, 8),
		('BA-1026', 3, 103, 9),

		('BA-1027', 1, 101, 9),
		('BA-1027', 2, 102, 6),
		('BA-1027', 3, 103, 5),

		('BA-1028', 1, 101, 1),
		('BA-1028', 2, 102, 9),
		('BA-1028', 3, 103, 7),

		('BA-1029', 1, 101, 7),
		('BA-1029', 2, 102, 6),
		('BA-1029', 3, 103, 4),

		('BA-1030', 1, 101, 13),
		('BA-1030', 2, 102, 3),
		('BA-1030', 3, 103, 6),

		('BA-1031', 1, 102, 6),
		('BA-1031', 2, 103, 8),

		('BA-1032', 1, 101, 10),
		('BA-1032', 2, 103, 9),

		('BA-1033', 1, 102, 8);

END TRY
BEGIN CATCH
	SELECT ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage,
			ERROR_SEVERITY() AS ErrorSeverity
END CATCH
GO

-----------------------------------------------------------------
--DELETE QUERY 

DELETE FROM ReturnToSupplier
	WHERE BatchID='BA-1033'
GO

---------------------------------------------------------------
--UPDATE QUERY

UPDATE ReturnToSupplier
	SET Qty=8
	WHERE BatchID='BA-1032' AND ProductID=103
GO
-----------------------------------------------
--make a copy table
SELECT * INTO Terms2 FROM Terms
-------------------------------------------------------
-- DELETE COLUMN
ALTER TABLE Terms2
	DROP COLUMN TermsDueDays
GO

------------------------------------------------------------------------
--DELETE TABLE

DROP TABLE Terms2
GO

---------------------------------------------------------------------
--Write a query to retrieve buyername wise average invoice total

SELECT BuyerName , AVG(InvoiceTotal) AvgInvoiceTotal FROM Invoices i 
JOIN Buyer b on i.BuyerID=b.BuyerID
GROUP BY BuyerName

--------------------------------------------------------------------
-- Write a query to to retrieve invoices from 3 August to 10 August

SELECT * FROM Invoices 
Where InvoiceDate Between '2022-08-02' and '2022-08-10'
--------------------------------------------------------------------
--Retrive those buyer name whoose name start with p and next letter is a to j
SELECT * FROM Buyer
Where BuyerName like 'P[a-j]%'

----------------------------------------------------------------------

--Retrive those buyer name whoose name start with C and next letter is not  j to z
SELECT * FROM Buyer
Where BuyerName like 'C[^j-z]%'

----------------------------------------------------------------------
--top clause 

SELECT TOP 1 Sum(invoiceTotal) As MaximumTotalBybatch From Invoices
GROUP BY Batch_ID
Order BY MaximumTotalBybatch desc

----------------------------------------------------------------------

--with ties

SELECT TOP 1 With Ties Sum(invoiceTotal) As MaximumTotalBybatch From Invoices
GROUP BY Batch_ID
Order BY MaximumTotalBybatch desc

----------------------------------------------------------------------
-- Give an example of OFFSET and FETCH Clause.
SELECT * FROM Invoices
ORDER BY InvoiceID
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY
----------------------------------------------------------------------
-- ANY 
SELECT * FROM Invoices 
WHERE InvoiceTotal > ANY
(SELECT Sum(Qty*Rate) FROM InvoiceLineItem Where InvoiceID=7)

----------------------------------------------------------------------
--ALL
SELECT * FROM Invoices 
WHERE InvoiceTotal > ALL
(SELECT Sum(Qty*Rate) FROM InvoiceLineItem Where InvoiceID=6)

---------------------------------------------------------------
--SOME 
SELECT * FROM Invoices 
WHERE InvoiceTotal > SOME
(SELECT Sum(Qty*Rate) FROM InvoiceLineItem Where InvoiceID=6)

---------------------------------------------------------------
--EXISTS 
SELECT * 
FROM Invoices 
WHERE EXISTS 
( SELECT 1  FROM Buyer WHERE Buyer.BuyerID = Invoices.BuyerID 
        AND Buyer.BuyerName = 'Chaldal')
----------------------------------------------------------------------
-- NOT EXISTS 
SELECT * 
FROM Invoices 
WHERE NOT EXISTS 
( SELECT 1  FROM Buyer WHERE Buyer.BuyerID = Invoices.BuyerID
AND Buyer.BuyerName = 'Chaldal')
---------------------------------------------------------------
----CAST function.
select cast('01-Jan-2024 10:00 AM' AS DATE)
--------------------------------------------------------------
----CONVERT function.
select convert(time,'01-Jan-2024 10:00 AM' ,101)

-----------------------------------------------------------------
--GROUP BY 

SELECT BuyerName, ProductName, Sum(InvoiceTotal) AS TotalPayment
	FROM Invoices AS I 
	JOIN Buyer AS B ON I.BuyerID=B.BuyerID
	JOIN InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
	JOIN Product AS P ON P.ProductID=IL.ProductID
	GROUP BY BuyerName, ProductName
	HAVING Sum(InvoiceTotal)>100000
GO
--------------------------------------------------
--GROUP BY CUBE

SELECT BuyerName, ProductName, Sum(InvoiceTotal) AS TotalPayment
	FROM Invoices AS I 
	JOIN Buyer AS B ON I.BuyerID=B.BuyerID
	JOIN InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
	JOIN Product AS P ON P.ProductID=IL.ProductID
	GROUP BY CUBE(BuyerName, ProductName)
	HAVING Sum(InvoiceTotal)>100000
GO

--------------------------------------------------
--GROUP BY Rollup

SELECT BuyerName, ProductName, Sum(InvoiceTotal) AS TotalPayment
	FROM Invoices AS I 
	JOIN Buyer AS B ON I.BuyerID=B.BuyerID
	JOIN InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
	JOIN Product AS P ON P.ProductID=IL.ProductID
	GROUP BY ROLLUP(BuyerName, ProductName)
	HAVING Sum(InvoiceTotal)>100000
GO

--------------------------------------------------------

SELECT BuyerName, ProductName, Sum(InvoiceTotal) AS TotalPayment
	FROM Invoices AS I 
	JOIN Buyer AS B ON I.BuyerID=B.BuyerID
	JOIN InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
	JOIN Product AS P ON P.ProductID=IL.ProductID
	GROUP BY GROUPING SETS(BuyerName, ProductName)
	HAVING Sum(InvoiceTotal)>100000
GO
-----------------------------------------------------------
--OVER Clause

SELECT  BatchID,BatchSequence,ProductID,Qty,
    SUM(Qty) OVER (PARTITION BY BatchID) AS TotalQuantityInBatch
	FROM
    BatchLineItem

---------------------------------------------------------------------
-- GIVE AN EXAMPLE Of ISNULL
SELECT ISNULL(BuyerName , 'Null Column'), ISNULL(ProductName , 'Null Column') , Sum(InvoiceTotal) AS TotalPayment
	FROM Invoices AS I 
	JOIN Buyer AS B ON I.BuyerID=B.BuyerID
	JOIN InvoiceLineItem AS IL ON IL.InvoiceID=I.InvoiceID
	JOIN Product AS P ON P.ProductID=IL.ProductID
	GROUP BY GROUPING SETS(BuyerName, ProductName)

---------------------------------------------------------------
--WILD CARD

SELECT * FROM Product
	WHERE ProductName LIKE 'D%'

------------------------------------------------------
--Retrive all info of chaldal Uding sub query

SELECT BuyerName, COUNT(InvoiceID) AS TotalInvoices, 
	SUM(InvoiceTotal) AS TotalPayment, MAX(InvoiceTotal) AS MaxPayment, 
	MIN(InvoiceTotal) AS MinPayment
		FROM Invoices AS I
		JOIN Buyer AS B ON I.BuyerID=B.BuyerID
			WHERE B.BuyerID IN
			(SELECT BuyerID FROM Buyer WHERE BuyerName='Chaldal')
		GROUP BY BuyerName
GO

---------------------------------------------------------------------------------------------
----MERGE -----
--SELECT * INTO ProductUpdate FROM Product
--INSERT INTO ProductUpdate VALUES (104,'Tofu'),(105,'Farm EGG')

MERGE Product AS T
USING ProductUpdate AS S
	ON S.ProductID=T.ProductID
WHEN MATCHED THEN 
	UPDATE SET T.ProductName=S.ProductName
WHEN NOT MATCHED THEN 
	INSERT ( ProductID, ProductName)
		VALUES (S.ProductID, S.ProductName);
SELECT * FROM Product
GO

---------------------------------------------
---CURSOR

DECLARE @ProductID int , @ProductName varchar(50), @Count int;
	SET @Count=0;

DECLARE MyCursor CURSOR
	FOR SELECT * FROM Product

OPEN MyCursor
	FETCH NEXT FROM MyCursor INTO @ProductID, @ProductName
	WHILE @@FETCH_STATUS=0
		BEGIN
			IF @ProductID>101
				PRINT @ProductName
					SET @Count=@Count+1
				PRINT @Count
			FETCH NEXT FROM MyCursor INTO @ProductID, @ProductName
		END
CLOSE MyCursor
DEALLOCATE MyCursor
GO

---------------------------------------------------------------------------------------------------------------

--SEARCH CASE 
SELECT InvoiceNumber, InvoiceTotal,
CASE 
	WHEN InvoiceTotal>=30000 THEN 'High Value'
	WHEN InvoiceTotal>=28000 THEN 'High Mid Value'
	WHEN InvoiceTotal>=25000 THEN 'High Mid Value'
	ELSE 'Low Value'
END AS PaymentStatus
FROM Invoices

--SIMPLE CASE 

SELECT TermsID,
CASE TermsID
WHEN 1 THEN 'Net Due 10 Days'
WHEN 2 THEN 'Net Due 20 Days'
WHEN 3 THEN 'Net Due 30 Days'
WHEN 4 THEN 'Net Due 40 Days'
END AS TermsDes
FROM Terms
GO

---------------------------------------------------------
---TRANSACTION 
DECLARE @InvID int 

BEGIN TRY
	BEGIN TRAN
		INSERT INTO Invoices
			VALUES(501,1688,'2020-02-01',10000, 1, '2020-02-10', 'po25245','BA-1033')

			SET @InvID=@@IDENTITY

		INSERT INTO InvoiceLineItem
			VALUES ( @InvID , 1, 101 , 600, 10 ),
					( @InvID , 2, 110 , 400, 10 )

	COMMIT TRAN
END TRY

BEGIN CATCH 
	ROLLBACK TRAN
END CATCH

SELECT * FROM Invoices
GO

-------------------------------------------------
--insert data using squence

INSERT INTO Batch VALUES	('BA-1051','801','2020-08-31'),
							('BA-1050','801','2020-08-30')

INSERT INTO BatchLineItem VALUES ('BA-1050',NEXT VALUE FOR MySequnce,101,258),
									('BA-1050',NEXT VALUE FOR MySequnce,102,210),
									('BA-1050',NEXT VALUE FOR MySequnce,103,150),

									('BA-1051',NEXT VALUE FOR MySequnce,101,258),
									('BA-1051',NEXT VALUE FOR MySequnce,102,210),
									('BA-1051',NEXT VALUE FOR MySequnce,103,150)
SELECT * FROM BatchLineItem
GO

----------------------------------------------------------
--Retreve from View 
SELECT * FROM Allinfo
GO
----------------------------------------------------------
--UPDATE THROW VIEW 

UPDATE Allinfo
	SET Rate=87
	WHERE InvoiceNumber=1757 AND ProductName='Duck Egg'
GO

--------------------------------------------------------------

--EXEC sp_helptext InvoiceInfo

SELECT * FROM InvoiceInfo
GO

--------------------------------------------------------------

--EXEC sp_helpindex Terms;
--EXEC sp_helpindex ReturnToSupplier;
GO

--------------------------------------------------------------------------
--INERST DATA IN INVOICE TABLE AND INVOICE LINE ITEM TABLE using Procedure

DECLARE @lineItem dbo.LineItemType
INSERT INTO @lineItem VALUES (1,101,25,20),(2,102,20,20),(3,103,25,12)

EXEC spInsertInvoiceAndLineItem 501,1999,'2020-02-02',1,'po158558','BA-1033',@lineItem

--SELECT * FROM Invoices
--SELECT * FROM InvoiceLineItem

-------------------------------------------------------
--calling table valued function 

SELECT * FROM dbo.MyTableFunction(1000)
GO

-------------------------------------------------------------
--calling function 

PRINT 'Total Damage EGG is ' + convert(varchar, dbo.DamageEGG(102), 0)
GO

---------------------------------------------------------------------
--insert update delete using store procedure 

EXEC spInsertUpdateDeleteOutput 'SELECT', '','','';
EXEC spInsertUpdateDeleteOutput 'Insert', '104','SHefain','';
EXEC spInsertUpdateDeleteOutput 'UPDATE', '104','Md Shefain';
EXEC spInsertUpdateDeleteOutput 'DELETE', '104','','','';