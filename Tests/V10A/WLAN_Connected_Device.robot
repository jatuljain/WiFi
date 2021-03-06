Documentation  TestCase to Verify WiFi Connected Devices

***Settings***
Resource   ../../Resource/PageObjects/V10A/ConnectedDevices.robot
Resource   ../../Resource/CommonWindowsFunction.robot
Resource   ../../Resource/PageObjects/V10A/CommonFunction.robot

Test Setup  Login to DUT
Suite Setup  Connect the Initial SSID
Test Teardown  Cleanup



*** Test Cases ***            
# Check Wifi connected devices
#     [Documentation]  This Test case is to verify Connected Devices
#     # [Arguments]  ${SSID}
#     [Tags]  Funtional  WiFi
#     Go to Connected Devices Page
#     ${Connected_Devices_Mac_Address}=  Get the MAC Address from Connected Devices list
#     ${Connected_Devices_Mac_Address}=  Change the MAC Address type  ${Connected_Devices_Mac_Address}
#     ${Connected_Devices_Mac_Address_Console}=  Fetch the MAC address for Wi-Fi LAN devices
#     Should Contain Match  ${Connected_Devices_Mac_Address_Console}  ${Connected_Devices_Mac_Address}


Check Wifi connected devices 
    [Documentation]  This Test case is to verify WiFi Connected Devices
    [Tags]  Funtional  WiFi  V10A  WiFiConnectedDevices
    Go to Connected Devices Page
    ${Connected_Devices_Mac_Address_GUI}=  Get the MAC Address of WiFi Connected Devices list
    ${Connected_Devices_Mac_Address_Console}=  Get the MAC address for Wi-Fi LAN devices from Windows
    List Should Contain Sub List  ${Connected_Devices_Mac_Address_GUI}  ${Connected_Devices_Mac_Address_Console}



***Keywords***

Connect the Initial SSID 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}
    Logout from DUT
    Connect to SSID with Password  ${Orginal_ssid}  ${Orginal_password}



Cleanup
    Logout from DUT