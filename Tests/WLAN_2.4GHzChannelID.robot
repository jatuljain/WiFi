Documentation  TestCase to WLAN ChannelID Test cases


***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot
Resource  ../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../TestData/TestData24GHz.csv

Test Setup  Login to DUT
# Test Teardown  Logout from DUT
Test Template  Verify 2.4Ghz ChannelID scenarios
# Test Template  Verify 2.4Ghz ChannelID scenarios
# Test Template  Verify 2.4Ghz ChannelID scenarios


*** Variables ***
@{Loop}=  1  2  3 
${2.4Ghz_ChannelID_Analyser}  0

*** Test Cases ***            
Verify setting 2.4Ghz ChannelID ${24GHz_Channel} with Bandwith ${24GHz_BandwidthValue} 



*** Keywords ***
# Verify 2.4Ghz ChannelID scenarios
#     [Documentation]  This Test case is to verify setting different channel with Bandwith 20mhz
#     [Arguments]  ${24GHz_Channel}  ${ChannelID_index}
#     [Tags]  Funtional  WiFi  ChannelIDSet
#     Go to WLAN Page
#     Set 2.4Ghz Channel ID with value  ${ChannelID_index}
#     Telnet to DUT Console
#     ${2.4Ghz_ChannelID_Console}=  Get the 2.4Ghz channel id from console
#     log  Channel ID from Console is ${2.4Ghz_ChannelID_Console}
#     Close All Connections
#     Should be equal  ${2.4Ghz_ChannelID_Console}  ${24GHz_Channel}
    
Verify 2.4Ghz ChannelID scenarios
    [Documentation]  This Test case is to verify setting different channel and Bandwith
    [Arguments]  ${24GHz_Channel}  ${ChannelID_index}  ${24GHz_Bandwidth}
    [Tags]  Funtional  WiFi  2.4GhzChannelIDSet
    Go to WLAN Page
    Set 2.4Ghz Channel ID with value  ${ChannelID_index}
    Set 2.4Ghz Bandwith with value  ${24GHz_Bandwidth}
    Save the WiFi setting
    Logout from DUT
    Telnet to DUT Console
    ${2.4Ghz_ChannelID_Console}=  Get the 2.4Ghz channel id from console
    log  Channel ID from Console is ${2.4Ghz_ChannelID_Console}
    Close All Connections
    Should be equal  ${2.4Ghz_ChannelID_Console}  ${24GHz_Channel}
    sleep  90s
    FOR  ${VAR}  IN   @{Loop}
      ${2.4Ghz_ChannelID_Analyser}=  Fetch the Channel IDs from Windows Analyser
      ${2.4Ghz_ChannelID_Analyser_Length}  Get Length  ${2.4Ghz_ChannelID_Analyser}
      log  ChannelIDs are ${2.4Ghz_ChannelID_Analyser} and Length of ChannelIDs is ${2.4Ghz_ChannelID_Analyser_Length}
      EXIT For Loop If  ${2.4Ghz_ChannelID_Analyser_Length} >= 2
      sleep  30s
    END
    list Should contain value  ${2.4Ghz_ChannelID_Analyser}  ${2.4Ghz_ChannelID_Console}