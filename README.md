# Airflow Data Processing Pipeline
<h2 align="center">
  Welcome to My Data Engineering Project!
  <img src="https://media.giphy.com/media/hvRJCLFzcasrR4ia7z/giphy.gif" width="28">
</h2>


<!-- Intro  -->
<h3 align="center">
        <samp>&gt; Hey There!, I am
                <b><a target="_blank" href="https://yourwebsite.com">Shubham Dalvi</a></b>
        </samp>
</h3>

<p align="center"> 
  <samp>
    <br>
    「 I am a data engineer with a passion for big data , distributed computing and data visualization 」
    <br>
    <br>
  </samp>
</p>

<div align="center">
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&random=false&width=435&lines=Spark+%7C+DataBricks++%7C+Power+BI+;Snowflake+%7C+Azure++%7C+Airflow;3+yrs+of+IT+experience+as+Analyst+%40+;Accenture+;Passionate+Data+Engineer+" alt="Typing SVG" /></a>
</div>

<p align="center">
 <a href="https://linkedin.com/in/yourprofile" target="_blank">
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="yourprofile"/>
 </a>
</p>
<br />

<!-- About Section -->
 # About me
 
<p>
 <img align="right" width="350" src="/assets/programmer.gif" alt="Coding gif" />
  
 ✌️ &emsp; Enjoy solving data problems <br/><br/>
 ❤️ &emsp; Passionate about big data technologies, distributed systems and data visualizations<br/><br/>
 📧 &emsp; Reach me : dshubhamp1999@gmail.com<br/><br/>

</p>

<br/>
<br/>
<br/>

## Skills and Technologies

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Apache Airflow](https://img.shields.io/badge/Apache_Airflow-017CEE?style=for-the-badge&logo=apache-airflow&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![VSCode](https://img.shields.io/badge/Visual_Studio-0078d7?style=for-the-badge&logo=visual%20studio&logoColor=white)

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
