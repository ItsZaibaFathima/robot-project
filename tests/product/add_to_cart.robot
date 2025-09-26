*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Sauce Demo
Suite Teardown    Close Browser

*** Variables ***
${URL}       https://www.saucedemo.com/
${BROWSER}   chrome
${USER}      standard_user
${PASSWORD}  secret_sauce
${CHROME_OPTS}   --guest

*** Test Cases ***
Add Item To Cart
    [Documentation]    Verify that an item can be added to the cart
    Input Credentials    ${USER}    ${PASSWORD}
    Add Item To Cart
    Cart Should Contain    1
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

Cart Should Contain
    [Arguments]    ${expected_count}
    Click Link    class=shopping_cart_link
    ${items}=    Get Element Count    xpath=//div[@class='cart_item']
    Should Be Equal As Numbers    ${items}    ${expected_count}
