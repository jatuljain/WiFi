Documentation  TestCase to Verify WLAN Setting Post reboot


***Settings***
Resource  ../../Resource/PageObjects/WLANPage.robot
Resource  ../../Resource/CommonFunction.robot
Resource  ../../Resource/PageObjects/V10A/AdministrationPage.robot
Resource  ../../Resource/PageObjects/V10A/RebootPage.robot


Test Setup  Login to DUT
Suite Setup   Fetch the Initial WLAN details
Suite Teardown  Run Keyword And Ignore Error  Cleanup


*** Test Cases ***
Reboot and verify if configured settings are preserved
    [Tags]  V10A  Funtional  WiFi  Reboot
    Go to Administration Page
    Go to Reboot Page
    Reboot the DUT
    Close All Browsers
    Login to DUT
    Go to WLAN Page
    ${Post_reboot_ssid}=  Get the SSID name
    ${Post_reboot_Authentication_Method}=  Get the Authentication Method
    ${Post_reboot_WPA_Encryption}=  Get the Encryption Type
    ${Post_reboot_password}=  Get the wifi Password
    ${Post_reboot_IGMP_Snooping}=  Get the IGMP Snooping Status
    ${Post_reboot_WPS}=   Get WPS Status
    Should be equal  ${Post_reboot_ssid}  ${Orginal_ssid}
    Should be equal  ${Post_reboot_Authentication_Method}  ${Orginal_Authentication_Method}
    Should be equal  ${Post_reboot_WPA_Encryption}  ${Orginal_WPA_Encryption}
    Should be equal  ${Post_reboot_password}  ${Orginal_password}
    Should be equal  ${Post_reboot_IGMP_Snooping}  ${Orginal_IGMP_Snooping}
    Should be equal  ${Post_reboot_WPS}  ${Orginal_WPS}
    Logout from DUT



*** Keywords ***
Fetch the Initial WLAN details 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    ${Orginal_Authentication_Method}=  Get the Authentication Method
    Set Global Variable  ${Orginal_Authentication_Method}
    ${Orginal_WPA_Encryption}=  Get the Encryption Type
    Set Global Variable  ${Orginal_WPA_Encryption}
    ${Orginal_password}=  Get the wifi Password
    Set Global Variable  ${Orginal_password}
    ${Orginal_IGMP_Snooping}=  Get the IGMP Snooping Status
    Set Global Variable  ${Orginal_IGMP_Snooping}
    ${Orginal_WPS}=   Get WPS Status
    Set Global Variable  ${Orginal_WPS}
    Logout from DUT



Cleanup
    Logout from DUT
