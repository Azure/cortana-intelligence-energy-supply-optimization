
/****** Object:  UserDefinedFunction [dbo].[GetRunsByTime]    Script Date: 5/9/2017 4:11:05 PM ******/

CREATE FUNCTION [dbo].[GetRunsByTime]
(	
	@ResourceType nvarchar(50) = '0'
)
RETURNS @result TABLE 
(
    ID INT
)

AS



BEGIN
DECLARE @NrDays int = 7

IF (@ResourceType  = 'Battery')
BEGIN
	INSERT INTO @result
	SELECT MAX([OutputBatteryId]) AS [ID]
	FROM [dbo].[OutputBattery] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 0
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
	GROUP BY [SubStationId]
		,OB.[SolutionNum]
		,[StartDateTime]
		,OA.[IsSimulatedRun]
		,OA.[IsRealTimeRun]

	INSERT INTO @result
	SELECT [OutputBatteryId] AS [ID]
	FROM [dbo].[OutputBattery] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 1
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
END

IF (@ResourceType = 'SSG')
BEGIN
	INSERT INTO @result
	SELECT MAX([OutputSSGId]) AS [ID]
	FROM [dbo].[OutputSSG] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 0
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
	GROUP BY [SubStationId]
		,OB.[SolutionNum]
		,[StartDateTime]
		,OA.[IsSimulatedRun]
		,OA.[IsRealTimeRun]

	INSERT INTO @result
	SELECT [OutputSSGId] AS [ID]
	FROM [dbo].[OutputSSG] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 1
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
END

IF (@ResourceType = 'DR')
BEGIN
	INSERT INTO @result
	SELECT MAX([OutputDRId]) AS [ID]
	FROM [dbo].[OutputDR] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 0
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
	GROUP BY [SubStationId]
		,OB.[SolutionNum]
		,[StartDateTime]
		,OA.[IsSimulatedRun]
		,OA.[IsRealTimeRun]

	INSERT INTO @result
	SELECT [OutputDRId] AS [ID]
	FROM [dbo].[OutputDR] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 1
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
END

IF (@ResourceType = 'LoadForecast')
BEGIN
	INSERT INTO @result
	SELECT MAX([OutputLoadForecastId]) AS [ID]
	FROM [dbo].[OutputLoadForecast] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 0
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
	GROUP BY [SubStationId]
		,OB.[SolutionNum]
		,[StartDateTime]
		,OA.[IsSimulatedRun]
		,OA.[IsRealTimeRun]

	INSERT INTO @result
	SELECT [OutputLoadForecastId] AS [ID]
	FROM [dbo].[OutputLoadForecast] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 1
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
END

IF (@ResourceType = 'DispGen')
BEGIN
	INSERT INTO @result
	SELECT MAX([OutputDispGenId]) AS [ID]
	FROM [dbo].[OutputDispGen] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 0
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
	GROUP BY [SubStationId]
		,OB.[SolutionNum]
		,[StartDateTime]
		,OA.[IsSimulatedRun]
		,OA.[IsRealTimeRun]

	INSERT INTO @result
	SELECT [OutputDispGenId] AS [ID]
	FROM [dbo].[OutputDispGen] AS OB
	INNER JOIN [dbo].[OutputMaster] AS OA
	ON OA.[OptimizationId] = OB.[OptimizationId]
	WHERE OA.[IsSimulatedRun] = 1
	AND [StartDateTime] > (GETDATE() - DAY(@NrDays))
END


