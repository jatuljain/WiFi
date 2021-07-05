Documentation  TestCase to Verify Connected Devices

***Settings***
Resource   ../../Resource/PageObjects/SW2MyDevices.robot
Resource   ../../Resource/CommonWindowsFunction.robot
Resource   ../../Resource/SW2CommonFunction.robot

Test Setup  Login to DUT
Test Teardown  Cleanup



*** Test Cases ***            
Check Wifi connected devices 
    [Documentation]  This Test case is to verify Connected Devices
    # [Arguments]  ${SSID}
    [Tags]  SW2   Funtional  WiFi
    Go to Connected Devices Page
    ${Connected_Devices_Mac_Address_GUI}=  Get the MAC Address of WiFi Connected Devices list
    ${Connected_Devices_Mac_Address_GUI}=  Change the MAC Address type  ${Connected_Devices_Mac_Address_GUI}
    ${Connected_Devices_Mac_Address_Console}=  Get the MAC address for Wi-Fi LAN devices from Windows
    # Should Contain Match  ${Connected_Devices_Mac_Address_Console}  ${Connected_Devices_Mac_Address_GUI}
    List Should Contain Sub List  ${Connected_Devices_Mac_Address_Console}  ${Connected_Devices_Mac_Address_GUI}



***Keywords***
Cleanup
    Logout from DUT