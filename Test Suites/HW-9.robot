*** Settings ***
Documentation     Suite contains one test case:
...               - *tc1*
Library           SeleniumLibrary

*** Test Cases ***
tc1
    [Documentation]    This test case is surfing on the website, and using the SeleniumLibrary framework to do needed manipulation.
    [Setup]
    Set Selenium Timeout    2s
    Set Selenium Speed    0.2s
    Set Selenium Implicit Wait    1s
    Open Browser    http://commentssprintone.azurewebsites.net/    browser=chrome
    Title Should Be    Index
    Click Button    Edit..
    Alert Should Be Present    Please, select one category
    Select From List By Value    SelectedCateg    5
    Click Button    Apply
    Table Cell Should Contain    //table[@class="webgrid"]    2    2    4
    Select Checkbox    5
    Click Button    Edit..
    Input Text    Text    My new comment from RF
    Unselect Checkbox    Active
    Select Checkbox    6
    Click Button    CurSelect
    Click Button    Save & Return
    Select From List By Label    SelectedStatus    Inactive
    Click Button    Apply
    Table Should Contain    //table[@class="webgrid"]    My new comment from RF
    [Teardown]    Close Browser
