Documentation  TestCase to WLAN ChannelID Test cases
***Settings***
Resource   ../Resource/Telnet.robot
Resource  ../Resource/PageObjects/WLANPage.robot
Resource  ../Resource/CommonFunction.robot


Test Setup  Login to DUT
Test Teardown  Logout from DUT
Test Template  Verify ChannelID scenarios


*** Test Cases ***           CHANNELID_INDEX
Verify setting ChannelID 1              2
Verify setting ChannelID 2              3
Verify setting ChannelID 3              4




*** Keywords ***
Verify ChannelID scenarios
    [Documentation]  This Test case is to verify setting different channel with Bandwith 20mhz
    [Arguments]  ${ChannelID_index}
    [Tags]  Funtional  WiFi  ChannelIDSet
    Go to WLAN Page
    Set the 2.4Ghz Channel ID with value  ${ChannelID_index}