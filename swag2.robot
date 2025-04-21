*** Settings ***
Library    SeleniumLibrary
Suite Setup    Set Selenium Speed    0.5s
Suite Teardown    Close All Browsers

*** Variables ***
${browser}    gc
${url}    https://www.saucedemo.com/
${username}    //input[@id='user-name']
${password}    //input[@id='password']
${button}    //input[@id='login-button']

*** Keywords ***
open web browser
    open browser    ${url}    ${browser}
    Maximize Browser Window

log in
    open web browser
    [Arguments]    ${usernameargument}    ${passwordargument}
    Input Text    ${username}    ${usernameargument}
    Input Password    ${password}    ${passwordargument}
    Click Button    ${button}

*** Test Cases ***
TC-001 login
    [Template]    log in
    standard_user    secret_sauce
    locked_out_user    secret_sauce
    problem_user    secret_sauce
    performance_glitch_user    secret_sauce
    error_user    secret_sauce
    visual_user    secret_sauce



    
    