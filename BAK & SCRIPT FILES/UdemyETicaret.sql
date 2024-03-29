USE [master]
GO
/****** Object:  Database [UdemyETicaretDB]    Script Date: 14.06.2019 11:08:17 ******/
CREATE DATABASE [UdemyETicaretDB] ON  PRIMARY 
( NAME = N'UdemyETicaretDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\UdemyETicaretDB.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UdemyETicaretDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\UdemyETicaretDB_log.ldf' , SIZE = 2112KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UdemyETicaretDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UdemyETicaretDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UdemyETicaretDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UdemyETicaretDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UdemyETicaretDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UdemyETicaretDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UdemyETicaretDB] SET RECOVERY FULL 
GO
ALTER DATABASE [UdemyETicaretDB] SET  MULTI_USER 
GO
ALTER DATABASE [UdemyETicaretDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UdemyETicaretDB] SET DB_CHAINING OFF 
GO
USE [UdemyETicaretDB]
GO
/****** Object:  User [fgurdal]    Script Date: 14.06.2019 11:08:17 ******/
CREATE USER [fgurdal] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [uniqueidentifier] NOT NULL,
	[AdresDescription] [nvarchar](300) NULL,
	[Member_Id] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NOT NULL,
	[Parent_Id] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifedDate] [datetime] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](250) NOT NULL,
	[Member_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
	[Surname] [nvarchar](25) NULL,
	[Email] [nvarchar](60) NOT NULL,
	[Password] [nvarchar](60) NOT NULL,
	[Bio] [nvarchar](300) NULL,
	[ProfileImageName] [nvarchar](50) NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[MemberType] [int] NOT NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessageReplies]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageReplies](
	[Id] [uniqueidentifier] NOT NULL,
	[Text] [nvarchar](300) NOT NULL,
	[MessageId] [uniqueidentifier] NOT NULL,
	[Member_Id] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_MessageReplies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [uniqueidentifier] NOT NULL,
	[Subject] [nvarchar](60) NOT NULL,
	[IsRead] [bit] NOT NULL,
	[AddedDate] [nchar](10) NOT NULL,
	[ModifiedDate] [nchar](10) NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [uniqueidentifier] NOT NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [tinyint] NOT NULL,
	[Order_Id] [uniqueidentifier] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [uniqueidentifier] NOT NULL,
	[Member_Id] [int] NOT NULL,
	[Address] [nvarchar](2000) NOT NULL,
	[Status] [nchar](10) NULL,
	[Description] [nvarchar](250) NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 14.06.2019 11:08:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](2000) NOT NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[IsContinued] [bit] NOT NULL,
	[StarPoint] [int] NOT NULL,
	[StarGivenMemberCount] [int] NOT NULL,
	[ProductImageName] [nvarchar](350) NOT NULL,
	[UnitsInStock] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[Category_Id] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (1, N'Beverages', NULL, N'Soft drinks, coffees, teas, beers, and ales', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (2, N'Condiments', NULL, N'Sweet and savory sauces, relishes, spreads, and seasonings', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (3, N'Confections', 1, N'Desserts, candies, and sweet breads', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (4, N'Dairy Products', 3, N'Cheeses', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (5, N'Grains/Cereals', NULL, N'Breads, crackers, pasta, and cereal', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (6, N'Meat/Poultry', NULL, N'Prepared meats', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (7, N'Produce', 5, N'Dried fruit and bean curd', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Parent_Id], [Description], [AddedDate], [ModifedDate]) VALUES (8, N'Seafood', NULL, N'Seaweed and fish', CAST(N'2019-06-13T19:38:09.577' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([Id], [Name], [Surname], [Email], [Password], [Bio], [ProfileImageName], [AddedDate], [ModifiedDate], [MemberType]) VALUES (1, N'Mert', N'Ersoy', N'mertersoy92@gmail.com', N'123456', NULL, NULL, CAST(N'2019-06-13T00:00:00.000' AS DateTime), NULL, 10)
INSERT [dbo].[Members] ([Id], [Name], [Surname], [Email], [Password], [Bio], [ProfileImageName], [AddedDate], [ModifiedDate], [MemberType]) VALUES (2, N'Ayşegül ', N'Dilek', N'dilek.aysegul95@gmail.com', N'123', NULL, NULL, CAST(N'2019-06-13T00:00:10.000' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[Members] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (1, N'Chai', N'', CAST(18.00 AS Decimal(8, 2)), 1, 0, 0, N'', 39, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (2, N'Chang', N'', CAST(19.00 AS Decimal(8, 2)), 1, 0, 0, N'', 17, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (3, N'Aniseed Syrup', N'', CAST(10.00 AS Decimal(8, 2)), 1, 0, 0, N'', 13, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (4, N'Chef Anton''s Cajun Seasoning', N'', CAST(22.00 AS Decimal(8, 2)), 1, 0, 0, N'', 53, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (5, N'Chef Anton''s Gumbo Mix', N'', CAST(21.35 AS Decimal(8, 2)), 1, 0, 0, N'', 0, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (6, N'Grandma''s Boysenberry Spread', N'', CAST(25.00 AS Decimal(8, 2)), 1, 0, 0, N'', 120, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (7, N'Uncle Bob''s Organic Dried Pears', N'', CAST(30.00 AS Decimal(8, 2)), 1, 0, 0, N'', 15, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 7)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (8, N'Northwoods Cranberry Sauce', N'', CAST(40.00 AS Decimal(8, 2)), 1, 0, 0, N'', 6, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (9, N'Mishi Kobe Niku', N'', CAST(97.00 AS Decimal(8, 2)), 1, 0, 0, N'', 29, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 6)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (10, N'Ikura', N'', CAST(31.00 AS Decimal(8, 2)), 1, 0, 0, N'', 31, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (11, N'Queso Cabrales', N'', CAST(21.00 AS Decimal(8, 2)), 1, 0, 0, N'', 22, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (12, N'Queso Manchego La Pastora', N'', CAST(38.00 AS Decimal(8, 2)), 1, 0, 0, N'', 86, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (13, N'Konbu', N'', CAST(6.00 AS Decimal(8, 2)), 1, 0, 0, N'', 24, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (14, N'Tofu', N'', CAST(23.25 AS Decimal(8, 2)), 1, 0, 0, N'', 35, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 7)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (15, N'Genen Shouyu', N'', CAST(15.50 AS Decimal(8, 2)), 1, 0, 0, N'', 39, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (16, N'Pavlova', N'', CAST(17.45 AS Decimal(8, 2)), 1, 0, 0, N'', 29, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (17, N'Alice Mutton', N'', CAST(39.00 AS Decimal(8, 2)), 1, 0, 0, N'', 0, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 6)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (18, N'Carnarvon Tigers', N'', CAST(62.50 AS Decimal(8, 2)), 1, 0, 0, N'', 42, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (19, N'Teatime Chocolate Biscuits', N'', CAST(9.20 AS Decimal(8, 2)), 1, 0, 0, N'', 25, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (20, N'Sir Rodney''s Marmalade', N'', CAST(81.00 AS Decimal(8, 2)), 1, 0, 0, N'', 40, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (21, N'Sir Rodney''s Scones', N'', CAST(10.00 AS Decimal(8, 2)), 1, 0, 0, N'', 3, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (22, N'Gustaf''s Knäckebröd', N'', CAST(21.00 AS Decimal(8, 2)), 1, 0, 0, N'', 104, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (23, N'Tunnbröd', N'', CAST(9.00 AS Decimal(8, 2)), 1, 0, 0, N'', 61, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (24, N'Guaraná Fantástica', N'', CAST(4.50 AS Decimal(8, 2)), 1, 0, 0, N'', 20, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (25, N'NuNuCa Nuß-Nougat-Creme', N'', CAST(14.00 AS Decimal(8, 2)), 1, 0, 0, N'', 76, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (26, N'Gumbär Gummibärchen', N'', CAST(31.23 AS Decimal(8, 2)), 1, 0, 0, N'', 15, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (27, N'Schoggi Schokolade', N'', CAST(43.90 AS Decimal(8, 2)), 1, 0, 0, N'', 49, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (28, N'Rössle Sauerkraut', N'', CAST(45.60 AS Decimal(8, 2)), 1, 0, 0, N'', 26, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 7)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (29, N'Thüringer Rostbratwurst', N'', CAST(123.79 AS Decimal(8, 2)), 1, 0, 0, N'', 0, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 6)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (30, N'Nord-Ost Matjeshering', N'', CAST(25.89 AS Decimal(8, 2)), 1, 0, 0, N'', 10, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (31, N'Gorgonzola Telino', N'', CAST(12.50 AS Decimal(8, 2)), 1, 0, 0, N'', 0, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (32, N'Mascarpone Fabioli', N'', CAST(32.00 AS Decimal(8, 2)), 1, 0, 0, N'', 9, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (33, N'Geitost', N'', CAST(2.50 AS Decimal(8, 2)), 1, 0, 0, N'', 112, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (34, N'Sasquatch Ale', N'', CAST(14.00 AS Decimal(8, 2)), 1, 0, 0, N'', 111, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (35, N'Steeleye Stout', N'', CAST(18.00 AS Decimal(8, 2)), 1, 0, 0, N'', 20, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (36, N'Inlagd Sill', N'', CAST(19.00 AS Decimal(8, 2)), 1, 0, 0, N'', 112, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (37, N'Gravad lax', N'', CAST(26.00 AS Decimal(8, 2)), 1, 0, 0, N'', 11, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (38, N'Côte de Blaye', N'', CAST(263.50 AS Decimal(8, 2)), 1, 0, 0, N'', 17, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (39, N'Chartreuse verte', N'', CAST(18.00 AS Decimal(8, 2)), 1, 0, 0, N'', 69, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (40, N'Boston Crab Meat', N'', CAST(18.40 AS Decimal(8, 2)), 1, 0, 0, N'', 123, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (41, N'Jack''s New England Clam Chowder', N'', CAST(9.65 AS Decimal(8, 2)), 1, 0, 0, N'', 85, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (42, N'Singaporean Hokkien Fried Mee', N'', CAST(14.00 AS Decimal(8, 2)), 1, 0, 0, N'', 26, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (43, N'Ipoh Coffee', N'', CAST(46.00 AS Decimal(8, 2)), 1, 0, 0, N'', 17, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (44, N'Gula Malacca', N'', CAST(19.45 AS Decimal(8, 2)), 1, 0, 0, N'', 27, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (45, N'Rogede sild', N'', CAST(9.50 AS Decimal(8, 2)), 1, 0, 0, N'', 5, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (46, N'Spegesild', N'', CAST(12.00 AS Decimal(8, 2)), 1, 0, 0, N'', 95, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (47, N'Zaanse koeken', N'', CAST(9.50 AS Decimal(8, 2)), 1, 0, 0, N'', 36, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (48, N'Chocolade', N'', CAST(12.75 AS Decimal(8, 2)), 1, 0, 0, N'', 15, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (49, N'Maxilaku', N'', CAST(20.00 AS Decimal(8, 2)), 1, 0, 0, N'', 10, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (50, N'Valkoinen suklaa', N'', CAST(16.25 AS Decimal(8, 2)), 1, 0, 0, N'', 65, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (51, N'Manjimup Dried Apples', N'', CAST(53.00 AS Decimal(8, 2)), 1, 0, 0, N'', 20, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 7)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (52, N'Filo Mix', N'', CAST(7.00 AS Decimal(8, 2)), 1, 0, 0, N'', 38, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (53, N'Perth Pasties', N'', CAST(32.80 AS Decimal(8, 2)), 1, 0, 0, N'', 0, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 6)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (54, N'Tourtière', N'', CAST(7.45 AS Decimal(8, 2)), 1, 0, 0, N'', 21, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 6)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (55, N'Pâté chinois', N'', CAST(24.00 AS Decimal(8, 2)), 1, 0, 0, N'', 115, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 6)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (56, N'Gnocchi di nonna Alice', N'', CAST(38.00 AS Decimal(8, 2)), 1, 0, 0, N'', 21, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (57, N'Ravioli Angelo', N'', CAST(19.50 AS Decimal(8, 2)), 1, 0, 0, N'', 36, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (58, N'Escargots de Bourgogne', N'', CAST(13.25 AS Decimal(8, 2)), 1, 0, 0, N'', 62, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (59, N'Raclette Courdavault', N'', CAST(55.00 AS Decimal(8, 2)), 1, 0, 0, N'', 79, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (60, N'Camembert Pierrot', N'', CAST(34.00 AS Decimal(8, 2)), 1, 0, 0, N'', 19, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (61, N'Sirop d''érable', N'', CAST(28.50 AS Decimal(8, 2)), 1, 0, 0, N'', 113, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (62, N'Tarte au sucre', N'', CAST(49.30 AS Decimal(8, 2)), 1, 0, 0, N'', 17, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (63, N'Vegie-spread', N'', CAST(43.90 AS Decimal(8, 2)), 1, 0, 0, N'', 24, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (64, N'Wimmers gute Semmelknödel', N'', CAST(33.25 AS Decimal(8, 2)), 1, 0, 0, N'', 22, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 5)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (65, N'Louisiana Fiery Hot Pepper Sauce', N'', CAST(21.05 AS Decimal(8, 2)), 1, 0, 0, N'', 76, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (66, N'Louisiana Hot Spiced Okra', N'', CAST(17.00 AS Decimal(8, 2)), 1, 0, 0, N'', 4, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (67, N'Laughing Lumberjack Lager', N'', CAST(14.00 AS Decimal(8, 2)), 1, 0, 0, N'', 52, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (68, N'Scottish Longbreads', N'', CAST(12.50 AS Decimal(8, 2)), 1, 0, 0, N'', 6, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 3)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (69, N'Gudbrandsdalsost', N'', CAST(36.00 AS Decimal(8, 2)), 1, 0, 0, N'', 26, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (70, N'Outback Lager', N'', CAST(15.00 AS Decimal(8, 2)), 1, 0, 0, N'', 15, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (71, N'Flotemysost', N'', CAST(21.50 AS Decimal(8, 2)), 1, 0, 0, N'', 26, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (72, N'Mozzarella di Giovanni', N'', CAST(34.80 AS Decimal(8, 2)), 1, 0, 0, N'', 14, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 4)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (73, N'Röd Kaviar', N'', CAST(15.00 AS Decimal(8, 2)), 1, 0, 0, N'', 101, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 8)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (74, N'Longlife Tofu', N'', CAST(10.00 AS Decimal(8, 2)), 1, 0, 0, N'', 4, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 7)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (75, N'Rhönbräu Klosterbier', N'', CAST(7.75 AS Decimal(8, 2)), 1, 0, 0, N'', 125, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (76, N'Lakkalikööri', N'', CAST(18.00 AS Decimal(8, 2)), 1, 0, 0, N'', 57, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [IsContinued], [StarPoint], [StarGivenMemberCount], [ProductImageName], [UnitsInStock], [AddedDate], [ModifiedDate], [Category_Id]) VALUES (77, N'Original Frankfurter grüne Soße', N'', CAST(13.00 AS Decimal(8, 2)), 1, 0, 0, N'', 32, CAST(N'2019-06-13T19:44:43.057' AS DateTime), NULL, 2)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Members] FOREIGN KEY([Member_Id])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Members]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories] FOREIGN KEY([Parent_Id])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Members] FOREIGN KEY([Member_Id])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Members]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Products]
GO
ALTER TABLE [dbo].[MessageReplies]  WITH CHECK ADD  CONSTRAINT [FK_MessageReplies_Members] FOREIGN KEY([Member_Id])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[MessageReplies] CHECK CONSTRAINT [FK_MessageReplies_Members]
GO
ALTER TABLE [dbo].[MessageReplies]  WITH CHECK ADD  CONSTRAINT [FK_MessageReplies_Messages] FOREIGN KEY([MessageId])
REFERENCES [dbo].[Messages] ([Id])
GO
ALTER TABLE [dbo].[MessageReplies] CHECK CONSTRAINT [FK_MessageReplies_Messages]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Members] FOREIGN KEY([Member_Id])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Members]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
USE [master]
GO
ALTER DATABASE [UdemyETicaretDB] SET  READ_WRITE 
GO
