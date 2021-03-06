Documentation  TestCase to Verify LAN Connected Devices

***Settings***
Resource   ../../Resource/PageObjects/V10A/ConnectedDevices.robot
Resource   ../../Resource/CommonWindowsFunction.robot
Resource   ../../Resource/PageObjects/V10A/CommonFunction.robot

Test Setup  Login to DUT
Test Teardown  Cleanup



*** Test Cases ***            
Check LAN connected devices 
    [Documentation]  This Test case is to verify LAN Connected Devices
    [Tags]  Funtional  WiFi  V10A  LANConnectedDevices
    Go to Connected Devices Page
    ${Connected_Devices_Mac_Address_GUI}=  Get the MAC Address of LAN Connected Devices list
    ${Connected_Devices_Mac_Address_Console}=  Get the MAC address for LAN devices from Windows
    List Should Contain Sub List  ${Connected_Devices_Mac_Address_GUI}  ${Connected_Devices_Mac_Address_Console}



***Keywords***
Cleanup
    Logout from DUT