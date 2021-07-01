Documentation  TestCase to Verify ECO settings (Wifi signal off)



***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/PageObjects/WLANGuestNetwork.robot
Resource  ../Resource/CommonFunction.robot
Resource  ../Resource/CommonWindowsFunction.robot

Test Setup  Login to DUT
# Suite Teardown  Logout from DUT
Suite Setup  Fetch the Initial SSID



*** Test Cases *** 
ECO settings (Wifi signal off)
    [Documentation]  This Test case is to verify ECO settings (Wifi signal off)
    [Tags]  Funtional  WiFi
    Go to WLAN Page
    Disable SSID Broadcast
    Save the WiFi setting
    Go to WLAN Guest Page
    Disable Guest Network
    Save Guest WiFi Network Settings
    Logout from DUT
    # sleep  60s
    # ${SSID_Broadcast_result}=  Check SSID Broadcast  ${Orginal_ssid}
    FOR  ${VAR}  IN RANGE    4
      ${SSID_Broadcast_result}=   Check SSID Broadcast  ${Orginal_ssid}
      sleep  30s
      EXIT For Loop If  "${SSID_Broadcast_result}" == ""
    END


    Should Be Empty  ${SSID_Broadcast_result}
    
# Disable Guest Network
#     Go to WLAN Page
#     Go to WLAN Guest Page
#     Disable Guest Network
#     Save Guest WiFi Network Settings

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
    Set the SSID name  ${Orginal_ssid}
    Save the WiFi setting
    Logout from DUT
