*** Settings ***
Documentation     Test suite contains solved home work to 8 lecture:
...               - *tc1*
Force Tags        HW8
Library           SSHLibrary

*** Test Cases ***
tc1
    [Documentation]    There is a Linux remote server host. Test case have next steps:
    ...    - *Open connection to remote server*
    ...    - *Login with login/password *
    ...    - *Change directory to /tmp *
    ...    - *Create a file demo.txt with text: this is a text file*
    ...    - *Run ls command *
    ...    - *Check that the file demo.txt is present *
    ...    - *Upload this file to the local PC*
    ...    - *Open new connection to the same server *
    ...    - *Login with public key to remote server *
    ...    - *Use Write keyword: cat /tmp/demo.txt *
    ...    - *Use Read Until, to check content of demo.txt file *
    ...    - *Switch connection to the first one *
    ...    - *Delete demo.txt file *
    ...    - *Switch connection to the second one*
    ...    - *Check that this file is absent*
    ...    - *Close all connections*
    ${host}    Set Variable    192.168.20.138
    ${username}    Set Variable    adminaccount
    ${password}    Set Variable    Install_new!
    ${connection_id_1}    SSHLibrary.Open Connection    ${host}
    ${output}    SSHLibrary.Login    ${username}    ${password}
    Write    cd /tmp
    ${output}    Read
    Write    echo this is a text file. > demo.txt
    ${output}    Read
    Write    ls
    ${output}    Read
    Write    find demo.txt
    ${output}    Read
    Should Contain    ${output}    demo.txt\r\n [adminaccount@localhost tmp]$
    ${rc}    Get File    /tmp/demo.txt    /tmp/demo.txt
    ${connection_id_2}    SSHLibrary.Open Connection    ${host}
    ${rc}    SSHLibrary.Login With Public Key    ${username}    C:/Users/odysh/.ssh/id_rsa.pub.    ${password}
    Write    cat /tmp/demo.txt
    ${output}    Read Until    this is a text file.
    Switch Connection    ${connection_id_1}
    ${output}    Read
    Write    rm demo.txt
    ${output}    Read
    Switch Connection    ${connection_id_2}
    ${output}    Read
    Write    cd /tmp
    ${output}    Read
    Write    find demo.txt
    ${output}    Read Until    find: ‘demo.txt’: No such file or directory
    SSHLibrary.Close All Connections
