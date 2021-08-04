Documentation  TestCase to check DHCP IP assignment range

***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Resource  ../../Resource/PageObjects/V10A/Network_LAN_Page.robot


Suite Setup  Fetch the Initial WLAN details

Test Setup  Login to DUT

***Test Cases***


Verify Random TestCase
    [Tags]  V10A   Funtional  WiFi  DynamicIP
    Go to Network Page
    ${Start_IP}=  Get the DHCP Start IP from DHCP Pool from GUI
    ${EndIP_IP}=  Get the DHCP End IP from DHCP Pool from GUI
    Logout from DUT
    ${IP_Console}=  Get IP from console for WiFi Interface
    @{Start_IP_octect} =	Split String	${Start_IP}	 .
    @{End_IP_octect} =	Split String	${EndIP_IP}	 .
    @{Console_IP_octect} =	Split String	${IP_Console}	 .
    should be True  ${Console_IP_octect}[3] >= ${Start_IP_octect}[3] 
    should be True  ${Console_IP_octect}[3] <= ${End_IP_octect}[3] 




*** Keywords ***
Fetch the Initial WLAN details 
    Telnet to DUT Console
    ${Orginal_ssid}=  Get the SSID from console
    ${Orginal_password}=  Get the SSID Password from console
    Connect to SSID with Password  ${Orginal_ssid}  ${Orginal_password}