DECLARE @obj sysname
 
DECLARE cur cursor FOR
     SELECT name FROM sysobjects WHERE type in ('FN', 'TF') AND objectproperty(id, 'IsMSShipped') = 0 AND id NOT IN (SELECT depid FROM sys.sysdepends sd
																											JOIN sys.objects so
																											ON sd.id=so.object_id
																											WHERE so.type='S' OR so.type='U')

OPEN cur
FETCH NEXT FROM cur INTO @obj
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP FUNCTION ' + @obj)
    FETCH NEXT FROM cur INTO @obj
END
 
CLOSE cur
DEALLOCATE cur