RETURN
END
GO
/****** Object:  Table [dbo].[OutputBattery]    Script Date: 5/9/2017 4:11:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputBattery](
	[OutputBatteryId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[StateofCharge] [decimal](10, 3) NOT NULL,
	[CommGen] [int] NOT NULL,
	[Generation] [decimal](10, 3) NOT NULL,
	[CommLoad] [int] NOT NULL,
	[Load] [decimal](10, 3) NOT NULL,
	[Violation] [decimal](10, 3) NULL,
	[BidId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[OutputBatteryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OutputMaster]    Script Date: 5/9/2017 4:11:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputMaster](
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[ObjFuncName] [nvarchar](255) NOT NULL,
	[Goal] [nvarchar](255) NOT NULL,
	[ObjFuncValue] [decimal](10, 3) NOT NULL,
	[IsSimulatedRun] [bit] NOT NULL,
	[IsRealTimeRun] [bit] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[OptimizationRunName] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OptimizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  UserDefinedFunction [dbo].[GetLatestRun]    Script Date: 5/9/2017 4:11:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Espen Brandt-Kjelsen
-- Create date: 05.01.2017
-- Description:	tbd
-- =============================================
CREATE FUNCTION [dbo].[GetLatestRun]
(	
	
)
RETURNS TABLE 
AS
RETURN 
(
  	SELECT OB.[OptimizationId]
	FROM [dbo].[OutputBattery] OB
	  LEFT OUTER JOIN [dbo].[OutputMaster] AS OM
  ON OM.[OptimizationId] = OB.[OptimizationId]
	WHERE OB.[OutputBatteryId] IN (SELECT MAX([OutputBatteryId]) FROM [dbo].[OutputBattery] OB2
	 LEFT OUTER JOIN [dbo].[OutputMaster] AS OM
	ON OM.[OptimizationId] = OB2.[OptimizationId]
	GROUP BY OM.[IsSimulatedRun], OM.[IsRealTimeRun])
)
GO
/****** Object:  View [dbo].[vBattery]    Script Date: 5/9/2017 4:11:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vBattery] AS

  SELECT  [OutputBatteryId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[DeviceId]
      ,[StateofCharge]
      ,[CommGen]
      ,[Generation]
      ,[CommLoad]
      ,([Load]*(-1)) AS [Load]
  FROM [dbo].[OutputBattery]
  WHERE [OutputBatteryId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('Battery'))
  UNION ALL
    SELECT  [OutputBatteryId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,DATEADD(hh, 1, (DATEADD(ss, -1.1, [StartDateTime]))) AS [StartDateTime]  
      ,[EndDateTime]
      ,[DeviceId]
      ,[StateofCharge]
      ,[CommGen]
      ,[Generation]
      ,[CommLoad]
      ,([Load]*(-1)) AS [Load]
  FROM [dbo].[OutputBattery]
  WHERE [OutputBatteryId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('Battery'))
GO
/****** Object:  View [dbo].[vBatteryIndividual]    Script Date: 5/9/2017 4:11:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[vBatteryIndividual] AS

  SELECT  [OutputBatteryId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[DeviceId]
      ,[StateofCharge]
      ,[CommGen]
      ,[Generation]
      ,[CommLoad]
      ,([Load]*(-1)) AS [Load]
  FROM [dbo].[OutputBattery]
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
  UNION ALL 
    SELECT  [OutputBatteryId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,DATEADD(hh, 1, (DATEADD(ss, -1.1, [StartDateTime]))) AS [StartDateTime] 
      ,[EndDateTime]
      ,[DeviceId]
      ,[StateofCharge]
      ,[CommGen]
      ,[Generation]
      ,[CommLoad]
      ,([Load]*(-1)) AS [Load]
  FROM [dbo].[OutputBattery]
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
GO
/****** Object:  Table [dbo].[OutputDispGen]    Script Date: 5/9/2017 4:11:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputDispGen](
	[OutputDispGenId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[CommGen] [int] NOT NULL,
	[Generation] [decimal](10, 3) NOT NULL,
	[Violation] [decimal](10, 3) NULL,
	[BidId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[OutputDispGenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  View [dbo].[vDispGen]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================


CREATE VIEW [dbo].[vDispGen] AS

SELECT [OutputDispGenId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[CommGen]
      ,[Generation]
  FROM [dbo].[OutputDispGen]
  WHERE [OutputDispGenId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('DispGen'))
GO
/****** Object:  Table [dbo].[OutputDR]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputDR](
	[OutputDRId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[LoadReduction] [decimal](10, 3) NOT NULL,
	[CommLoadReduction] [decimal](10, 3) NOT NULL,
	[Violation] [decimal](10, 3) NULL,
	[BidId] [uniqueidentifier] NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OutputDRId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  View [dbo].[vDR]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================


CREATE VIEW [dbo].[vDR] AS

SELECT [OutputDRId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[LoadReduction]
      ,[CommLoadReduction]
      ,[StartDateTime]
      ,[EndDateTime]
  FROM [dbo].[OutputDR] dr1
  WHERE [OutputDRId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('DR'))
  UNION ALL
  SELECT [OutputDRId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[LoadReduction]
      ,[CommLoadReduction]
      ,DATEADD(hh, 1, (DATEADD(ss, -1.1, [StartDateTime]))) AS [StartDateTime]  
      ,[EndDateTime]
  FROM [dbo].[OutputDR] dr2
  WHERE [OutputDRId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('DR'))
GO
/****** Object:  View [dbo].[vDRIndividual]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================


CREATE VIEW [dbo].[vDRIndividual] AS

SELECT [OutputDRId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[LoadReduction]
      ,[CommLoadReduction]
      ,[StartDateTime]
      ,[EndDateTime]
  FROM [dbo].[OutputDR]
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
  UNION ALL
  SELECT [OutputDRId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[LoadReduction]
      ,[CommLoadReduction]
      ,DATEADD(hh, 1, (DATEADD(ss, -1.1, [StartDateTime]))) AS [StartDateTime] 
      ,[EndDateTime]
  FROM [dbo].[OutputDR]
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
GO
/****** Object:  Table [dbo].[OutputLoadForecast]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputLoadForecast](
	[OutputLoadForecastId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[StartDateTime] [datetime2](7) NOT NULL,
	[EndDateTime] [datetime2](7) NOT NULL,
	[LoadForecast] [decimal](10, 3) NOT NULL,
	[Import] [decimal](10, 3) NOT NULL,
	[Export] [decimal](10, 3) NOT NULL,
	[PriceForecast] [decimal](10, 3) NOT NULL,
	[ShadowPrice] [decimal](10, 3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OutputLoadForecastId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  View [dbo].[vLatest]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================

CREATE VIEW [dbo].[vLatest] AS

	SELECT OB.[OptimizationId]
	,'Latest' AS [Latest]
	FROM [dbo].[OutputLoadForecast] OB
	LEFT OUTER JOIN [dbo].[OutputMaster] AS OM
	ON OM.[OptimizationId] = OB.[OptimizationId]
	WHERE OB.[OutputLoadForecastId] IN (
		SELECT MAX([OutputLoadForecastId]) 
		FROM [dbo].[OutputLoadForecast] OB2
		LEFT OUTER JOIN [dbo].[OutputMaster] AS OM
		ON OM.[OptimizationId] = OB2.[OptimizationId]
		GROUP BY OM.[IsSimulatedRun], OM.[IsRealTimeRun], OB2.[SubStationId])
GO
/****** Object:  View [dbo].[vLoadForecast]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================


CREATE VIEW [dbo].[vLoadForecast] AS

SELECT  [OutputLoadForecastId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[LoadForecast]
      ,[Import]
      ,[Export]
      ,[PriceForecast]
      ,[ShadowPrice]
  FROM [dbo].[OutputLoadForecast]
  WHERE [OutputLoadForecastId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('LoadForecast'))
GO
/****** Object:  View [dbo].[vLoadForecastIndividual]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================


CREATE VIEW [dbo].[vLoadForecastIndividual] AS

SELECT [OutputLoadForecastId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[LoadForecast]
      ,[Import]
      ,[Export]
      ,[PriceForecast]
      ,[ShadowPrice]
  FROM [dbo].[OutputLoadForecast] olf
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
GO
/****** Object:  View [dbo].[vOutputMaster]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vOutputMaster] AS
SELECT [OptimizationId]
      ,[ObjFuncName]
      ,[Goal]
      ,[ObjFuncValue]
      ,[IsSimulatedRun]
      ,[IsRealTimeRun]
      ,[SolutionNum]
      ,[OptimizationRunName]
      ,[CreatedDate]
  FROM [dbo].[OutputMaster]
  WHERE [CreatedDate] > (GETDATE() - DAY(14))
GO
/****** Object:  Table [dbo].[OutputSSG]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputSSG](
	[OutputSSGId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[Generation] [decimal](10, 3) NOT NULL,
	[Violation] [decimal](10, 3) NULL,
	[BidId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[OutputSSGId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  View [dbo].[vSSG]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vSSG] AS

SELECT  [OutputSSGId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[Generation]
  FROM [dbo].[OutputSSG]
  WHERE [OutputSSGId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('SSG'))
  AND [Generation] > -100
  UNION ALL
  SELECT  [OutputSSGId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,DATEADD(hh, 1, (DATEADD(ss, -1.1, [StartDateTime]))) AS [StartDateTime]  
      ,[EndDateTime]
      ,[Generation]
  FROM [dbo].[OutputSSG]
  WHERE [OutputSSGId] IN (SELECT [ID] FROM [dbo].[GetRunsByTime] ('SSG'))
  AND [Generation] > -100
GO
/****** Object:  View [dbo].[vSSGIndividual]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vSSGIndividual] AS

SELECT  [OutputSSGId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[Generation]
  FROM [dbo].[OutputSSG]
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
  UNION ALL
  SELECT  [OutputSSGId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,DATEADD(hh, 1, (DATEADD(ss, -1.1, [StartDateTime]))) AS [StartDateTime] 
      ,[EndDateTime]
      ,[Generation]
  FROM [dbo].[OutputSSG]
  WHERE [StartDateTime] > (GETDATE() - DAY(7))
GO
/****** Object:  Table [dbo].[SubStation]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubStation](
	[SubStationId] [int] IDENTITY(1,1) NOT NULL,
	[RowKey] [nvarchar](255) NOT NULL,
	[SubStationName] [nvarchar](255) NOT NULL,
	[MacroLoadForecastDeviceNames] [nvarchar](255) NOT NULL,
	[PriceDataDeviceName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubStationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  View [dbo].[vRunTotals]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [dbo].[vRunTotals] AS
SELECT  
	    SS.[SubStationId] 
	  ,OB.[StartDateTime]
	  ,OA.[IsSimulatedRun]
	  ,OA.[IsRealTimeRun]
	  ,OB.[OptimizationId]
	  ,SUM(BAT.[Generation])+SUM(SSGWindPV.[Generation]) AS [Battery Generation]
	  ,SUM(SSG.[Generation]) + SUM(BAT.[Generation]) + SUM([LoadReduction]) 
	  - SUM(BAT.[Load]*(-1)) + ISNULL(SUM(ODG.[DispGen]),0)  AS [GenerationTotal]
	  ,SUM([LoadForecast]) AS [Load Forecast]
	  ,SUM([LoadReduction]) AS [LoadReduction]
      ,SUM([Import]) AS [Import]
      ,SUM([Export]) AS [Export]
      ,SUM([PriceForecast]) AS [Price Forecast]
      ,SUM([ShadowPrice]) AS [Shadow Price]
	  ,SUM(SSG.[Generation]) AS [SSG]
	  ,SUM(BAT.[Load]*(-1)) AS [Battery Load]

		FROM [dbo].[vLoadForecast] AS OB
  
  JOIN [dbo].[SubStation] AS SS
  ON SS.[SubStationId] = OB.[SubStationId]

  LEFT OUTER JOIN [dbo].[OutputMaster] AS OA
  ON OA.[OptimizationId] = OB.[OptimizationId]

  LEFT OUTER JOIN 
  (SELECT [OptimizationId]
  ,[StartDateTime]
  ,SUM([Generation]) AS [Generation]
  FROM [dbo].[vSSG]
  WHERE [DeviceId] = '29'
  OR [DeviceId] = '31'
  GROUP BY [OptimizationId]
  ,[StartDateTime]
  )
   AS SSGWindPV
  ON SSGWindPV.[OptimizationId] = OB.[OptimizationId]
  AND SSGWindPV.[StartDateTime] = OB.[StartDateTime]
    LEFT OUTER JOIN 
  (SELECT [OptimizationId]
  ,[StartDateTime]
  ,SUM([Generation]) AS [Generation]
  FROM [dbo].[vSSG]
  GROUP BY [OptimizationId]
  ,[StartDateTime]
  )
   AS SSG
  ON SSG.[OptimizationId] = OB.[OptimizationId]
  AND SSG.[StartDateTime] = OB.[StartDateTime]

  LEFT OUTER JOIN
  (SELECT [OptimizationId]
      ,[StartDateTime]
      ,SUM([StateofCharge]) AS [StateofCharge]
      ,SUM([CommGen]) AS [CommGen]
      ,SUM([Generation]) AS [Generation]
      ,SUM([CommLoad]) AS [CommLoad]
      ,SUM([Load]) AS [Load]
  FROM [dbo].[vBattery]
  GROUP BY [OptimizationId]
      ,[StartDateTime]) AS BAT
  ON BAT.[OptimizationId] = OB.[OptimizationId]
  AND BAT.[StartDateTime] = OB.[StartDateTime]

  LEFT OUTER JOIN 
  (SELECT [OptimizationId]
      ,SUM([LoadReduction]) AS  [LoadReduction]
      ,SUM([CommLoadReduction]) AS [CommLoadReduction]
      ,[StartDateTime]
  FROM [dbo].[vDR]
  GROUP BY [OptimizationId]
      ,[StartDateTime]) DR
  ON DR.[OptimizationId] = OB.[OptimizationId]
  AND DR.[StartDateTime] = OB.[StartDateTime]

  LEFT OUTER JOIN
  (SELECT [OptimizationId]
      ,[StartDateTime]
      ,SUM([CommGen]) AS [CommGen]
      ,ISNULL(SUM([Generation]),0) AS [DispGen]
  FROM [dbo].[vDispGen]
  GROUP BY [OptimizationId]
      ,[StartDateTime])
  AS ODG
  ON ODG.[OptimizationId] = OB.[OptimizationId]
  AND ODG.[StartDateTime] = OB.[StartDateTime]



  GROUP BY 
  SS.[SubStationId] 
	   
	  ,OA.[IsSimulatedRun]
      ,OB.[StartDateTime]
	  ,OA.[IsRealTimeRun]
	  ,OB.[OptimizationId]
GO
/****** Object:  View [dbo].[vRunTotalsIndividual]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE VIEW [dbo].[vRunTotalsIndividual] AS
SELECT  
	    SS.[SubStationId] 
	  ,OB.[StartDateTime]
	  ,OA.[IsSimulatedRun]
	  ,OA.[IsRealTimeRun]
	  ,OB.[OptimizationId]
	  ,SUM(BAT.[Generation])+SUM(SSGWindPV.[Generation]) AS [Battery Generation]
	  ,SUM(SSG.[Generation]) + SUM(BAT.[Generation]) + SUM([LoadReduction]) 
	  - SUM(BAT.[Load]*(-1)) + ISNULL(SUM(ODG.[DispGen]),0)  AS [GenerationTotal]
	  ,SUM([LoadForecast]) AS [Load Forecast]
	  ,SUM([LoadReduction]) AS [LoadReduction]
      ,SUM([Import]) AS [Import]
      ,SUM([Export]) AS [Export]
      ,SUM([PriceForecast]) AS [Price Forecast]
      ,SUM([ShadowPrice]) AS [Shadow Price]
	  ,SUM(SSG.[Generation]) AS [SSG]
	  ,SUM(BAT.[Load]*(-1)) AS [Battery Load]

		FROM [dbo].[vLoadForecastIndividual] AS OB
  
  JOIN [dbo].[SubStation] AS SS
  ON SS.[SubStationId] = OB.[SubStationId]

  LEFT OUTER JOIN [dbo].[OutputMaster] AS OA
  ON OA.[OptimizationId] = OB.[OptimizationId]

  LEFT OUTER JOIN 
  (SELECT [OptimizationId]
  ,[StartDateTime]
  ,SUM([Generation]) AS [Generation]
  FROM [dbo].[vSSGIndividual]
  WHERE [DeviceId] = '29'
  OR [DeviceId] = '31'
  AND [StartDateTime] > (GETDATE() - DAY(14))
  GROUP BY [OptimizationId]
  ,[StartDateTime]
  )
   AS SSGWindPV
  ON SSGWindPV.[OptimizationId] = OB.[OptimizationId]
  AND SSGWindPV.[StartDateTime] = OB.[StartDateTime]
    LEFT OUTER JOIN 
  (SELECT [OptimizationId]
  ,[StartDateTime]
  ,SUM([Generation]) AS [Generation]
  FROM [dbo].[vSSGIndividual]
  WHERE [StartDateTime] > (GETDATE() - DAY(14))
  GROUP BY [OptimizationId]
  ,[StartDateTime]
  )
   AS SSG
  ON SSG.[OptimizationId] = OB.[OptimizationId]
  AND SSG.[StartDateTime] = OB.[StartDateTime]

  LEFT OUTER JOIN
  (SELECT [OptimizationId]
      ,[StartDateTime]
      ,SUM([StateofCharge]) AS [StateofCharge]
      ,SUM([CommGen]) AS [CommGen]
      ,SUM([Generation]) AS [Generation]
      ,SUM([CommLoad]) AS [CommLoad]
      ,SUM([Load]) AS [Load]
  FROM [dbo].[vBatteryIndividual]
  WHERE [StartDateTime] > (GETDATE() - DAY(14))
  GROUP BY [OptimizationId]
      ,[StartDateTime]) AS BAT
  ON BAT.[OptimizationId] = OB.[OptimizationId]
  AND BAT.[StartDateTime] = OB.[StartDateTime]

  LEFT OUTER JOIN 
  (SELECT [OptimizationId]
      ,SUM([LoadReduction]) AS  [LoadReduction]
      ,SUM([CommLoadReduction]) AS [CommLoadReduction]
      ,[StartDateTime]
  FROM [dbo].[vDRIndividual]
  WHERE [StartDateTime] > (GETDATE() - DAY(14))
  GROUP BY [OptimizationId]
      ,[StartDateTime]) DR
  ON DR.[OptimizationId] = OB.[OptimizationId]
  AND DR.[StartDateTime] = OB.[StartDateTime]

  LEFT OUTER JOIN
  (SELECT [OptimizationId]
      ,[StartDateTime]
      ,SUM([CommGen]) AS [CommGen]
      ,ISNULL(SUM([Generation]),0) AS [DispGen]
  FROM [dbo].[vDispGen]
  WHERE [StartDateTime] > (GETDATE() - DAY(14))
  GROUP BY [OptimizationId]
      ,[StartDateTime])
  AS ODG
  ON ODG.[OptimizationId] = OB.[OptimizationId]
  AND ODG.[StartDateTime] = OB.[StartDateTime]



  GROUP BY 
  SS.[SubStationId] 
	   
	  ,OA.[IsSimulatedRun]
      ,OB.[StartDateTime]
	  ,OA.[IsRealTimeRun]
	  ,OB.[OptimizationId]
GO
/****** Object:  Table [dbo].[BatteryCommand]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatteryCommand](
	[BatteryCommandId] [int] IDENTITY(1,1) NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[CommandName] [nvarchar](255) NOT NULL,
	[ClassName] [nvarchar](255) NOT NULL,
	[UserKey] [nvarchar](255) NOT NULL,
	[RequestId] [nvarchar](255) NOT NULL,
	[IoTHubResult] [bit] NOT NULL,
	[DeviceId] [nvarchar](255) NOT NULL,
	[ObjectName] [nvarchar](255) NULL,
	[SampleInterval] [int] NULL,
	[LocalTime] [datetime] NOT NULL,
	[UnitOfMeasure] [int] NULL,
	[CommaSeperatedValues] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[BatteryCommandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[CommandResponseLog]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommandResponseLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DeviceId] [nvarchar](255) NULL,
	[CommandName] [nvarchar](255) NULL,
	[PowerOn] [nvarchar](255) NULL,
	[RequestId] [nvarchar](255) NULL,
	[CommandState] [nvarchar](255) NULL,
	[ErrorMessage] [nvarchar](255) NULL,
	[Output] [nvarchar](255) NULL,
	[LocalTime] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
	[UnitOfMeasure] [nvarchar](255) NULL,
	[ClassName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[DeviceDemandOutput]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceDemandOutput](
	[DeviceDemandOutputId] [int] IDENTITY(1,1) NOT NULL,
	[DeviceId] [nvarchar](255) NULL,
	[EffectiveDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[Value] [decimal](10, 3) NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DeviceDemandOutputId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[DevicePowerPrice]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DevicePowerPrice](
	[DevicePowerPriceId] [int] IDENTITY(1,1) NOT NULL,
	[DeviceId] [nvarchar](255) NULL,
	[EffectiveDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[Value] [decimal](10, 3) NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DevicePowerPriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[DispatchCommand]    Script Date: 5/9/2017 4:11:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DispatchCommand](
	[CommandId] [int] IDENTITY(1,1) NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[CommandName] [nvarchar](255) NOT NULL,
	[ClassName] [nvarchar](255) NOT NULL,
	[UserKey] [nvarchar](255) NOT NULL,
	[RequestId] [nvarchar](255) NOT NULL,
	[IoTHubResult] [bit] NOT NULL,
	[DeviceId] [nvarchar](255) NOT NULL,
	[StartDateTimeParam] [datetime2](7) NOT NULL,
	[EndDateTimeParam] [datetime2](7) NOT NULL,
	[LoadForecastParam] [decimal](10, 3) NULL,
	[ImportParam] [decimal](10, 3) NULL,
	[ExportParam] [decimal](10, 3) NULL,
	[PriceForecastParam] [decimal](10, 3) NULL,
	[ShadowPriceParam] [decimal](10, 3) NULL,
	[LoadReductionValueParam] [decimal](10, 3) NULL,
	[GenerationValueParam] [decimal](10, 3) NULL,
PRIMARY KEY CLUSTERED 
(
	[CommandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[DispatchOutput]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DispatchOutput](
	[DispatchOutputId] [int] IDENTITY(1,1) NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Error] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[DispatchOutputId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[LogId] [bigint] IDENTITY(1,1) NOT NULL,
	[MethodName] [varchar](100) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ExceptionLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OptimizationInput]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OptimizationInput](
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[DeviceId] [nvarchar](255) NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[IntervalInMinutes] [int] NOT NULL,
	[AutoDispatch] [bit] NOT NULL,
	[SubStationLimits] [nvarchar](255) NOT NULL,
	[SimulatedRun] [bit] NOT NULL,
	[OptimizationRunName] [nvarchar](255) NOT NULL,
	[IsRealTimeRun] [bit] NOT NULL,
	[OverallDuration] [int] NOT NULL,
	[FirstMinutesValue] [int] NOT NULL,
	[FirstMinutesInterval] [int] NOT NULL,
	[RestMinutesInterval] [int] NOT NULL,
	[SubStationId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OptimizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OutputLimitViolation]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutputLimitViolation](
	[OutputLimitViolationId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[SolutionNum] [int] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[ImportMaxNum] [int] NOT NULL,
	[ImportMaxVV] [decimal](10, 3) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OutputLimitViolationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[RealTimeRunConfig]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RealTimeRunConfig](
	[SubStationId] [int] NOT NULL,
	[RealTimeRunInterval] [int] NOT NULL,
	[OverallDuration] [int] NOT NULL,
	[FirstMinutesValue] [int] NOT NULL,
	[FirstMinutesInterval] [int] NOT NULL,
	[RestMinutesInterval] [int] NOT NULL,
	[CommValuesDuration] [int] NOT NULL,
	[StartAfterMinutes] [int] NOT NULL,
	[LastUpdatedBy] [nvarchar](50) NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RealTimeRunConfig] PRIMARY KEY CLUSTERED 
(
	[SubStationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ResourceMapping]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourceMapping](
	[ResourceMappingId] [int] IDENTITY(1,1) NOT NULL,
	[ResourceProfileId] [int] NOT NULL,
	[SubStationId] [int] NOT NULL,
	[ResourceType] [nvarchar](255) NOT NULL,
	[ResourceName] [nvarchar](255) NOT NULL,
	[DisplayName] [nvarchar](255) NULL,
	[Longitude] [decimal](10, 5) NULL,
	[Latitude] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[StationLimits]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StationLimits](
	[StationLimitId] [int] IDENTITY(1,1) NOT NULL,
	[SubStationId] [int] NOT NULL,
	[RowKey] [int] NOT NULL,
	[Limit] [int] NOT NULL,
	[Price] [decimal](10, 3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StationLimitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
ALTER TABLE [dbo].[DeviceDemandOutput] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DevicePowerPrice] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[DispatchCommand] ADD  DEFAULT (getutcdate()) FOR [StartDateTimeParam]
GO
ALTER TABLE [dbo].[DispatchCommand] ADD  DEFAULT (getutcdate()) FOR [EndDateTimeParam]
GO
ALTER TABLE [dbo].[DispatchOutput] ADD  DEFAULT (getutcdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[ErrorLog] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OptimizationInput] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OptimizationInput] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[OptimizationInput] ADD  DEFAULT ((0)) FOR [SubStationId]
GO
ALTER TABLE [dbo].[OutputBattery] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OutputBattery] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[OutputDispGen] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OutputDispGen] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[OutputDR] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OutputDR] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[OutputLimitViolation] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OutputLimitViolation] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[OutputLimitViolation] ADD  DEFAULT (getutcdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[OutputLoadForecast] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OutputLoadForecast] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[OutputMaster] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OutputSSG] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[OutputSSG] ADD  DEFAULT (getutcdate()) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[DispatchCommand]  WITH CHECK ADD  CONSTRAINT [FK_DispatchCommand_OptimizationInput] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OptimizationInput] ([OptimizationId])
GO
ALTER TABLE [dbo].[DispatchCommand] CHECK CONSTRAINT [FK_DispatchCommand_OptimizationInput]
GO
ALTER TABLE [dbo].[DispatchOutput]  WITH CHECK ADD  CONSTRAINT [FK_DispatchOutput_OptimizationInput] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OptimizationInput] ([OptimizationId])
GO
ALTER TABLE [dbo].[DispatchOutput] CHECK CONSTRAINT [FK_DispatchOutput_OptimizationInput]
GO
ALTER TABLE [dbo].[OutputBattery]  WITH CHECK ADD  CONSTRAINT [FK_OutputBattery_OutputMaster] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OutputMaster] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputBattery] CHECK CONSTRAINT [FK_OutputBattery_OutputMaster]
GO
ALTER TABLE [dbo].[OutputBattery]  WITH CHECK ADD  CONSTRAINT [FK_OutputBattery_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[OutputBattery] CHECK CONSTRAINT [FK_OutputBattery_SubStation]
GO
ALTER TABLE [dbo].[OutputDispGen]  WITH CHECK ADD  CONSTRAINT [FK_OutputDispGen_OutputMaster] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OutputMaster] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputDispGen] CHECK CONSTRAINT [FK_OutputDispGen_OutputMaster]
GO
ALTER TABLE [dbo].[OutputDispGen]  WITH CHECK ADD  CONSTRAINT [FK_OutputDispGen_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[OutputDispGen] CHECK CONSTRAINT [FK_OutputDispGen_SubStation]
GO
ALTER TABLE [dbo].[OutputDR]  WITH CHECK ADD  CONSTRAINT [FK_OutputDR_OutputMaster] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OutputMaster] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputDR] CHECK CONSTRAINT [FK_OutputDR_OutputMaster]
GO
ALTER TABLE [dbo].[OutputDR]  WITH CHECK ADD  CONSTRAINT [FK_OutputDR_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[OutputDR] CHECK CONSTRAINT [FK_OutputDR_SubStation]
GO
ALTER TABLE [dbo].[OutputLimitViolation]  WITH CHECK ADD  CONSTRAINT [FK_OutputLimitViolation_OutputMaster] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OutputMaster] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputLimitViolation] CHECK CONSTRAINT [FK_OutputLimitViolation_OutputMaster]
GO
ALTER TABLE [dbo].[OutputLimitViolation]  WITH CHECK ADD  CONSTRAINT [FK_OutputLimitViolation_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[OutputLimitViolation] CHECK CONSTRAINT [FK_OutputLimitViolation_SubStation]
GO
ALTER TABLE [dbo].[OutputLoadForecast]  WITH CHECK ADD  CONSTRAINT [FK_OutputLoadForecast_OutputMaster] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OutputMaster] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputLoadForecast] CHECK CONSTRAINT [FK_OutputLoadForecast_OutputMaster]
GO
ALTER TABLE [dbo].[OutputLoadForecast]  WITH CHECK ADD  CONSTRAINT [FK_OutputLoadForecast_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[OutputLoadForecast] CHECK CONSTRAINT [FK_OutputLoadForecast_SubStation]
GO
ALTER TABLE [dbo].[OutputMaster]  WITH CHECK ADD  CONSTRAINT [FK_OutputMaster_OptimizationInput] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OptimizationInput] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputMaster] CHECK CONSTRAINT [FK_OutputMaster_OptimizationInput]
GO
ALTER TABLE [dbo].[OutputSSG]  WITH CHECK ADD  CONSTRAINT [FK_OutputSSG_OutputMaster] FOREIGN KEY([OptimizationId])
REFERENCES [dbo].[OutputMaster] ([OptimizationId])
GO
ALTER TABLE [dbo].[OutputSSG] CHECK CONSTRAINT [FK_OutputSSG_OutputMaster]
GO
ALTER TABLE [dbo].[OutputSSG]  WITH CHECK ADD  CONSTRAINT [FK_OutputSSG_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[OutputSSG] CHECK CONSTRAINT [FK_OutputSSG_SubStation]
GO
ALTER TABLE [dbo].[RealTimeRunConfig]  WITH CHECK ADD  CONSTRAINT [FK_RealTimeRunConfig_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[RealTimeRunConfig] CHECK CONSTRAINT [FK_RealTimeRunConfig_SubStation]
GO
ALTER TABLE [dbo].[StationLimits]  WITH CHECK ADD  CONSTRAINT [FK_StationLimits_SubStation] FOREIGN KEY([SubStationId])
REFERENCES [dbo].[SubStation] ([SubStationId])
GO
ALTER TABLE [dbo].[StationLimits] CHECK CONSTRAINT [FK_StationLimits_SubStation]
GO
/****** Object:  StoredProcedure [dbo].[DeviceDemandOutput_GetByDateRange]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeviceDemandOutput_GetByDateRange]
	@deviceId nvarchar(255),
@startDate datetime,
@endDate datetime
AS
	SELECT [DeviceDemandOutputId]
      ,[DeviceId]
      ,[EffectiveDateTime]
      ,[Unit]
      ,[Value]
      ,[ClassName]
      ,[CreatedDate]
  FROM [dbo].[DeviceDemandOutput]
  WHERE (  
  DeviceId=@deviceId
  AND
  [EffectiveDateTime] >= @startDate AND [EffectiveDateTime] <= @endDate
   )
GO
/****** Object:  StoredProcedure [dbo].[DevicePowerPrice_GetByDateRange]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DevicePowerPrice_GetByDateRange]
@deviceId nvarchar(255),
@startDate datetime,
@endDate datetime
AS
	SELECT [DevicePowerPriceId]
      ,[DeviceId]
      ,[EffectiveDateTime]
      ,[Unit]
      ,[Value]
      ,[ClassName]
      ,[CreatedDate]
  FROM [dbo].[DevicePowerPrice]
  WHERE (  
  DeviceId=@deviceId
  AND
  [EffectiveDateTime] >= @startDate AND [EffectiveDateTime] <= @endDate
   )
GO
/****** Object:  StoredProcedure [dbo].[DispatchOutput_Insert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DispatchOutput_Insert]
	@timeStamp Datetime,
	@description NVARCHAR(MAX),
	@error NVARCHAR(MAX),
	@optimizationId UNIQUEIDENTIFIER,
	@loadForecastCommandsJson NVARCHAR(MAX),
	@demandResponseCommandsJson NVARCHAR(MAX),
	@sSGCommandsJson NVARCHAR(MAX),
	@batteryCommandsJson NVARCHAR(MAX)
AS
	
	INSERT INTO [dbo].[DispatchOutput]
           (
           [OptimizationId]
           ,[Timestamp]
           ,[Description]
           ,[Error])
     VALUES
           (
            @optimizationId
           ,@timeStamp
           ,@description
           ,@error)

IF (@loadForecastCommandsJson <> '')
BEGIN
INSERT INTO DispatchCommand (CommandName, ClassName,UserKey, RequestId, IoTHubResult,DeviceId,OptimizationId,StartDateTimeParam,EndDateTimeParam ,LoadForecastParam,ImportParam,ExportParam,PriceForecastParam,ShadowPriceParam )
  SELECT *
 FROM OPENJSON(@loadForecastCommandsJson)
 WITH (
 CommandName NVARCHAR(255),
 ClassName NVARCHAR(255),
 UserKey NVARCHAR(255),
 RequestId NVARCHAR(255),
 IoTHubResult BIT,
 DeviceId NVARCHAR(255),
 
 OptimizationId UNIQUEIDENTIFIER '$.Parameters.OptimizationId',
 StartDateTime DATETIME2 '$.Parameters.StartDateTime',
 EndDateTime DATETIME2 '$.Parameters.EndDateTime',

 LoadForecast DECIMAL(10, 3) '$.Parameters.LoadForecast',
 Import DECIMAL(10, 3) '$.Parameters.Import',
 Export DECIMAL(10, 3)'$.Parameters.Export',
 PriceForecast DECIMAL(10, 3) '$.Parameters.PriceForecast',
 ShadowPrice DECIMAL(10, 3) '$.Parameters.ShadowPrice'
 )
END

IF (@demandResponseCommandsJson <> '')
BEGIN
 INSERT INTO DispatchCommand (CommandName, ClassName,UserKey, RequestId, IoTHubResult,DeviceId,OptimizationId,StartDateTimeParam,EndDateTimeParam ,LoadReductionValueParam )
  SELECT *
 FROM OPENJSON(@demandResponseCommandsJson)
 WITH (
 CommandName NVARCHAR(255),
 ClassName NVARCHAR(255),
 UserKey NVARCHAR(255),
 RequestId NVARCHAR(255),
 IoTHubResult BIT,
 DeviceId NVARCHAR(255),
 
 OptimizationId UNIQUEIDENTIFIER '$.Parameters.OptimizationId',
 StartDateTime DATETIME2 '$.Parameters.StartDateTime',
 EndDateTime DATETIME2 '$.Parameters.EndDateTime',

 LoadReductionValue DECIMAL(10, 3) '$.Parameters.LoadReductionValue'
 )
 END

 IF (@sSGCommandsJson <> '')
 BEGIN
 INSERT INTO DispatchCommand (CommandName, ClassName,UserKey, RequestId, IoTHubResult,DeviceId,OptimizationId,StartDateTimeParam,EndDateTimeParam, GenerationValueParam )
  SELECT *
 FROM OPENJSON(@sSGCommandsJson)
 WITH (
 CommandName NVARCHAR(255),
 ClassName NVARCHAR(255),
 UserKey NVARCHAR(255),
 RequestId NVARCHAR(255),
 IoTHubResult BIT,
 DeviceId NVARCHAR(255),
 
 OptimizationId UNIQUEIDENTIFIER '$.Parameters.OptimizationId',
 StartDateTime DATETIME2 '$.Parameters.StartDateTime',
 EndDateTime DATETIME2 '$.Parameters.EndDateTime',

  GenerationValue DECIMAL(10, 3) '$.Parameters.GenerationValue'
 )
 END


 IF (@batteryCommandsJson <> '')
 BEGIN
 INSERT INTO BatteryCommand(CommandName, ClassName,UserKey, RequestId, IoTHubResult,DeviceId,OptimizationId,ObjectName,SampleInterval,LocalTime,UnitOfMeasure,CommaSeperatedValues)
  SELECT *
 FROM OPENJSON(@batteryCommandsJson)
 WITH (
 CommandName NVARCHAR(255),
 ClassName NVARCHAR(255),
 UserKey NVARCHAR(255),
 RequestId NVARCHAR(255),
 IoTHubResult BIT,
 DeviceId NVARCHAR(255),
 
 OptimizationId UNIQUEIDENTIFIER,
 ObjectName NVARCHAR(255)  ,
 SampleInterval INT  ,
 LocalTime DATETIME2 ,
 UnitOfMeasure INT  ,
 CommaSeperatedValues NVARCHAR(255) 
 
 )
 END
GO
/****** Object:  StoredProcedure [dbo].[LogException]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LogException]
	@MethodName VARCHAR (100),
	@ErrorMessage NVARCHAR (MAX),
	@StackTrace NVARCHAR (MAX)=Null,
	@Comments NVARCHAR (MAX)=Null
AS
	INSERT INTO ErrorLog
	    ([MethodName]
		   ,[ErrorMessage]
           ,[StackTrace]
           ,[Comments])
		   VALUES (
		   @MethodName
		  ,@ErrorMessage
		 ,@StackTrace
		 ,@Comments)
GO
/****** Object:  StoredProcedure [dbo].[MarkAsDispatched]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MarkAsDispatched]
@optimizationId uniqueidentifier
AS
UPDATE OptimizationInput SET AutoDispatch = 1 WHERE OptimizationId = @optimizationId
GO
/****** Object:  StoredProcedure [dbo].[OptimizationInput_GetByDateRange]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OptimizationInput_GetByDateRange]
	@startDate datetime,
	@endDate datetime
AS
	SELECT [OptimizationId]
      ,[DeviceId]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[IntervalInMinutes]
      ,[AutoDispatch]
      ,[SubStationLimits]
      ,[SimulatedRun]
      ,[OptimizationRunName]
      ,[IsRealTimeRun]
      ,[OverallDuration]
      ,[FirstMinutesValue]
      ,[FirstMinutesInterval]
      ,[RestMinutesInterval]
  FROM [dbo].[OptimizationInput]
 WHERE (  [StartDateTime] >= @startDate AND [EndDateTime] <= @endDate )
GO
/****** Object:  StoredProcedure [dbo].[OptimizationInput_GetByOptimizationId]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OptimizationInput_GetByOptimizationId]
	@optimizationId UNIQUEIDENTIFIER
AS
	SELECT [OptimizationId]
      ,[DeviceId]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[IntervalInMinutes]
      ,[AutoDispatch]
      ,[SubStationLimits]
      ,[SimulatedRun]
      ,[OptimizationRunName]
      ,[IsRealTimeRun]
      ,[OverallDuration]
      ,[FirstMinutesValue]
      ,[FirstMinutesInterval]
      ,[RestMinutesInterval]
	  ,[OptimizationInput].[SubStationId]
	  ,[SubStationName]
  FROM [dbo].[OptimizationInput]
  LEFT OUTER JOIN [SubStation] ON [SubStation].SubStationId = [OptimizationInput].SubStationId
 WHERE [OptimizationId]=@optimizationId
GO
/****** Object:  StoredProcedure [dbo].[OptimizationInput_Insert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OptimizationInput_Insert]
@OptimizationId uniqueidentifier,
	@DeviceId nvarchar(255),
	@StartDateTime datetime,
	@EndDateTime datetime,
	@IntervalInMinutes int,
	@AutoDispatch bit,
	@SubStationLimits nvarchar(255),
	@SimulatedRun bit,
	@OptimizationRunName nvarchar(255),
	@IsRealTimeRun bit,
	@OverallDuration int,
	@FirstMinutesValue int,
	@FirstMinutesInterval int,
	@RestMinutesInterval int,
	@SubStationId int = 0


AS

SET NOCOUNT ON;



	INSERT INTO [dbo].[OptimizationInput]
           (
		   [OptimizationId]
           ,[DeviceId]
           ,[StartDateTime]
           ,[EndDateTime]
           ,[IntervalInMinutes]
           ,[AutoDispatch]
           ,[SubStationLimits]
           ,[SimulatedRun]
           ,[OptimizationRunName]
           ,[IsRealTimeRun]
           ,[OverallDuration]
           ,[FirstMinutesValue]
           ,[FirstMinutesInterval]
           ,[RestMinutesInterval]
		   ,[SubStationId])
     VALUES
           (
		   @OptimizationId
           ,@DeviceId
           ,@StartDateTime
           ,@EndDateTime
           ,@IntervalInMinutes
           ,@AutoDispatch
           ,@SubStationLimits
           ,@SimulatedRun
           ,@OptimizationRunName
           ,@IsRealTimeRun
           ,@OverallDuration
           ,@FirstMinutesValue
           ,@FirstMinutesInterval
           ,@RestMinutesInterval
		   ,@SubStationId)

SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [dbo].[OutputDocument_GetByOptimizationId]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OutputDocument_GetByOptimizationId]
	@optimizationId UNIQUEIDENTIFIER
	
AS

/*
Recordset 1: OutputMaster
*/

