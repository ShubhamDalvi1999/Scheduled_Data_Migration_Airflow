yesterday_date=$(date -d "1 day ago" '+%Y-%m-%d')

if [ ! -f ~/store_files_airflow/raw_store_transactions.csv ]; then
    echo "File not found!"
else
    cp -f ~/store_files_airflow/raw_store_transactions.csv ~/store_files_airflow/raw_store_transactions_$yesterday_date.csv  
fi