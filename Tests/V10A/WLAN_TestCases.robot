Documentation  TestCase to WLAN features

***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/AdministrationPage.robot
Resource  ../../Resource/PageObjects/V10A/RebootPage.robot
Resource  ../../Resource/PageObjects/WLANGuestNetwork.robot
Resource  ../../Resource/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot

# Resource  ../../Resource/PageObjects/SW2SettingPage.robot
# Resource  ../../Resource/SW2CommonFunction.robot
# Resource  ../../Resource/PageObjects/SW2/SW2_SystemPage.robot

# Suite Setup  Login to DUT
# Suite Teardown  Logout from DUT

# Test Setup  Login to DUT
# Test Teardown  Run Keyword And Ignore Error  Logout from DUT

***Test Cases***

Verify total BSSID
    [Tags]  V10A  Funtional  WiFi2.4  WiFi  Test
    ${Count}=  Fetch BSSID Broadcast  owl


Verify WLAN 2.4GHz Channel ID from GUI and Console should match
    [Documentation]  This Test case is to verify 2.4Ghz Channel ID from GUI and Console
    [Tags]  V10A  Funtional  WiFi2.4  WiFi
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
    [Tags]  Funtional  WiFi5  WiFi
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
    [Tags]  V10A  Funtional  WiFi  WLANPage
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
    [Tags]  V10A  Funtional  WiFi
    Go to Administration Page
    Go to Reboot Page
    Reboot the DUT
    


Verify Ping to Gateway
    [Tags]  V10A  Funtional  WiFi  PingtoGateway
    Ping to Gateway