DECLARE @obj sysname
DECLARE cur cursor FOR
    SELECT name FROM sysobjects WHERE xtype = 'TR'
 
OPEN cur
FETCH NEXT FROM cur INTO @obj
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP TRIGGER ' + @obj)
    FETCH NEXT FROM cur INTO @obj
END
 
CLOSE cur
DEALLOCATE cur