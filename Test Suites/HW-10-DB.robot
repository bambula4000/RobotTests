*** Settings ***
Documentation     Test suite contains 3 test case:
...               - *tc1* - select some data from table
...               - *tc2* - delete data from table
...               - *tc3* - adding data to table
Test Teardown     Disconnect From Database
Library           DatabaseLibrary
Resource          ../Resources Files/Keywords-Sql.tsv

*** Test Cases ***
tc1
    [Documentation]    Test case do next steps:
    ...    - *1.* Connect to database with the prepared parameters in db.conf file.
    ...    - *2.* Select from demo1 people with age < 7. Implement it as a custom keyword.
    ...    - *3.* Test fail if salary > 0
    Connect To Database    dbConfigFile=C:\\Program Files\\MySQL\\MySQL Server 5.5\\db.cfg
    ${result}    Select    *    age < 7
    Run Keyword If    '${result}[0][4]' > '0'    FAIL
    [Teardown]

tc2
    [Documentation]    Test case do next steps:
    ...    - *1.* Connect to database with using all parameters
    ...    - *2.* Delete all information from table demo1
    ...    - *3.* Calculate count of rows in the table
    ...    - *4.* Test fail if count of rows > 0.
    Connect To Database    pymysql    demo_database    root    123456    localhost    3306
    Delete All Rows From Table    demo1
    Row Count Is 0    SELECT * FROM demo1
    [Teardown]

tc3
    [Documentation]    - *1.* Connect to database with using custom parameters
    ...    - *2.* Use Execute Sql Script to add ten records to demo1. Implement it as a custom keyword.
    ...    - *3.* Calculate count of records.
    ...    - *4.* Test fail if count of records <> 10.
    Connect To Database Using Custom Params    pymysql    database='demo_database', user='root', password='123456', host='localhost', port=3306
    Add
    ${row_count}    Row Count    SELECT * FROM demo1
    Run Keyword If    '${row_count}' == '10'    FAIL
    [Teardown]
