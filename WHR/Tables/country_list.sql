CREATE TABLE [WHR].[country_list] (
    [country_id] INT          IDENTITY (1, 1) NOT NULL,
    [Country]    VARCHAR (50) NOT NULL,
    [Region]     VARCHAR (50) NULL
);
GO

ALTER TABLE [WHR].[country_list]
    ADD CONSTRAINT [PK_country_list] PRIMARY KEY CLUSTERED ([country_id] ASC);
GO

