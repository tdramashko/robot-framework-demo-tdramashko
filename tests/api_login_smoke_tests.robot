*** Settings ***

Documentation       This suite runs essential smoke tests for the application's core functionality.

Resource            ../resources/common.resource
Resource            ../resources/login.resource

Suite Setup         Launch Browser To Base URL
Suite Teardown      Close and Cleanup Browser
Test Setup          No Operation

*** Test Cases ***

User Can Successfully Log In
    [Tags]    Smoke    Login    P1
    [Documentation]    Verifies that a user can log in with valid credentials and get a token.
    Perform Login       ${USERNAME}       ${PASSWORD}
    Should Contain      ${response.json()}    token

User Cannot Log In With Invalid Password
    [Tags]    Smoke    Login    P2
    [Documentation]    Tests the security mechanism with incorrect login credentials.
    Perform Login       ${USERNAME}       wrong_password
    Should Be Equal As Strings    ${response.json()}[reason]    Bad credentials

User Cannot Log In With Invalid Username
    [Tags]    Smoke    Login    Negative
    [Documentation]    Confirms that invalid username cannot access.
    Perform Login       invalid_user     ${PASSWORD}
    Should Be Equal As Strings    ${response.json()}[reason]    Bad credentials