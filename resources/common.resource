*** Settings ***

Library         RequestsLibrary
Variables       ../libraries/common_variables.py

*** Keywords ***

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