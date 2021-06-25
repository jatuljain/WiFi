Documentation  TestCase to Verify WLAN SSID


***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot
Resource  ../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../TestData/TestDataPassword.csv

Test Setup  Login to DUT
Suite Teardown  Cleanup

Test Template  Verify setting SSID Password


*** Test Cases *** 
Change the WiFi Password Characters of the Wi-Fi network ${SSID_Password}


*** Keywords ***
Verify setting SSID Password
    [Documentation]  This Test case is to verify WiFi Password
    [Arguments]  ${SSID}
    [Tags]  Funtional  WiFi
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Set the SSID name  ${SSID}
    Save the WiFi setting
    Logout from DUT
    # Telnet to DUT Console
    # ${SSID_Console}=  Get the SSID from console
    # log  Channel ID from Console is ${SSID_Console}
    # Close All Connections
    # Should Be Equal As Strings  ${SSID}  ${SSID_Console}
    FOR  ${VAR}  IN RANGE    10
        Add WiFi Profile
        ${Connection_status}=  Connect to SSID  ${SSID}
        ${status}=    Run Keyword And Return Status   Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
      EXIT For Loop If  ${status}
      sleep  30s
    END
    # ${Connection_status}=  Connect to SSID
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from.*bytes=32 time<1ms TTL=64"  "${Ping_Status}"



Cleanup
    Login to DUT
    Go to WLAN Page
    Set the SSID name  ${Orginal_ssid}
    Save the WiFi setting
    Logout from DUT
