Documentation  TestCase to WLAN ChannelID Test cases


***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot
Library  DataDriver  ../TestData/TestData24GHz.csv

Test Setup  Login to DUT
Test Teardown  Logout from DUT
Test Template  Verify 2.4Ghz ChannelID scenarios
# Test Template  Verify 2.4Ghz ChannelID scenarios
# Test Template  Verify 5Ghz ChannelID scenarios


*** Test Cases ***            
Verify setting 2.4Ghz ChannelID ${24GHz_Channel}



*** Keywords ***
Verify 2.4Ghz ChannelID scenarios
    [Documentation]  This Test case is to verify setting different channel with Bandwith 20mhz
    [Arguments]  ${24GHz_Channel}  ${ChannelID_index}
    [Tags]  Funtional  WiFi  ChannelIDSet
    Go to WLAN Page
    Set 2.4Ghz Channel ID with value  ${ChannelID_index}
    Telnet to DUT Console
    ${2.4Ghz_ChannelID_Console}=  Get the 2.4Ghz channel id from console
    log  Channel ID from Console is ${2.4Ghz_ChannelID_Console}
    Close All Connections
    Should be equal  ${2.4Ghz_ChannelID_Console}  ${24GHz_Channel}
    
