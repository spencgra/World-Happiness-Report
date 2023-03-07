CREATE TABLE [WHR].[scores] (
    [score_id]       INT        IDENTITY (1, 1) NOT NULL,
    [country_id]     INT        NOT NULL,
    [Year]           SMALLINT   NULL,
    [Rank]           TINYINT    NULL,
    [Score]          FLOAT (53) NULL,
    [GDP_per_capita] FLOAT (53) NULL,
    [Social_support] FLOAT (53) NULL,
    [Health]         FLOAT (53) NULL,
    [Freedom]        FLOAT (53) NULL,
    [Trust]          FLOAT (53) NULL,
    [Generosity]     FLOAT (53) NULL
);
GO

ALTER TABLE [WHR].[scores]
    ADD CONSTRAINT [PK_scores] PRIMARY KEY CLUSTERED ([score_id] ASC);
GO

ALTER TABLE [WHR].[scores]
    ADD CONSTRAINT [CK_Year] CHECK ([Year]>=(2015) AND [Year]<=(2019));
GO

