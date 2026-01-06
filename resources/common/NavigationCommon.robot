*** Settings ***
Documentation    COMMON UTILITY - Navigation Keywords
...              Provides base navigation keywords used across all tests
...              Examples: Go To Home Page, Go To Login Page, Go To Admin Panel
...              Referenced by: common.resource → used by all tests

Library         SeleniumLibrary
Resource        ../common.resource

*** Keywords ***
# Navigation Keywords
Navigate To Home Page
    [Documentation]    Navigates to the home page of the application
    Go To    ${UI_URL}
    # Wait for page to load (actual content verification depends on application)
    Sleep    2s

Go To Login Page
    [Documentation]    Navigates to the login page
    Go To    ${UI_URL}/login
    Wait Until Page Contains Element    xpath=//input[@id='username']    timeout=10s

Go To Admin Panel
    [Documentation]    Navigates to the admin panel
    Go To    ${UI_URL}/admin
    # Wait for page to load (actual content verification depends on application)
    Sleep    3s

Go To Booking Page
    [Documentation]    Navigates to the booking page
    Go To    ${UI_URL}/booking
    Wait Until Page Contains    Book a Room    timeout=10s

Navigate Back To Home
    [Documentation]    Navigates back to the home page from any page
    Click Link    xpath=//a[contains(text(),'Home')] | //a[@href='/']
    Wait Until Page Contains    Welcome to Restful Booker Platform    timeout=10s

Refresh Current Page
    [Documentation]    Refreshes the current page
    Reload Page
    Sleep    2s  # Allow page to fully load

Verify Page Loaded
    [Documentation]    Verifies that the current page has loaded completely
    [Arguments]    ${expected_content}
    Wait Until Page Contains    ${expected_content}    timeout=15s
    Wait For Condition    return document.readyState == "complete"    timeout=10s

Wait For Page To Load
    [Documentation]    Waits for the page to fully load
    Wait For Condition    return document.readyState == "complete"    timeout=15s

Verify Navigation Menu
    [Documentation]    Verifies that the main navigation menu is present
    Page Should Contain Element    xpath=//nav | //header
    Page Should Contain Link    Home
    Page Should Contain Link    Bookings
    Page Should Contain Link    Contact

Click Navigation Link
    [Documentation]    Clicks on a navigation link by text
    [Arguments]    ${link_text}
    Click Link    xpath=//a[contains(text(),'${link_text}')]
    Wait For Page To Load

Verify Current URL
    [Documentation]    Verifies that the current URL matches expected pattern
    [Arguments]    ${expected_url_pattern}
    ${current_url}=    Get Location
    Should Match Regexp    ${current_url}    ${expected_url_pattern}

Go To Previous Page
    [Documentation]    Navigates to the previous page in browser history
    Go Back
    Wait For Page To Load

Go To Next Page
    [Documentation]    Navigates to the next page in browser history (if available)
    Go Forward
    Wait For Page To Load

Verify Page Title
    [Documentation]    Verifies the page title
    [Arguments]    ${expected_title}
    Title Should Be    ${expected_title}

Wait For Element And Click
    [Documentation]    Waits for an element to be visible and then clicks it
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}

Wait For Element And Input Text
    [Documentation]    Waits for an input element to be visible and then inputs text
    [Arguments]    ${locator}    ${text}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Input Text    ${locator}    ${text}

Scroll To Element
    [Documentation]    Scrolls to a specific element on the page
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}
    Sleep    1s  # Allow time for scroll to complete

Verify Element In Viewport
    [Documentation]    Verifies that an element is visible in the current viewport
    [Arguments]    ${locator}
    Element Should Be Visible    ${locator}
    ${in_viewport}=    Execute JavaScript
    ...    return (function() {
    ...        var elem = arguments[0];
    ...        var rect = elem.getBoundingClientRect();
    ...        return (
    ...            rect.top >= 0 &&
    ...            rect.left >= 0 &&
    ...            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
    ...            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    ...        );
    ...    })(arguments[0]);
    Should Be True    ${in_viewport}