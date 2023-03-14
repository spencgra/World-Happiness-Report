/********************************************************************************************

 Cleanup data tables for the World Happiness Report

 Create a combined data table and copy the data from each year into this table.
 Only use a subset of the columns that are common to all the years reports

 Version History:
    20220207 - Graham Spencer   - Create initial version
    20230313 - Graham Spencer   - Add clenup code for year 2020

**********************************************************************************************/

-- Cleanup Country names in each year file to make linking  easier
UPDATE WHR.[2015]
	SET Country = 'Northern Cyprus'
	WHERE Country = 'North Cyprus';

UPDATE WHR.[2016]
	SET Country = 'Northern Cyprus'
	WHERE Country = 'North Cyprus';

UPDATE WHR.[2017]
	SET Country = 'Northern Cyprus'
	WHERE Country = 'North Cyprus';

UPDATE WHR.[2020]
SET [Country name] = 'Northern Cyprus'
WHERE [Country name] = 'North Cyprus';

UPDATE WHR.[2015]
	SET Country = 'Somaliland Region'
	WHERE Country = 'Somaliland region';

UPDATE WHR.[2017]
	SET Country = 'Taiwan'
	WHERE Country = 'Taiwan Province of China';

UPDATE WHR.[2020]
SET [Country name] = 'Taiwan'
WHERE [Country name] = 'Taiwan Province of China';

UPDATE WHR.[2018]
	SET Country_or_region = 'Trinidad and Tobago'
	WHERE Country_or_region = 'Trinidad & Tobago';

UPDATE WHR.[2019]
	SET Country_or_region = 'Trinidad and Tobago'
	WHERE Country_or_region = 'Trinidad & Tobago';

UPDATE WHR.[2017]
	SET Country = 'Hong Kong'
	WHERE Country = 'Hong Kong S.A.R., China';

UPDATE WHR.[2020]
SET [Country name] = 'Hong Kong'
WHERE [Country name] = 'Hong Kong S.A.R. of China';



-- Insert the list of all the countries from the report into the country list table
INSERT INTO
WHR.country_list (Country)
    SELECT
        t.Country
    FROM (SELECT
            [Country]
        FROM [DataAnalysis].[WHR].[2015]
        UNION
        SELECT
            [Country]
        FROM [DataAnalysis].[WHR].[2016]
        UNION
        SELECT
            [Country]
        FROM [DataAnalysis].[WHR].[2017]
        UNION
        SELECT
            Country_or_region
        FROM [DataAnalysis].[WHR].[2018]
        UNION
        SELECT
            Country_or_region
        FROM [DataAnalysis].[WHR].[2019]
        UNION
        SELECT
            [Country name]
        FROM [DataAnalysis].[WHR].[2020]) t


-- update the region column in the country list table from the 2015 and 2016 reports
UPDATE WHR.country_list
	SET Region = (SELECT
			t.Region
		FROM (SELECT
				Country
			   ,Region
			FROM WHR.[2015]
			UNION
			SELECT
				Country
			   ,Region
			FROM WHR.[2016]) t
		WHERE t.Country = WHR.country_list.Country)


-- update the missing regions in the country list table
UPDATE WHR.country_list
	SET Region = 'Sub-Saharan Africa'
	WHERE Country = 'Gambia';

UPDATE WHR.country_list
	SET Region = 'Central and Eastern Europe'
	WHERE Country = 'North Macedonia';

UPDATE WHR.country_list
SET Region = 'Southern Asia'
WHERE Country = 'Maldives';


-- Insert the scores from each of the year reports into a single scores table
INSERT INTO
	WHR.scores (country_id, Year, Rank, Score, GDP_per_capita, Social_support, Health, Freedom, Trust, Generosity)
	SELECT
		cl.country_id
	   ,2015 AS [Year]
	   ,a.Happiness_Rank AS [Rank]
	   ,a.Happiness_Score AS Score
	   ,a.Economy_GDP AS GDP_per_capita
	   ,a.Family AS Social_support
	   ,a.Health
	   ,a.Freedom
	   ,a.Trust
	   ,a.Generosity
	FROM WHR.[2015] a
	INNER JOIN WHR.country_list cl
		ON a.Country = cl.Country;

