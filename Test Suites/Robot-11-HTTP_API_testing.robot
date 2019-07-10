*** Settings ***
Library           RequestsLibrary
Library           OperatingSystem

*** Test Cases ***
tc1
    Comment    ${stdout}    Run    curl
    Create Session    httpbin    https://www.httpbin.org
    ${resp}    Get Request    alias=httpbin    uri=/json
    Log    ${resp.status_code}
    Log    ${resp.content}
    Log    ${resp.json()}
    Delete All Sessions
