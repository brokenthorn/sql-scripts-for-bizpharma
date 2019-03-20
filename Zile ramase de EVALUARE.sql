sp_configure 'show advanced options', 1;
RECONFIGURE
GO

sp_configure 'Agent XPs', 1;
RECONFIGURE
GO

DECLARE
  @daysleft int
DECLARE
  @instancename sysname
SELECT @instancename = CONVERT(sysname, SERVERPROPERTY('InstanceName'))
EXEC @daysleft = xp_qv '2715127595', @instancename
SELECT @daysleft 'Number of days left'
GO