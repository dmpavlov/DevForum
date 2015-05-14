CREATE TABLE [dbo].[Topic](
	[Id] int IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[StartDate] datetime NOT NULL,
	CONSTRAINT [TopicPK] PRIMARY KEY CLUSTERED ( [Id] asc ))