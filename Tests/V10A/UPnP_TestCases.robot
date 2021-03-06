Documentation  TestCase to WLAN features

***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/PageObjects/V10A/Network_LAN_Page.robot
Resource  ../../Resource/PageObjects/V10A/Network_UPnP_Page.robot

Test Setup  Login to DUT
# Test Teardown  Run Keyword And Ignore Error  Logout from DUT

***Test Cases***
Verify UPnP Enable
    [Tags]  V10A   Funtional  UPnP
    Go to Network Page
    Go to UPnP tab
    Enable UPnP
    Save UPnP Setting
    Logout from DUT
    Telnet to DUT Console
    ${UPnP_console_status}=  Get the UPnP Status from console
    Should Be Equal  ${UPnP_console_status}  1

    
Verify UPnP Disable
    [Tags]   V10A   Funtional  UPnP
    Go to Network Page
    Go to UPnP tab
    Disable UPnP
    Save UPnP Setting
    Logout from DUT
    Telnet to DUT Console
    ${UPnP_console_status}=  Get the UPnP Status from console
    Should Be Equal  ${UPnP_console_status}  0


