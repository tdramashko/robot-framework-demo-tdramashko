*** Settings ***
Documentation    PAGE OBJECT - Home Page
...              Locators and keywords specific to the Home Page
...              Part of the Page Object Model (POM) architecture
...              Referenced by: common.resource → used by all tests

Library         SeleniumLibrary

*** Variables ***
# Page Elements
${HOME_PAGE_TITLE}          Shady Meadows B&B
${BOOKING_CHECKIN_INPUT}    xpath=//input[@name='checkin']
${BOOKING_CHECKOUT_INPUT}   xpath=//input[@name='checkout']
${BOOK_AVAILABILITY_BTN}    xpath=//input[@value='Check Availability']
${ROOM_BOOK_BTN}            xpath=//button[contains(text(),'Book now')]
${NAV_CONTACT_LINK}         xpath=//a[contains(text(),'Contact')]
${NAV_ADMIN_LINK}           xpath=//a[contains(text(),'Admin panel')]

*** Keywords ***
# Navigation Keywords
Go To Home Page
    [Documentation]    Navigates to the home page of the application
    Go To    ${UI_URL}
    # Wait for page to load (actual content verification depends on application)
    Sleep    3s

Navigate To Contact Page
    [Documentation]    Clicks on the Contact navigation link
    Click Link    ${NAV_CONTACT_LINK}
    Wait Until Page Contains    Contact Information    timeout=10s

Navigate To Admin Panel
    [Documentation]    Clicks on the Admin panel navigation link
    Click Link    ${NAV_ADMIN_LINK}
    # Note: This will redirect to login page if not authenticated

# Room Interaction Keywords
Get Available Rooms Count
    [Documentation]    Returns the count of available rooms displayed
    ${count}=    Get Element Count    ${ROOM_BOOK_BTN}
    RETURN    ${count}

Get Room Details
    [Documentation]    Gets details of a specific room by index
    [Arguments]    ${room_index}=1
    ${room_selector}=    Set Variable    xpath=(//div[contains(@class,'room')])[${room_index}]
    ${room_text}=    Get Text    ${room_selector}
    RETURN    ${room_text}

Click Book Room Button
    [Documentation]    Clicks the Book now button for a specific room
    [Arguments]    ${room_index}=1
    ${book_btn}=    Set Variable    xpath=(//button[contains(text(),'Book now')])[${room_index}]
    Click Button    ${book_btn}
    Wait Until Page Contains    Booking Details    timeout=10s

Verify Room Displayed
    [Documentation]    Verifies that rooms are displayed on the home page
    [Arguments]    ${expected_count}=3
    ${actual_count}=    Get Available Rooms Count
    Should Be Equal As Numbers    ${actual_count}    ${expected_count}

# Search and Filter Keywords
Search Rooms By Dates
    [Documentation]    Searches for rooms by check-in and check-out dates
    [Arguments]    ${checkin_date}    ${checkout_date}
    Input Text    ${BOOKING_CHECKIN_INPUT}    ${checkin_date}
    Input Text    ${BOOKING_CHECKOUT_INPUT}    ${checkout_date}
    Click Button    ${BOOK_AVAILABILITY_BTN}
    Wait Until Page Contains    Available Rooms    timeout=10s

Filter Rooms By Type
    [Documentation]    Filters rooms by type (Single, Double, Suite)
    [Arguments]    ${room_type}
    ${filter_selector}=    Set Variable    xpath=//option[contains(text(),'${room_type}')]
    Select From List By Label    xpath=//select[@name='room_type']    ${room_type}
    Wait Until Page Contains    ${room_type}    timeout=5s

Verify Search Results
    [Documentation]    Verifies that search results are displayed correctly
    Page Should Contain Element    xpath=//div[contains(@class,'room')]
    ${results_count}=    Get Available Rooms Count
    Should Be True    ${results_count} > 0