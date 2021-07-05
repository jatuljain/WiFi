Documentation  TestCase to Verify ECO settings (Wifi signal off)



***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/SW2SettingPage.robot
Resource  ../../Resource/PageObjects/SW2_WLANGuestNetwork.robot
Resource  ../../Resource/SW2CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot

Test Setup  Login to DUT
Suite Teardown  Cleanup
Suite Setup  Fetch the Initial SSID


*** Test Cases *** 
ECO settings (Wifi signal off)
    [Documentation]  This Test case is to verify ECO settings (Wifi signal off)
    [Tags]  SW2   Funtional  WiFi
    Go to Settings Page
    Disable SSID Broadcast
    Save the WiFi setting
    Go to WLAN Guest Page
    Disable Guest Network
    Save Guest WiFi Network Settings
    Logout from DUT
    sleep  30s
    FOR  ${VAR}  IN RANGE  4
      ${SSID_Broadcast_result}=   Check SSID Broadcast  ${Orginal_ssid}
      ${SSID_Broadcast_result}=  Convert To String  ${SSID_Broadcast_result}
      EXIT For Loop If  "${SSID_Broadcast_result.replace('\n','').strip()}"=="${Empty}"
      sleep  30s
    END
    Should Be Empty  ${SSID_Broadcast_result}

*** Keywords ***
Fetch the Initial SSID
    Login to DUT
    Go to Settings Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Logout from DUT

Cleanup
    Login to DUT
    Go to Settings Page
    Go to WLAN Guest Page
    Enable Guest Network
    Save Guest WiFi Network Settings
    Go to Settings Page
    Enable SSID Broadcast
    Save the WiFi setting
    Logout from DUT
