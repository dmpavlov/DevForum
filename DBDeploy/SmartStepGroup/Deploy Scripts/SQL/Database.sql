IF NOT EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name='$(db)')  
	CREATE DATABASE $(db)