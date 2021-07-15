Documentation  TestCase to Verify WLAN Setting Post Factory Reset if configured settings are defaulted SW2
                In this Test will do Factory Reset of SW2 and check the Default values

***Settings***
Resource  ../../Resource/PageObjects/WLANPage.robot
Resource  ../../Resource/CommonFunction.robot
# Resource  ../../Resource/PageObjects/SW2/SW2_SystemPage.robot
Library  DataDriver  ../../TestData/V10A_TestDataFactoryReset.csv

Default Tags   SW2  Funtional  WiFi  FactoryReset

Test Setup  Login to DUT
Suite Setup   Fetch the Initial WLAN details
Suite Teardown  Run Keyword And Ignore Error  Cleanup

Test Template  Facrory Reset and verify WLAN settings are set to Defaults



*** Test Cases ***
Facrory Reset and verify WLAN settings are set to Defaults for SW2




*** Keywords ***
Facrory Reset and verify WLAN settings are set to Defaults
    [Arguments]  ${Factory_ssid}  ${Factory_Authentication_Method}  ${Factory_password}  ${Factory_WPS}  ${Factory_24GHz_Mode}  ${Factory_5GHz_Mode}  ${Factory_24GHz_Bandwith}  ${Factory_5GHz_Bandwith}  ${Factory_24GHz_ChannelID}  ${Factory_5GHz_ChannelID}  ${Factory_Compatibility_Mode}
    Go to System Page
    Click on Restart and Factory Recovery Tab
    Factory Reset the DUT
    Close All Browsers
    Factory Reset Login to DUT
    Go to Settings Page
    ${Post_fr_ssid}=  Get the SSID name
    ${Post_fr_Authentication_Method}=  Get the Authentication Method
    ${Post_fr_password}=  Get the wifi Password
    ${Post_fr_WPS}=   Get WPS Status
    ${Post_fr_2.4GHz_Mode}=   Get 2.4GHz Mode 
    ${Post_fr_5GHz_Mode}=   Get 5GHz Mode     
    ${Post_fr_2.4GHz_Bandwith}=   Get 2.4GHz Bandwith 
    ${Post_fr_5GHz_Bandwith}=   Get 5GHz Bandwith     
    ${Post_fr_2.4GHz_ChannelID}=   Get 2.4GHz Channel ID 
    ${Post_fr_5GHz_ChannelID}=   Get 5GHz Channel ID 
    ${Post_fr_Compatibility_Mode}=   Get Compatibility Mode Status
    Should be equal  ${Post_fr_ssid}  ${Factory_ssid}
    Should be equal  ${Post_fr_Authentication_Method}  ${Factory_Authentication_Method}
    Should be equal  ${Post_fr_password}  ${Factory_password}
    Should be equal  ${Post_fr_2.4GHz_Mode}  ${Factory_24GHz_Mode}
    Should be equal  ${Post_fr_5GHz_Mode}  ${Factory_5GHz_Mode}
    Should be equal  ${Post_fr_2.4GHz_Bandwith}  ${Factory_24GHz_Bandwith}
    Should be equal  ${Post_fr_5GHz_Bandwith}  ${Factory_5GHz_Bandwith}    
    Should be equal  ${Post_fr_2.4GHz_ChannelID}  ${Factory_24GHz_ChannelID}
    Should be equal  ${Post_fr_5GHz_ChannelID}  ${Factory_5GHz_ChannelID}
    Should be equal  ${Post_fr_WPS}  ${Factory_WPS}
    Should be equal  ${Post_fr_Compatibility_Mode}  ${Factory_Compatibility_Mode}
    Logout from DUT



Fetch the Initial WLAN details 
    Login to DUT
    Go to Settings Page
    ${Original_ssid}=  Get the SSID name
    Set Global Variable  ${Original_ssid}
    ${Original_Authentication_Method}=  Get the Authentication Method
    Set Global Variable  ${Original_Authentication_Method}
    ${Original_password}=  Get the wifi Password
    Set Global Variable  ${Original_password}
    ${Original_2.4GHz_Mode}=   Get 2.4GHz Mode 
    Set Global Variable  ${Original_2.4GHz_Mode}    
    ${Original_5GHz_Mode}=   Get 5GHz Mode 
    Set Global Variable  ${Original_5GHz_Mode}
    ${Original_2.4GHz_Bandwith}=   Get 2.4GHz Bandwith 
    Set Global Variable  ${Original_2.4GHz_Bandwith}
    ${Original_5GHz_Bandwith}=   Get 5GHz Bandwith 
    Set Global Variable  ${Original_5GHz_Bandwith}    
    ${Original_2.4GHz_ChannelID}=   Get 2.4GHz Channel ID 
    Set Global Variable  ${Original_2.4GHz_ChannelID}
    ${Original_5GHz_ChannelID}=   Get 5GHz Channel ID 
    Set Global Variable  ${Original_5GHz_ChannelID}
    ${Original_WPS}=   Get WPS Status
    Set Global Variable  ${Original_WPS}
    ${Original_Compatibility_Mode}=   Get Compatibility Mode Status
    Set Global Variable  ${Original_Compatibility_Mode}
    Logout from DUT



Cleanup
    Login to DUT
    Go to Settings Page
    Set the SSID name  ${Original_ssid}
    Set the Authentication Method  ${Original_Authentication_Method}
    Set the wifi Password  ${Original_password}
    Set 2.4GHz Mode  ${Original_2.4GHz_Mode}    
    Set 5GHz Mode  ${Original_5GHz_Mode}
    Set 2.4GHz Bandwith  ${Original_2.4GHz_Bandwith}
    Set 5GHz Bandwith  ${Original_5GHz_Bandwith}    
    Set 2.4Ghz Channel ID  ${Original_2.4GHz_ChannelID}
    Set 5Ghz Channel ID  ${Original_5GHz_ChannelID}
    Set WPS  ${Original_WPS}
    Set Compatibility Mode Status  ${Original_Compatibility_Mode}
    Save the WiFi setting
    Logout from DUT


