*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         Collections
Resource        ../common.resource
Resource        ../pages/HomePage.robot
Resource        ../pages/BookingPage.robot
Resource        ../pages/AdminPage.robot
Resource        ../common/NavigationCommon.robot
Resource        ../common/VerificationCommon.robot
Resource        ../common/DataSetupCommon.robot

*** Keywords ***
# Complete Booking Workflow Keywords
Complete Room Booking Process
    [Documentation]    Complete end-to-end room booking process
    [Arguments]    ${booking_data}    ${user_credentials}=${EMPTY}
    # Navigate to home page
    Go To Home Page

    # Select available room
    ${available_rooms}=    Get Available Rooms Count
    Should Be True    ${available_rooms} > 0    No rooms available for booking

    # Click book room button
    Click Book Room Button

    # Fill booking form
    Fill Booking Form    ${booking_data}

    # Submit booking
    Submit Booking

    # Verify booking confirmation
    Verify Booking Confirmation

    # Return booking details for verification
    ${booking_id}=    Get Booking ID From Confirmation
    RETURN    ${booking_id}

Book Room With API And Verify UI
    [Documentation]    Books a room via API and verifies in UI
    [Arguments]    ${booking_data}
    # Create booking via API
    ${api_response}=    Create Booking Via API    ${booking_data}
    ${booking_id}=    Get From Dictionary    ${api_response.json()}    bookingid

    # Verify booking appears in UI
    Go To Home Page
    Verify Booking In UI    ${booking_id}    ${booking_data}

    RETURN    ${booking_id}

# Admin Workflow Keywords
Admin Manage Booking Process
    [Documentation]    Complete admin workflow for managing bookings
    [Arguments]    ${booking_id}    ${action}    ${updated_data}=${EMPTY}
    # Login to admin panel
    Go To Admin Panel
    Perform Admin Login

    # Navigate to bookings
    View All Bookings

    # Perform action based on type
    Run Keyword If    '${action}' == 'edit'    Edit Booking Details    ${booking_id}    ${updated_data}
    Run Keyword If    '${action}' == 'delete'    Delete Booking    ${booking_id}

    # Verify changes
    Run Keyword If    '${action}' == 'edit'    Verify Booking Changes    ${booking_id}    ${updated_data}
    Run Keyword If    '${action}' == 'delete'    Verify Booking Deleted    ${booking_id}

Admin Room Management Process
    [Documentation]    Complete admin workflow for managing rooms
    [Arguments]    ${action}    ${room_data}=${EMPTY}    ${room_id}=${EMPTY}
    # Login to admin panel
    Go To Admin Panel
    Perform Admin Login

    # Perform room management action
    Run Keyword If    '${action}' == 'add'    Add New Room    ${room_data}
    Run Keyword If    '${action}' == 'edit'    Edit Room Details    ${room_id}    ${room_data}
    Run Keyword If    '${action}' == 'delete'    Delete Room    ${room_id}

    # Verify changes
    Run Keyword If    '${action}' == 'add'    Verify Room Added    ${room_data}
    Run Keyword If    '${action}' == 'edit'    Verify Room Updated    ${room_id}    ${room_data}
    Run Keyword If    '${action}' == 'delete'    Verify Room Deleted    ${room_id}

# Contact Workflow Keywords
Submit Contact Inquiry Process
    [Documentation]    Complete contact form submission process
    [Arguments]    ${contact_data}
    # Navigate to contact page
    Go To Contact Page

    # Fill and submit contact form
    Fill Contact Form    &{contact_data}
    Submit Contact Form

    # Verify submission
    Verify Contact Form Submission

# Multi-step Business Process Keywords
Complete Guest Experience Workflow
    [Documentation]    Simulates complete guest experience from booking to contact
    [Arguments]    ${booking_data}    ${contact_data}
    # Step 1: Book a room
    ${booking_id}=    Complete Room Booking Process    ${booking_data}

    # Step 2: Submit contact inquiry
    Submit Contact Inquiry Process    ${contact_data}

    # Step 3: Verify booking status
    Verify Booking Status In System    ${booking_id}

    RETURN    ${booking_id}

