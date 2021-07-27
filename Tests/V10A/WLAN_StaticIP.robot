Documentation  TestCase to Verify LAN WiFi Connected Devices with Static IP, In this test case Fetching the initial Gateway and Subnet mask and assiging the static IP to 
.. DUT WiFi client and checking PING to Gateway with new IP. As part of Cleanup connecting back to orinal SSID and making connectivity to DHCP
.. This test case needs to be run with Administrative access

***Settings***
Resource   ../../Resource/CommonWindowsFunction.robot
Resource   ../../Resource/CommonFunction.robot
Resource  ../../Resource/PageObjects/V10A/Network_LAN_Page.robot

Suite Setup  Fetch the Initial DUT details
Suite Teardown  Cleanup



*** Test Cases ***            
Verify device with fixed IP DHCP Binding
    [Tags]  V10A  Funtional WiFi  Static_IP
    Connect to SSID  ${Orginal_ssid}
    Assign static IP to WiFi client  ${Gateway_octect}.10  ${network_mask}  ${network_gateway}
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from" in """${Ping_Status}"""



*** Keywords ***
Fetch the Initial DUT details 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Go to Network Page
    ${network_gateway}   Get the Network Gateway from GUI
    Set Global Variable  ${network_gateway}
    ${network_mask}   Get the Network SubnetMask from GUI
    Set Global Variable  ${network_mask}
    Logout from DUT
    ${Gateway_octect}   Get first three octet from IP  ${network_gateway}
    Set Global Variable  ${Gateway_octect}

Cleanup
    Connect to SSID  owl
    Assign dhcp IP to WiFi client