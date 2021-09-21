Documentation  Upgrade SuperWifi Disc2

***Settings***
Resource  ../../Resource/PageObjects/V10A/CommonFunction.robot
Resource  ../../Resource/PageObjects/V10A/WLAN_AccessPoints.robot
Resource  ../../Resource/PageObjects/SW2/SW2_UpgradePage.robot
Resource  ../../Resource/PageObjects/SW2/SW2Authorization.robot
Library  String

# Test Setup  Login to DUT
Suite Setup  Fetch the Serial numbers for SW2 through V10A

***Test Cases***

Upgrade SuperWifi Disc2
    [Documentation]  Upgrade SuperWifi Disc2 from V10A
    [Tags]  SW2  Funtional  WiFi  SW2UpgradeFromV10A
    FOR   ${Sw2_SN}  ${SW2_IP}  IN ZIP  ${SW2_SN_list}    ${SW2_IP_list}  
        ${Serianl_Number_last6}=  Get Substring  ${Sw2_SN}  4  10
        ${Upgrade_HOME_PAGE_Password}=  Set Variable  ${Upgrade_Password}${Serianl_Number_last6}
        Login to Upgrade Home Page  ${Upgrade_HOME_PAGE_Password}  ${SW2_IP}
        Choose file and upgrade
    END


*** Keywords ***
Fetch the Serial numbers for SW2 through V10A
    CommonFunction.Login to DUT
    Go to WLAN Page
    Go to Access Points Page
    @{SW2_SN_list}=  Fetch the Serial numbers from Access Point Page
    Set Global Variable  @{SW2_SN_list}
    @{SW2_IP_list}=  Fetch the IPs of SW2 from Access Point Page
    Set Global Variable  @{SW2_IP_list} 
    Logout from DUT