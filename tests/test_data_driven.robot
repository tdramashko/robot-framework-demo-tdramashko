*** Settings ***
Documentation       Data-Driven Testing Suite
...                 This suite demonstrates various data-driven testing approaches in Robot Framework
...                 including Test Templates, external data files, and inline data tables.

Resource            ../resources/common.resource
Library             String
Library             OperatingSystem
Library             Collections

Suite Setup         Log    Data-Driven Testing Suite Started
Suite Teardown      Log    Data-Driven Testing Suite Completed
Test Setup          Launch Browser To Base URL
Test Teardown       Close and Cleanup Browser

*** Variables ***
@{LOGIN_DATA}    ${USERNAME}    ${PASSWORD}    ${USERNAME}    wrong_password    invalid_user    ${PASSWORD}    invalid_user    wrong_password
@{EXPECTED_RESULTS}    token    Bad credentials    Bad credentials    Bad credentials

*** Test Cases ***

# ===== TEST TEMPLATE APPROACH =====
Login With Multiple Data Sets
    [Documentation]    Demonstrates data-driven testing using FOR loops
    [Tags]    data-driven    template    login
    @{test_data}=    Create List
    ...    ${USERNAME}|${PASSWORD}|token
    ...    ${USERNAME}|wrong_password|Bad credentials
    ...    invalid_user|${PASSWORD}|Bad credentials
    ...    invalid_user|wrong_password|Bad credentials

    FOR    ${data_set}    IN    @{test_data}
        @{fields}=    Split String    ${data_set}    |
        ${username}=    Set Variable    ${fields}[0]
        ${password}=    Set Variable    ${fields}[1]
        ${expected}=    Set Variable    ${fields}[2]

        Log    Testing login with: ${username}/${password} -> ${expected}
        Perform Login Via API    ${username}    ${password}

        Run Keyword If    '${expected}' == 'token'
        ...    Should Contain    ${response.json()}    ${expected}
        ...    ELSE
        ...    Should Be Equal As Strings    ${response.json()}[reason]    ${expected}
    END

# ===== INLINE DATA TABLE APPROACH =====
Login Scenarios Using Inline Data
    [Documentation]    Demonstrates inline data table approach using FOR loops
    [Tags]    data-driven    inline    login
    @{test_data}=    Create List
    ...    ${USERNAME}|${PASSWORD}|token
    ...    ${USERNAME}|wrong_password|Bad credentials
    ...    invalid_user|${PASSWORD}|Bad credentials
    ...    invalid_user|wrong_password|Bad credentials

    FOR    ${data_set}    IN    @{test_data}
        @{fields}=    Split String    ${data_set}    |
        ${username}=    Set Variable    ${fields}[0]
        ${password}=    Set Variable    ${fields}[1]
        ${expected}=    Set Variable    ${fields}[2]

        Log    Testing inline data: ${username}/${password} -> ${expected}
        Perform Login Via API    ${username}    ${password}

        Run Keyword If    '${expected}' == 'token'
        ...    Should Contain    ${response.json()}    ${expected}
        ...    ELSE
        ...    Should Be Equal As Strings    ${response.json()}[reason]    ${expected}
    END

# ===== EXTERNAL CSV DATA APPROACH =====
Login With CSV Data
    [Documentation]    Demonstrates reading data from CSV file manually
    [Tags]    data-driven    csv    external    login
    # For demonstration purposes, using hardcoded data that simulates CSV reading
    # In a real scenario, this would read from an actual CSV file
    @{csv_like_data}=    Create List
    ...    admin|password123|token
    ...    admin|wrongpass|Bad credentials
    ...    invaliduser|password123|Bad credentials
    ...    invaliduser|wrongpass|Bad credentials
    ...    testuser|testpass|Bad credentials

    FOR    ${data_set}    IN    @{csv_like_data}
        @{fields}=    Split String    ${data_set}    |
        ${username}=    Get From List    ${fields}    0
        ${password}=    Get From List    ${fields}    1
        ${expected}=    Get From List    ${fields}    2

        Log    Testing CSV-like data: ${username}/${password} -> ${expected}
        Perform Login Via API    ${username}    ${password}

        Run Keyword If    '${expected}' == 'token'
        ...    Should Contain    ${response.json()}    ${expected}
        ...    ELSE
        ...    Should Be Equal As Strings    ${response.json()}[reason]    ${expected}
    END

# ===== DYNAMIC DATA GENERATION =====
Login With Dynamically Generated Data
    [Documentation]    Demonstrates dynamic data generation for testing
    [Tags]    data-driven    dynamic    login
    # Generate multiple test scenarios dynamically
    FOR    ${i}    IN RANGE    1    4
        ${random_username}=    Generate Random Username
        ${random_password}=    Generate Random Password

        Log    Testing with generated data: ${random_username}/${random_password}
        Perform Login Via API    ${random_username}    ${random_password}

        # All random credentials should fail with "Bad credentials"
        Should Be Equal As Strings    ${response.json()}[reason]    Bad credentials
        Should Not Contain    ${response.json()}    token
    END

# ===== COMPREHENSIVE SCENARIO TESTING =====
Multiple Login Attempts Data Driven
    [Documentation]    Demonstrates comprehensive scenario testing with data-driven approach
    [Tags]    data-driven    comprehensive    scenarios
    [Template]    Comprehensive Login Test
    # scenario_name    username    password    expected_result    additional_checks
    Valid Login    ${USERNAME}    ${PASSWORD}    token    True
    Invalid Password    ${USERNAME}    wrong_password    Bad credentials    False
    Invalid Username    invalid_user    ${PASSWORD}    Bad credentials    False
    Both Invalid    invalid_user    wrong_password    Bad credentials    False

*** Keywords ***

Login Template
    [Documentation]    Template keyword for login testing with different credentials
    [Arguments]    ${username}    ${password}    ${expected_result}
    Perform Login Via API    ${username}    ${password}
    Run Keyword If    '${expected_result}' == 'token'    Should Contain    ${response.json()}    ${expected_result}
    ...    ELSE    Should Be Equal As Strings    ${response.json()}[reason]    ${expected_result}

Comprehensive Login Test
    [Documentation]    Comprehensive login test with additional validation steps
    [Arguments]    ${scenario_name}    ${username}    ${password}    ${expected_result}    ${should_have_token}
    Log    Testing scenario: ${scenario_name}
    Perform Login Via API    ${username}    ${password}

    # Validate response based on expected result
    Run Keyword If    ${should_have_token}    Should Contain    ${response.json()}    token
    ...    ELSE    Should Not Contain    ${response.json()}    token

    # Additional validations for comprehensive testing
    Run Keyword If    '${expected_result}' != 'token'    Should Contain    ${response.json()}    reason
    Run Keyword If    '${expected_result}' != 'token'    Should Be Equal As Strings    ${response.json()}[reason]    ${expected_result}

    # Log test results for reporting
    Log    Scenario '${scenario_name}' completed successfully

Generate Random Username
    [Documentation]    Generates a random username for testing
    ${random_string}=    Generate Random String    8    [LETTERS]
    RETURN    testuser_${random_string}

Generate Random Password
    [Documentation]    Generates a random password for testing
    ${random_string}=    Generate Random String    10    [LETTERS][NUMBERS]
    RETURN    pass_${random_string}