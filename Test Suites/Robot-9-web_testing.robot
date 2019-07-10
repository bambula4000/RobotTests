*** Settings ***
Library           SeleniumLibrary    #timeout=1s, implicit_wait=1s, speed=0.2s

*** Test Cases ***
tc1
    Set Selenium Speed    0.2s
    Set Selenium Timeout    1s
    Set Selenium Implicit Wait    1s
    Open Browser    http://commentssprintone.azurewebsites.net/    browser=chrome
    Comment    Click Link    newbutton
    Comment    Element Should Be Focused    //input[@id="Text"]
    Comment    Input Text    Text    Hello People
    Comment    Select Checkbox    1
    Comment    Click Button    id:CurSelect
    Comment    Click Button    Save & Return
    Comment    Select From List By Value    SelectedCateg    1
    Comment    Select From List By Value    SelectedStatus    1
    Comment    Submit Form
    Comment    Click Link    Number
    Comment    Page Should Contain    Cat0    #не особо хорошо
    Comment    Page Should Contain Element    //div[@id="title"]/h1    #норм xpath(в скобках указываем конкретный id дива)
    Comment    Page Should Contain Element    //div[@id="title"]/h22    # в случае неудачи автоматом будет вызван киворд скриншота в лог, чтобы быстрее найти где упал тест(такой киворд по умолчанию стоит, можно что-то другое настроить)
    Comment    Table Cell Should Contain    //table[@class="webgrid"]    2    5    Cat0
    ${coockie}    Get Cookie    ASP.NET_SessionId
    Log To Console    ${coockie.value}
    Execute Javascript    window.EditCmd('Edit')
