*** Settings ***
Documentation     Test suite contains 7 test case:
...               - *tc1*
...               - *tc2*
...               - *tc3*
...               - *tc4*
...               - *tc5*
...               - *tc6*
...               - *tc7*
...               They are implement API testing, specifically GET, POST, DEL and Authorization requests.
Test Teardown     Delete All Sessions
Library           RequestsLibrary

*** Test Cases ***
tc1
    [Documentation]    Run simple Get request https://httpbin.org/anything and check in response "json": null, "method": "GET"
    Create Session    httpbin    https://www.httpbin.org/anything
    ${resp}    Get Request    alias=httpbin    uri=\json
    Should Contain    ${resp.content}    "json": null
    Should Contain    ${resp.content}    "method": "GET"

tc2
    [Documentation]    Run Get request with parameters https://httpbin.org/get?param=text and check in response "param1": "text"
    Create Session    httpbin    https://www.httpbin.org/get?param=text
    ${resp}    Get Request    alias=httpbin    uri=\
    Should Not Contain    ${resp.content}    "param1": "text"

tc3
    [Documentation]    Run Get with extra headers and check extra headers in json
    Create Session    httpbin    https://www.httpbin.org/headers
    ${headers}    Create Dictionary    Some-Header=Some-Header-New
    ${resp}    Get Request    alias=httpbin    uri=\    headers=${headers}
    Should Be Equal As Strings    ${resp.json()['headers']['Some-Header']}    Some-Header-New

tc4
    [Documentation]    Run Get https://httpbin.org/delay/3 with small timeout 1s and check error code
    Create Session    httpbin    https://www.httpbin.org/delay/3    timeout=1
    ${resp}    Get Request    alias=httpbin    uri=\json
    Should Be Equal    ${resp.status_code}    ${404}

tc5
    [Documentation]    Test Basic authorization using user "student" and password "111" with https://httpbin.org/basic-auth/student/111 and check {"authenticated": true, "user": "student"}
    ${user}    Set Variable    student
    ${password}    Set Variable    111
    ${auth}    Create List    ${user}    ${password}
    Create Session    httpbin    https://www.httpbin.org/basic-auth/student/111    auth=${auth}
    ${resp}    Get Request    alias=httpbin    uri=\
    Should Contain    ${resp.content}    {\n \ \ "authenticated": true, \n \ \ "user": "student"\n}

tc6
    [Documentation]    Test Delete request https://httpbin.org/delete and check response
    Create Session    httpbin    https://www.httpbin.org/delete
    ${del_resp}    Delete Request    alias=httpbin    uri=\
    Should Be Equal    ${del_resp.status_code}    ${200}

tc7
    [Documentation]    Test simple Post request https://httpbin.org/post and :
    ...    - Generate json with parameters.
    ...    - Send to https://httpbin.org/post
    ...    - Check parameters in response.
    Create Session    httpbin    https://www.httpbin.org/post
    ${json_data}    To Json    {"width": 123, "heigh": 105, "price": 50}
    ${resp}    Post Request    alias=httpbin    uri=\    json=${json_data}
    Should Contain    ${resp.content}    "json": {\n \ \ \ \ "heigh": 105, \n \ \ \ \ "price": 50, \n \ \ \ \ "width": 123\n \ \ }
