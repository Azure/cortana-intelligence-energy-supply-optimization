
/****** Object:  Table [dbo].[deroptciqsresult]    Script Date: 5/9/2017 4:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[deroptciqsresult](
	[ID] [nvarchar](50) NULL,
	[Time Stamp] [nvarchar](50) NULL,
	[Quantity] [nvarchar](50) NULL,
	[Value] [float] NULL,
	[ObjValue] [float] NULL,
	[BaseValue] [float] NULL,
	[computeStamp] [float] NULL
)

GO
/****** Object:  Table [dbo].[Input]    Script Date: 5/9/2017 4:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Input](
	[ID] [nvarchar](50) NULL,
	[Time Stamp] [nvarchar](50) NULL,
	[Quantity] [nvarchar](50) NULL,
	[Value] [float] NULL,
	[computeStamp] [float] NULL
)

GO
