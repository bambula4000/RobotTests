*** Settings ***
Test Setup        Open DB
Test Teardown     Close DB
Force Tags        DB

*** Variables ***
${close}          Close DB

*** Test Cases ***
s_t
    [Tags]    SMOKE    HIGH
    [Timeout]    2 seconds
    Sleep    5s
    ${list}    Query    SELECT * FROM TABLE

s_t-2
    [Tags]    SMOKE
    ${list}    Query    SELECT * FROM TABLE
    Should Be Empty    ${list}

ELSE
    [Tags]    L
    ${status}    Set Variable    PASSasd
    Run Keyword If    '${status}' == 'PASS'    Some Action    arg
    ...    ELSE IF    ${rc} == 0    Anotger Action
    ...    ELSE IF    ${rc} === 1    Another Action with args    ${rc}    arg2
    ...    ELSE    Another action

Loop_FOR
    [Tags]    ANIMALS
    : FOR    ${animal}    IN    cat    dog    bird    pork
    ...    bull
    \    Log    ${animal}
    : FOR    ${num}    IN RANGE    1    10
    \    Log    ${num}
    : FOR    ${num}    IN RANGE    1    10    2    #i set step 2, it may be any
    \    Log    ${num}
    : FOR    ${num}    IN RANGE    15
    \    Log    ${num}

IF
    ${status}    Set Variable    PASSjkl
    Run Keyword If    '${status}' == 'PASS'    Some Action
    Run Keyword Unless    '${status}' == 'PASS'    Another Action

*** Keywords ***
Open DB
    Log    Open DB

Close DB
    Log    Close DB

Query
    [Arguments]    ${arg1}
    Log    ${arg1}
    [Return]    11

Some Action
    Log    PASS

Another Action
    Log    NOT PASS
