Documentation  TestCase to Verify 2.4GHz ChannelIDs updated through V10A


***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/WLANPage.robot
Resource  ../../Resource/PageObjects/WLANGuestNetwork.robot
Resource  ../../Resource/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestData24GHz.csv

Test Setup  Login to DUT
# Test Teardown  Logout from DUT
Test Template  Verify 2.4Ghz ChannelID scenarios
Suite Teardown  Run Keyword And Ignore Error  Set 2.4Ghz Channel ID to Auto
Suite Setup  Fetch the Initial SSID
Default Tags   V10A   Funtional  WiFi  24GhzChannelIDSet



*** Test Cases ***
Verify setting 2.4Ghz ChannelID ${24GHz_Channel} with Bandwith ${24GHz_BandwidthValue} 
[Documentation]  This Test case is to verify setting different channel and Bandwith


*** Keywords ***
Verify 2.4Ghz ChannelID scenarios
    [Arguments]  ${24GHz_Channel}  ${ChannelID_index}  ${24GHz_Bandwidth}
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
    sleep  60s
    FOR  ${VAR}  IN RANGE    10
      ${2.4Ghz_ChannelID_Analyser}=  Fetch the Channel IDs from Windows Analyser  ${Orginal_ssid}
      ${2.4Ghz_ChannelID_Analyser_Length}  Get Length  ${2.4Ghz_ChannelID_Analyser}
      log  ChannelIDs are ${2.4Ghz_ChannelID_Analyser} and Length of ChannelIDs is ${2.4Ghz_ChannelID_Analyser_Length}
      ${status}=    Run Keyword And Return Status  list Should contain value  ${2.4Ghz_ChannelID_Analyser}  ${2.4Ghz_ChannelID_Console}
      EXIT For Loop If  ${status}
      sleep  30s
    END
    list Should contain value  ${2.4Ghz_ChannelID_Analyser}  ${2.4Ghz_ChannelID_Console}
    ${Connection_status}=  Connect to SSID  ${Orginal_ssid}
    Should Be True      "Connection request was completed successfully" in """${Connection_status}"""
    ${Ping_Status}=  Ping to Gateway
    Should Be True   "Reply from.*bytes=32 time<1ms TTL=64"  "${Ping_Status}"



Fetch the Initial SSID
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    # Go to WLAN Guest Page
    # Disable Guest Network
    # Save Guest WiFi Network Settings
    Logout from DUT
