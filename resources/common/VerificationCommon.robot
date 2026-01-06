*** Settings ***
Library         SeleniumLibrary
Library         Collections

*** Keywords ***
# Element Verification Keywords
Verify Element Is Visible
    [Documentation]    Verifies that an element is visible on the page
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}

Verify Element Is Not Visible
    [Documentation]    Verifies that an element is not visible on the page
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Not Visible    ${locator}    timeout=${timeout}

Verify Element Contains Text
    [Documentation]    Verifies that an element contains specific text
    [Arguments]    ${locator}    ${expected_text}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Element Should Contain    ${locator}    ${expected_text}

Verify Element Does Not Contain Text
    [Documentation]    Verifies that an element does not contain specific text
    [Arguments]    ${locator}    ${unexpected_text}
    Element Should Not Contain    ${locator}    ${unexpected_text}

Verify Page Contains Text
    [Documentation]    Verifies that the page contains specific text
    [Arguments]    ${expected_text}    ${timeout}=10s
    Wait Until Page Contains    ${expected_text}    timeout=${timeout}

Verify Page Does Not Contain Text
    [Documentation]    Verifies that the page does not contain specific text
    [Arguments]    ${unexpected_text}
    Page Should Not Contain    ${unexpected_text}

Verify Element Attribute
    [Documentation]    Verifies that an element has a specific attribute value
    [Arguments]    ${locator}    ${attribute}    ${expected_value}
    ${actual_value}=    Get Element Attribute    ${locator}    ${attribute}
    Should Be Equal    ${actual_value}    ${expected_value}

Verify Element Count
    [Documentation]    Verifies the number of elements matching a locator
    [Arguments]    ${locator}    ${expected_count}
    ${actual_count}=    Get Element Count    ${locator}
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Verify Elements Are Equal
    [Documentation]    Verifies that two elements have the same text content
    [Arguments]    ${locator1}    ${locator2}
    ${text1}=    Get Text    ${locator1}
    ${text2}=    Get Text    ${locator2}
    Should Be Equal    ${text1}    ${text2}

Verify List Contains Item
    [Documentation]    Verifies that a list contains a specific item
    [Arguments]    ${list_locator}    ${item_text}
    Page Should Contain Element    xpath=${list_locator}//li[contains(text(),'${item_text}')]

Verify Checkbox Is Selected
    [Documentation]    Verifies that a checkbox is selected
    [Arguments]    ${locator}
    Checkbox Should Be Selected    ${locator}

Verify Checkbox Is Not Selected
    [Documentation]    Verifies that a checkbox is not selected
    [Arguments]    ${locator}
    Checkbox Should Not Be Selected    ${locator}

Verify Radio Button Is Selected
    [Documentation]    Verifies that a radio button is selected
    [Arguments]    ${group_name}    ${value}
    Radio Button Should Be Set To    ${group_name}    ${value}

Verify Dropdown Selection
    [Documentation]    Verifies that a dropdown has a specific option selected
    [Arguments]    ${locator}    ${expected_value}
    ${selected_value}=    Get Selected List Value    ${locator}
    Should Be Equal    ${selected_value}    ${expected_value}

Verify Dropdown Contains Option
    [Documentation]    Verifies that a dropdown contains a specific option
    [Arguments]    ${locator}    ${option_value}
    List Selection Should Be    ${locator}    ${option_value}

# Form Validation Keywords
Verify Form Field Is Required
    [Documentation]    Verifies that a form field is marked as required
    [Arguments]    ${field_locator}
    ${required_attr}=    Get Element Attribute    ${field_locator}    required
    Should Be Equal    ${required_attr}    true

Verify Form Field Validation Message
    [Documentation]    Verifies that a form field shows a validation message
    [Arguments]    ${field_locator}    ${expected_message}
    ${validation_message}=    Get Element Attribute    ${field_locator}    validationMessage
    Should Contain    ${validation_message}    ${expected_message}

Verify Form Submission Success
    [Documentation]    Verifies that a form was submitted successfully
    [Arguments]    ${success_message_locator}    ${expected_message}
    Wait Until Element Is Visible    ${success_message_locator}    timeout=10s
    Element Should Contain    ${success_message_locator}    ${expected_message}

Verify Form Submission Error
    [Documentation]    Verifies that a form submission failed with an error
    [Arguments]    ${error_message_locator}    ${expected_error}
    Wait Until Element Is Visible    ${error_message_locator}    timeout=10s
    Element Should Contain    ${error_message_locator}    ${expected_error}

# API Response Verification Keywords
Verify API Response Status
    [Documentation]    Verifies that an API response has the expected status code
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}

Verify API Response Contains Key
    [Documentation]    Verifies that an API response JSON contains a specific key
    [Arguments]    ${response}    ${key}
    Dictionary Should Contain Key    ${response.json()}    ${key}

Verify API Response Key Value
    [Documentation]    Verifies that an API response JSON has a specific key-value pair
    [Arguments]    ${response}    ${key}    ${expected_value}
    ${actual_value}=    Get From Dictionary    ${response.json()}    ${key}
    Should Be Equal    ${actual_value}    ${expected_value}

Verify API Response Array Length
    [Documentation]    Verifies that an API response contains an array of specific length
    [Arguments]    ${response}    ${array_key}    ${expected_length}
    ${array}=    Get From Dictionary    ${response.json()}    ${array_key}
    Length Should Be    ${array}    ${expected_length}

Verify API Response Schema
    [Documentation]    Verifies that an API response matches expected schema structure
    [Arguments]    ${response}    ${expected_keys}
    ${response_data}=    Set Variable    ${response.json()}
    :FOR    ${key}    IN    @{expected_keys}
    \    Dictionary Should Contain Key    ${response_data}    ${key}

# General Verification Keywords
Verify Value Is Not Empty
    [Documentation]    Verifies that a value is not empty or null
    [Arguments]    ${value}
    Should Not Be Empty    ${value}

Verify Values Are Equal
    [Documentation]    Verifies that two values are equal
    [Arguments]    ${actual}    ${expected}
    Should Be Equal    ${actual}    ${expected}

Verify Value Matches Pattern
    [Documentation]    Verifies that a value matches a regular expression pattern
    [Arguments]    ${value}    ${pattern}
    Should Match Regexp    ${value}    ${pattern}

Verify Date Format
    [Documentation]    Verifies that a date string matches expected format
    [Arguments]    ${date_string}    ${expected_format}
    Should Match Regexp    ${date_string}    ${expected_format}

Verify Email Format
    [Documentation]    Verifies that a string is a valid email format
    [Arguments]    ${email}
    Should Match Regexp    ${email}    ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$

Verify Phone Number Format
    [Documentation]    Verifies that a string is a valid phone number format
    [Arguments]    ${phone}
    Should Match Regexp    ${phone}    ^[+]?[0-9\\s\\-\\(\\)]{10,}$

Verify URL Format
    [Documentation]    Verifies that a string is a valid URL format
    [Arguments]    ${url}
    Should Match Regexp    ${url}    ^https?://[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}(/.*)?$