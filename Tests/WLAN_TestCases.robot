Documentation  TestCase to WLAN features

***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot

# Suite Setup  Login to DUT
# Suite Teardown  Logout from DUT

Test Setup  Login to DUT
Test Teardown  Logout from DUT

***Test Cases***

Verify WLAN 2.4GHz Channel ID from GUI and Console should match
    [Documentation]  This Test case is to verify 2.4Ghz Channel ID from GUI and Console
    [Tags]  Funtional  WiFi2.4
    Telnet to DUT Console
    ${2.4Ghz_ChannelID_Console}=  Get the 2.4Ghz channel id from console
    log  Channel ID from Console is ${2.4Ghz_ChannelID_Console}
    Close All Connections
    Go to WLAN Page
    ${2.4Ghz_ChannelID_GUI}=  Get the 2.4Ghz channel id from GUI
    log  Channel ID from Console is ${2.4Ghz_ChannelID_GUI}
    Should be equal  ${2.4Ghz_ChannelID_Console}  ${2.4Ghz_ChannelID_GUI}


Verify WLAN 5GHz Channel ID from GUI and Console should match
    [Documentation]  This Test case is to verify 5Ghz Channel ID from GUI and Console
    [Tags]  Funtional  WiFi5
    Telnet to DUT Console
    ${5Ghz_ChannelID_Console}=  Get the 5Ghz channel id from console
    log  Channel ID from Console is ${5Ghz_ChannelID_Console}
    Close All Connections
    Go to WLAN Page
    ${5Ghz_ChannelID_GUI}=  Get the 5Ghz channel id from GUI
    log  Channel ID from Console is ${5Ghz_ChannelID_GUI}
    Should be equal  ${5Ghz_ChannelID_Console}  ${5Ghz_ChannelID_GUI}


Verify setting different channel with Bandwith 20mhz
    [Documentation]  This Test case is to verify setting different channel with Bandwith 20mhz
    [Tags]  Funtional  WiFi  ChannelSet
    Go to WLAN Page
    Set the 2.4Ghz Channel ID with value  3
    # Set the 2.4Ghz Channel ID to 1
