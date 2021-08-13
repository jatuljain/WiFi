############### Test case Description ########
# Test type: WLAN SSID connectivity
# Description: TestCase is to Verify different WLAN SSID connectivity
# Application(s) used: Windows Utility WLAN NETSH
# Input file(s) Used: ../../TestData/TestDataSSID.csv
##############################################
Documentation  TestCase to Verify WLAN SSID


***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/WLANPage.robot
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestDataSSID.csv
Default Tags   V10A   Funtional  WiFi  WiFiSSID

Test Setup  Login to DUT
Suite Teardown  Run Keyword And Ignore Error  Cleanup
Suite Setup  Fetch the Initial SSID

Test Template  Verify setting SSID


*** Test Cases *** 
Change the name of the Wi-Fi network (SSID) ${SSID}
    [Documentation]  This Test case is to verify setting SSID


*** Keywords ***
Verify setting SSID
    [Arguments]  ${SSID}
    Go to WLAN Page
    Set the SSID name  ${SSID}
    Save the WiFi setting
    Logout from DUT
    # Telnet to DUT Console
    # ${SSID_Console}=  Get the SSID from console
    # log  Channel ID from Console is ${SSID_Console}
    # Close All Connections
    # Should Be Equal As Strings  ${SSID}  ${SSID_Console}
    FOR  ${VAR}  IN RANGE    10
        ${Connection_status}=  Connect to SSID with Password  ${SSID}  ${Orginal_password}
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
    Save the WiFi setting
    Logout from DUT
