
CREATE TABLE [dbo].[costcomp](
	[Region] [varchar](255) NULL,
	[computeStamp] [int] NULL,
	[optCost] [float] NULL,
	[baseCost] [float] NULL
)


CREATE TABLE [dbo].[flowgraph](
	[computeStamp] [int] NULL,
	[flow] [float] NULL,
	[source] [varchar](255) NULL,
	[target] [varchar](255) NULL
)


CREATE TABLE [dbo].[flowtoday](
	[Timestamp] [varchar](255) NULL,
	[LocalStamp] [varchar](255) NULL,
	[Interface Name] [varchar](255) NULL,
	[Point ID] [int] NULL,
	[Flow (MWH)] [float] NULL,
	[Positive Limit (MWH)] [float] NULL,
	[Negative Limit (MWH)] [float] NULL
)


CREATE TABLE [dbo].[lbmptoday](
	[Time Stamp] [varchar](255) NULL,
	[LocalStamp] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[PTID] [int] NULL,
	[LBMP ($/MWHr)] [float] NULL,
	[Marginal Cost Losses ($/MWHr)] [float] NULL,
	[Marginal Cost Congestion ($/MWHr)] [float] NULL
)


CREATE TABLE [dbo].[lbmptomorrow](
	[Time Stamp] [varchar](255) NULL,
	[LocalStamp] [varchar](255) NULL,
	[Name] [varchar](255) NULL,
	[PTID] [int] NULL,
	[LBMP ($/MWHr)] [float] NULL,
	[Marginal Cost Losses ($/MWHr)] [float] NULL,
	[Marginal Cost Congestion ($/MWHr)] [float] NULL
)


CREATE TABLE [dbo].[loadforecasttoday](
	[Time Stamp] [varchar](255) NULL,
	[LocalStamp] [varchar](255) NULL,
	[Capitl] [float] NULL,
	[Centrl] [float] NULL,
	[Dunwod] [float] NULL,
	[Genese] [float] NULL,
	[Hud Vl] [float] NULL,
	[Longil] [float] NULL,
	[Mhk Vl] [float] NULL,
	[Millwd] [float] NULL,
	[N.Y.C.] [float] NULL,
	[North] [float] NULL,
	[West] [float] NULL,
	[NYISO] [float] NULL,
	[simulationStamp] [float] NULL
)


CREATE TABLE [dbo].[loadforecasttomorrow](
	[Time Stamp] [varchar](255) NULL,
	[LocalStamp] [varchar](255) NULL,
	[Capitl] [float] NULL,
	[Centrl] [float] NULL,
	[Dunwod] [float] NULL,
	[Genese] [float] NULL,
	[Hud Vl] [float] NULL,
	[Longil] [float] NULL,
	[Mhk Vl] [float] NULL,
	[Millwd] [float] NULL,
	[N.Y.C.] [float] NULL,
	[North] [float] NULL,
	[West] [float] NULL,
	[NYISO] [float] NULL,
	[simulationStamp] [float] NULL
)


CREATE TABLE [dbo].[optresult](
	[CAPITL] [float] NULL,
	[CAPITL->HUD VL] [float] NULL,
	[CENTRL] [float] NULL,
	[CENTRL->MHK VL] [float] NULL,
	[Cost] [float] NULL,
	[DUNWOD] [float] NULL,
	[DUNWOD->LONGIL] [float] NULL,
	[DUNWOD->N.Y.C.] [float] NULL,
	[GENESE] [float] NULL,
	[GENESE->CENTRL] [float] NULL,
	[H Q->NORTH] [float] NULL,
	[HUD VL] [float] NULL,
	[HUD VL->MILLWD] [float] NULL,
	[LONGIL] [float] NULL,
	[MHK VL] [float] NULL,
	[MHK VL->CAPITL] [float] NULL,
	[MHK VL->HUD VL] [float] NULL,
	[MILLWD] [float] NULL,
	[MILLWD->DUNWOD] [float] NULL,
	[N.Y.C.] [float] NULL,
	[N.Y.C.->LONGIL] [float] NULL,
	[NORTH] [float] NULL,
	[NORTH->MHK VL] [float] NULL,
	[NPX->CAPITL] [float] NULL,
	[NPX->HUD VL] [float] NULL,
	[NPX->LONGIL] [float] NULL,
	[NPX->NORTH] [float] NULL,
	[O H->MHK VL] [float] NULL,
	[O H->WEST] [float] NULL,
	[PJM->CENTRL] [float] NULL,
	[PJM->HUD VL] [float] NULL,
	[PJM->N.Y.C.] [float] NULL,
	[PJM->WEST] [float] NULL,
	[Region] [varchar](255) NULL,
	[WEST] [float] NULL,
	[WEST->CENTRL] [float] NULL,
	[WEST->GENESE] [float] NULL,
	[computeStamp] [int] NULL
)

