Documentation  TestCase to Verify WLAN SSID through SuperWiFi2


***Settings***
Resource  ../../Resource/PageObjects/SW2/SW2SettingPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestDataSSID.csv
Default Tags   SW2   Funtional  WiFi  WiFiSSID

Test Setup  Login to DUT
Suite Teardown  Run Keyword And Ignore Error  Cleanup
Suite Setup  Fetch the Initial SSID

Test Template  Verify setting SSID


*** Test Cases *** 
Change the name of the Wi-Fi network (SSID) ${SSID}

*** Keywords ***
Verify setting SSID
    [Documentation]  This Test case is to verify setting SSID through SuperWiFi2
    [Arguments]  ${SSID}
    Go to Settings Page
    Set the SSID name  ${SSID}
    Save the WiFi setting
    Logout from DUT
    FOR  ${VAR}  IN RANGE    10
        ${Connection_status}=  Connect to SSID with Password  ${SSID}  ${Orginal_password}
        ${status}=    Run Keyword And Return Status   Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
      EXIT For Loop If  ${status}
      sleep  30s
    END
    # ${Connection_status}=  Connect to SSID
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from" in """${Ping_Status}"""



Fetch the Initial SSID
    Login to DUT
    Go to Settings Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}
    Logout from DUT

Cleanup
    Login to DUT
    Go to Settings Page
    Set the SSID name  ${Orginal_ssid}
    Save the WiFi setting
    Logout from DUT
