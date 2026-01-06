*** Settings ***

Library         RequestsLibrary
Library         SeleniumLibrary
Variables       ../libraries/common_variables.py

*** Keywords ***

# API Keywords

Launch Browser To Base URL
    [Documentation]    Creates a session to the API.
    Create Session    restful    ${URL}

Close and Cleanup Browser
    [Documentation]    Closes the session.
    Delete All Sessions

Verify Inventory Page Is Displayed
    [Documentation]    Verifies that the API is accessible by getting bookings.
    ${resp}=    GET On Session    restful    /booking
    Status Should Be    200    ${resp}

Perform Login Via API
    [Documentation]    Performs login via API
    [Arguments]    ${username}    ${password}
    ${data}=    Create Dictionary    username=${username}    password=${password}
    ${resp}=    POST On Session    restful    /auth    json=${data}
    Set Test Variable    ${response}    ${resp}

# UI Keywords

Launch UI Browser And Go To Login
    [Documentation]    Launches UI browser and navigates to login page.
    Open Browser    ${UI_URL}    ${BROWSER}
    Maximize Browser Window
    Set Window Size    1920    1080
    Set Selenium Implicit Wait    5s

Close and Cleanup UI Browser
    [Documentation]    Closes the UI browser.
    Close All Browsers

Perform UI Login
    [Documentation]    Inputs credentials and clicks the login button for UI.
    [Arguments]    ${username}    ${password}
    Input Text          id=username        ${username}
    Input Text          id=password        ${password}
    Click Button        xpath=//button[text()='Login']

Verify UI Login Success
    [Documentation]    Verifies that the login was successful by checking the page no longer contains 'Login'.
    Wait Until Page Does Not Contain    Login    timeout=10s

Verify UI Login Failure
    [Documentation]    Verifies that the login failed by checking for error message.
    Wait Until Page Contains    Invalid    timeout=10s

# BDD Gherkin Keywords

Given the user is on the login page
    [Documentation]    Ensures the user is on the login page (handled by test setup).
    No Operation

When the user enters valid username and password
    [Documentation]    Enters valid credentials.
    Perform UI Login    ${UI_USERNAME}    ${UI_PASSWORD}

When the user enters valid username and invalid password
    [Documentation]    Enters valid username with invalid password.
    Perform UI Login    ${UI_USERNAME}    wrong_password

When the user enters invalid username and valid password
    [Documentation]    Enters invalid username with valid password.
    Perform UI Login    invalid_user    ${UI_PASSWORD}

And the user clicks the login button
    [Documentation]    The login button click is included in Perform UI Login.
    No Operation

Then the user should be logged in successfully
    [Documentation]    Verifies successful login.
    Verify UI Login Success

Then the login should fail with an error message
    [Documentation]    Verifies login failure.
    Verify UI Login Failure