Documentation  TestCase to Verify MAC Filtering features

***Settings***
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Resource  ../../Resource/PageObjects/V10A/WLAN_MAC_Filtering_Page.robot


Suite Setup  Fetch the Initial WLAN details
# Suite Teardown  Logout from DUT

Test Setup  Login to DUT
# Test Teardown  Run Keyword And Ignore Error  Logout from DUT

***Test Cases***


Verify Random TestCase
    [Tags]  V10A   Funtional  WiFi  MACFilter
    Go to WLAN Page
    Go to MAC Filtering Page
    Enable MAC Filter
    Reject MAC Filter Mode
    Add MAC entry for LAN connected device
    Save MAC Filter Settings
    Logout from DUT
    FOR  ${VAR}  IN RANGE    5
        ${Connection_status}=  Connect to SSID with Password  ${Orginal_ssid}  ${Orginal_password}
        ${status}=    Run Keyword And Return Status   Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
      EXIT For Loop If  ${status}
      sleep  30s
    END
    ${Ping_Status}=  Ping to WiFi Interface Gateway
    Should Not Be True   "Reply from" in """${Ping_Status}"""



*** Keywords ***
Fetch the Initial WLAN details 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}    
    Logout from DUT