*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Sauce Demo
Suite Teardown    Close Browser

*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       chrome
${USER}          standard_user
${PASSWORD}      secret_sauce
${FIRST_NAME}    John
${LAST_NAME}     Doe
${ZIP_CODE}      12345
${CHROME_OPTS}   --guest

*** Test Cases ***
Complete Checkout
    [Documentation]    Verify that a user can complete the checkout process
    Input Credentials    ${USER}    ${PASSWORD}
    Add Item To Cart
    Go To Cart
    Proceed To Checkout
    Fill Checkout Information    ${FIRST_NAME}    ${LAST_NAME}    ${ZIP_CODE}
    Finish Checkout And Verify

*** Keywords ***
Open Browser To Sauce Demo
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    ${CHROME_OPTS}
    Open Browser    ${URL}    ${BROWSER}    options=${options}
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

Go To Cart
    Click Link    class=shopping_cart_link
    Wait Until Page Contains Element    id=checkout    10s

Proceed To Checkout
    Click Button    id=checkout
    Wait Until Element Is Visible    id=first-name    10s

Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${zip_code}
    Input Text    id=first-name    ${first_name}
    Input Text    id=last-name     ${last_name}
    Input Text    id=postal-code   ${zip_code}
    Click Button    id=continue
    Wait Until Element Is Visible    id=finish    10s

Finish Checkout And Verify
    Click Button    id=finish
    Wait Until Element Is Visible    css=h2.complete-header    timeout=10s
    Page Should Contain Element      css=h2.complete-header
    Capture Page Screenshot

