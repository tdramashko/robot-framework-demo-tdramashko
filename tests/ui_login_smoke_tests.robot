*** Settings ***

Documentation       This suite runs essential smoke tests for the UI application's login functionality using BDD Gherkin style.

Resource            ../resources/common.resource
Resource            ../resources/ui_login.resource

Suite Setup         No Operation
Suite Teardown      No Operation
Test Setup          Launch UI Browser And Go To Login
Test Teardown       Close and Cleanup UI Browser

*** Test Cases ***

Successful UI Login
    [Tags]    Smoke    Login    P1    UI    BDD
    [Documentation]    Verifies that a user can log in with valid credentials via UI.
    Given the user is on the login page
    When the user enters valid username and password
    And the user clicks the login button
    Then the user should be logged in successfully

Failed UI Login with Invalid Password
    [Tags]    Smoke    Login    P2    UI    BDD
    [Documentation]    Tests the security mechanism with incorrect password via UI.
    Given the user is on the login page
    When the user enters valid username and invalid password
    And the user clicks the login button
    Then the login should fail with an error message

Failed UI Login with Invalid Username
    [Tags]    Smoke    Login    Negative    UI    BDD
    [Documentation]    Confirms that invalid username cannot access via UI.
    Given the user is on the login page
    When the user enters invalid username and valid password
    And the user clicks the login button
    Then the login should fail with an error message