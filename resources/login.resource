*** Settings ***
Library         RequestsLibrary

*** Keywords ***
Perform Login
    [Documentation]    Performs login via API.
    [Arguments]    ${username}    ${password}
    ${data}=    Create Dictionary    username=${username}    password=${password}
    ${resp}=    POST On Session    restful    /auth    json=${data}
    Set Test Variable    ${response}    ${resp}
