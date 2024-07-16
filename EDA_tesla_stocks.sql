SELECT *
FROM tesla_dataset;

-- Create staging table 
CREATE TABLE tesla_staging
LIKE tesla_dataset;

SELECT *
FROM tesla_staging;

-- Insert data from tesla_stocks table to tesla_staging table
INSERT tesla_staging
SELECT *
FROM tesla_dataset;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Date`, `Open`, High, Low, `Close`, `Adj Close`, Volume) AS row_num
FROM tesla_staging;

-- Checking for Duplicate values
WITH duplicate_cte AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Date`, `Open`, High, Low, `Close`, `Adj Close`, Volume) AS row_num
FROM tesla_staging)
SELECT *
FROM duplicate_cte
WHERE row_num>1;

SELECT *
FROM tesla_dataset;

SELECT *
FROM tesla_staging;

-- Statistical Observations
SELECT 
    MIN(Close) AS Min_Close,
    MAX(Close) AS Max_Close,
    STDDEV(Close) AS StdDev_Close,
    MIN(Volume) AS Min_Volume,
    MAX(Volume) AS Max_Volume
FROM tesla_staging;

-- Open vs Close
SELECT 
    Date,
    Close - Open AS Price_Change,
    (Close - Open) / Open * 100 AS Percent_Change
FROM tesla_staging
WHERE (Close - Open) / Open * 100 > 0
ORDER BY ABS(Percent_Change) DESC
;

-- Weekly Analysis
SELECT 
    DAYNAME(Date) AS Day_Of_Week,
    AVG(Close) AS Avg_Close,
    AVG(Volume) AS Avg_Volume
FROM tesla_staging
GROUP BY DAYNAME(Date), DAYOFWEEK(Date)
ORDER BY DAYOFWEEK(Date);

-- Yearly Analysis
SELECT 
    EXTRACT(YEAR FROM Date) AS Year,
    AVG(Close) AS Avg_Close,
    SUM(Volume) AS Total_Volume
FROM tesla_staging
GROUP BY EXTRACT(YEAR FROM Date)
ORDER BY Year; 

-- Highest and lowest closing prices for each year
SELECT 
    YEAR(Date) AS Year,
    MAX(Close) AS Yearly_High,
    MIN(Close) AS Yearly_Low
FROM tesla_staging
GROUP BY Year
ORDER BY Year;

-- Volatility Trends
SELECT 
    YEAR(Date) AS Year,
    STDDEV(Close) AS Volatility
FROM tesla_staging
GROUP BY Year
ORDER BY Year;

-- Monthly Volatility
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    STDDEV(Close) AS Monthly_Volatility
FROM tesla_staging
GROUP BY Month
ORDER BY Month;

-- 50-Day Moving Average
SELECT 
    Date,
    AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS Moving_Avg_50
FROM tesla_staging;

-- 200-Day Moving Average
SELECT 
    Date,
    AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 199 PRECEDING AND CURRENT ROW) AS Moving_Avg_200
FROM tesla_staging;

-- Percentage Change
SELECT 
    Date, 
    Close,
    LAG(Close) OVER (ORDER BY Date) AS Previous_Close,
    ((Close - LAG(Close) OVER (ORDER BY Date)) / LAG(Close) OVER (ORDER BY Date)) * 100 AS Percentage_Change
FROM tesla_staging
;

-- Number of upward trend and downward trend days
WITH PriceChanges AS (
    SELECT 
        Date, 
        Close,
        LAG(Close) OVER (ORDER BY Date) AS Previous_Close
    FROM tesla_staging
)
SELECT 
    SUM(CASE WHEN Close > Previous_Close THEN 1 ELSE 0 END) AS Uptrend_Days,
    SUM(CASE WHEN Close < Previous_Close THEN 1 ELSE 0 END) AS Downtrend_Days
FROM PriceChanges;

-- Seasonal Analysis

SELECT 
    MONTH(Date) AS Month,
    AVG(Close) AS Avg_Monthly_Close
FROM tesla_staging
GROUP BY Month
ORDER BY Month;

-- Effect of weekend on stock prices

SELECT 
    DAYOFWEEK(Date) AS Day_of_Week,
    AVG(Close) AS Avg_Close
FROM tesla_staging
GROUP BY Day_of_Week
ORDER BY Day_of_Week;

-- Unusual Spike in volume
-- Threshold Volume=Avg_Volume+2×STDDEV(Volume). 
-- This threshold volume is the value that trading volumes must exceed to be considered "unusually high." 

WITH VolumeStats AS (
SELECT Date, Volume,
        AVG(Volume) OVER () AS Avg_Volume,
        2 * STDDEV(Volume) OVER () AS Volume_Threshold
    FROM tesla_staging
)
SELECT Date,Volume,Avg_Volume,Volume_Threshold 
FROM VolumeStats
WHERE Volume > (Avg_Volume + Volume_Threshold)
ORDER BY Volume DESC ;

-- Potential Support and Resistance 

-- A Support level is a price level where a stock tends to find buying interest as it falls.
-- A Resistance level is a price level where a stock tends to find selling interest as it rises.

WITH SupportResistance AS (
    SELECT Date, Close,
        LAG(Close, 1) OVER (ORDER BY Date) AS Prev_Close,
        LEAD(Close, 1) OVER (ORDER BY Date) AS Next_Close
    FROM tesla_staging
)
SELECT 
    Date, Close,
     CASE 
            WHEN Close < Prev_Close AND Close < Next_Close THEN 'Support'
            WHEN Close > Prev_Close AND Close > Next_Close THEN 'Resistance'
            ELSE NULL
        END AS Level_Type
FROM SupportResistance
HAVING Level_Type IS NOT NULL
ORDER BY Date;






























