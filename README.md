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





