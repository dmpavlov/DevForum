DECLARE @obj SYSNAME
DECLARE cur CURSOR FOR
    SELECT '[' + table_schema + '].' + table_name AS obj FROM Information_schema.VIEWS
 
OPEN cur
FETCH NEXT FROM cur INTO @obj
WHILE @@FETCH_STATUS = 0
BEGIN
  EXEC('DROP VIEW ' + @obj)
  FETCH NEXT FROM cur INTO @obj
END
 
CLOSE cur
DEALLOCATE cur