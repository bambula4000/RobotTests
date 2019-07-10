*** Settings ***
Library           ../Libraries/lib1.py

*** Variables ***
${var}            1

*** Test Cases ***
tc1
    Execute Sql String    123
    Select Data From Database    SELECT * FROM table
    Add 5 Copies Of sheet To Cart
    Select Data From Database    123

*** Keywords ***
Get ${var} table
    Log    hello

Get Windows Env
    Log    Windows 10

Get Linux Env
    Log    Ubuntu 18.04
