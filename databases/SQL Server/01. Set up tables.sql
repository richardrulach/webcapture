
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


CREATE TABLE [CodeType](
	CodeTypeId	INT				IDENTITY(1,1)	PRIMARY KEY,
	[Name]		NVARCHAR(50)	NOT NULL,
	iOrder		INT				NOT NULL		DEFAULT 0,
	dtAdded		DATETIME		NOT NULL		DEFAULT GETDATE(),
	dtUpdated	DATETIME		NOT NULL		DEFAULT GETDATE()
)
GO

INSERT INTO [dbo].[CodeType]([Name], iOrder)
VALUES ('SQL' , 1),('JQuery', 2),('C#', 3),('HTML', 4),('CSS', 5)
GO


CREATE TABLE [Code](
	CodeId			INT					IDENTITY(1,1)		PRIMARY KEY,
	CodeTypeId		INT					NOT NULL,
	CategoryId		INT					NOT NULL,
	Question		NVARCHAR(1000)		NOT NULL,
	Answer			NTEXT				NOT NULL,
	iOrder			INT					NOT NULL			DEFAULT 0,
	dtAdded			DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated		DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE [dbo].[Code]
ADD CONSTRAINT FK_Code_CodeType FOREIGN KEY(CodeTypeId)
REFERENCES CodeType(CodeTypeId)
GO

ALTER TABLE [dbo].[Code]
ADD CONSTRAINT FK_Code_Category FOREIGN KEY(CategoryId)
REFERENCES dbo.Category(CategoryId)
GO



CREATE TABLE [QATextType](
	QATextTypeID	INT				IDENTITY(1,1)		PRIMARY KEY,
	[Name]			NVARCHAR(50)	NOT NULL,
	iOrder			INT				NOT NULL			DEFAULT 0,
	dtAdded			DATETIME		NOT NULL			DEFAULT GETDATE(),
	dtUpdated		DATETIME		NOT NULL			DEFAULT GETDATE()
)
GO

INSERT INTO [dbo].[QATextType]([Name])
VALUES ('Blanks'),('Vocabulary'),('Task')
GO


CREATE TABLE [QAText](
	QATextId		INT					IDENTITY(1,1)		PRIMARY KEY,
	QATextTypeId	INT					NOT NULL,
	CategoryId		INT					NOT NULL,
	Question		NVARCHAR(1000)		NOT NULL,
	Answer			NVARCHAR(1000)		NOT NULL,
	iOrder			INT					NOT NULL			DEFAULT 0,
	dtAdded			DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated		DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE dbo.[QAText]
ADD CONSTRAINT FK_QAText_QATextType FOREIGN KEY(QATextTypeId) 
REFERENCES QATextType(QATextTypeId)
GO

ALTER TABLE dbo.[QAText]
ADD CONSTRAINT FK_QAText_Category FOREIGN KEY(CategoryId) 
REFERENCES Category(CategoryId)
GO


CREATE TABLE [MemorisationText](
	MemorisationTextId	INT					IDENTITY(1,1)		PRIMARY KEY,
	CategoryId			INT					NOT NULL,
	MemText				NVARCHAR(2000)		NOT NULL,
	iOrder				INT					NOT NULL			DEFAULT 0,
	dtAdded				DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated			DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE dbo.[MemorisationText]
ADD CONSTRAINT FK_MemorisationText_Category FOREIGN KEY(CategoryId) 
REFERENCES Category(CategoryId)
GO


CREATE TABLE [OrderedList](
	OrderedListId		INT					IDENTITY(1,1)		PRIMARY KEY,
	CategoryId			INT					NOT NULL,
	ListName			NVARCHAR(200)		NOT NULL,
	iOrder				INT					NOT NULL			DEFAULT 0,
	dtAdded				DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated			DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE dbo.[OrderedList]
ADD CONSTRAINT FK_OrderedList_Category FOREIGN KEY(CategoryId) 
REFERENCES Category(CategoryId)
GO

CREATE TABLE [OrderedListItem](
	OrderedListItemId	INT					IDENTITY(1,1)		PRIMARY KEY,
	OrderedListId		INT,
	ItemText			NVARCHAR(2000)		NOT NULL,
	iOrder				INT					NOT NULL			DEFAULT 0,
	dtAdded				DATETIME			NOT NULL			DEFAULT GETDATE(),
	dtUpdated			DATETIME			NOT NULL			DEFAULT GETDATE()
)
GO

ALTER TABLE dbo.[OrderedListItem]
ADD CONSTRAINT FK_OrderedListItem_OrderedList FOREIGN KEY(OrderedListId) 
REFERENCES OrderedList(OrderedListId)
GO


CREATE TABLE [MultipleChoice](
	MultipleChoiceId	INT				IDENTITY(1,1)	PRIMARY KEY,
	CategoryId			INT				NOT NULL,
	Question			NVARCHAR(1000)	NOT NULL,
	iOrder				INT				NOT NULL		DEFAULT 0,
	dtAdded				DATETIME		NOT NULL		DEFAULT GETDATE(),
	dtUpdated			DATETIME		NOT NULL		DEFAULT GETDATE()
)

ALTER TABLE dbo.[MultipleChoice]
ADD CONSTRAINT FK_MultipleChoice_Category FOREIGN KEY(CategoryId) 
REFERENCES Category(CategoryId)
GO

CREATE TABLE MultipleChoiceAnswer(
	MultipleChoiceAnswerId		INT				IDENTITY(1,1)	PRIMARY KEY,
	MultipleChoiceId			INT				NOT NULL,
	Answer						NVARCHAR(200)	NOT NULL,
	isCorrect					BIT				NOT NULL		DEFAULT 0,	
	iOrder						INT				NOT NULL		DEFAULT 0,
	dtAdded						DATETIME		NOT NULL		DEFAULT GETDATE(),
	dtUpdated					DATETIME		NOT NULL		DEFAULT GETDATE()
)
GO

ALTER TABLE dbo.[MultipleChoiceAnswer]
ADD CONSTRAINT FK_MultipleChoiceAnswer_MultipleChoice FOREIGN KEY(MultipleChoiceId) 
REFERENCES MultipleChoice(MultipleChoiceId)
GO


