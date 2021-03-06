USE [master]
GO
/****** Object:  Database [InfilonPractical]    Script Date: 11-06-2022 17:42:47 ******/
CREATE DATABASE [InfilonPractical]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InfilonPractical', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\InfilonPractical.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InfilonPractical_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\InfilonPractical_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [InfilonPractical] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InfilonPractical].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InfilonPractical] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InfilonPractical] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InfilonPractical] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InfilonPractical] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InfilonPractical] SET ARITHABORT OFF 
GO
ALTER DATABASE [InfilonPractical] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InfilonPractical] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InfilonPractical] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InfilonPractical] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InfilonPractical] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InfilonPractical] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InfilonPractical] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InfilonPractical] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InfilonPractical] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InfilonPractical] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InfilonPractical] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InfilonPractical] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InfilonPractical] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InfilonPractical] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InfilonPractical] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InfilonPractical] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InfilonPractical] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InfilonPractical] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [InfilonPractical] SET  MULTI_USER 
GO
ALTER DATABASE [InfilonPractical] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InfilonPractical] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InfilonPractical] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InfilonPractical] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InfilonPractical] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InfilonPractical] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [InfilonPractical] SET QUERY_STORE = OFF
GO
USE [InfilonPractical]
GO
/****** Object:  UserDefinedTableType [dbo].[UserData]    Script Date: 11-06-2022 17:42:48 ******/
CREATE TYPE [dbo].[UserData] AS TABLE(
	[UserId] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[Title] [nvarchar](2000) NULL,
	[Completed] [bit] NULL
)
GO
/****** Object:  Table [dbo].[Even]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Even](
	[UserId] [int] NULL,
	[Id] [int] NULL,
	[Title] [nvarchar](2000) NULL,
	[Completed] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[UserId] [int] NULL,
	[Id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Odd]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Odd](
	[UserId] [int] NULL,
	[Id] [int] NULL,
	[Title] [nvarchar](2000) NULL,
	[Completed] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUser]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllUser] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Even
	UNION ALL 
	SELECT * FROM Odd
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserById]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserById]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (@Id % 2 = 0)
	begin
		select * from Even where Id = @Id
	end
	else
	begin
		select * from Odd where Id = @Id
	end
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserJson]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetUserJson]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT E.UserId,E.Id, E.Title,E.Completed,IIF(H.UserId is null,null,1) AS Edited FROM Even E
	LEFT JOIN History H ON H.UserId = E.UserId and H.Id = E.Id
	UNION ALL 
	SELECT O.UserId,O.Id, O.Title,O.Completed,IIF(H.UserId is null,null,1) AS Edited FROM Odd O
	LEFT JOIN History H ON H.UserId = O.UserId and H.Id = O.Id
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertUser] 
	-- Add the parameters for the stored procedure here
	@UserData UserData READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Even (UserId, Id, Title, Completed)
	SELECT UserId, Id, Title, Completed FROM @UserData WHERE (Id%2) = 0

	INSERT INTO Even (UserId, Id, Title, Completed)
	SELECT UserId, Id, Title, Completed FROM @UserData WHERE (Id%2) != 0
END
GO
/****** Object:  StoredProcedure [dbo].[SaveUser]    Script Date: 11-06-2022 17:42:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SaveUser]
	-- Add the parameters for the stored procedure here
	@Id int,
	@UserId int,
	@Title nvarchar(2000),
	@Completed bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (@Id % 2 = 0)
	begin
		Update Even set UserId = @UserId, Title = @Title, Completed = 1 where Id = @Id
	end
	else
	begin
		Update Odd set UserId = @UserId, Title = @Title, Completed = 1 where Id = @Id
	end
	INSERT INTO History
	(UserId, Id)
	Values(@UserId,@Id)
END
GO
USE [master]
GO
ALTER DATABASE [InfilonPractical] SET  READ_WRITE 
GO
