*** Settings ***
Library            SeleniumLibrary
Suite Setup    Set Selenium Speed    0.3s
Test Setup    Open web browser
Test Teardown    Close Browser
Suite Teardown    Close All Browsers

*** Variables ***
${Url}    https://www.saucedemo.com/
${Browser}    chrome
${user}    xpath=//*[@id="user-name"]
${password}    xpath=//*[@id="password"]
${locator_error_password}    xpath=//*[@id="login_button_container"]/div/form/div[3]/h3
${locator_number_cart}    xpath=//*[@id="shopping_cart_container"]/a/span
${locator_number_cartt}    xpath=//*[@id="shopping_cart_container"]/a
${locator_price}    xpath=//*[@id="cart_contents_container"]/div/div[1]/div[3]/div[2]/div[2]/div
${locator_namegoods}    xpath=//*[@id="item_4_title_link"]/div
${locator_checkoutprice}    xpath=//*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[2]/div
${firstname}    xpath=//*[@id="first-name"]
${lastname}    xpath=//*[@id="last-name"]
${zip/postcode}    xpath=//*[@id="postal-code"]


*** Keywords ***
Open web browser
    Open Browser    ${Url}    ${Browser}
    Maximize Browser Window

login-Pass
    Input Text    ${user}    standard_user    
    Input Password    ${password}    secret_sauce
    Click Element        locator=//*[@id="login-button"]

Login-Fail
    Input Text    ${user}    standard_user
    Input Password    ${password}    secret_sauce123
    Click Element        locator=//*[@id="login-button"]

Verify-msg password
    ${msg_password}    Get Text    ${locator_error_password}
    Should Be Equal As Strings    ${msg_password}    Epic sadface: Username and password do not match any user in this service

Add to cart
    Click Element    xpath=//*[@id="add-to-cart-sauce-labs-backpack"]

Checkout
    Input Text    ${firstname}    automate
    Input Text    ${lastname}    test
    Input Text    ${zip/postcode}    12345
    Click Element    xpath=//*[@id="continue"]


Verify goods in cart
    [Arguments]    ${goods}    ${price}
    ${txt}    Get Text    ${goods}
    Should Be Equal As Strings    ${txt}    ${price}

Verify price of goods
    ${price}    Get Text    ${locator_price}
    Should Be Equal As Strings    ${price}    $29.99

Verify name of goods
    ${name}    Get Text    ${locator_namegoods}
    Should Be Equal As Strings    ${name}    Sauce Labs Backpack

Verify Total
    ${total}    Get Text    ${locator_checkoutprice}
    Should Be Equal As strings    ${total}    $29.99

verify
    Verify goods in cart    goods=${EMPTY}    price=${EMPTY}

*** Test Cases ***
SWAG-001
    login-Pass
    Sleep    2s
    Wait Until Page Contains    Swag Labs

SWAG-002
    Login-Fail
    Verify-msg password

SWAG-003
    login-Pass
    Add to cart
    Verify goods in cart


SWAG-004
    login-Pass
    Add to cart
    Sleep    1s
    Click Element    xpath=//*[@id="remove-sauce-labs-backpack"]
    Sleep    2s
    ${goods_of_cart}    Get Text    ${locator_number_cartt}
    Should Be Equal As Strings    ${goods_of_cart}    ${EMPTY}

SWAG-005
    login-Pass
    Add to cart
    Click Element    xpath=//*[@id="shopping_cart_container"]/a
    Sleep    2s
    Wait Until Page Contains    Sauce Labs Backpack
    Verify price of goods
    Click Element    xpath=//*[@id="checkout"]
    Checkout
    Verify
    Click Element    xpath=//*[@id="finish"]
    sleep    2s
    Wait Until Page Contains    Thank you for your order!

SWAG-006
    login-Pass
    Click Element    xpath=//*[@id="react-burger-menu-btn"]
    Sleep    1s
    Click Element    xpath=//*[@id="logout_sidebar_link"]
    Sleep    2s
    Wait Until Page Contains    Swag Labs
    