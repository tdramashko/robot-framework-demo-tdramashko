*** Settings ***

Documentation       This suite runs essential smoke tests for the application's core functionality.

Resource            ../resources/common.resource

Suite Setup         Launch Browser To Base URL
Suite Teardown      Close and Cleanup Browser

*** Test Cases ***

User Can Successfully Log In
    [Tags]    Smoke    Login    P1
    [Documentation]    Verifies that a user can log in with valid credentials and get a token.
 
    Perform Login Via API       ${USERNAME}       ${PASSWORD}
    Should Contain      ${response.json()}    token

User Cannot Log In With Invalid Password
    [Tags]    Smoke    Login    P2
    [Documentation]    Tests the security mechanism with incorrect login credentials.
 
    Perform Login Via API       ${USERNAME}       wrong_password
    Should Be Equal As Strings    ${response.json()}[reason]    Bad credentials

User Cannot Log In With Invalid Username
    [Tags]    Smoke    Login    Negative
    [Documentation]    Confirms that invalid username cannot access.
 
    Perform Login Via API       invalid_user     ${PASSWORD}
    Should Be Equal As Strings    ${response.json()}[reason]    Bad credentials

Auth Token Is Properly Formatted
    [Tags]    API    Token    P1
    [Documentation]    Verifies that generated auth tokens have proper format and structure.
 
    ${token}=    Get Auth Token    ${USERNAME}    ${PASSWORD}
    Validate Token Format    ${token}

Auth Token Can Be Used For API Access
    [Tags]    API    Token    Authentication    P1
    [Documentation]    Verifies that auth tokens can be used to access protected API endpoints.
 
    ${token}=    Get Auth Token    ${USERNAME}    ${PASSWORD}
    ${resp}=    Use Token In Request    ${token}
    Status Should Be    200    ${resp}

Auth Token Enables Booking Creation
    [Tags]    API    Token    Booking    P2
    [Documentation]    Verifies that booking creation works and tokens are properly generated (note: POST /booking may not require auth in demo).
 
    ${token}=    Get Auth Token    ${USERNAME}    ${PASSWORD}
    ${resp}=    Create Booking With Token    ${token}
    # Testing that booking creation works and token was successfully obtained
    Status Should Be    200    ${resp}
    Should Contain    ${resp.json()}    bookingid

Invalid Credentials Do Not Return Token
    [Tags]    API    Token    Security    P1
    [Documentation]    Ensures that invalid credentials never return an auth token.
 
    Perform Login Via API    invalid_user    wrong_password
    Should Not Contain    ${response.json()}    token
    Should Contain    ${response.json()}    reason

Auth Token Works Across Multiple Requests
    [Tags]    API    Token    Persistence    P2
    [Documentation]    Verifies that auth tokens remain valid across multiple API requests.
 
    ${token}=    Get Auth Token    ${USERNAME}    ${PASSWORD}
    
    # First request - get bookings
    ${resp1}=    Use Token In Request    ${token}
    Status Should Be    200    ${resp1}
    
    # Second request - create booking
    ${resp2}=    Create Booking With Token    ${token}
    Status Should Be    200    ${resp2}
    
    # Third request - get bookings again to verify token still works
    ${resp3}=    Use Token In Request    ${token}
    Status Should Be    200    ${resp3}