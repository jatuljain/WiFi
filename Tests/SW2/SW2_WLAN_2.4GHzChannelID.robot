Documentation  TestCase to Verify 2.4GHz ChannelIDs updated through SuperWiFi2


***Settings***
Resource  ../../Resource/PageObjects/SW2/SW2SettingPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestData24GHz.csv
Default Tags   SW2   Funtional  WiFi  24GhzChannelIDSet



Test Setup  Login to DUT
Suite Teardown  Run Keyword And Ignore Error  Set 2.4Ghz Channel ID to Auto
Suite Setup  Fetch the Initial SSID

Test Template  Verify 2.4Ghz ChannelID scenarios


*** Test Cases *** 
Verify setting 2.4Ghz ChannelID ${24GHz_Channel} with Bandwith ${24GHz_BandwidthValue} 
    [Documentation]  This Test case is to verify setting different channel and Bandwith in SW2



*** Keywords ***
Verify 2.4Ghz ChannelID scenarios
    [Arguments]  ${24GHz_Channel}  ${ChannelID_index}  ${24GHz_Bandwidth}
    Go to Settings Page
    Set 2.4Ghz Channel ID with value  ${ChannelID_index}
    Set 2.4Ghz Bandwith with value  ${24GHz_Bandwidth}
    Save the WiFi setting
    Logout from DUT
    # Telnet to DUT Console
    # ${2.4Ghz_ChannelID_Console}=  Get the 2.4Ghz channel id from console
    # log  Channel ID from Console is ${2.4Ghz_ChannelID_Console}
    # Close All Connections
    # Should be equal  ${2.4Ghz_ChannelID_Console}  ${24GHz_Channel}
    sleep  60s
    FOR  ${VAR}  IN RANGE    10
      ${2.4Ghz_ChannelID_Analyser}=  Fetch the Channel IDs from Windows Analyser  ${Orginal_ssid}
      ${2.4Ghz_ChannelID_Analyser_Length}  Get Length  ${2.4Ghz_ChannelID_Analyser}
      log  ChannelIDs are ${2.4Ghz_ChannelID_Analyser} and Length of ChannelIDs is ${2.4Ghz_ChannelID_Analyser_Length}
      ${status}=    Run Keyword And Return Status  list Should contain value  ${2.4Ghz_ChannelID_Analyser}  ${24GHz_Channel}
      EXIT For Loop If  ${status}
      # EXIT For Loop If  ${2.4Ghz_ChannelID_Analyser_Length} >= 2
      sleep  30s
    END
    list Should contain value  ${2.4Ghz_ChannelID_Analyser}  ${24GHz_Channel}
    ${Connection_status}=  Connect to SSID  ${Orginal_ssid}
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from.*bytes=32 time<1ms TTL=64"  "${Ping_Status}"



Fetch the Initial SSID
    Login to DUT
    Go to Settings Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Logout from DUT
