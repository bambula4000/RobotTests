*** Settings ***
Library           OperatingSystem
Library           Process

*** Test Cases ***
copy_create_get
    [Documentation]    Should be connect OperatingSystem library
    ${rc}    Copy file    robot-7.robot    robot-NEW.robot
    ${rc}    Copy Directory    pybot    pybot-NEW
    ${rc}    Copy Files    Local.robot    HW-5.robot    ts1.robot    /tmp
    ${count}    Count Items In Directory    /tmp    *.robot
    Log To Console    ${count}
    ${create}    Create File    /tmp/ts7.robot    *** Test Cases ***
    ${create}    Create Binary File    /tmp/bin_file.bin    hello\x09hello
    ${get}    Get Binary File    /tmp/bin_file.bin
    Log To Console    ${get}
    ${rc}    ${stdout}    Run And Return Rc And Output    dir /asd.asd
    Should Be Equal As Integers    ${rc}    0

process
    [Documentation]    Should be connect Process library
    Comment    ${d1}    Start Process    python    /tmp/daemon.py    alias=daemon    shell=true
    Comment    ${result}    Wait For Process    timeout=2s    on_timeout=continue
    Comment    Terminate Process    ${d1}    kill=True
    Comment    Switch Process    ${d1}
    ${ret}    Run Process    dir    shell=True
    Log To Console    ${ret.stdout}
    Comment    ${d1}    Start Process    /tmp/daemon1.bat    alias=daemon1    shell=True
    Comment    ${status}    Is Process Running
    Comment    ${result}    Wait For Process    timeout=11s
    Comment    Log To Console    ${status}
    Comment    Log To Console    ${result}
    Comment    ${d2}    Start Process    /tmp/daemon2.bat

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
