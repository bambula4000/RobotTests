*** Settings ***
Documentation     Test suit with solutions for HW-12, contains four test case:
...               - *tc1*
Library           OperatingSystem
Library           ../Libraries/hw-12.py

*** Variables ***
${md5}            a37e9ce9e5a53c24d44a59084f0dde32

*** Test Cases ***
tc1
    [Documentation]    Test case steps:
    ...    - Read "Windows" directory (%windir%) to a list variable
    ...    - Check that "notepad.exe" exists in the list
    ...    - Calculate MD5 for "notepad.exe"
    ...    - Compare results with expected value
    ${list_var}    Read Dir Content & Add To List    %windir%
    ${result}    Find Element in List    ${list_var}    notepad.exe
    ${result_md5}    Calculate Hash Sum
    ${Compare_Hash_Results}    Compare_Hash_Results    ${md5}    ${result_md5}

*** Keywords ***
Find Element in List
    [Arguments]    ${list_var}    ${object}
    [Documentation]    keyword has one variable:
    ...    - *${list}* - is a list variable where should find.
    ...    - *${object}* - is a string name of element that should be find.
    ${result}    Find Value In List    ${list_var}    ${object}
    Should Not Be Equal    ${result}    ${-1}

Read Dir Content & Add To List
    [Arguments]    ${directory}
    [Documentation]    The keyword has one variable:
    ...    - *${directory}* - directroy to be shown what does it contains.
    ${windir_content}    Run    dir ${directory}
    ${windir_content_list}    Add String To List    ${windir_content}
    [Return]    ${windir_content_list}

Calculate Hash Sum
    [Documentation]    The keyword takes one argument:
    ...    - *${string}* - a string that will be calculate MD5
    ${hash_sum}    Calculate notepad.exe MD5
    [Return]    ${hash_sum}

Compare_Hash_Results
    [Arguments]    ${md5}    ${result_md5}
    [Documentation]    The keyword takes two argument:
    ...    - *${md5}* - is a global variable
    ...    - *${result_md5}* - is a md5 sum
    ${result}    Compare Hash Sum Of Two Args    ${md5}    ${result_md5}
    Should Be True    ${result}
    [Return]    ${result}
