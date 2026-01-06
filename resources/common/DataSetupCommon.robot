*** Settings ***
Documentation    COMMON UTILITY - Data Setup Keywords
...              Provides test data generation and setup utilities
...              Examples: Create Test User, Create Test Booking Data, Generate Random String
...              Referenced by: common.resource → used by all tests

Library         SeleniumLibrary
Library         RequestsLibrary
Library         Collections
Resource        ../common.resource

*** Keywords ***
# Test Data Setup Keywords
Create Test User
    [Documentation]    Creates a test user for testing purposes
    [Arguments]    ${username}=testuser    ${password}=testpass123
    ${user_data}=    Create Dictionary
    ...    username=${username}
    ...    password=${password}
    ...    email=${username}@test.com
    ...    firstName=Test
    ...    lastName=User
    RETURN    ${user_data}

Create Test Booking Data
    [Documentation]    Creates test booking data
    [Arguments]    ${checkin_date}=2024-12-25    ${checkout_date}=2024-12-26    ${firstname}=John    ${lastname}=Doe    ${totalprice}=150    ${depositpaid}=true    ${additionalneeds}=Breakfast
    ${booking_data}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${{ {"checkin": "${checkin_date}", "checkout": "${checkout_date}"} }}
    ...    additionalneeds=${additionalneeds}
    RETURN    ${booking_data}

Create Test Room Data
    [Documentation]    Creates test room data for admin operations
    [Arguments]    ${roomname}=Test Room    ${type}=Single    ${beds}=1    ${accessible}=true    ${roomPrice}=100
    ${room_data}=    Create Dictionary
    ...    roomname=${roomname}
    ...    type=${type}
    ...    beds=${beds}
    ...    accessible=${accessible}
    ...    roomPrice=${roomPrice}
    RETURN    ${room_data}

# API Setup Keywords
Create API Session
    [Documentation]    Creates a new API session for testing
    [Arguments]    ${alias}=restfulbooker    ${url}=${URL}
    Create Session    ${alias}    ${url}    verify=True

Get Authentication Token
    [Documentation]    Gets authentication token for API operations
    ${auth_data}=    Create Dictionary    username=admin    password=password123
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    restfulbooker    /auth    json=${auth_data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Get From Dictionary    ${response.json()}    token
    RETURN    ${token}

Create Authorized Session
    [Documentation]    Creates an authorized API session with token
    [Arguments]    ${alias}=authorized    ${token}=${EMPTY}
    Run Keyword If    '${token}' == '${EMPTY}'    Get Authentication Token
    ${token}=    Run Keyword If    '${token}' == '${EMPTY}'    Get Authentication Token    ELSE    Set Variable    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Cookie=token=${token}
    Create Session    ${alias}    ${URL}    headers=${headers}    verify=True
    RETURN    ${token}

# Database Setup Keywords (Mock - would connect to actual DB in real implementation)
Initialize Test Database
    [Documentation]    Initializes test database with clean state
    Log    Initializing test database...
    # In real implementation, this would connect to database and set up test data
    # For now, we'll use API calls to set up data

Clean Test Data
    [Documentation]    Cleans up test data after test execution
    Log    Cleaning up test data...
    # In real implementation, this would clean database tables
    # For now, we'll use API calls to clean up

# Browser Setup Keywords
Setup Browser For Testing
    [Documentation]    Sets up browser with optimal settings for testing
    [Arguments]    ${browser}=chrome    ${headless}=${False}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions() if "${browser}" == "chrome" else sys.modules['selenium.webdriver'].FirefoxOptions()
    Run Keyword If    ${headless}    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    # Note: window-size argument removed due to compatibility issues
    RETURN    ${options}

Open Test Browser
    [Documentation]    Opens browser with test configuration
    [Arguments]    ${url}=${UI_URL}    ${browser}=chrome    ${headless}=${False}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s

Close Test Browser
    [Documentation]    Closes browser and cleans up
    Close All Browsers

# Test Fixture Keywords
Setup Test Environment
    [Documentation]    Sets up the complete test environment
    Create API Session
    Open Test Browser
    ${token}=    Get Authentication Token
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Teardown Test Environment
    [Documentation]    Cleans up the test environment
    Close Test Browser
    Delete All Sessions

# Data Generation Keywords
Generate Random String
    [Documentation]    Generates a random string of specified length from given characters
    [Arguments]    ${length}=8    ${chars}=[LETTERS][NUMBERS]
    ${char_set}=    Set Variable If
    ...    '${chars}' == '[LETTERS]'    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
    ...    '${chars}' == '[LETTERS][NUMBERS]'    abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
    ...    ${chars}
    ${random_string}=    Evaluate    ''.join(random.choices('${char_set}', k=int(${length})))    modules=random
    RETURN    ${random_string}

Generate Random Email
    [Documentation]    Generates a random email address
    [Arguments]    ${domain}=test.com
    ${username}=    Generate Random String    6
    ${email}=    Set Variable    ${username}@${domain}
    RETURN    ${email}

Generate Random Phone Number
    [Documentation]    Generates a random phone number
    ${area_code}=    Evaluate    random.randint(200, 999)    modules=random
    ${exchange}=    Evaluate    random.randint(200, 999)    modules=random
    ${number}=    Evaluate    random.randint(1000, 9999)    modules=random
    ${phone}=    Set Variable    ${area_code}-${exchange}-${number}
    RETURN    ${phone}

Generate Future Date
    [Documentation]    Generates a future date string
    [Arguments]    ${days_ahead}=30
    ${future_date}=    Evaluate    (datetime.datetime.now() + datetime.timedelta(days=${days_ahead})).strftime('%Y-%m-%d')    modules=datetime
    RETURN    ${future_date}

Generate Past Date
    [Documentation]    Generates a past date string
    [Arguments]    ${days_back}=30
    ${past_date}=    Evaluate    (datetime.datetime.now() - datetime.timedelta(days=${days_back})).strftime('%Y-%m-%d')    modules=datetime
    RETURN    ${past_date}

# Test Data Validation Keywords
Validate Booking Data
    [Documentation]    Validates booking data structure
    [Arguments]    ${booking_data}
    Dictionary Should Contain Key    ${booking_data}    firstname
    Dictionary Should Contain Key    ${booking_data}    lastname
    Dictionary Should Contain Key    ${booking_data}    totalprice
    Dictionary Should Contain Key    ${booking_data}    depositpaid
    Dictionary Should Contain Key    ${booking_data}    bookingdates
    Dictionary Should Contain Key    ${booking_data}    additionalneeds

Validate User Data
    [Documentation]    Validates user data structure
    [Arguments]    ${user_data}
    Dictionary Should Contain Key    ${user_data}    username
    Dictionary Should Contain Key    ${user_data}    password
    Dictionary Should Contain Key    ${user_data}    email

Validate Room Data
    [Documentation]    Validates room data structure
    [Arguments]    ${room_data}
    Dictionary Should Contain Key    ${room_data}    roomname
    Dictionary Should Contain Key    ${room_data}    type
    Dictionary Should Contain Key    ${room_data}    beds
    Dictionary Should Contain Key    ${room_data}    accessible
    Dictionary Should Contain Key    ${room_data}    roomPrice