INSERT INTO
	WHR.scores (country_id, Year, Rank, Score, GDP_per_capita, Social_support, Health, Freedom, Trust, Generosity)
	SELECT
		cl.country_id
	   ,2016 AS [Year]
	   ,a.Happiness_Rank AS [Rank]
	   ,a.Happiness_Score AS Score
	   ,a.Economy_GDP_per_Capita AS GDP_per_capita
	   ,a.Family AS Social_support
	   ,a.Health_Life_Expectancy AS Health
	   ,a.Freedom
	   ,a.Trust_Government_Corruption AS Trust
	   ,a.Generosity
	FROM WHR.[2016] a
	INNER JOIN WHR.country_list cl
		ON a.Country = cl.Country;

INSERT INTO
	WHR.scores (country_id, Year, Rank, Score, GDP_per_capita, Social_support, Health, Freedom, Trust, Generosity)
	SELECT
		cl.country_id
	   ,2017 AS [Year]
	   ,a.Happiness_Rank AS [Rank]
	   ,a.Happiness_Score AS Score
	   ,a.Economy_GDP AS GDP_per_capita
	   ,a.Family AS Social_support
	   ,a.Health
	   ,a.Freedom
	   ,a.Trust
	   ,a.Generosity
	FROM WHR.[2017] a
	INNER JOIN WHR.country_list cl
		ON a.Country = cl.Country;

INSERT INTO
	WHR.scores (country_id, Year, Rank, Score, GDP_per_capita, Social_support, Health, Freedom, Trust, Generosity)
	SELECT
		cl.country_id
	   ,2018 AS [Year]
	   ,a.Overall_rank AS [Rank]
	   ,a.Score
	   ,a.GDP_per_capita
	   ,a.Social_support
	   ,a.Healthy_life_expectancy AS Health
	   ,a.Freedom_to_make_life_choices AS Freedom
	   ,a.Perceptions_of_corruption AS Trust
	   ,a.Generosity
	FROM WHR.[2018] a
	INNER JOIN WHR.country_list cl
		ON a.Country_or_region = cl.Country;

INSERT INTO
	WHR.scores (country_id, Year, Rank, Score, GDP_per_capita, Social_support, Health, Freedom, Trust, Generosity)
	SELECT
		cl.country_id
	   ,2019 AS [Year]
	   ,a.Overall_rank AS [Rank]
	   ,a.Score
	   ,a.GDP_per_capita
	   ,a.Social_support
	   ,a.Healthy_life_expectancy AS Health
	   ,a.Freedom_to_make_life_choices AS Freedom
	   ,a.Perceptions_of_corruption AS Trust
	   ,a.Generosity
	FROM WHR.[2019] a
	INNER JOIN WHR.country_list cl
		ON a.Country_or_region = cl.Country;

INSERT INTO
WHR.scores (country_id, Year, Rank, Score, GDP_per_capita, Social_support, Health, Freedom, Trust, Generosity)
    SELECT
        cl.country_id
       ,2020 AS Year
       ,RANK() OVER (ORDER BY a.[Ladder score] DESC) AS Overall_rank
       ,a.[Ladder score] AS Score
       ,a.[Explained by  Log GDP per capita] AS GDP_per_capita
       ,a.[Explained by  Social support] AS Social_support
       ,a.[Explained by  Healthy life expectancy] AS Health
       ,a.[Explained by  Freedom to make life choices] AS Freedom
       ,a.[Explained by  Perceptions of corruption] AS Trust
       ,a.[Explained by  Generosity] AS Generosity
    FROM WHR.[2020] a
    INNER JOIN WHR.country_list cl
        ON a.[Country name] = cl.Country;
