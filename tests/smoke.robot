*** Settings ***

Resource        ../resources/common.resource
Suite Setup     Open Browser  about:blank  chrome
Suite Teardown  Close All Browsers

*** Test Cases ***

Smoke Test
    Go To Home Page
    Title Should Be  Example Domain 
