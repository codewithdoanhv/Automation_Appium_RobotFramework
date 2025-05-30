*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${APPIUM_SERVER_URL}    http://127.0.0.1:4723/wd/hub
${AUTOMATION_NAME}      UiAutomator2
${PLATFORM_NAME}        Android
${DEVICE_NAME}          R5CW92FWKCP
${PLATFORM_VERSION}     14
${APP_PACKAGE}          com.android.settings
${APP_ACTIVITY}         .Settings

*** Test Cases ***
Open Settings App And Click Location
    [Documentation]    Mở ứng dụng cài đặt và nhấp vào mục "Location"
    Open Android Settings
    Scroll To And Click Location

*** Keywords ***
Open Android Settings
    Open Application    ${APPIUM_SERVER_URL}
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}

Scroll To And Click Location
    ${max_swipes}=    Set Variable    10
    FOR    ${i}    IN RANGE    0    ${max_swipes}
        ${found}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[contains(@text, 'Location') or contains(@text, 'Vị trí')]
        Run Keyword If    ${found}    Click Element    xpath=//*[contains(@text, 'Location') or contains(@text, 'Vị trí')]
        Run Keyword If    ${found}    Exit For Loop
        #Vuốt từ điểm giữa màn hình (50% chiều ngang, 70% chiều dọc) xuống điểm giữa màn hình (50% chiều ngang, 20% chiều dọc) trong 1000ms (1 giây)
        Run Keyword If    not ${found}    Swipe By Percent    50    70    50    20    1000
    END
    Run Keyword If    not ${found}    Fail    Could not find Location option after ${max_swipes} swipes