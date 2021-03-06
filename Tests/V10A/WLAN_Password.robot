Documentation  TestCase to Verify WLAN SSID


***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/WLANPage.robot
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestDataPassword.csv

Test Setup  Login to DUT
Suite Setup   Fetch the Initial SSID
Suite Teardown  Run Keyword And Ignore Error  Cleanup
Default Tags   V10A   Funtional  WiFi  WiFiPassword

Test Template  Verify setting SSID Password


*** Test Cases ***
Change the WiFi Password Characters of the Wi-Fi network to ${SSID_Password}
    [Documentation]  This Test case is to verify WiFi Password


*** Keywords ***
Verify setting SSID Password
    [Arguments]  ${SSID}  ${SSID_Password}
    Go to WLAN Page
    Set the SSID name  ${SSID}
    Set the wifi Password  ${SSID_Password}
    Save the WiFi setting
    Logout from DUT
    FOR  ${VAR}  IN RANGE    10
        ${Connection_status}=  Connect to SSID with Password  ${SSID}  ${SSID_Password}
        ${status}=    Run Keyword And Return Status   Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
      EXIT For Loop If  ${status}
      sleep  30s
    END
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from" in """${Ping_Status}"""



Fetch the Initial SSID 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}
    Logout from DUT


Cleanup
    Login to DUT
    Go to WLAN Page
    Set the SSID name  ${Orginal_ssid}
    Set the wifi Password  ${Orginal_password}
    Save the WiFi setting
    Logout from DUT
