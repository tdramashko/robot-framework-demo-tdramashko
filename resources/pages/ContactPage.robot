*** Settings ***
Documentation    PAGE OBJECT - Contact Page
...              Locators and keywords specific to the Contact Page
...              Part of the Page Object Model (POM) architecture
...              Referenced by: common.resource → used by all tests

Library         SeleniumLibrary

*** Variables ***
# Contact Form Elements
${CONTACT_NAME_FIELD}       id=name
${CONTACT_EMAIL_FIELD}      id=email
${CONTACT_PHONE_FIELD}      id=phone
${CONTACT_SUBJECT_FIELD}    id=subject
${CONTACT_MESSAGE_FIELD}    id=message
${CONTACT_SUBMIT_BUTTON}    xpath=//button[contains(text(),'Send Message')]
${CONTACT_SUCCESS_MESSAGE}  xpath=//div[contains(@class,'success-message')]
${CONTACT_ERROR_MESSAGE}    xpath=//div[contains(@class,'error-message')]

*** Keywords ***
# Contact Form Keywords
Navigate To Contact Page
    [Documentation]    Navigates to the contact page
    Click Link    xpath=//a[contains(text(),'Contact')]
    Wait Until Page Contains    Contact Us    timeout=10s

Fill Contact Form
    [Documentation]    Fills out the contact form with provided details
    [Arguments]    ${name}    ${email}    ${message}    ${phone}=${EMPTY}    ${subject}=${EMPTY}
    Input Text    ${CONTACT_NAME_FIELD}    ${name}
    Input Text    ${CONTACT_EMAIL_FIELD}    ${email}
    Input Text    ${CONTACT_MESSAGE_FIELD}    ${message}
    Run Keyword If    '${phone}' != '${EMPTY}'    Input Text    ${CONTACT_PHONE_FIELD}    ${phone}
    Run Keyword If    '${subject}' != '${EMPTY}'    Input Text    ${CONTACT_SUBJECT_FIELD}    ${subject}

Submit Contact Form
    [Documentation]    Submits the contact form
    Click Button    ${CONTACT_SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CONTACT_SUCCESS_MESSAGE}    timeout=10s

Verify Contact Form Submission
    [Documentation]    Verifies that contact form was submitted successfully
    Page Should Contain Element    ${CONTACT_SUCCESS_MESSAGE}
    Element Should Contain    ${CONTACT_SUCCESS_MESSAGE}    Thank you for your message

Verify Contact Form Validation
    [Documentation]    Verifies form validation for required fields
    [Arguments]    ${field_name}
    ${field_locator}=    Set Variable If
    ...    '${field_name}' == 'name'    ${CONTACT_NAME_FIELD}
    ...    '${field_name}' == 'email'    ${CONTACT_EMAIL_FIELD}
    ...    '${field_name}' == 'message'    ${CONTACT_MESSAGE_FIELD}
    ...    ${CONTACT_NAME_FIELD}  # default fallback
    Element Should Be Visible    xpath=//input[@id='${field_name}']/following-sibling::span[@class='error']

Submit Invalid Contact Form
    [Documentation]    Attempts to submit contact form with invalid data
    [Arguments]    ${invalid_data}
    Fill Contact Form    &{invalid_data}
    Click Button    ${CONTACT_SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CONTACT_ERROR_MESSAGE}    timeout=5s

Verify Contact Form Error
    [Documentation]    Verifies that contact form shows appropriate error
    [Arguments]    ${expected_error}
    Page Should Contain Element    ${CONTACT_ERROR_MESSAGE}
    Element Should Contain    ${CONTACT_ERROR_MESSAGE}    ${expected_error}

Clear Contact Form
    [Documentation]    Clears all fields in the contact form
    Clear Element Text    ${CONTACT_NAME_FIELD}
    Clear Element Text    ${CONTACT_EMAIL_FIELD}
    Clear Element Text    ${CONTACT_PHONE_FIELD}
    Clear Element Text    ${CONTACT_SUBJECT_FIELD}
    Clear Element Text    ${CONTACT_MESSAGE_FIELD}

Verify Contact Form Fields
    [Documentation]    Verifies that all contact form fields are present and accessible
    Page Should Contain Element    ${CONTACT_NAME_FIELD}
    Page Should Contain Element    ${CONTACT_EMAIL_FIELD}
    Page Should Contain Element    ${CONTACT_PHONE_FIELD}
    Page Should Contain Element    ${CONTACT_SUBJECT_FIELD}
    Page Should Contain Element    ${CONTACT_MESSAGE_FIELD}
    Page Should Contain Element    ${CONTACT_SUBMIT_BUTTON}

Get Contact Form Field Value
    [Documentation]    Gets the value of a specific contact form field
    [Arguments]    ${field_name}
    ${field_locator}=    Set Variable If
    ...    '${field_name}' == 'name'    ${CONTACT_NAME_FIELD}
    ...    '${field_name}' == 'email'    ${CONTACT_EMAIL_FIELD}
    ...    '${field_name}' == 'phone'    ${CONTACT_PHONE_FIELD}
    ...    '${field_name}' == 'subject'    ${CONTACT_SUBJECT_FIELD}
    ...    '${field_name}' == 'message'    ${CONTACT_MESSAGE_FIELD}
    ...    ${CONTACT_NAME_FIELD}  # default fallback
    ${value}=    Get Value    ${field_locator}
    RETURN    ${value}