Admin Daily Operations Workflow
    [Documentation]    Simulates admin daily operations
    # Login to admin
    Go To Admin Panel
    Perform Admin Login

    # Check dashboard statistics
    ${stats}=    Get Dashboard Statistics

    # Review recent bookings
    View All Bookings
    ${booking_count}=    Get Element Count    ${ADMIN_BOOKING_ROWS}

    # Check room availability
    ${available_rooms}=    Get Available Rooms Count

    # Update room status if needed
    Run Keyword If    ${available_rooms} == 0    Update Room Availability    1    Available

    # Return operational summary
    ${summary}=    Create Dictionary
    ...    total_bookings=${stats}[bookings]
    ...    recent_bookings=${booking_count}
    ...    available_rooms=${available_rooms}
    RETURN    ${summary}

# Validation Workflow Keywords
Verify Booking In UI
    [Documentation]    Verifies booking details appear correctly in UI
    [Arguments]    ${booking_id}    ${expected_data}
    # Navigate to bookings page
    Go To Booking Page

    # Search for booking
    Search Bookings    ${booking_id}

    # Verify booking details
    Verify Element Contains Text    xpath=//div[@data-booking-id='${booking_id}']    ${expected_data}[firstname]
    Verify Element Contains Text    xpath=//div[@data-booking-id='${booking_id}']    ${expected_data}[lastname]

Verify Booking Status In System
    [Documentation]    Verifies booking status across API and UI
    [Arguments]    ${booking_id}
    # Check via API
    ${api_booking}=    Get Booking Via API    ${booking_id}
    Should Not Be Empty    ${api_booking}

    # Check via UI (if applicable)
    Run Keyword And Ignore Error    Verify Booking In UI    ${booking_id}    ${api_booking}

Verify Room Added
    [Documentation]    Verifies that a room was added successfully
    [Arguments]    ${room_data}
    Page Should Contain    ${room_data}[roomname]
    Page Should Contain    ${room_data}[type]

Verify Room Updated
    [Documentation]    Verifies that room details were updated
    [Arguments]    ${room_id}    ${updated_data}
    ${room_row}=    Set Variable    xpath=//tr[@data-room-id='${room_id}']
    Element Should Contain    ${room_row}    ${updated_data}[roomname]

Verify Room Deleted
    [Documentation]    Verifies that a room was deleted
    [Arguments]    ${room_id}
    Page Should Not Contain Element    xpath=//tr[@data-room-id='${room_id}']

Verify Booking Deleted
    [Documentation]    Verifies that a booking was deleted
    [Arguments]    ${booking_id}
    Page Should Not Contain Element    xpath=//tr[@data-booking-id='${booking_id}']

# Error Handling Workflow Keywords
Handle Booking Failure
    [Documentation]    Handles booking failure scenarios
    [Arguments]    ${error_type}
    Run Keyword If    '${error_type}' == 'no_rooms'    Log    No rooms available - cannot complete booking
    Run Keyword If    '${error_type}' == 'invalid_dates'    Log    Invalid booking dates provided
    Run Keyword If    '${error_type}' == 'payment_failed'    Log    Payment processing failed
    # Could add more sophisticated error handling here

Handle Admin Operation Failure
    [Documentation]    Handles admin operation failure scenarios
    [Arguments]    ${operation}    ${error_details}
    Log    Admin operation '${operation}' failed: ${error_details}
    # Could add retry logic, notifications, etc.

# Reporting Workflow Keywords
Generate Booking Report
    [Documentation]    Generates a summary report of booking operations
    [Arguments]    ${start_date}    ${end_date}
    # Collect booking data
    ${bookings}=    Get Bookings In Date Range    ${start_date}    ${end_date}

    # Calculate statistics
    ${total_bookings}=    Get Length    ${bookings}
    ${total_revenue}=    Calculate Total Revenue    ${bookings}

    # Generate report
    ${report}=    Create Dictionary
    ...    period_start=${start_date}
    ...    period_end=${end_date}
    ...    total_bookings=${total_bookings}
    ...    total_revenue=${total_revenue}
    ...    bookings=${bookings}

    RETURN    ${report}

Calculate Total Revenue
    [Documentation]    Calculates total revenue from booking list
    [Arguments]    ${bookings}
    ${total}=    Set Variable    0
    :FOR    ${booking}    IN    @{bookings}
    \    ${price}=    Get From Dictionary    ${booking}    totalprice
    \    ${total}=    Evaluate    ${total} + ${price}
    RETURN    ${total}

Get Bookings In Date Range
    [Documentation]    Gets all bookings within a date range
    [Arguments]    ${start_date}    ${end_date}
    # This would typically query database or API
    # For now, return mock data
    ${bookings}=    Create List
    RETURN    ${bookings}