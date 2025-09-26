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
Valid Checkout
    [Documentation]    Verify that a user can complete checkout successfully
    Input Credentials    ${VALID_USER}    ${PASSWORD}
    Add Item To Cart
    Go To Checkout
    Enter Checkout Info    Zaiba    Fathima    12345
    Complete Checkout
    Page Should Contain    THANK YOU FOR YOUR ORDER
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

Add Item To Cart
    Click Button    xpath=//button[@id='add-to-cart-sauce-labs-backpack']
    Wait Until Element Is Visible    class=shopping_cart_link    10s

Go To Checkout
    Click Link    class=shopping_cart_link
    Click Button    id=checkout

Enter Checkout Info
    [Arguments]    ${first}    ${last}    ${zip}
    Input Text    id=first-name    ${first}
    Input Text    id=last-name     ${last}
    Input Text    id=postal-code   ${zip}
    Click Button  id=continue

Complete Checkout
    Click Button    id=finish
