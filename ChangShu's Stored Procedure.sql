--Chang Shu's stored procedure
--Includes Inventory, Inventory_Type, RANK_STYLE,RANK, STYLE

--Add Inventory
CREATE PROCEDURE uspAddINVENTORY
(@InventoryName varchar(50),
@Quantity NUMERIC,
@InventoryDescr varchar(500), 
@InventoryTypeName varchar(50)
)
AS
BEGIN TRANSACTION AddINVENTORY
DECLARE @InventoryTypeID INT
SET @InventoryTypeID = 
(SELECT InventoryTypeID FROM INVENTORY_TYPE WHERE InventoryTypeName = @InventoryTypeName)
IF @InventoryTypeID IS NULL 
	BEGIN RAISERROR(16, 'Your inventory type is not found')
END

INSERT INTO INVENTORY(InventoryName, Quantity, InventoryDescr, InventoryTypeID)
VALUES(@InventoryName, @Quantity, @InventoryDescr, @InventoryTypeID)

IF @@ERROR <> 0 
	ROLLBACK TRANSACTION AddINVENTORY
ELSE 
	COMMIT TRANSACTION AddINVENTORY

--Add Inventory_Type
CREATE PROCEDURE uspAddINVENTORY_TYPE(
@InventoryTypeName varchar(50)，
@InventoryTypeDescr varchar(500)
)
AS
BEGIN TRANSACTION AddINVENTORY_TYPE
INSERT INTO INVENTORY_TYPE(InventoryTypeName, InventoryTypeDescr)
VALUES(@InventoryTypeName,@InventoryTypeDescr)
IF @@ERROR <> 0 
	ROLLBACK TRANSACTION AddINVENTORY_TYPE
ELSE 
	COMMIT TRANSACTION AddINVENTORY_TYPE

--Add Style for ranks
CREATE PROCEDURE uspAddSTYLE(
@StyleName varchar(50),
@StytleDescr, varchar(50)
)
AS
BEGIN TRANSACTION AddSTYLE
INSERT INTO STYLE(StyleName, StyleDescr)
VALUES(@StyleName, @StytleDescr)
IF @@ERROR <> 0 
	ROLLBACK TRANSACTION AddSTYLE
ELSE 
	COMMIT TRANSACTION AddSTYLE

--Add Rank
Create PROCEDURE uspAddRank(
@RankNmae varchar(40),
@RankDescr varchar(500)
)
BEGIN TRANSACTION AddRANKK

INSERT INTO RANK(RankName, RankDescr)
VALUES(@RankNmae,@RankDescr)

IF @@ERROR <> 0 
	ROLLBACK TRANSACTION AddRANK
ELSE 
	COMMIT TRANSACTION AddRANK


--Add RANK_STYLE
CREATE PROCEDURE uspRANK_STYLE(
@RankName,
@StyleName
)
AS
BEGIN TRANSACTION AddINVENTORY
DECLARE @RankId INT
SET @RankID = 
(SELECT RankID FROM RANK WHERE RankName = @RankName
IF @RankID IS NULL 
	BEGIN RAISERROR(16, 'Your Rank Name is not found')
END
DECLARE @StyleId INT
SET @StyleId = 
(SELECT StyleID FROM STYLE WHERE StyleName = @RankName
IF @RankID IS NULL 
	BEGIN RAISERROR(16, 'Your Rank Name is not found')
END

INSERT INTO INVENTORY(InventoryName, Quantity, InventoryDescr, InventoryTypeID)
VALUES(@InventoryName, @Quantity, @InventoryDescr, @InventoryTypeID)

IF @@ERROR <> 0 
	ROLLBACK TRANSACTION AddINVENTORY
ELSE 
	COMMIT TRANSACTION AddINVENTORY






