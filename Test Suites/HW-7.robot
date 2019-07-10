*** Settings ***
Library           OperatingSystem
Library           Process

*** Test Cases ***
tc1
    ${create}    Create File    /Users/odysh/hm7tc1.py    print("Hello home work!")
    ${d1}    Run    python /Users/odysh/hm7tc1.py
    Should Be Equal As Strings    ${d1}    Hello home work!
    ${rc}    ${stdout}    Run And Return Rc And Output    python /Users/odysh/hm7tc1.py
    ${create}    Create File    /Users/odysh/stdout_log.txt    ${stdout}
    ${find}    Run    find "work" C:/Users/odysh/stdout_log.txt
    Should Be Equal As Strings    ${find}    \n---------- C:/USERS/ODYSH/STDOUT_LOG.TXT\nHello home work!
    Copy file    /Users/odysh/stdout_log.txt    /tmp/
    Move File    /Users/odysh/hm7tc1.py    /Users/odysh/src/
    ${list_directory}    List Directory    /Users/odysh/
    Log Many    ${list_directory}

tc2
    ${find}    Run In Command Line    find /i "ERROR" C:/tmp/changelog.txt
    Log Many    ${find}
    ${open}    Start Process    C:/tmp/changelog.txt    shell=True
    ${result}    Wait For Process    timeout=0.1s    on_timeout=kill
    Log To Console    ${result}

*** Keywords ***
Run In Command Line
    [Arguments]    ${command}
    [Documentation]    Keyword helps to run any command using command line
    ...
    ...    Parameters:
    ...    - *command* - should be a command that can be read by command line.
    ${find}    Run    ${command}
    [Return]    ${find}
