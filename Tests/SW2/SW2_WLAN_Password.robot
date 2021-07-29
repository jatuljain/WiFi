Documentation  TestCase to Verify WLAN SSID through SuperWiFi2


***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/SW2/SW2SettingPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestDataPassword.csv
Default Tags   SW2   Funtional  WiFi

Suite Setup  Fetch the Initial SSID
Test Setup  Run Keyword And Ignore Error  Login to DUT
Suite Teardown  Cleanup

Test Template  Verify setting SSID Password


*** Test Cases ***
Change the WiFi Password Characters of the Wi-Fi network to ${SSID_Password} for SW2
[Documentation]  This Test case is to verify setting SSID through SuperWiFi2

*** Keywords ***
Verify setting SSID Password
    [Arguments]  ${SSID}  ${SSID_Password}
    Go to Settings Page
    Set the SSID name  ${SSID}
    Set the wifi Password  ${SSID_Password}
    Save the WiFi setting
    Logout from DUT
    FOR  ${VAR}  IN RANGE    10
        # sleep  60s
        ${Connection_status}=  Connect to SSID  ${SSID}
        ${status}=    Run Keyword And Return Status   Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
      EXIT For Loop If  ${status}
      sleep  30s
    END
    # ${Connection_status}=  Connect to SSID
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from.*bytes=32 time<1ms TTL=64"  "${Ping_Status}"


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
