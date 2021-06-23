Documentation  TestCase to WLAN ChannelID Test cases


***Settings***
Resource  ../Resource/PageObjects/SW2SettingPage.robot
Resource  ../Resource/SW2CommonFunction.robot
Resource  ../Resource/CommonWindowsFunction.robot
Library  DataDriver  ../TestData/TestData5GHz.csv

Test Setup  Login to DUT
# Test Teardown  Logout from DUT

Test Template  Verify 5Ghz ChannelID scenarios


*** Variables ***
# @{Loop}=  1  2  3 
${5Ghz_ChannelID_Analyser}  0

*** Test Cases ***            
Verify setting 5Ghz ChannelID ${5GHz_Channel} with Bandwith ${5GHz_BandwidthValue} 


*** Keywords ***
 
Verify 5Ghz ChannelID scenarios
    [Documentation]  This Test case is to verify setting different channel and Bandwith in SW2
    [Arguments]  ${5GHz_Channel}  ${ChannelID5_index}  ${5GHz_Bandwidth}
    [Tags]  SW2  Funtional  WiFi  5GhzChannelIDSet
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
      ${5Ghz_ChannelID_Analyser}=  Fetch the Channel IDs from Windows Analyser
      ${5Ghz_ChannelID_Analyser_Length}  Get Length  ${5Ghz_ChannelID_Analyser}
      log  ChannelIDs are ${5Ghz_ChannelID_Analyser} and Length of ChannelIDs is ${5Ghz_ChannelID_Analyser_Length}
      EXIT For Loop If  ${5Ghz_ChannelID_Analyser_Length} >= 2
      sleep  30s
    END
    list Should contain value  ${5Ghz_ChannelID_Analyser}  ${5GHz_Channel}