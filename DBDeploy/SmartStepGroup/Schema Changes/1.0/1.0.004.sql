CREATE TABLE [dbo].[Company](
	[Id] int IDENTITY(1,1) NOT NULL,
	[LegalName] [varchar](100) NOT NULL,
	CONSTRAINT [CompanyPK] PRIMARY KEY CLUSTERED ( [Id] asc ))

INSERT INTO COMPANY ([LegalName])
VALUES ('SmartStepGroup')
GO

ALTER TABLE [dbo].[Presenter]
ADD [CompanyId] INT NULL
GO

UPDATE [dbo].[Presenter]
SET [CompanyId] = 1

ALTER TABLE [dbo].[Presenter]
ALTER COLUMN CompanyId INT NOT NULL

ALTER TABLE [dbo].[Presenter]
ADD CONSTRAINT [Presenter_CompanyFK] FOREIGN KEY ([CompanyId]) REFERENCES [Company]([Id])