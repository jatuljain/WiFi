Documentation  TestCase to Verify WLAN Setting Post Reboot if configured settings are preserved for SW2


***Settings***
Resource  ../../Resource/PageObjects/SW2/SW2SettingPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/PageObjects/SW2/SW2_SystemPage.robot


Test Setup  Login to DUT
Suite Setup   Fetch the Initial WLAN details
Suite Teardown  Run Keyword And Ignore Error  Cleanup


*** Test Cases ***
Reboot and verify if configured settings are preserved
    [Tags]  SW2  Funtional  WiFi  Reboot
    Go to System Page
    Click on Restart and Factory Recovery Tab
    Reboot the DUT
    Close All Browsers
    Login to DUT
    Go to Settings Page
    ${Post_reboot_ssid}=  Get the SSID name
    ${Post_reboot_Authentication_Method}=  Get the Authentication Method
    # ${Post_reboot_WPA_Encryption}=  Get the Encryption Type    ## Not Applicable for SW2
    ${Post_reboot_password}=  Get the wifi Password
    # ${Post_reboot_IGMP_Snooping}=  Get the IGMP Snooping Status   ## Not Applicable for SW2
    ${Post_reboot_WPS}=   Get WPS Status
    ${Post_2.4GHz_Mode}=   Get 2.4GHz Mode 
    ${Post_5GHz_Mode}=   Get 5GHz Mode     
    ${Post_2.4GHz_Bandwith}=   Get 2.4GHz Bandwith 
    ${Post_5GHz_Bandwith}=   Get 5GHz Bandwith     
    ${Post_2.4GHz_ChannelID}=   Get 2.4GHz Channel ID 
    ${Post_5GHz_ChannelID}=   Get 5GHz Channel ID 
    ${Post_Compatibility_Mode}=   Get Compatibility Mode Status
    Should be equal  ${Post_reboot_ssid}  ${Original_ssid}
    Should be equal  ${Post_reboot_Authentication_Method}  ${Original_Authentication_Method}
    # Should be equal  ${Post_reboot_WPA_Encryption}  ${Original_WPA_Encryption}
    Should be equal  ${Post_reboot_password}  ${Original_password}
    # Should be equal  ${Post_reboot_IGMP_Snooping}  ${Original_IGMP_Snooping}
    Should be equal  ${Post_2.4GHz_Mode}  ${Original_2.4GHz_Mode}
    Should be equal  ${Post_5GHz_Mode}  ${Original_5GHz_Mode}
    Should be equal  ${Post_2.4GHz_Bandwith}  ${Original_2.4GHz_Bandwith}
    Should be equal  ${Post_5GHz_Bandwith}  ${Original_5GHz_Bandwith}    
    Should be equal  ${Post_2.4GHz_ChannelID}  ${Original_2.4GHz_ChannelID}
    Should be equal  ${Post_5GHz_ChannelID}  ${Original_5GHz_ChannelID}
    Should be equal  ${Post_reboot_WPS}  ${Original_WPS}
    Should be equal  ${Post_Compatibility_Mode}  ${Original_Compatibility_Mode}
    Logout from DUT



*** Keywords ***
Fetch the Initial WLAN details 
    Login to DUT
    Go to Settings Page
    ${Original_ssid}=  Get the SSID name
    Set Global Variable  ${Original_ssid}
    ${Original_Authentication_Method}=  Get the Authentication Method
    Set Global Variable  ${Original_Authentication_Method}
    # ${Original_WPA_Encryption}=  Get the Encryption Type   ## Not Applicable for SW2
    # Set Global Variable  ${Original_WPA_Encryption}
    ${Original_password}=  Get the wifi Password
    Set Global Variable  ${Original_password}
    # ${Original_IGMP_Snooping}=  Get the IGMP Snooping Status  ## Not Applicable for SW2
    # Set Global Variable  ${Original_IGMP_Snooping}
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
    Logout from DUT
