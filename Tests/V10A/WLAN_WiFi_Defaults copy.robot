Documentation  TestCase to Verify WLAN SSID


***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/WLANPage.robot
Resource  ../../Resource/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestDataPassword.csv

Test Setup  Login to DUT
Suite Setup   Fetch the Initial WLAN details
Suite Teardown  Run Keyword And Ignore Error  Cleanup
Default Tags   V10A   Funtional  WiFi  WiFiDefault

Test Template  Verify setting SSID Password


*** Test Cases ***
Reboot and verify if configured settings are preserved
    [Documentation]  This Test case is to verify after Reboot if configured settings are preserved



*** Keywords ***
Verify setting SSID Password
    [Arguments]  ${SSID}  ${SSID_Password}
    Go to WLAN Page
    Set the SSID name  ${SSID}
    Set the wifi Password  ${SSID_Password}
    Save the WiFi setting
    Logout from DUT

    FOR  ${VAR}  IN RANGE    10
        ${Connection_status}=  Connect to SSID  ${SSID}
        ${status}=    Run Keyword And Return Status   Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
      EXIT For Loop If  ${status}
      sleep  30s
    END
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from.*bytes=32 time<1ms TTL=64"  "${Ping_Status}"



Fetch the Initial WLAN details 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_Authentication_Method}=  Get the Authentication Method
    Set Global Variable  ${Orginal_Authentication_Method}
    ${Orginal_WPA_Encryption}=  Get the Encryption Type
    Set Global Variable  ${Orginal_WPA_Encryption}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}
    ${Orginal_IGMP_Snooping}=  Get the IGMP Snooping Status
    Set Global Variable  ${Orginal_IGMP_Snooping}
    ${Orginal_WPS}=   Get WPS Status
    Set Global Variable  ${Orginal_WPS}
    # Save the WiFi setting
    Logout from DUT



Cleanup
    Login to DUT
    Go to WLAN Page
    Set the SSID name  ${Orginal_ssid}
    Set the Authentication Method  ${Orginal_Authentication_Method}
    Set the Encryption Type  ${Orginal_WPA_Encryption}
    Set the wifi Password  ${Orginal_password}
    Set the IGMP Snooping  ${Orginal_IGMP_Snooping}
    Set the WPS  ${Orginal_WPS}
    Save the WiFi setting
    Logout from DUT
