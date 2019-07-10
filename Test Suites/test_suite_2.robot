*** Settings ***
Documentation     Test suite contais materials depend on home work2 and home work4.
...
...               Structure:
...               - *'Test Suites'* directory conains all test suites.
...               - *'Resources File'* directory contains robot keywords.
...               - *'Libraries'* directory contains custom keywords.
Library           OperatingSystem
Library           BuiltIn
Resource          ../Resources Files/keywords.tsv

*** Test Cases ***
HW2
    [Documentation]    Case takes price and discount for two products and calculate their total price and print it to console.
    ...
    ...    Parameters:
    ...    - *product1* - should be an interger.
    ...    - *discount* - should be an interger, please write without '%' symbol.
    ...    - *product2* - should be an interger.
    ...    - *discoun2* - should be an interger, please write without '%' symbol.
    ${actual_price_product1}    Calculation of discount price    product_price=${100}    discount=${5}
    ${actual_price_product2}    Calculation of discount price    product_price=${990}    discount=${15}
    ${total_price}    Total price    ${actual_price_product1}    ${actual_price_product2}
    Log To Console    ${total_price}

*** Keywords ***
