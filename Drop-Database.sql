
/***

	Listing 1

	Using DROP DATABASE IF EXISTS still returns an error
	if an open connection exists.

***/
use master;
go

CREATE DATABASE DropMe;
GO

-- Try to drop using IF EXISTS
DROP DATABASE IF EXISTS DropMe;
GO

--Create a database
CREATE DATABASE DropMe;
go


-- Results in following error:
--
-- Msg 3702, Level 16, State 3, Line 11
-- Cannot drop database "DropMe" because it is currently in use.

/***

	Listing 2
	
	Using IF EXISTS(), SET SINGLE_USER and
	WITH ROLLBACK IMMEDIATE

***/

USE master;
go

IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'DropMe')
BEGIN
	ALTER DATABASE DropMe SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DropMe;
END
