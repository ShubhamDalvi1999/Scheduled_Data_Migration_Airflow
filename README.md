# Airflow Data Processing Pipeline

## Overview
This project demonstrates an automated data processing pipeline using Apache Airflow. The pipeline consists of several tasks that handle data ingestion, cleaning, transformation, and storage. Each task is defined as a node in the workflow, ensuring a clear and maintainable structure.

## Workflow
The workflow is composed of the following tasks:

1. **Check for Files**: Verifies the presence of the required input files.

    ```python
    t1 = BashOperator(
        task_id='check_file_exists',
        bash_command='shasum ~/store_files_airflow/raw_store_transactions.csv',
        retries=2,
        retry_delay=timedelta(seconds=15)
    )
    ```

2. **Clean Raw CSV**: Processes and cleans the raw CSV data.

    ```python
    t2 = PythonOperator(
        task_id='clean_raw_csv',
        python_callable=data_cleaner
    )
    ```

3. **Create MySQL Table**: Creates a table in the MySQL database.

    ```python
    t3 = MySqlOperator(
        task_id='create_mysql_table',
        mysql_conn_id="mysql_conn",
        sql="create_table.sql"
    )
    ```

4. **Insert into Table**: Inserts the cleaned data into the MySQL table.

    ```python
    t4 = MySqlOperator(
        task_id='insert_into_table',
        mysql_conn_id="mysql_conn",
        sql="insert_into_table.sql"
    )
    ```

5. **Select from Table**: Retrieves data from the MySQL table for further processing.

    ```python
    t5 = MySqlOperator(
        task_id='select_from_table',
        mysql_conn_id="mysql_conn",
        sql="select_from_table.sql"
    )
    ```

6. **Move File 1**: Moves the first processed file to a new location.

    ```python
    t6 = BashOperator(
        task_id='move_file1',
        bash_command='mv ~/store_files_airflow/location_wise_profit.csv ~/store_files_airflow/location_wise_profit_%s.csv' % yesterday_date
    )
    ```

7. **Move File 2**: Moves the second processed file to a new location.

    ```python
    t7 = BashOperator(
        task_id='move_file2',
        bash_command='mv ~/store_files_airflow/store_wise_profit.csv ~/store_files_airflow/store_wise_profit_%s.csv' % yesterday_date
    )
    ```

8. **Send Email**: Sends an email notification with the generated reports.

    ```python
    t8 = EmailOperator(
        task_id='send_email',
        to='dshubhamp1999@gmail.com',
        subject='Daily report generated',
        html_content=""" <h1>Congratulations! Your store reports are ready.</h1> """,
        files=[
            '/usr/local/airflow/store_files_airflow/location_wise_profit_%s.csv' % yesterday_date,
            '/usr/local/airflow/store_files_airflow/store_wise_profit_%s.csv' % yesterday_date
        ]
    )
    ```

9. **Rename Raw File**: Renames the raw file using a shell script.

    ```python
    t9 = BashOperator(
        task_id='rename_raw',
        bash_command='bash /usr/local/airflow/sql_files/copy_shell_script.sh'
    )
    ```

## Getting Started
1. Place your input files in the designated directory.
2. Trigger the DAG from the Airflow UI or command line:

    ```bash
    airflow dags trigger your_dag_id
    ```

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

## License
This project is licensed under the MIT License.
