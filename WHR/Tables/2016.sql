CREATE TABLE [WHR].[2016] (
    [Country]                     NVARCHAR (50) NOT NULL,
    [Region]                      NVARCHAR (50) NOT NULL,
    [Happiness_Rank]              TINYINT       NOT NULL,
    [Happiness_Score]             FLOAT (53)    NOT NULL,
    [Lower_Confidence_Interval]   FLOAT (53)    NOT NULL,
    [Upper_Confidence_Interval]   FLOAT (53)    NOT NULL,
    [Economy_GDP_per_Capita]      FLOAT (53)    NOT NULL,
    [Family]                      FLOAT (53)    NOT NULL,
    [Health_Life_Expectancy]      FLOAT (53)    NOT NULL,
    [Freedom]                     FLOAT (53)    NOT NULL,
    [Trust_Government_Corruption] FLOAT (53)    NOT NULL,
    [Generosity]                  FLOAT (53)    NOT NULL,
    [Dystopia_Residual]           FLOAT (53)    NOT NULL
);
GO

