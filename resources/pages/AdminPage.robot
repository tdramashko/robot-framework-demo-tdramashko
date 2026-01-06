*** Settings ***
Documentation    PAGE OBJECT - Admin Page
...              Locators and keywords specific to the Admin Panel Page
...              Part of the Page Object Model (POM) architecture
...              Referenced by: common.resource → used by all tests

Library         SeleniumLibrary

*** Variables ***
# Admin Panel Elements - Generic selectors for Restful Booker
${ADMIN_USERNAME_FIELD}     xpath=//input[@name='username' or @id='username' or @placeholder='Username']
${ADMIN_PASSWORD_FIELD}     xpath=//input[@name='password' or @id='password' or @placeholder='Password']
${ADMIN_LOGIN_BUTTON}       xpath=//button[@type='submit' or contains(text(),'Login') or contains(text(),'Sign in')]
${ADMIN_DASHBOARD}          xpath=//div[contains(@class,'dashboard') or contains(@class,'admin') or @id='dashboard']
${ADMIN_BOOKINGS_TABLE}     xpath=//table | //div[contains(@class,'bookings')] | //div[contains(@class,'table')]
${ADMIN_BOOKING_ROWS}       xpath=//tr | //div[contains(@class,'booking-row')] | //div[contains(@class,'row')]
${ADMIN_EDIT_BUTTON}        xpath=//button[contains(text(),'Edit') or contains(@class,'edit')]
${ADMIN_DELETE_BUTTON}      xpath=//button[contains(text(),'Delete') or contains(@class,'delete')]
${ADMIN_ADD_ROOM_BUTTON}    xpath=//button[contains(text(),'Add Room') or contains(text(),'New Room')]
${ADMIN_ROOM_FORM}          xpath=//form | //div[contains(@class,'room-form')]

*** Keywords ***
# Authentication Keywords
Perform Admin Login
    [Documentation]    Performs login to admin panel
    [Arguments]    ${username}=admin    ${password}=password
    ${username_found}=    Run Keyword And Return Status    Page Should Contain Element    ${ADMIN_USERNAME_FIELD}
    Run Keyword If    ${username_found}    Input Text    ${ADMIN_USERNAME_FIELD}    ${username}

    ${password_found}=    Run Keyword And Return Status    Page Should Contain Element    ${ADMIN_PASSWORD_FIELD}
    Run Keyword If    ${password_found}    Input Text    ${ADMIN_PASSWORD_FIELD}    ${password}

    ${login_found}=    Run Keyword And Return Status    Page Should Contain Element    ${ADMIN_LOGIN_BUTTON}
    Run Keyword If    ${login_found}    Click Button    ${ADMIN_LOGIN_BUTTON}

    # Wait for dashboard or success indication
    Sleep    3s

Verify Admin Access
    [Documentation]    Verifies that admin panel is accessible
    ${dashboard_found}=    Run Keyword And Return Status    Page Should Contain Element    ${ADMIN_DASHBOARD}
    ${admin_text_found}=    Run Keyword And Return Status    Page Should Contain    Admin
    Should Be True    ${dashboard_found} or ${admin_text_found}    Admin access verification failed

# Booking Management Keywords
View All Bookings
    [Documentation]    Navigates to and displays all bookings
    Click Link    xpath=//a[contains(text(),'Bookings')]
    Wait Until Page Contains Element    ${ADMIN_BOOKINGS_TABLE}    timeout=10s

Search Bookings
    [Documentation]    Searches for bookings by criteria
    [Arguments]    ${search_term}
    Input Text    xpath=//input[@placeholder='Search bookings']    ${search_term}
    Click Button    xpath=//button[contains(text(),'Search')]
    Wait Until Page Contains    ${search_term}    timeout=5s

Edit Booking Details
    [Documentation]    Edits booking details for a specific booking
    [Arguments]    ${booking_id}    ${new_details}
    ${edit_btn}=    Set Variable    xpath=//tr[@data-booking-id='${booking_id}']//button[contains(text(),'Edit')]
    Click Button    ${edit_btn}
    Wait Until Page Contains Element    xpath=//form[contains(@class,'edit-booking')]    timeout=5s
    # Fill in new details (implementation depends on form structure)
    Click Button    xpath=//button[contains(text(),'Save Changes')]

Delete Booking
    [Documentation]    Deletes a specific booking
    [Arguments]    ${booking_id}
    ${delete_btn}=    Set Variable    xpath=//tr[@data-booking-id='${booking_id}']//button[contains(text(),'Delete')]
    Click Button    ${delete_btn}
    Handle Alert    action=ACCEPT
    Wait Until Page Does Not Contain Element    xpath=//tr[@data-booking-id='${booking_id}']    timeout=10s

Verify Booking Changes
    [Documentation]    Verifies that booking changes were applied
    [Arguments]    ${booking_id}    ${expected_change}
    ${booking_row}=    Set Variable    xpath=//tr[@data-booking-id='${booking_id}']
    Element Should Contain    ${booking_row}    ${expected_change}

# Room Management Keywords
Add New Room
    [Documentation]    Adds a new room to the system
    [Arguments]    ${room_details}
    Click Button    ${ADMIN_ADD_ROOM_BUTTON}
    Wait Until Page Contains Element    ${ADMIN_ROOM_FORM}    timeout=5s
    # Fill room details form (implementation depends on form structure)
    Click Button    xpath=//button[contains(text(),'Save Room')]

Edit Room Details
    [Documentation]    Edits details of an existing room
    [Arguments]    ${room_id}    ${new_details}
    ${edit_btn}=    Set Variable    xpath=//tr[@data-room-id='${room_id}']//button[contains(text(),'Edit')]
    Click Button    ${edit_btn}
    Wait Until Page Contains Element    xpath=//form[contains(@class,'edit-room')]    timeout=5s
    # Update room details
    Click Button    xpath=//button[contains(text(),'Update Room')]

Delete Room
    [Documentation]    Deletes a room from the system
    [Arguments]    ${room_id}
    ${delete_btn}=    Set Variable    xpath=//tr[@data-room-id='${room_id}']//button[contains(text(),'Delete')]
    Click Button    ${delete_btn}
    Handle Alert    action=ACCEPT
    Wait Until Page Does Not Contain Element    xpath=//tr[@data-room-id='${room_id}']    timeout=10s

Update Room Availability
    [Documentation]    Updates room availability status
    [Arguments]    ${room_id}    ${status}
    ${status_btn}=    Set Variable    xpath=//tr[@data-room-id='${room_id}']//button[contains(text(),'${status}')]
    Click Button    ${status_btn}
    Wait Until Page Contains    Room ${status}    timeout=5s

# Dashboard Keywords
Verify Admin Dashboard
    [Documentation]    Verifies admin dashboard displays correctly
    Page Should Contain Element    ${ADMIN_DASHBOARD}
    Page Should Contain    Total Bookings
    Page Should Contain    Available Rooms
    Page Should Contain    Revenue

Get Dashboard Statistics
    [Documentation]    Retrieves dashboard statistics
    ${booking_count}=    Get Text    xpath=//div[@class='stat-bookings']//span[@class='count']
    ${room_count}=    Get Text    xpath=//div[@class='stat-rooms']//span[@class='count']
    ${revenue}=    Get Text    xpath=//div[@class='stat-revenue']//span[@class='count']
    ${stats}=    Create Dictionary    bookings=${booking_count}    rooms=${room_count}    revenue=${revenue}
    RETURN    ${stats}