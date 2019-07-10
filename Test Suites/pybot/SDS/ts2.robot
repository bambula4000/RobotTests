*** Test Cases ***
tc3
    [Tags]    HIGH    LOW    SMOKE
    Log    TC3

tc4
    [Tags]    LOW
    Log    TC4

tc4-bug
    [Tags]    BUG-12345    BUG
    Should Be True    ${FALSE}