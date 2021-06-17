Documentation  TestCase to WLAN 5GHz ChannelID Test cases


***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot
Library  DataDriver  ../TestData/TestData5GHz.csv


Test Setup  Login to DUT
Test Teardown  Logout from DUT
Test Template  Verify 5Ghz ChannelID scenarios


*** Test Cases ***            
Verify setting 5GHz ChannelID ${5GHz_Channel} with Bandwith ${5GHz_BandwidthValue} 


*** Keywords ***
Verify 5Ghz ChannelID scenarios
    [Documentation]  This Test case is to verify setting different channel and Bandwith
    [Arguments]  ${5GHz_Channel}  ${ChannelID5_index}  ${5GHz_Bandwidth}
    [Tags]  Funtional  WiFi  5GhzChannelIDSet
    Go to WLAN Page
    Set 5Ghz Channel ID with value  ${ChannelID5_index}
    Set 5Ghz Bandwith with value  ${5GHz_Bandwidth}
    Save the WiFi setting
    Telnet to DUT Console
    ${5Ghz_ChannelID_Console}=  Get the 5Ghz channel id from console
    log  Channel ID from Console is ${5Ghz_ChannelID_Console}
    Close All Connections
    Should be equal  ${5Ghz_ChannelID_Console}  ${5GHz_Channel}

    