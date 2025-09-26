*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Sauce Demo
Suite Teardown    Close Browser

*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       chrome
${VALID_USER}    standard_user
${PASSWORD}      secret_sauce

*** Test Cases ***
Valid User Login
    [Documentation]    Verify that a valid user can log in successfully
    Input Credentials    ${VALID_USER}    ${PASSWORD}
    Page Should Contain    Products
    Capture Page Screenshot

Invalid User Login
    [Documentation]    Verify that an invalid user cannot log in
    Input Credentials    invalid_user    ${PASSWORD}
    Page Should Contain    Epic sadface
    Capture Page Screenshot

*** Keywords ***
Open Browser To Sauce Demo
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s    

Input Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id=user-name    10s
    Input Text    id=user-name    ${username}
    Input Text    id=password    ${password}
    Click Button    id=login-button
    Wait Until Page Contains Element    xpath=//div[@class='inventory_list']    10s
