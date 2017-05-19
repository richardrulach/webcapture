
use cards
go


create table CapturedText(
	CapturedTextId int identity(1,1) PRIMARY KEY,
	[Text] nvarchar(1000) NOT NULL
)

