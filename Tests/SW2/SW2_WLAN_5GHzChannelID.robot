Documentation  TestCase to Verify 5GHz ChannelIDs updated through SuperWiFi2


***Settings***
Resource  ../../Resource/PageObjects/SW2SettingPage.robot
Resource  ../../Resource/SW2CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../../TestData/TestData5GHz.csv
Default Tags   SW2   Funtional  WiFi  5GhzChannelIDSet


Test Setup  Login to DUT
# Test Teardown  Logout from DUT
Suite Teardown  Run Keyword And Ignore Error  Set 5Ghz Channel ID to Auto
Suite Setup  Fetch the Initial SSID

Test Template  Verify 5Ghz ChannelID scenarios


*** Test Cases ***
Verify setting 5Ghz ChannelID ${5GHz_Channel} with Bandwith ${5GHz_BandwidthValue} 
    [Documentation]  This Test case is to verify setting different channel and Bandwith in SW2 



*** Keywords ***
 
Verify 5Ghz ChannelID scenarios
    [Tags]  SW2   Funtional  WiFi  5GhzChannelIDSet
    [Arguments]  ${5GHz_Channel}  ${ChannelID5_index}  ${5GHz_Bandwidth}
    Go to Settings Page
    Set 5Ghz Channel ID with value  ${ChannelID5_index}
    Set 5Ghz Bandwith with value  ${5GHz_Bandwidth}
    Save the WiFi setting
    Logout from DUT
    IF  ${5GHz_Channel} < 100
      sleep  60s
    ELSE  
      sleep  180s
    END    
    FOR  ${VAR}  IN RANGE    14
      ${5Ghz_ChannelID_Analyser}=  Fetch the Channel IDs from Windows Analyser  ${Orginal_ssid}
      ${5Ghz_ChannelID_Analyser_Length}  Get Length  ${5Ghz_ChannelID_Analyser}
      log  ChannelIDs are ${5Ghz_ChannelID_Analyser} and Length of ChannelIDs is ${5Ghz_ChannelID_Analyser_Length}
      ${status}=    Run Keyword And Return Status  list Should contain value  ${5Ghz_ChannelID_Analyser}  ${5GHz_Channel}
      EXIT For Loop If  ${status}
      # EXIT For Loop If  ${5Ghz_ChannelID_Analyser_Length} >= 2
      sleep  30s
    END
    list Should contain value  ${5Ghz_ChannelID_Analyser}  ${5GHz_Channel}
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
