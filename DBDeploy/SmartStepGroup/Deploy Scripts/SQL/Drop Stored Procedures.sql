DECLARE @obj sysname
DECLARE cur cursor FOR
    SELECT name FROM sysobjects WHERE type = 'P' AND objectproperty(id, 'IsMSShipped') = 0
 
OPEN cur
FETCH NEXT FROM cur INTO @obj
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP PROCEDURE ' + @obj)
    FETCH NEXT FROM cur INTO @obj
END
 
CLOSE cur
DEALLOCATE cur