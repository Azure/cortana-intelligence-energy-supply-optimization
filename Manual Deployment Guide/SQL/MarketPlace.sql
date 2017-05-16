
CREATE FUNCTION [dbo].[SplitToVarchars] (
		@toSplit nvarchar(4000),
		@delimiter nchar(1)
	)
RETURNS TABLE
AS

	RETURN
	(
		WITH SplitToVarchars( stpos, endpos )
		AS (
			SELECT 0 AS stpos, CharIndex( @delimiter, @toSplit ) AS endpos
			
			UNION ALL
			
			SELECT
				endpos + 1,
				CharIndex( @delimiter, @toSplit, endpos + 1 )
			FROM
				[SplitToVarchars]
			WHERE
				endpos > 0
		)
		SELECT
			'Id' = Row_Number() OVER ( ORDER BY ( SELECT 1 ) ),
			'Data' = Cast( SubString( @toSplit, stpos, Coalesce( NullIf( endpos, 0 ),
				Len( @toSplit ) + 1 ) - stpos ) as varchar(50) )
		FROM [SplitToVarchars]
	);
GO
/****** Object:  Table [dbo].[BatteryState]    Script Date: 5/9/2017 4:02:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatteryState](
	[BatteryStateId] [uniqueidentifier] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[MarketDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[SampleInterval] [int] NULL,
	[Value] [decimal](10, 3) NULL,
	[ObjectName] [nvarchar](255) NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BatteryStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BatteryTelemetry]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BatteryTelemetry](
	[BatteryTelemetryId] [uniqueidentifier] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[MarketDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[SampleInterval] [int] NULL,
	[Value] [decimal](10, 3) NULL,
	[ObjectName] [nvarchar](255) NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BatteryTelemetryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Bid]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bid](
	[BidId] [uniqueidentifier] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[MarketDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[GenMax] [decimal](10, 3) NULL,
	[GenMin] [decimal](10, 3) NULL,
	[LoadMax] [decimal](10, 3) NULL,
	[LoadMin] [decimal](10, 3) NULL,
	[LimitMax] [decimal](10, 3) NULL,
	[LimitMin] [decimal](10, 3) NULL,
	[GenPrice] [decimal](10, 3) NULL,
	[LoadPrice] [decimal](10, 3) NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BidId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BidDispatch]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BidDispatch](
	[BidDispatchId] [bigint] IDENTITY(1,1) NOT NULL,
	[BidId] [uniqueidentifier] NOT NULL,
	[SubstationName] [nvarchar](255) NULL,
	[DispatchMessage] [nvarchar](255) NULL,
	[OptimizationId] [uniqueidentifier] NULL,
	[ClearedValue] [decimal](10, 6) NULL,
	[CreatedDateTime] [datetime] NULL,
 CONSTRAINT [PK__tmp_ms_x__BB121C4667A92212] PRIMARY KEY CLUSTERED 
(
	[BidDispatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BidLatest]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BidLatest](
	[BidId] [uniqueidentifier] NULL,
	[DeviceId] [int] NOT NULL,
	[MarketDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[GenMax] [decimal](10, 3) NULL,
	[GenMin] [decimal](10, 3) NULL,
	[LoadMax] [decimal](10, 3) NULL,
	[LoadMin] [decimal](10, 3) NULL,
	[LimitMax] [decimal](10, 3) NULL,
	[LimitMin] [decimal](10, 3) NULL,
	[GenPrice] [decimal](10, 3) NULL,
	[LoadPrice] [decimal](10, 3) NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DeviceId] ASC,
	[MarketDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[BidResult]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BidResult](
	[BidResultId] [bigint] IDENTITY(1,1) NOT NULL,
	[BidId] [uniqueidentifier] NULL,
	[GenValue] [decimal](10, 3) NULL,
	[LoadValue] [decimal](10, 3) NULL,
	[OptimizationId] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BidResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 5/9/2017 4:02:23 PM ******/
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
/****** Object:  Table [dbo].[InputFlexValues]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InputFlexValues](
	[InputFlexId] [bigint] IDENTITY(1,1) NOT NULL,
	[DeviceId] [nvarchar](255) NOT NULL,
	[LocalTime] [datetime] NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[UnitOfMeasure] [int] NULL,
	[ClassName] [nvarchar](255) NULL,
	[Value] [decimal](10, 3) NULL,
	[FlexValue] [decimal](10, 3) NULL,
	[Price] [decimal](10, 3) NULL,
PRIMARY KEY CLUSTERED 
(
	[InputFlexId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[LoadState]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoadState](
	[LoadStateId] [int] IDENTITY(1,1) NOT NULL,
	[DeviceId] [int] NOT NULL,
	[EffectiveDateTime] [datetime] NOT NULL,
	[Unit] [int] NULL,
	[Value] [int] NULL,
	[ClassName] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LoadStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[OptimizationResult]    Script Date: 5/9/2017 4:02:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OptimizationResult](
	[OptimizationResultId] [bigint] IDENTITY(1,1) NOT NULL,
	[OptimizationId] [uniqueidentifier] NOT NULL,
	[OptimizationRunName] [nvarchar](255) NOT NULL,
	[OptimizationRunTime] [datetime] NOT NULL,
	[OverallDuration] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OptimizationResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ResourceProfile]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourceProfile](
	[ResourceProfileId] [int] IDENTITY(1,1) NOT NULL,
	[TenantId] [nvarchar](255) NOT NULL,
	[ResourceType] [nvarchar](255) NOT NULL,
	[RowKey] [nvarchar](255) NOT NULL,
	[UpTimeMax] [decimal](10, 3) NOT NULL,
	[DayUpTimeMax] [decimal](10, 3) NOT NULL,
	[DownTimeMin] [decimal](10, 3) NOT NULL,
	[PowerMin] [decimal](10, 3) NOT NULL,
	[PowerMax] [decimal](10, 3) NOT NULL,
	[RampUpMax] [decimal](10, 3) NOT NULL,
	[RampDownMax] [decimal](10, 3) NOT NULL,
	[SocMin] [decimal](10, 3) NOT NULL,
	[SocMax] [decimal](10, 3) NOT NULL,
	[ChargeRateMin] [decimal](10, 3) NOT NULL,
	[ChargeRateMax] [decimal](10, 3) NOT NULL,
	[DischargeRateMin] [decimal](10, 3) NOT NULL,
	[DischargeRateMax] [decimal](10, 3) NOT NULL,
	[Price] [decimal](10, 3) NOT NULL,
	[Latitude] [decimal](10, 5) NOT NULL,
	[Longitude] [decimal](10, 5) NOT NULL,
	[AutoDispatch] [bit] NOT NULL,
	[DisplayName] [nvarchar](255) NOT NULL,
	[Efficiency] [decimal](10, 3) NOT NULL,
	[ChargePrice] [decimal](10, 3) NOT NULL,
	[Enabled] [bit] NOT NULL,
	[MeterId] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Tenant]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tenant](
	[TenantId] [nvarchar](255) NOT NULL,
	[TenantName] [nvarchar](255) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastUpdatedBy] [nvarchar](100) NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK__tmp_ms_x__2E9B47E1808E426B] PRIMARY KEY CLUSTERED 
(
	[TenantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[TraderWebAdmin]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TraderWebAdmin](
	[EmailAddress] [nvarchar](100) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_TraderWebAdmin] PRIMARY KEY CLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[UserInfoHashed]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfoHashed](
	[UserInfoId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](255) NOT NULL,
	[UserPassword] [varbinary](max) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
ALTER TABLE [dbo].[BatteryState] ADD  DEFAULT (newid()) FOR [BatteryStateId]
GO
ALTER TABLE [dbo].[BatteryState] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[BatteryTelemetry] ADD  DEFAULT (newid()) FOR [BatteryTelemetryId]
GO
ALTER TABLE [dbo].[BatteryTelemetry] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Bid] ADD  DEFAULT (newid()) FOR [BidId]
GO
ALTER TABLE [dbo].[Bid] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[BidDispatch] ADD  CONSTRAINT [DF__tmp_ms_xx__Creat__7F80E8EA]  DEFAULT (getutcdate()) FOR [CreatedDateTime]
GO
ALTER TABLE [dbo].[BidLatest] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[BidResult] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ErrorLog] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[LoadState] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OptimizationResult] ADD  DEFAULT (getutcdate()) FOR [OptimizationRunTime]
GO
ALTER TABLE [dbo].[Tenant] ADD  CONSTRAINT [DF_Tenant_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TraderWebAdmin] ADD  CONSTRAINT [DF_TraderWebAdmin_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[UserInfoHashed] ADD  DEFAULT (newid()) FOR [UserInfoId]
GO
ALTER TABLE [dbo].[UserInfoHashed] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[BatteryState]  WITH CHECK ADD  CONSTRAINT [FK_BatteryState_ResourceProfile] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[ResourceProfile] ([ResourceProfileId])
GO
ALTER TABLE [dbo].[BatteryState] CHECK CONSTRAINT [FK_BatteryState_ResourceProfile]
GO
ALTER TABLE [dbo].[BatteryTelemetry]  WITH CHECK ADD  CONSTRAINT [FK_BatteryTelemetry_ResourceProfile] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[ResourceProfile] ([ResourceProfileId])
GO
ALTER TABLE [dbo].[BatteryTelemetry] CHECK CONSTRAINT [FK_BatteryTelemetry_ResourceProfile]
GO
ALTER TABLE [dbo].[Bid]  WITH CHECK ADD  CONSTRAINT [FK_TradeBids_ResourceProfile] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[ResourceProfile] ([ResourceProfileId])
GO
ALTER TABLE [dbo].[Bid] CHECK CONSTRAINT [FK_TradeBids_ResourceProfile]
GO
ALTER TABLE [dbo].[BidDispatch]  WITH CHECK ADD  CONSTRAINT [FK_BidDispatch_Bid] FOREIGN KEY([BidId])
REFERENCES [dbo].[Bid] ([BidId])
GO
ALTER TABLE [dbo].[BidDispatch] CHECK CONSTRAINT [FK_BidDispatch_Bid]
GO
ALTER TABLE [dbo].[BidLatest]  WITH CHECK ADD  CONSTRAINT [FK_BidLatest_ResourceProfile] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[ResourceProfile] ([ResourceProfileId])
GO
ALTER TABLE [dbo].[BidLatest] CHECK CONSTRAINT [FK_BidLatest_ResourceProfile]
GO
ALTER TABLE [dbo].[BidResult]  WITH CHECK ADD  CONSTRAINT [FK_BidResult_Bid] FOREIGN KEY([BidId])
REFERENCES [dbo].[Bid] ([BidId])
GO
ALTER TABLE [dbo].[BidResult] CHECK CONSTRAINT [FK_BidResult_Bid]
GO
ALTER TABLE [dbo].[ResourceProfile]  WITH CHECK ADD  CONSTRAINT [FK_ResourceProfile_Tenant] FOREIGN KEY([TenantId])
REFERENCES [dbo].[Tenant] ([TenantId])
GO
ALTER TABLE [dbo].[ResourceProfile] CHECK CONSTRAINT [FK_ResourceProfile_Tenant]
GO
/****** Object:  StoredProcedure [dbo].[AutomaticRunTotals]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Espen Brandt-Kjelsen
-- Create date: 05.01.2017
-- Description:	AutomaticRunTotals
-- =============================================
CREATE PROCEDURE [dbo].[AutomaticRunTotals] 

AS
BEGIN

	SET NOCOUNT ON;

	SELECT * FROM dbo.SubStation
END
GO
/****** Object:  StoredProcedure [dbo].[Battery]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Espen Brandt-Kjelsen
-- Create date: 05.01.2017
-- Description:	AutomaticRunTotals
-- =============================================
CREATE PROCEDURE [dbo].[Battery] 
@IsSimulatedRun int

AS
BEGIN

	SET NOCOUNT ON;
DECLARE @OptimizationId TABLE
([OptimizationId] nvarchar(256))

IF @IsSimulatedRun = 0
BEGIN
	INSERT INTO @OptimizationId
  	SELECT [OptimizationId]
	FROM [dbo].[OutputBattery]
	WHERE [OutputBatteryId] IN (SELECT MAX([OutputBatteryId]) FROM [dbo].[OutputBattery])
	GROUP BY [OptimizationId]
END
Else If @IsSimulatedRun = 1
BEGIN
    INSERT INTO @OptimizationId
  	SELECT [OptimizationId]
	FROM [dbo].[OutputBattery]
	GROUP BY [OptimizationId]
END

SELECT SS.[SubStationName] AS 'Substation'
	  ,OA.[OptimizationRunName] AS 'Run Name'
      ,[StartDateTime] AS 'Time'
      --,[EndDateTime]
      ,RP.[DisplayName] AS 'Battery'
      ,[StateofCharge]
      ,[CommGen]
      ,[Generation]
      ,[CommLoad]
      ,[Load]
  FROM [dbo].[OutputBattery] AS OB

  LEFT OUTER JOIN [dbo].[ResourceProfile] AS RP
  ON OB.[DeviceId] = RP.[ResourceProfileId]
  AND OB.[SubStationId] = RP.[SubStationId]
  
  LEFT OUTER JOIN [dbo].[SubStation] AS SS
  ON SS.[SubStationId] = OB.[SubStationId]

  LEFT OUTER JOIN [dbo].[OutputMaster] AS OA
  ON OA.[OptimizationId] = OB.[OptimizationId]

  WHERE RP.[Enabled] = 1
  AND OB.[OptimizationId] IN (SELECT [OptimizationId] FROM @OptimizationId)
  AND OA.[IsSimulatedRun] = @IsSimulatedRun


	

eof:

RETURN 

END
GO
/****** Object:  StoredProcedure [dbo].[Battery_GetSoC]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Battery_GetSoC]
AS
  SELECT B1.DeviceId, B1.Value, B1.MarketDateTime
  FROM [dbo].[BatteryState] B1 
  inner join (select deviceid, MAX(MarketDateTime) as maxdatetime from [dbo].[BatteryState]
  group by deviceid) B2
  ON B2.deviceid = B1.deviceid and B2.maxdatetime = B1.MarketDateTime
GO
/****** Object:  StoredProcedure [dbo].[Bid_Insert]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Bid_Insert]
	@DeviceId int,
	@MarketDateTime datetime,
	@Unit INT,
	@OfferValue DECIMAL(10, 3),
	@OfferPrice DECIMAL(10, 3),
	@ClassName NVARCHAR(255),
	@CreatedBy  NVARCHAR(255)
AS


 INSERT INTO Bid (DeviceId, MarketDateTime,Unit,GenMax,GenMin,GenPrice,ClassName,CreatedBy,CreatedDate)
 VALUES (@DeviceId,
 @MarketDateTime,
 @Unit,
 @OfferValue,
 @OfferValue,
 @OfferPrice,
 @ClassName,
 @CreatedBy,
 getdate()
 )
GO
/****** Object:  StoredProcedure [dbo].[BidDispatch_GetBidsByTenantIdAndTimeRange]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BidDispatch_GetBidsByTenantIdAndTimeRange]
	@startDateTime datetime,
	@endDateTime datetime,
	@tenantId Uniqueidentifier = Null,
	@deviceId nvarchar(255) = Null,
	@substation nvarchar(255) = Null
AS
	SELECT b1.BidId, b1.MarketDateTime,b1.DeviceId , GenMax,GenMin,LoadMax,LoadMin,Unit,GenPrice, d.ClearedValue,
	p.TenantId,p.ResourceType,p.Price AS 'ResourcePrice', p.DisplayName AS 'DeviceName',
	d.SubStationName, d.BidDispatchId,CASE WHEN d.BidDispatchId IS NULL THEN 0 ELSE 1 END AS IsDispatched,d.CreatedDateTime AS 'DispatchDateTime'
	FROM [dbo].[BidLatest] b1
		JOIN ResourceProfile p
	ON p.ResourceProfileId=b1.DeviceId
		LEFT OUTER JOIN BidDispatch d
	   ON b1.BidId=d.BidId
		  WHERE MarketDateTime BETWEEN @startDateTime AND @endDateTime
		 AND( @tenantId IS Null OR p.TenantId=@tenantId)
		  AND( @deviceId IS Null OR b1.DeviceId IN (SELECT Data FROM [SplitToVarchars]( @deviceId, ',' )))
		 AND( @substation IS Null OR d.SubStationName=@substation)
		 AND p.Enabled=1 
		 AND p.AutoDispatch=1
GO
/****** Object:  StoredProcedure [dbo].[BidDispatch_Insert]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BidDispatch_Insert]
	@json NVARCHAR(MAX)
	
AS


BEGIN TRANSACTION
--Insert into BidDispatch
INSERT INTO [dbo].[BidDispatch]
           ([BidId]
           ,[DispatchMessage]
		   ,[OptimizationId]
		   ,[SubStationName]
		   ,[ClearedValue]
          )
SELECT *
FROM OPENJSON(@json)
WITH ( 
BidId UNIQUEIDENTIFIER ,
DispatchMessage NVARCHAR(255),
OptimizationId UNIQUEIDENTIFIER,
SubStationName NVARCHAR(255),
ClearedValue DECIMAL(10, 6)
)

 COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[Bids_GetBidsByTimeRange]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Bids_GetBidsByTimeRange]
	@startDateTime datetime,
	@endDateTime datetime
AS
	 SELECT BidId, DeviceId ,Unit, MarketDateTime, GenMax, GenMin, LoadMax, LoadMin, LimitMax, LimitMin, GenPrice, LoadPrice, ClassName, CreatedDate, CreatedBy 
	 FROM 
		[dbo].[BidLatest]
	 WHERE MarketDateTime BETWEEN @startDateTime AND @endDateTime
GO
/****** Object:  StoredProcedure [dbo].[GetHashedPassword]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHashedPassword]
	@username nvarchar(255),
		@password nvarchar(255)
	AS
	
	
	SELECT UserName,UserPassword FROM UserInfoHashed WHERE UserName=@username
GO
/****** Object:  StoredProcedure [dbo].[LoadState_GetByStartDate]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadState_GetByStartDate]
	@startDate datetime
AS
	SELECT [LoadStateId]
      ,[DeviceId]
      ,[EffectiveDateTime]
      ,[Unit]
      ,[Value]
      ,[ClassName]
      ,[CreatedDate]
  FROM [dbo].[LoadState]
  WHERE EffectiveDateTime >= @startDate
GO
/****** Object:  StoredProcedure [dbo].[LogException]    Script Date: 5/9/2017 4:02:24 PM ******/
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
/****** Object:  StoredProcedure [dbo].[OptimizationResult_BidResult_Insert]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OptimizationResult_BidResult_Insert]
	@resultJson NVARCHAR(MAX)
	
AS


BEGIN TRANSACTION
--Insert into OptimizationResult
INSERT INTO [OptimizationResult](
	   [OptimizationId]
      ,[OptimizationRunName]
      ,[OverallDuration]
)
SELECT *
FROM OPENJSON(@resultJson)
WITH ( 
OptimizationId UNIQUEIDENTIFIER,
OptimizationRunName NVARCHAR(255),
OverallDuration INT
)


--Insert into BidResult
INSERT INTO [dbo].[BidResult]
           ([BidId]
           ,[GenValue]
           ,[LoadValue]
           ,[OptimizationId]
           )
SELECT *
FROM OPENJSON(@resultJson ,'$.Result')
WITH ( 
BidId UNIQUEIDENTIFIER ,
GenValue DECIMAL(10,3) ,
LoadValue DECIMAL(10,3) ,
OptimizationId UNIQUEIDENTIFIER 
)

 COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_Delete]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_Delete]
	@resourceProfileId int 
AS
	DELETE FROM [ResourceProfile]
	WHERE ResourceProfileId=@resourceProfileId
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_Edit]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_Edit]
	@resourceProfileId int,
	@rowKey nvarchar(255),
	@resourceType nvarchar(255),
	--@subStationId INT,
	@upTimeMax DECIMAL(10, 3),
	@dayUpTimeMax DECIMAL(10, 3),
	@downTimeMin DECIMAL(10, 3),
	@powerMin DECIMAL(10, 3),
	@powerMax DECIMAL(10, 3),
	@rampUpMax DECIMAL(10, 3),
	@rampDownMax DECIMAL(10, 3),
	@socMin DECIMAL(10, 3),
	@socMax DECIMAL(10, 3),
	@chargeRateMin DECIMAL(10, 3),
	@chargeRateMax DECIMAL(10, 3),
	@dischargeRateMin DECIMAL(10, 3),
	@dischargeRateMax DECIMAL(10, 3),
	@price DECIMAL(10, 3),
	@latitude DECIMAL(10, 5),
	@longitude DECIMAL(10,5),
	@autoDispatch BIT,
	@displayName NVARCHAR(255),
	@efficiency DECIMAL(10, 3),
	@chargePrice DECIMAL(10, 3),
	@enabled BIT,
	@meterId nvarchar(255)
AS
	UPDATE [dbo].[ResourceProfile]
   SET --[SubStationId] = @subStationId
      [ResourceType] = @resourceType
      ,[RowKey] = @rowKey
      ,[UpTimeMax] = @upTimeMax
      ,[DayUpTimeMax] = @dayUpTimeMax
      ,[DownTimeMin] = @downTimeMin
      ,[PowerMin] = @powerMin
      ,[PowerMax] = @powerMax
      ,[RampUpMax] = @rampUpMax
      ,[RampDownMax] = @rampDownMax
      ,[SocMin] = @socMin
      ,[SocMax] = @socMax
      ,[ChargeRateMin] = @chargeRateMin
      ,[ChargeRateMax] = @chargeRateMax
      ,[DischargeRateMin] = @dischargeRateMin
      ,[DischargeRateMax] = @dischargeRateMax
      ,[Price] = @price
      ,[Latitude] = @latitude
      ,[Longitude] = @longitude
      ,[AutoDispatch] = @autoDispatch
      ,[DisplayName] = @displayName
      ,[Efficiency] = @efficiency
      ,[ChargePrice] = @chargePrice
      ,[Enabled] = @enabled
	  ,[MeterId]=@meterId
 WHERE ResourceProfileId=@resourceProfileId
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_GetAllResources]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_GetAllResources]
AS
	SELECT [ResourceProfileId]
      --,[SubStationId]
      ,[ResourceType]
      ,[RowKey]
      ,[UpTimeMax]
      ,[DayUpTimeMax]
      ,[DownTimeMin]
      ,[PowerMin]
      ,[PowerMax]
      ,[RampUpMax]
      ,[RampDownMax]
      ,[SocMin]
      ,[SocMax]
      ,[ChargeRateMin]
      ,[ChargeRateMax]
      ,[DischargeRateMin]
      ,[DischargeRateMax]
      ,[Price]
      ,[Latitude]
      ,[Longitude]
      ,[AutoDispatch]
      ,[DisplayName]
      ,[Efficiency]
      ,[ChargePrice]
      ,[Enabled]
	  ,[MeterId]
	  ,[TenantId]
	  FROM [ResourceProfile]
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_GetByResourceType]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_GetByResourceType]
	@resourceType NVARCHAR(255)

AS
SELECT [ResourceProfileId]

      --,r.[SubStationId]
	  --,s.RowKey AS 'SubStaionRowKey'

      ,[ResourceType]

      ,r.[RowKey]

      ,[UpTimeMax]

      ,[DayUpTimeMax]

      ,[DownTimeMin]

      ,[PowerMin]

      ,[PowerMax]

      ,[RampUpMax]

      ,[RampDownMax]

      ,[SocMin]

      ,[SocMax]

      ,[ChargeRateMin]

      ,[ChargeRateMax]

      ,[DischargeRateMin]

      ,[DischargeRateMax]

      ,[Price]

      ,[Latitude]

      ,[Longitude]

      ,[AutoDispatch]

      ,[DisplayName]

      ,[Efficiency]

      ,[ChargePrice]

      ,[Enabled]

	  ,[MeterId]

	  ,[TenantId]

	  FROM [ResourceProfile] r
	  --INNER JOIN 
	 -- SubStation s
	  --ON s.SubStationId=r.SubStationId
  WHERE
	r.[ResourceType] = @resourceType
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_GetByResourceTypeAndRowKey]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_GetByResourceTypeAndRowKey]
	@resourceType NVARCHAR(255),
	@rowKey NVARCHAR(255)
AS
	SELECT [ResourceProfileId]
      --,[SubStationId]
      ,[ResourceType]
      ,[RowKey]
      ,[UpTimeMax]
      ,[DayUpTimeMax]
      ,[DownTimeMin]
      ,[PowerMin]
      ,[PowerMax]
      ,[RampUpMax]
      ,[RampDownMax]
      ,[SocMin]
      ,[SocMax]
      ,[ChargeRateMin]
      ,[ChargeRateMax]
      ,[DischargeRateMin]
      ,[DischargeRateMax]
      ,[Price]
      ,[Latitude]
      ,[Longitude]
      ,[AutoDispatch]
      ,[DisplayName]
      ,[Efficiency]
      ,[ChargePrice]
      ,[Enabled]
	  ,[MeterId]
	  FROM [ResourceProfile]
  WHERE
	[ResourceProfile].[ResourceType] = @resourceType
	AND
	[ResourceProfile].[RowKey] = @rowKey
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_GetBySubStationId]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_GetBySubStationId]
	--@subStationId int
AS
SELECT [ResourceProfileId]
      --,[SubStationId]
      [ResourceType]
      ,[RowKey]
      ,[UpTimeMax]
      ,[DayUpTimeMax]
      ,[DownTimeMin]
      ,[PowerMin]
      ,[PowerMax]
      ,[RampUpMax]
      ,[RampDownMax]
      ,[SocMin]
      ,[SocMax]
      ,[ChargeRateMin]
      ,[ChargeRateMax]
      ,[DischargeRateMin]
      ,[DischargeRateMax]
      ,[Price]
      ,[Latitude]
      ,[Longitude]
      ,[AutoDispatch]
      ,[DisplayName]
      ,[Efficiency]
      ,[ChargePrice]
      ,[Enabled]
  FROM [ResourceProfile]
 -- WHERE
	--[ResourceProfile].[SubStationId] = @subStationId
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_GetDevicesByTenantId]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_GetDevicesByTenantId]
	@tenantId int
	
AS
	SELECT DISTINCT RowKey ,ResourceProfileId
	FROM ResourceProfile
	WHERE TenantId=@tenantId
GO
/****** Object:  StoredProcedure [dbo].[ResourceProfile_Insert]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResourceProfile_Insert]
	@rowKey nvarchar(255),
	@resourceType nvarchar(255),
	--@subStationId INT,
	@tenantId  nvarchar(255),
	@upTimeMax DECIMAL(10, 3),
	@dayUpTimeMax DECIMAL(10, 3),
	@downTimeMin DECIMAL(10, 3),
	@powerMin DECIMAL(10, 3),
	@powerMax DECIMAL(10, 3),
	@rampUpMax DECIMAL(10, 3),
	@rampDownMax DECIMAL(10, 3),
	@socMin DECIMAL(10, 3),
	@socMax DECIMAL(10, 3),
	@chargeRateMin DECIMAL(10, 3),
	@chargeRateMax DECIMAL(10, 3),
	@dischargeRateMin DECIMAL(10, 3),
	@dischargeRateMax DECIMAL(10, 3),
	@price DECIMAL(10, 3),
	@latitude DECIMAL(10, 5),
	@longitude DECIMAL(10, 5),
	@autoDispatch BIT,
	@displayName NVARCHAR(255),
	@efficiency DECIMAL(10, 3),
	@chargePrice DECIMAL(10, 3),
	@enabled BIT,
	@meterId NVARCHAR(255)

AS

SET NOCOUNT ON;

DECLARE @resourceProfileId int

INSERT INTO [ResourceProfile] (
		 [RowKey]
		 ,[ResourceType]
		--,[SubStationId]
		,[TenantId]
		,[UpTimeMax]
		,[DayUpTimeMax]
		,[DownTimeMin]
		,[PowerMin]
		,[PowerMax]
		,[RampUpMax]
		,[RampDownMax]
		,[SocMin]
		,[SocMax]
		,[ChargeRateMin]
		,[ChargeRateMax]
		,[DischargeRateMin]
		,[DischargeRateMax]
		,[Price]
		,[Latitude]
		,[Longitude]
		,[AutoDispatch]
		,[DisplayName]
		,[Efficiency]
		,[ChargePrice]
		,[Enabled]
		,[MeterId]
	)
VALUES (
		@rowKey
		,@resourceType
		--,@subStationId
		,@tenantId
		,@upTimeMax
		,@dayUpTimeMax
		,@downTimeMin
		,@powerMin
		,@powerMax
		,@rampUpMax
		,@rampDownMax
		,@socMin
		,@socMax
		,@chargeRateMin
		,@chargeRateMax
		,@dischargeRateMin
		,@dischargeRateMax
		,@price 
		,@latitude 
		,@longitude 
		,@autoDispatch 
		,@displayName 
		,@efficiency 
		,@chargePrice 
		,@enabled
		,@meterId
	);

SET @resourceProfileId = SCOPE_IDENTITY();

SET NOCOUNT OFF;

SELECT @resourceProfileId AS [ResourceProfileId];
GO
/****** Object:  StoredProcedure [dbo].[TradeBids_Insert]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TradeBids_Insert]
	@tradeJson NVARCHAR(MAX),
	@tenantId int
AS


BEGIN TRANSACTION


 INSERT INTO Bid (DeviceId, MarketDateTime,Unit,GenMax,GenMin,GenPrice,CreatedBy)
 SELECT *
 FROM OPENJSON(@tradeJson)
 WITH (DeviceId INT,
 MarketDateTime datetime,
 Unit INT,
 GenMax DECIMAL(10, 3),
 GenMin DECIMAL(10, 3),
 GenPrice DECIMAL(10, 3),
 CreatedBy  NVARCHAR(255)
 ) 

 COMMIT TRANSACTION
GO
/****** Object:  StoredProcedure [dbo].[Trader_GetByTraderId]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Trader_GetByTraderId]
	@tenantId nvarchar(255)
AS
	select TenantId, TenantName, IsEnabled, IsDeleted, CreatedBy, CreatedDate, LastUpdatedBy, LastUpdatedDate 
	from [dbo].[Tenant]
	where TenantId = @tenantId
GO
/****** Object:  StoredProcedure [dbo].[UserInfo_Insert]    Script Date: 5/9/2017 4:02:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserInfo_Insert]
	@username NVARCHAR(255),
	@email NVARCHAR(255) ,
	@userPassword VARBINARY(MAX)
AS
	
INSERT INTO [UserInfoHashed]
           (
           [UserName]
           ,[UserPassword]
           ,[Email]
           )
     VALUES
           (
          @username
           ,@userPassword
           ,@email
           )
GO
