# Exploratory-Data-Analysis-on-Tesla-Stocks-2010-2024-using-SQL


## Description
This project performs an Exploratory Data Analysis (EDA) on Tesla stock data using SQL. The analysis includes data loading, cleaning, and various statistical analyses to uncover patterns and insights from the historical stock data.
The dataset is collected from Kaggle, link - https://www.kaggle.com/datasets/esrathkanon/tesla-stock-market-dataset-2010-2024

## Preprocessing performed

### Creating Staging Table - 
Created a staging table and insert data from the original dataset into this new table for further analysis. The staging table is used to manipulate and analyze data without affecting the original dataset.

### Checking for Duplicate Values - 
Searched for duplicate values in the staging table. By using ROW_NUMBER() with PARTITION BY, we identify rows that have the same values across specified columns. Rows with row_num > 1 are considered duplicates. No duplicate values were found in this dataset.
![image](https://github.com/user-attachments/assets/092d0ba9-5bfb-4f50-a921-93ddfc02ea9a)

## Analysis performed

### Statistical Observations
Calculated basic statistical metrics for the closing prices and trading volumes in the Tesla stock dataset. The metrics include:

- MIN(Close) and MAX(Close) to find the minimum and maximum closing prices.
- STDDEV(Close) to calculate the standard deviation of the closing prices, indicating price variability.
- MIN(Volume) and MAX(Volume) to find the minimum and maximum trading volumes.
These statistics provide a snapshot of the stock's price range and trading activity over the analyzed period.
![image](https://github.com/user-attachments/assets/fefbe775-b65f-4962-87e0-278a3dc4a339)

### Open vs Close Analysis
Analysed the daily price change and percentage change from the opening to the closing prices of Tesla stock. Following calculations were made - 
- Price_Change = (Close - Open) to find the absolute change in price.
- Percent_Change = [{(Close - Open) / Open} * 100] to find the percentage change relative to the opening price.
The results are filtered to include only days where the price increased, and the output is ordered by the absolute percentage change in descending order. This analysis highlights the days with the most significant positive price movements.
![image](https://github.com/user-attachments/assets/daa97118-b00b-48cc-a002-a59f42505c2c)

From this we find it was on 29/06/2010 had the highest positive change with a spike of 25.736833204195197%








