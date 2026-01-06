*** Settings ***
Documentation    PAGE OBJECT - Booking Page
...              Locators and keywords specific to the Booking Page
...              Part of the Page Object Model (POM) architecture
...              Referenced by: common.resource → used by all tests

Library         SeleniumLibrary

*** Variables ***
# Booking Form Elements
${BOOKING_FIRSTNAME}        xpath=//input[@name='firstname']
${BOOKING_LASTNAME}         xpath=//input[@name='lastname']
${BOOKING_EMAIL}            xpath=//input[@name='email']
${BOOKING_PHONE}            xpath=//input[@name='phone']
${BOOKING_CHECKIN}          xpath=//input[@name='checkin']
${BOOKING_CHECKOUT}         xpath=//input[@name='checkout']
${BOOKING_ADULTS}           xpath=//select[@name='adults']
${BOOKING_CHILDREN}         xpath=//select[@name='children']
${BOOKING_SUBMIT_BTN}       xpath=//button[@type='submit']
${BOOKING_CONFIRMATION}     xpath=//div[contains(@class,'confirmation')]

*** Keywords ***
# Form Filling Keywords
Fill Booking Form
    [Documentation]    Fills the complete booking form with provided details
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${phone}    ${checkin}    ${checkout}    ${adults}=1    ${children}=0
    Input Text    ${BOOKING_FIRSTNAME}    ${firstname}
    Input Text    ${BOOKING_LASTNAME}     ${lastname}
    Input Text    ${BOOKING_EMAIL}        ${email}
    Input Text    ${BOOKING_PHONE}        ${phone}
    Input Text    ${BOOKING_CHECKIN}      ${checkin}
    Input Text    ${BOOKING_CHECKOUT}     ${checkout}
    Select From List By Value    ${BOOKING_ADULTS}     ${adults}
    Select From List By Value    ${BOOKING_CHILDREN}   ${children}

Select Check-in Date
    [Documentation]    Selects the check-in date
    [Arguments]    ${date}
    Input Text    ${BOOKING_CHECKIN}    ${date}

Select Check-out Date
    [Documentation]    Selects the check-out date
    [Arguments]    ${date}
    Input Text    ${BOOKING_CHECKOUT}    ${date}

Enter Personal Details
    [Documentation]    Enters personal information for booking
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${phone}
    Input Text    ${BOOKING_FIRSTNAME}    ${firstname}
    Input Text    ${BOOKING_LASTNAME}     ${lastname}
    Input Text    ${BOOKING_EMAIL}        ${email}
    Input Text    ${BOOKING_PHONE}        ${phone}

Enter Contact Information
    [Documentation]    Enters contact details
    [Arguments]    ${email}    ${phone}
    Input Text    ${BOOKING_EMAIL}    ${email}
    Input Text    ${BOOKING_PHONE}    ${phone}

# Validation Keywords
Verify Form Validation
    [Documentation]    Verifies that form validation is working
    [Arguments]    ${field_name}
    ${field_selector}=    Set Variable    xpath=//input[@name='${field_name}']
    ${validation_msg}=    Get Element Attribute    ${field_selector}    validationMessage
    Should Not Be Empty    ${validation_msg}

Verify Date Selection
    [Documentation]    Verifies that dates are properly selected
    ${checkin_value}=    Get Value    ${BOOKING_CHECKIN}
    ${checkout_value}=    Get Value    ${BOOKING_CHECKOUT}
    Should Not Be Empty    ${checkin_value}
    Should Not Be Empty    ${checkout_value}

Verify Price Calculation
    [Documentation]    Verifies that price is calculated and displayed
    Page Should Contain Element    xpath=//span[contains(text(),'£')]

# Submission Keywords
Submit Booking
    [Documentation]    Submits the booking form
    Click Button    ${BOOKING_SUBMIT_BTN}
    Wait Until Page Contains Element    ${BOOKING_CONFIRMATION}    timeout=10s

Verify Booking Confirmation
    [Documentation]    Verifies that booking confirmation is displayed
    Page Should Contain Element    ${BOOKING_CONFIRMATION}
    Page Should Contain    Booking confirmed

Get Booking Reference
    [Documentation]    Extracts and returns the booking reference number
    ${reference}=    Get Text    xpath=//span[@class='booking-reference']
    RETURN    ${reference}

# Error Handling
Verify Booking Error
    [Documentation]    Verifies that booking error is displayed
    [Arguments]    ${error_message}
    Wait Until Page Contains    ${error_message}    timeout=10s