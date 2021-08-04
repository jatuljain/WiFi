Documentation  TestCase to WLAN features

***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/AdministrationPage.robot
Resource  ../../Resource/PageObjects/V10A/RebootPage.robot
Resource  ../../Resource/PageObjects/V10A/WLANGuestNetwork.robot
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Resource  ../../Resource/PageObjects/V10A/Network_LAN_Page.robot
Resource  ../../Resource/PageObjects/V10A/Network_UPnP_Page.robot
Resource  ../../Resource/PageObjects/V10A/WLAN_MAC_Filtering_Page.robot
# Resource  ../../Resource/PageObjects/SW2/SW2SettingPage.robot
# Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
# Resource  ../../Resource/PageObjects/SW2/SW2_SystemPage.robot

# Suite Setup  Fetch the Initial WLAN details
# Suite Teardown  Logout from DUT

Test Setup  Login to DUT
Test Teardown  Run Keyword And Ignore Error  Logout from DUT

***Test Cases***


Verify Random TestCase
    [Tags]  Test
    Go to Network Page
    ${Start_IP}=  Get the DHCP Start IP from DHCP Pool from GUI
    ${EndIP_IP}=  Get the DHCP End IP from DHCP Pool from GUI
    Telnet to DUT Console
    ${Orginal_ssid}=  Get the SSID from console
    ${Orginal_password}=  Get the SSID Password from console
    ${Connection_status}=  Connect to SSID with Password  ${Orginal_ssid}  ${Orginal_password}
    ${IP_Console}=  Get IP from console for WiFi Interface
    @{Start_IP_octect} =	Split String	${Start_IP}	 .
    @{End_IP_octect} =	Split String	${EndIP_IP}	 .
    @{Console_IP_octect} =	Split String	${IP_Console}	 .
    should be True  ${Console_IP_octect}[3] > ${Start_IP_octect}[3] 
    should be True  ${Console_IP_octect}[3] < ${End_IP_octect}[3] 



Verify Random Disbale TestCase
    [Tags]  
    Telnet to DUT Console
    Get the SSID from console
    Get the SSID Password from console
    Get the UPnP Status from console
    ${UPnP_console_status}=  Get the UPnP Status from console
    Should Be Equal  ${UPnP_console_status}  1



Verify total BSSID
    ${BroadCasted_Count}=  Fetch BSSID Broadcast  owl
    ${BroadCasted_Count}  Get length  ${BroadCasted_Count}
    ${CountofSW2}=  Get total SuperWifi2 count
    ${CountofSW1}=  Get total SuperWifi1 count
    ${CountofV10A}=  Get total V10A count
    ${CountofExperiaWiFi}=  Get total ExperiaWiFi count
    ${Total_APs}=  Evaluate       ${CountofSW2} + ${CountofSW1} + ${CountofV10A} + ${CountofExperiaWiFi}
    log  Total APs are ${Total_APs}
    Should Be True	${Total_APs} == ${BroadCasted_Count}


Verify WLAN 2.4GHz Channel ID from GUI and Console should match
    [Documentation]  This Test case is to verify 2.4Ghz Channel ID from GUI and Console
    Telnet to DUT Console
    ${2.4Ghz_ChannelID_Console}=  Get the 2.4Ghz channel id from console
    log  Channel ID from Console is ${2.4Ghz_ChannelID_Console}
    Close All Connections
    Go to WLAN Page
    ${2.4Ghz_ChannelID_GUI}=  Get the 2.4Ghz channel id from GUI
    log  Channel ID from GUI is ${2.4Ghz_ChannelID_GUI}
    Should be equal  ${2.4Ghz_ChannelID_Console}  ${2.4Ghz_ChannelID_GUI}


Verify WLAN 5GHz Channel ID from GUI and Console should match
    [Documentation]  This Test case is to verify 5GHz Channel ID from GUI and Console
    Telnet to DUT Console
    ${5Ghz_ChannelID_Console}=  Get the 5Ghz channel id from console
    log  Channel ID from Console is ${5Ghz_ChannelID_Console}
    Close All Connections
    Go to WLAN Page
    ${5Ghz_ChannelID_GUI}=  Get the 5Ghz channel id from GUI
    log  Channel ID from GUI is ${5Ghz_ChannelID_GUI}
    Should be equal  ${5Ghz_ChannelID_Console}  ${5Ghz_ChannelID_GUI}


# Verify setting different channel with Bandwith 20mhz
#     [Documentation]  This Test case is to verify setting different channel with Bandwith 20MHz
#     [Tags]  Funtional  WiFi  ChannelSet
#     Go to WLAN Page
#     Set the 2.4Ghz Channel ID with value  3
#     # Set the 2.4Ghz Channel ID to 1

# Verify Guest Network Status
#     [Documentation]  This Test case is to verify Guest Network Status
#     [Tags]  V10A  Funtional  WiFi  GuestNetwork
#     Go to WLAN Page
#     Go to WLAN Guest Page
#     # Get the Guest Network Status
#     Disable Guest Network
#     # Enable Guest Network
#     Save Guest WiFi Network Settings


# Verify Restart DUT
#     [Documentation]  This Test case is to verify Restart Funtional of DUT
#     [Tags]  SW2  Funtional  WiFi  DUTRestart
#     Go to System Page
#     Click on Restart and Factory Recovery
#     Click on Restart

Verify WLAN Page Details
    [Documentation]  This Test case is to verify Restart Funtional of DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}
    ${Authentication_Method}=  Get the Authentication Method
    Set Global Variable  ${Authentication_Method}
    Set the Authentication Method  2
    Get the IGMP Snooping Status
    Get WPS Status
    Set the IGMP Snooping OFF
    Set the WPS OFF
    Save the WiFi setting
    Logout from DUT

Verify WLAN Page Details
    [Documentation]  This Test case is to verify Restart Funtional of DUT
    Go to Administration Page
    Go to Reboot Page
    Reboot the DUT
    


Verify Ping to Gateway
    Ping to Gateway


*** Keywords ***
Fetch the Initial WLAN details 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}    
    Go to Network Page
    Logout from DUT