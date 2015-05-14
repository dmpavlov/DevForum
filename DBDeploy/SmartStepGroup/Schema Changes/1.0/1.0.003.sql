CREATE TABLE [dbo].[Presenter](
	[Id] int IDENTITY(1,1) NOT NULL,
	[TopicId] int NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	[Email] NVARCHAR(100) NOT NULL,
	[JobTitle] NVARCHAR(100) NOT NULL,
	CONSTRAINT [PresenterPK] PRIMARY KEY clustered ([Id] asc ),
	CONSTRAINT [Presenter_TopicFK] FOREIGN KEY ([TopicId]) REFERENCES [Topic]([Id]))
GO

DECLARE @TopicId INT
SELECT @TopicId = ID from [dbo].[Topic]
WHERE [Title] = 'Incremental DB Deployment'

INSERT INTO [dbo].[Presenter] ([TopicId], [Name], [Email], [JobTitle]) 
VALUES (@TopicId, 'Dmitry', 'dmitry@smartstepgroup.com', 'Developer');