SELECT [OptimizationId]
      ,[ObjFuncName]
      ,[Goal]
      ,[ObjFuncValue]
      ,[IsSimulatedRun]
      ,[IsRealTimeRun]
      ,[SolutionNum]
      ,[OptimizationRunName]
  FROM [dbo].[OutputMaster]
  WHERE [OptimizationId]=@optimizationId

 /*
Recordset 2: OutputLoadForecast
*/

	SELECT [OutputLoadForecastId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[LoadForecast]
      ,[Import]
      ,[Export]
      ,[PriceForecast]
      ,[ShadowPrice]
  FROM [dbo].[OutputLoadForecast]
  WHERE [OptimizationId]=@optimizationId

 /*
Recordset 3: OutputLimitViolation
*/

  SELECT [OutputLimitViolationId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[ImportMaxNum]
      ,[ImportMaxVV]
      ,[Timestamp]
  FROM [dbo].[OutputLimitViolation]
  WHERE [OptimizationId]=@optimizationId

 /*
Recordset 4: OutputDR
*/

  SELECT [OutputDRId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[LoadReduction]
      ,[CommLoadReduction]
      ,[StartDateTime]
      ,[EndDateTime]
	  ,[Violation]
	  ,[BidId]
  FROM [dbo].[OutputDR]
  WHERE [OptimizationId]=@optimizationId

 /*
Recordset 5: OutputSSG
*/

  SELECT [OutputSSGId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[Generation]
	  ,[Violation]
	  ,[BidId]
  FROM [dbo].[OutputSSG]
  WHERE [OptimizationId]=@optimizationId

   /*
Recordset 6: OutputBattery
*/

  SELECT [OutputBatteryId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[DeviceId]
      ,[StateofCharge]
      ,[CommGen]
      ,[Generation]
      ,[CommLoad]
      ,[Load]
	  ,[Violation]
	  ,[BidId]
  FROM [dbo].[OutputBattery]
  WHERE [OptimizationId]=@optimizationId

 /*
Recordset 7: OutputDispGen
*/ 
  SELECT [OutputDispGenId]
      ,[SubStationId]
      ,[OptimizationId]
      ,[DeviceId]
      ,[SolutionNum]
      ,[StartDateTime]
      ,[EndDateTime]
      ,[CommGen]
      ,[Generation]
	  ,[Violation]
	  ,[BidId]
  FROM [dbo].[OutputDispGen]
  WHERE [OptimizationId]=@optimizationId
GO
/****** Object:  StoredProcedure [dbo].[OutputDocument_Insert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OutputDocument_Insert]
	@loadForecastJson NVARCHAR(MAX),
	@limitViolationJson NVARCHAR(MAX),
	@demandResponseJson NVARCHAR(MAX),
	@sSGOutputtJson NVARCHAR(MAX),
	@batteryOutputJson NVARCHAR(MAX),
	@dispGenOutputJson NVARCHAR(MAX),
	@outputMasterJson NVARCHAR(MAX)

AS

BEGIN TRY
	BEGIN TRANSACTION
INSERT INTO OutputMaster (ObjFuncName, OptimizationId, SolutionNum, Goal, ObjFuncValue, IsSimulatedRun,IsRealTimeRun,OptimizationRunName)
 SELECT *
 FROM OPENJSON(@outputMasterJson)
 WITH (ObjFuncName NVARCHAR(MAX),
 OptimizationId UNIQUEIDENTIFIER '$.PartitionKey',
 SolutionNum INT,
 Goal NVARCHAR(MAX),
 ObjFuncValue DECIMAL(10, 3),
  

 IsSimulatedRun BIT,
 IsRealTimeRun BIT,
 OptimizationRunName NVARCHAR(MAX)
 
)

INSERT INTO OutputLoadForecast (SubStationId, OptimizationId, SolutionNum, StartDateTime, EndDateTime,LoadForecast,Import,Export,PriceForecast,ShadowPrice)
 SELECT *
 FROM OPENJSON(@loadForecastJson)
 WITH (SubStationId INT,
 OptimizationId UNIQUEIDENTIFIER,
 SolutionNum INT,
 StartDateTime DATETIME2,
 EndDateTime DATETIME2,
 LoadForecast DECIMAL(10, 3),
 Import DECIMAL(10, 3),
 Export DECIMAL(10, 3),
 PriceForecast DECIMAL(10, 3),
 ShadowPrice DECIMAL(10, 3)
)

INSERT INTO OutputLimitViolation (SubStationId, OptimizationId, SolutionNum, StartDateTime, EndDateTime, ImportMaxNum,ImportMaxVV)
 SELECT *
 FROM OPENJSON(@limitViolationJson)
 WITH (SubStationId INT,
 OptimizationId UNIQUEIDENTIFIER,
 SolutionNum INT,
 StartDateTime DATETIME2,
 EndDateTime DATETIME2,
  

 ImportMaxNum INT,
 ImportMaxVV DECIMAL(10, 3)
 
)

INSERT INTO OutputDR (SubStationId, OptimizationId, SolutionNum, StartDateTime, EndDateTime,DeviceId,LoadReduction,CommLoadReduction,Violation,BidId)
 SELECT *
 FROM OPENJSON(@demandResponseJson)
 WITH (SubStationId INT,
 OptimizationId UNIQUEIDENTIFIER,
 SolutionNum INT,
 StartDateTime DATETIME2,
 EndDateTime DATETIME2,

 DeviceId NVARCHAR(MAX),
 LoadReduction DECIMAL(10, 3),
 CommLoadReduction DECIMAL(10, 3),
 Violation DECIMAL(10, 3),
 BidId UNIQUEIDENTIFIER 
 
)


INSERT INTO OutputSSG (SubStationId, OptimizationId, SolutionNum, StartDateTime, EndDateTime, DeviceId,Generation,Violation,BidId)
 SELECT *
 FROM OPENJSON(@sSGOutputtJson)
 WITH (SubStationId INT,
 OptimizationId UNIQUEIDENTIFIER,
 SolutionNum INT,
 StartDateTime DATETIME2,
 EndDateTime DATETIME2,
  

 DeviceId NVARCHAR(MAX),
 Generation DECIMAL(10, 3),
 Violation DECIMAL(10, 3),
 BidId UNIQUEIDENTIFIER 
 
)

INSERT INTO OutputBattery (SubStationId, OptimizationId, SolutionNum, StartDateTime, EndDateTime, DeviceId,Generation,StateofCharge,CommGen,CommLoad,Load,Violation,BidId)
 SELECT *
 FROM OPENJSON(@batteryOutputJson)
 WITH (SubStationId INT,
 OptimizationId UNIQUEIDENTIFIER,
 SolutionNum INT,
 StartDateTime DATETIME2,
 EndDateTime DATETIME2,
  

 DeviceId NVARCHAR(MAX),
 Generation DECIMAL(10, 3),
 StateofCharge DECIMAL(10, 3),
 CommGen INT,
 CommLoad INT,
 Load DECIMAL(10,3),
 Violation DECIMAL(10, 3),
 BidId UNIQUEIDENTIFIER 
 
)

INSERT INTO OutputDispGen (SubStationId, OptimizationId, SolutionNum, StartDateTime, EndDateTime, DeviceId,Generation,CommGen,Violation,BidId)
 SELECT *
 FROM OPENJSON(@dispGenOutputJson)
 WITH (SubStationId INT,
 OptimizationId UNIQUEIDENTIFIER,
 SolutionNum INT,
 StartDateTime DATETIME2,
 EndDateTime DATETIME2,
  

 DeviceId NVARCHAR(MAX),
 Generation DECIMAL(10, 3),
 CommGen INT,
 Violation DECIMAL(10, 3),
 BidId UNIQUEIDENTIFIER

)

COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
   
	EXEC LogException 'OutputDocument_Insert', @ErrorMessage

END CATCH
GO
/****** Object:  StoredProcedure [dbo].[RealTimeRunConfig_GetAll]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RealTimeRunConfig_GetAll]	
AS
	SELECT * from RealTimeRunConfig
GO
/****** Object:  StoredProcedure [dbo].[RealTimeRunConfig_Upsert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RealTimeRunConfig_Upsert]
	@SubStationID int,
	@RealTimeRunInterval int,
	@OverallDuration int,
	@FirstMinutesValue int,
	@FirstMinutesInterval int,
	@RestMinutesInterval int,
	@CommValuesDuration int,
	@StartAfterMinutes int,
	@LastUpdatedBy nvarchar(50),
	@LastUpdateDate datetime
AS
	if exists (select 1 from [dbo].[RealTimeRunConfig] where SubStationId = @SubStationID)
		update 
			[dbo].[RealTimeRunConfig] 
		set
			RealTimeRunInterval = @RealTimeRunInterval,
			OverallDuration = @OverallDuration,
			FirstMinutesValue = @FirstMinutesValue,
			FirstMinutesInterval = @FirstMinutesInterval,
			RestMinutesInterval = @RestMinutesInterval,
			CommValuesDuration = @CommValuesDuration,
			StartAfterMinutes = @StartAfterMinutes,
			LastUpdatedBy = @LastUpdatedBy,
			LastUpdateDate = @LastUpdateDate
		where
			SubStationId = @SubStationID
	else
		insert into [dbo].[RealTimeRunConfig]
		(SubStationId, RealTimeRunInterval, OverallDuration, FirstMinutesValue, FirstMinutesInterval, RestMinutesInterval, CommValuesDuration, StartAfterMinutes, LastUpdatedBy, LastUpdateDate)
		values 
		(@SubStationId, @RealTimeRunInterval, @OverallDuration, @FirstMinutesValue, @FirstMinutesInterval, @RestMinutesInterval, @CommValuesDuration, @StartAfterMinutes, @LastUpdatedBy, @LastUpdateDate)
GO
/****** Object:  StoredProcedure [dbo].[ResourceMapping_GetBySubStationId]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceMapping_GetBySubStationId]
	@subStationId int
AS
	SELECT [ResourceMappingId]
      ,[ResourceProfileId]
      ,[SubStationId]
      ,[ResourceName]
      ,[ResourceType]
  FROM [dbo].[ResourceMapping]
  WHERE [SubStationId] = @subStationId
GO
/****** Object:  StoredProcedure [dbo].[ResourceMapping_GetSubStationMappedToResource]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceMapping_GetSubStationMappedToResource]
AS
	SELECT [ResourceProfileId]
      ,[SubStationId]
FROM [dbo].[ResourceMapping]
GO
/****** Object:  StoredProcedure [dbo].[ResourceMapping_Insert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceMapping_Insert]
	@json NVARCHAR(MAX)
AS
 DELETE FROM ResourceMapping
 INSERT INTO ResourceMapping(ResourceProfileId,ResourceName,DisplayName,ResourceType,SubstationId)
 SELECT * 
 FROM OPENJSON(@json)
 WITH (ResourceProfileId int,
 ResourceName nvarchar(255), 
 DisplayName nvarchar(255),
 ResourceType nvarchar(255), 
 SubstationId int
 )
GO
/****** Object:  StoredProcedure [dbo].[SubStation_Edit]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStation_Edit]
    @subStationId int,
	@rowKey nvarchar(255),
	@subStationName nvarchar(255),
	@macroLoadForecastDeviceNames nvarchar(255),
	@priceDataDeviceName nvarchar(255)
AS
UPDATE [SubStation]
   SET [RowKey] = @rowKey
      ,[SubStationName] = @subStationName
      ,[MacroLoadForecastDeviceNames] = @macroLoadForecastDeviceNames
      ,[PriceDataDeviceName] = @priceDataDeviceName
 WHERE SubStationId=@subStationId
GO
/****** Object:  StoredProcedure [dbo].[SubStation_GetBySubStationId]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStation_GetBySubStationId]
	@subStationId int = Null	
AS
	SELECT [SubStationId]
	  ,[RowKey]
      ,[SubStationName]
      ,[MacroLoadForecastDeviceNames]
      ,[PriceDataDeviceName]
  FROM [SubStation]
  WHERE( @subStationId IS Null OR [SubStation].[SubStationId] = @subStationId )
GO
/****** Object:  StoredProcedure [dbo].[SubStation_Insert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStation_Insert]
	@subStationName nvarchar(255),
	@rowKey nvarchar(255),
	@macroLoadForecastDeviceNames nvarchar(255),
	@priceDataDeviceName nvarchar(255)
AS

SET NOCOUNT ON;
DECLARE  @subStationId int

	INSERT INTO [SubStation]
           ([SubStationName]
		   ,[RowKey]
           ,[MacroLoadForecastDeviceNames]
           ,[PriceDataDeviceName])
		   VALUES (
		   @subStationName
		   ,@rowKey
		 ,@macroLoadForecastDeviceNames
		 ,@priceDataDeviceName)

SET @subStationId = SCOPE_IDENTITY();

SET NOCOUNT OFF;

SELECT @subStationId AS [SubStationId];
GO
/****** Object:  StoredProcedure [dbo].[SubStationLimit_Edit]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStationLimit_Edit]
	@subStationLimitId INT,
	@limitPrice DECIMAL(10, 3),
	@limitValue INT
AS
UPDATE [dbo].[StationLimits]
   SET 
      [Limit] = @limitValue
      ,[Price] = @limitPrice
 WHERE StationLimitId=@subStationLimitId
GO
/****** Object:  StoredProcedure [dbo].[SubStationLimit_GetByStationLimitId]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStationLimit_GetByStationLimitId]
	@stationLimitId int
	
AS
	SELECT  [StationLimitId]
      ,[SubStationId]
      ,[Limit]
      ,[Price]
  FROM [StationLimits]
  WHERE [StationLimits].[StationLimitId] =@stationLimitId
GO
/****** Object:  StoredProcedure [dbo].[SubStationLimit_GetBySubStationId]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStationLimit_GetBySubStationId]
	@subStationId int
	
AS
	SELECT  [StationLimitId]
      ,[SubStationId]
      ,[Limit]
      ,[Price]
	  ,[RowKey]
  FROM [StationLimits]
  WHERE [StationLimits].[SubStationId] =@subStationId
GO
/****** Object:  StoredProcedure [dbo].[SubStationLimit_Insert]    Script Date: 5/9/2017 4:11:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubStationLimit_Insert]
	@subStationId int,
	@limitPrice DECIMAL(10, 3),
	@limitValue INT
AS
SET NOCOUNT ON;
DECLARE @rowKey int
DECLARE @stationLimitId int

 SELECT @rowKey=COUNT(SubStationId) FROM [StationLimits] WHERE SubStationId=@subStationId

	INSERT INTO [dbo].[StationLimits]
           ([SubStationId]
		   ,[RowKey]
           ,[Limit]
           ,[Price])
     VALUES
           (@subStationId
          ,@rowKey+1
           ,@limitValue
		    ,@limitPrice)

SET @stationLimitId = SCOPE_IDENTITY();
SET NOCOUNT OFF;

SELECT @stationLimitId AS [SubStationLimitId];
GO
