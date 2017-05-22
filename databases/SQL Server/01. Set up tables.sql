
USE cards
GO

CREATE TABLE Category(
	CategoryId		INT					IDENTITY(1,1)		PRIMARY KEY,
	ParentId		INT					NULL,
	[Name]			NVARCHAR(100)		NOT NULL,
	isCurrent		BIT					NOT NULL			DEFAULT 0,
	dtAdded			DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated		DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE Category 
ADD CONSTRAINT FK_CategoryParent FOREIGN KEY(ParentId)
REFERENCES Category(CategoryId);
GO

INSERT INTO Category([Name], [isCurrent])
VALUES('Root', 1)

CREATE TABLE TextType (
	TextTypeId		INT					IDENTITY(1,1)		PRIMARY KEY,
	[Name]			NVARCHAR(100)		NOT NULL,
	dtAdded			DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated		DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

INSERT INTO TextType(name)
VALUES
	('sentence'),('olist'),('vocabulary'),('task'),('memorisation'),('SQL'),('JQuery'),('C#'),('HTML'),('CSS')

CREATE TABLE [Text](
	TextId			INT					IDENTITY(1,1)		PRIMARY KEY,
	TextTypeId		INT					NOT NULL,
	CategoryId		INT					NOT NULL,
	[Text]			NVARCHAR(1000)		NOT NULL,
	iOrder			INT					NOT NULL			DEFAULT 0,
	dtAdded			DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated		DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE dbo.[Text]
ADD CONSTRAINT FK_Text_TextType FOREIGN KEY(TextTypeId) 
REFERENCES TextType(TextTypeID)
GO

ALTER TABLE dbo.[Text]
ADD CONSTRAINT FK_Text_Category FOREIGN KEY(CategoryId) 
REFERENCES Category(CategoryId)
GO




