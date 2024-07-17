# Exploratory Data Analysis on Tesla Stocks from 2010 to 2024 using SQL


## Description
This project performs an Exploratory Data Analysis (EDA) on Tesla stock data using SQL. The analysis includes data loading, cleaning, and various statistical analyses to uncover patterns and insights from the historical stock data.
The dataset is collected from Kaggle, link - https://www.kaggle.com/datasets/esrathkanon/tesla-stock-market-dataset-2010-2024

## Preprocessing performed

### Creating Staging Table - 
Created a staging table and insert data from the original dataset into this new table for further analysis. The staging table is used to manipulate and analyze data without affecting the original dataset.

### Checking for Duplicate Values - 
Searched for duplicate values in the staging table. By using ROW_NUMBER() with PARTITION BY, we identify rows that have the same values across specified columns. Rows with row_num > 1 are considered duplicates. No duplicate values were found in this dataset.
![image](https://github.com/user-attachments/assets/092d0ba9-5bfb-4f50-a921-93ddfc02ea9a)
|:--:|
| *Figure 1: Zero Duplicate values found* |

## Analysis performed

### Statistical Observations - 
Calculated basic statistical metrics for the closing prices and trading volumes in the Tesla stock dataset. The metrics include:

- MIN(Close) and MAX(Close) to find the minimum and maximum closing prices.
- STDDEV(Close) to calculate the standard deviation of the closing prices, indicating price variability.
- MIN(Volume) and MAX(Volume) to find the minimum and maximum trading volumes.
These statistics provide a snapshot of the stock's price range and trading activity over the analyzed period.

![image](https://github.com/user-attachments/assets/fefbe775-b65f-4962-87e0-278a3dc4a339)
|:--:|
| *Figure 2: Statistical Observation* |

### Open vs Close Analysis - 
Analysed the daily price change and percentage change from the opening to the closing prices of Tesla stock. Following calculations were made - 
- Price_Change = (Close - Open) to find the absolute change in price.
- Percent_Change = [{(Close - Open) / Open} * 100] to find the percentage change relative to the opening price.
The results are filtered to include only days where the price increased, and the output is ordered by the absolute percentage change in descending order. This analysis highlights the days with the most significant positive price movements.

![image](https://github.com/user-attachments/assets/daa97118-b00b-48cc-a002-a59f42505c2c)
|:--:|
| *Figure 3: Table containing data on daily Price Changes and Percentange Change in Descending Order* |

From this we find it was on 29/06/2010 had the highest positive change with a spike of 25.736833204195197%

### Weekly Analysis - 
Performed an analysis of Tesla stock's average closing prices and trading volumes for each day of the week. It groups the data by day of the week and calculates:
- AVG(Close) to find the average closing price for each day.
- AVG(Volume) to find the average trading volume for each day.
Insights on weekly patterns and trends in stock performance and trading activity are obtained

![image](https://github.com/user-attachments/assets/9dd89947-24eb-4dd3-87a4-495c40b657f5)
|:--:|
| *Figure 4: Table containing data on Average closing price and volume of each day in the week* |

### Yearly Analysis
Perfomed a yearly analysis of Tesla stock's average closing prices and total trading volumes. It groups the data by year and calculates:

- AVG(Close) to find the average closing price for each year.
- SUM(Volume) to find the total trading volume for each year.
From this we gain insights into long-term trends in stock performance and trading activity over the years.

![image](https://github.com/user-attachments/assets/f4fa15b2-7e84-466b-8a9c-b722b8bcfb5f)
|:--:|
| *Figure 5: Table containing data on Yearly analysis of Tesla stock's average closing prices and total trading volumes* |

### Highest and Lowest closing prices for each year
Calculated the highest and lowest closing prices for Tesla stock in each year. It groups the data by year and calculates:

- MAX(Close) to find the highest closing price for each year.
- MIN(Close) to find the lowest closing price for each year.
The results are ordered by year, providing a clear view of the peak and trough prices for each year.

![image](https://github.com/user-attachments/assets/ab5f9268-c363-4914-94dd-8a2c7a34feb3)
|:--:|
| *Figure 6: Table displaying highest and lowest closing prices of the stock for each year* |

### Volatility Trends

Calculated the yearly volatility of Tesla stock's closing prices by using the standard deviation. It groups the data by year and calculates STDDEV(Close) for each year. Volatility indicates the degree of variation in stock prices over time, and this analysis helps understand how the stock's price stability has changed over the years.

![image](https://github.com/user-attachments/assets/a71c1ce8-9be5-4bf6-beb7-d0c081a22f7a)
|:--:|
| *Figure 7: Table displaying the volatility of the stock for each year* |

### Monthly Volatility

Calculated the monthly volatility of Tesla stock's closing prices by using the standard deviation. It groups the data by month and calculates STDDEV(Close) for each month. 

![image](https://github.com/user-attachments/assets/bac7b4fa-aafc-4b35-96fd-4bfe3b677e34)
|:--:|
| *Figure 8: Table displaying the monthly volatility of the stock for each year* |

### 50-Day Moving Average

Calculated the 50-day moving average of Tesla's closing prices. The AVG(Close) OVER window function computes the average of the closing prices over the current row and the previous 49 rows, providing a smooth trend line that helps to identify the direction of the stock's price movement.

![image](https://github.com/user-attachments/assets/c7e2cfdd-2ae8-4b49-b225-fccbe56cd799)
|:--:|
| *Figure 9: Table displaying 50- Day moving average* |

### 200-Day Moving Average

Found out the 200-day moving average of Tesla's closing prices. Similar to the 50-day moving average, it uses the AVG(Close) OVER window function to compute the average over the current row and the previous 199 rows, providing a longer-term trend line that is used to identify major price movements.

![image](https://github.com/user-attachments/assets/7e7b2e5d-b9c1-439b-8e13-57a052a2e05a)
|:--:|
| *Figure 10: Table displaying 200- Day moving average* |

### Percentage Change

Calculated the daily percentage change in Tesla's closing prices. The LAG(Close) OVER window function retrieves the closing price from the previous day, and the percentage change is computed using the formula {(Close - Previous_Close) / Previous_Close} * 100

![image](https://github.com/user-attachments/assets/9674a07a-c4d1-43b0-aad3-e33324bdde59)
|:--:|
| *Figure 11: Table displaying daily Percentage Change* |

### Number of Upward Trend and Downward Trend Days

Calculated the number of upward and downward trend days for Tesla stock. It uses a Common Table Expression (CTE) to retrieve the previous day's closing price, then counts the number of days where the closing price increased (Uptrend_Days) or decreased (Downtrend_Days).

![image](https://github.com/user-attachments/assets/2da5afff-baa8-440e-8806-196961358d87)
|:--:|
| *Figure 12: Table displaying total number of upward and downward trend days* |

### Seasonal Analysis

Performed a seasonal analysis of Tesla stock by calculating the average closing price for each month. The data is grouped by month and the average closing price (AVG(Close)) is computed for each month. This analysis helps to identify any seasonal patterns in the stock's performance.

![image](https://github.com/user-attachments/assets/74aea2f3-402d-4198-86e5-a604bb02d93a)
|:--:|
| *Figure 13: Table displaying total number of upward and downward trend days* |

### Effect of Weekend on Stock Prices
Analyzed the effect of the day of the week on Tesla's stock prices. It groups the data by the day of the week (DAYOFWEEK(Date)) and calculates the average closing price (AVG(Close)) for each day. This analysis helps to identify any significant differences in stock performance based on the day of the week.

![image](https://github.com/user-attachments/assets/981f12d7-e592-4641-8b44-08cd0604c30c)
|:--:|
| *Figure 14: Table displaying Avgerage price for each day* |

### Unusual Spike in Volume

Calculated the average trading volume (AVG(Volume)) and the 
Threshold Volume=Avg_Volume+2×STDDEV(Volume)
using window functions. Days where the trading volume exceeds the sum of the average volume and the volume threshold are considered to have unusually high volumes.
These days are arranged in descending order. 
This analysis helps to spot significant trading activity that might indicate important market events.

![image](https://github.com/user-attachments/assets/40328ba4-42ec-4f6a-a44c-52ce50bb81f4)
|:--:|
| *Figure 15: Table displaying the days with unusual spike in volume* |

### Potential Support and Resistance Levels

identifies potential support and resistance levels in Tesla's stock prices. Support levels are prices where the stock tends to find buying interest as it falls, while resistance levels are prices where the stock tends to find selling interest as it rises. Used window functions (LAG and LEAD) to compare the current closing price with the previous and next closing prices. Rows where the closing price is lower than both the previous and next prices are labeled as 'Support', while those where the closing price is higher are labeled as 'Resistance'. 

![image](https://github.com/user-attachments/assets/ae9b067c-b3c9-4ebf-94bf-eb0dec6adc9f)
|:--:|
| *Figure 16: Table showing Potential Support and Resistance Levels* |






























