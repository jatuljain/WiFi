Documentation  TestCase to Verify 5GHz ChannelIDs updated through V10A

***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot
Resource  ../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../TestData/TestData5GHz.csv

Test Setup  Login to DUT
# Test Teardown  Logout from DUT
Suite Teardown  Set 5Ghz Channel ID to Auto

Test Template  Verify 5Ghz ChannelID scenarios


*** Variables ***
${5Ghz_ChannelID_Analyser}  0


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
    Logout from DUT
    Telnet to DUT Console
    ${5Ghz_ChannelID_Console}=  Get the 5Ghz channel id from console
    log  Channel ID from Console is ${5Ghz_ChannelID_Console}
    Close All Connections
    Should be equal  ${5Ghz_ChannelID_Console}  ${5GHz_Channel}
    IF  ${5GHz_Channel} < 100
      sleep  60s
    ELSE  
      sleep  180s
    END
    FOR  ${VAR}  IN RANGE    14
      ${5Ghz_ChannelID_Analyser}=  Fetch the Channel IDs from Windows Analyser
      ${5Ghz_ChannelID_Analyser_Length}  Get Length  ${5Ghz_ChannelID_Analyser}
      log  ChannelIDs are ${5Ghz_ChannelID_Analyser} and Length of ChannelIDs is ${5Ghz_ChannelID_Analyser_Length}
      ${status}=    Run Keyword And Return Status  list Should contain value  ${5Ghz_ChannelID_Analyser}  ${5Ghz_ChannelID_Console}
      EXIT For Loop If  ${status}
      # EXIT For Loop If  ${5Ghz_ChannelID_Analyser_Length} >= 2
      sleep  30s
    END
    list Should contain value  ${5Ghz_ChannelID_Analyser}  ${5Ghz_ChannelID_Console}
    ${Connection_status}=  Connect to SSID
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from.*bytes=32 time<1ms TTL=64"  "${Ping_Status}"