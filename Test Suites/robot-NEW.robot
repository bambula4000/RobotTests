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
    ${d1}    Start Process    python    /tmp/daemon.py    alias=daemon    shell=true
    ${result}    Wait For Process    timeout=2s    on_timeout=continue
    Terminate Process    ${d1}    kill=True
    Switch Process    ${d1}
    Comment    ${ret}    Run Process    dir    shell=True
    Comment    Log To Console    ${ret.stdout}
    Comment    ${d1}    Start Process    /tmp/daemon1.bat    alias=daemon1    shell=True
    Comment    ${status}    Is Process Running
    Comment    ${result}    Wait For Process    timeout=11s
    Comment    Log To Console    ${status}
    Comment    Log To Console    ${result}
    Comment    ${d2}    Start Process    /tmp/daemon2.bat

tc1
    ${create}    Create File    /Users/odysh/hm7tc1.py    print("Hello home work!")
    ${d1}    run    python /Users/odysh/hm7tc1.py
    Comment    ${rc}    ${stdout}    Run And Return Rc And Output    python /Users/odysh/hm7tc1.py
