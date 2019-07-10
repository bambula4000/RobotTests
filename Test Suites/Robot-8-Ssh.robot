*** Settings ***
Library           SSHLibrary

*** Test Cases ***
tc1
    [Timeout]
    ${connection_id2}    SSHLibrary.Open Connection    192.168.20.135
    ${output}    SSHLibrary.Login    adminaccount    Install_new!
    Log To Console    ${output}
    ${stdout}    ${stdout}    Execute Command    ls    return_stdout=True    return_rc=True
    Log To Console    ${stdout}
    Comment    Start Command    sudo cat /var/log/messages    Install_new!
    Comment    ${stdout_of_latest_command}    Read Command Output
    Comment    Log To Console    ${stdout_of_latest_command}
    SSHLibrary.Close Connection

tc2
    [Tags]
    ${connection_id2}    SSHLibrary.Open Connection    192.168.20.135
    ${output}    SSHLibrary.Login    adminaccount    Install_new!
    Write    python
    ${output}    Read Until    >>>
    Log    ${output}
    Write    print "Hi!"
    ${output}    Read
    Log    ${output}
    Write    exit()
    ${output}    Read
    Log    ${output}

tc3
    [Tags]    RUN
    ${connection_id2}    SSHLibrary.Open Connection    192.168.20.135
    ${output}    SSHLibrary.Login    adminaccount    Install_new!
    ${rc}    Get File    ./.bash_profile    /tmp/.bash_profile    # copy from remote to host
    ${rc}    Put File    /tmp/changelog.txt    ./    # copy from host to remote
    Close Connection
