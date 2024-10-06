-- DROP TABLE IF EXISTS tmp_location_wise_profit;
-- CREATE TEMPORARY TABLE tmp_location_wise_profit AS
-- SELECT DATE, STORE_LOCATION, ROUND((SUM(SP) - SUM(CP)), 2) AS lc_profit
-- FROM clean_store_transactions
-- WHERE DATE = SUBDATE(date(now()),1)
-- GROUP BY STORE_LOCATION
-- ORDER BY lc_profit DESC;

-- -- Delete the existing file before creating a new one
-- SYSTEM rm -f /var/lib/mysql-files/location_wise_profit.csv;

SELECT DATE, STORE_LOCATION, ROUND((SUM(SP) - SUM(CP)), 2) AS lc_profit FROM 
clean_store_transactions WHERE DATE = SUBDATE(date(now()),1) 
GROUP BY STORE_LOCATION ORDER BY lc_profit DESC 
INTO OUTFILE '/var/lib/mysql-files/location_wise_profit.csv' 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n';


-- DROP TABLE IF EXISTS tmp_store_wise_profit;
-- CREATE TEMPORARY TABLE tmp_store_wise_profit AS
-- SELECT DATE, STORE_ID, ROUND((SUM(SP) - SUM(CP)), 2) AS st_profit
-- FROM clean_store_transactions
-- WHERE DATE = SUBDATE(date(now()),1)
-- GROUP BY STORE_ID
-- ORDER BY st_profit DESC;


-- -- Delete the existing file before creating a new one
-- SYSTEM rm -f /var/lib/mysql-files/store_wise_profit.csv;


SELECT DATE, STORE_ID, ROUND((SUM(SP) - SUM(CP)), 2) AS st_profit 
FROM clean_store_transactions WHERE DATE = SUBDATE(date(now()),1) 
GROUP BY STORE_ID ORDER BY st_profit DESC 
INTO OUTFILE '/var/lib/mysql-files/store_wise_profit.csv' 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';