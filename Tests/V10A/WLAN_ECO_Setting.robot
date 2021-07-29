Documentation  TestCase to Verify ECO settings (Wifi signal off)



***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/WLANPage.robot
Resource  ../../Resource/PageObjects/V10A/WLANGuestNetwork.robot
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot

Test Setup  Login to DUT
Suite Teardown  Run Keyword And Ignore Error  Cleanup
Suite Setup  Fetch the Initial SSID


*** Test Cases *** 
ECO settings (Wifi signal off)
    [Documentation]  This Test case is to verify ECO settings When WiFi Signal is Disabled it should not Broadcast (Wifi signal off)
    [Tags]  V10A  Funtional  WiFi  EcoSetting
    Go to WLAN Page
    Disable SSID Broadcast
    Save the WiFi setting
    Go to WLAN Guest Page
    Disable Guest Network
    Save Guest WiFi Network Settings
    Logout from DUT
    sleep  30s
    FOR  ${VAR}  IN RANGE  5
      ${SSID_Broadcast_result}=   Check SSID Broadcast  ${Orginal_ssid}
      ${SSID_Broadcast_result}=  Convert To String  ${SSID_Broadcast_result}
    #   sleep  30s
      EXIT For Loop If  "${SSID_Broadcast_result.replace('\n','').strip()}"=="${Empty}"
      sleep  30s
    END
    Should Be Empty  ${SSID_Broadcast_result}

*** Keywords ***
Fetch the Initial SSID
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Logout from DUT

Cleanup
    Login to DUT
    Go to WLAN Page
    Go to WLAN Guest Page
    Enable Guest Network
    Save Guest WiFi Network Settings
    Go to WLAN Page
    Enable SSID Broadcast
    Save the WiFi setting
    Logout from DUT
