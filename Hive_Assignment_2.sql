CREATE DATABASE NASDAQ;
use NASDAQ;
1)Create an external table for NASDAQ daily prices data set.

DROP TABLE IF EXISTS NASDAQ_daily_prices;
create external table NASDAQ_daily_prices
(exchang String,
 stock_symbol String, NQ_DATE date,
 stock_price_open double,
 stock_price_high double,
 stock_price_low double,
 stock_price_close double,
 stock_volume int,
 stock_price_adj_close double)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
location '/user/maria_dev/NASDAQ_daily_prices/';
///////////////////
2)Create an external table for NASDAQ dividends data set.

create external table NASDAQ_dividends
(exchange_NQ String,
 stock_symbol String,
 NQ_Date date,
 dividends double)

ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
location '/user/maria_dev/NASDAQ_dividends/'
tblproperties("skip.header.line.count"="1");
//////////////////////////////
3)Find out total volume sale for each stock symbol which has closing price more than $5.

use nasdaq;
SELECT stock_symbol, sum(stock_volume) as total_volume
from nasdaq_daily_prices
where stock_price_close > 5
group by stock_symbol;
///////////////////////////////
4)Find out highest price in the history for each stock symbol.

use nasdaq;
SELECT stock_symbol, MAX(stock_price_adj_close) as highest_price
from nasdaq_daily_prices
group by stock_symbol;

///////////////////////
5)Find out highesh dividends given for each stock symbol in entire history.


use nasdaq;
SELECT stock_symbol, MAX(dividends) as highest_Dividens
from NASDAQ_dividends
group by stock_symbol;
//////////////////////////
6)Find out highest price and highesh dividends for each stock symbol if highest price and highest dividends exist.

use nasdaq;
Select np.stock_symbol,
max(np.stock_price_adj_close)as MaxPrice,
max(nd.dividends)as MaxDividens
from nasdaq_daily_prices np join nasdaq_dividends nd
on (np.stock_symbol = nd.Stock_symbol)
group by np.stock_symbol
order by np.stock_symbol;
//////////////////////////////
