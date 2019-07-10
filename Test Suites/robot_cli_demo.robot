*** Settings ***
Library           Collections
Library           String
Library           mathemetical_operations.py
Resource          ../keywords.tsv

*** Variables ***
${GLOBAL}         10
${USER NAM$E}     guest
${HOST}           www.ibm.com
@{MY_LIST}        11    22    33    44
&{CRED}           user=Alex    password=111
${first_var}      first
${second_var}     second

*** Test Cases ***
var 1
    Log To Console    ${HOST}
    ${password}    Set Variable    asdfgasgdf
    Log To Console    ${password}
    Set Suite Variable    ${password}    111
    Set Global Variable    ${GLOBAL}    0
    ${test_var}    Set Variable    1
    ${test_var_if}    Set Variable if    "${test_var}" == "I am from test"    I am if
    Variable Should Exist    ${GLOBAL}
    Log To Console    ${test_var_if}
    Should Be Equal    ${password}    111

list
    #Log To Console    @{MY_LIST}[0]
    #Print    @{MY_LIST}[2]
    #Log To Console    ${MY_LIST}[3]
    @{my_list2}    Create List    1    2    3    4
    ${my_list2}    Create List    ${1}    2    3    4
    Append To List    ${my_list2}    new value
    Log To Console    ${my_list2}
    ${combined}    Combine Lists    ${my_list2}    ${MY_LIST}
    Log To Console    ${combined}
    Insert Into List    ${combined}    1111    ${TRUE}
    Log To Console    ${combined}
    Remove From List    ${combined}    3
    Log To Console    ${combined}
    Set list Value    ${combined}    0    ${FALSE}
    Log To Console    ${combined}
    Log Many    @{combined}
    Should Not Be Equal    @{MY_LIST}    ${my_list2}

dict
    Log    ${CRED.user}    console=True
    &{db_access}    Create Dictionary    host=db.com    db_name=test_01
    Log many    &{db_access}
    &{python_dict}    Evaluate    {'key' : 'value', 'nested' : {'key2' : 'value2'}}
    Log many    &{python_dict}
    Log Dictionary    ${python_dict}
    Set To Dictionary    ${python_dict}    key3=value3
    Log Dictionary    ${python_dict}
    #${key}    Pop From Dictionary    ${python_dict}    key
    #Log Dictionary    ${python_dict}
    Remove From Dictionary    ${python_dict}    key
    Log Dictionary    ${python_dict}
    Log    ${python_dict.nested}
    Log    ${python_dict.nested}[key2]
    #Log Many    &{python_dict}[key3]    &{python_dict}[nested]

var in var
    Log    ${${second_var}_var}    console=True
    Print    qweqweqwe
    Total price    123    123

system info
    Log    %{USERNAME}
    Log    ${SUITE NAME}
    Log    ${TEST NAME}
    Log    ${TEST TAGS}
    Log    ${OUTPUT FILE}

string
    ${str1}    Convert To Lowercase    ABCDEF GHJKLM
    Log    ${str1}    console=True
    ${str2}    Convert To Uppercase    qwerty
    Log    ${str2}    console=True
    ${str3}    Generate Random String    12    [LOWER][NUMBERS]
    Log    ${str3}    console=True
    ${sub_string}    Get Substring    ${str1}    2    4
    ${bool_result}    Should Be Lowercase    ${str1}    #If success its return NONE
    ${split_to_characters}    Split String To Characters    ${str2}

*** Keywords ***
