*** Settings ***
Documentation     Test suite contains materials for home work 5.
...               - There is a remote host (RH).
...               - RH has a web server and a backend server there.
...               - Our goal is connect to RH and perform three verifications.
...               - Each verification is one test case.
Test Teardown
Force Tags        Global
Library           OperatingSystem
Library           ../Libraries/SSHLibrary/
Resource          ../Resources Files/keywords-hw5.tsv

*** Test Cases ***
case_1
    [Documentation]    First test case.
    ...
    ...    - The first test case has tags UI and smoke . Timeout - one minute.
    ...    - It runs UI verification and check result.
    ...    - If result is failed,then set new tag - UI_Error , else set tag No_Errors.
    [Tags]    UI    smoke
    [Timeout]    1 minute
    ${check_UI_status}    Verify UI
    Run Keyword If    '${check_UI_status}' == 'FAILED'    Set Tags    UI_Error
    ...    ELSE    Set Tags    No_Errors

case_2
    [Documentation]    Second test case.
    ...
    ...    - The second test case has tag backend .
    ...    - If backend verification returns PASSED will set tag Backend_Error .
    [Tags]    backend
    ${check_backend_status}    Verify Backend
    Run Keyword If    '${check_backend_status}' != 'PASSED'    Set Tags    Backend_Error
    ${params}    Create List    host    www.com    user    guest    password
    ...    qwerty
    :FOR    ${param}    ${value}    IN    @{params}
    \    Edit Config    ${param}=${value}
    [Teardown]    Backup Configuration

case_3
    [Documentation]    Third test case.
    ...    - the third test case has tag CLI.
    ...    - It create five directories in current directory with name 'robot_1', 'robot_2', 'robot_3', 'robot_4', 'robot_5'.
    ...    - In test case set teardown func that will delete created directories in this case.
    [Tags]    CLI
    : FOR    ${index}    IN RANGE    1    6
    \    Create Directory    robot_${index}
    [Teardown]    Directory Remover

*** Keywords ***
