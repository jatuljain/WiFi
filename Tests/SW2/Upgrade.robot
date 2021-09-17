Documentation  Upgrade SuperWifi Disc2

***Settings***
Resource  ../../Resource/PageObjects/SW2/SW2_SystemPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/PageObjects/SW2/SW2_UpgradePage.robot
Library  String

# Test Setup  Login to DUT
Suite Setup  Fetch the Serial number for SW2

***Test Cases***

Upgrade SuperWifi Disc2
    [Documentation]  Upgrade SuperWifi Disc2
    [Tags]  SW2  Funtional  WiFi  Upgrade
    ${Serianl_Number_last6}=  Get Substring  ${SW2_Serial_Number}  4  10
    ${Upgrade_HOME_PAGE_Password}=  Set Variable  ${Upgrade_Password}${Serianl_Number_last6}
    Login to Upgrade Home Page  ${Upgrade_HOME_PAGE_Password}
    Choose file and upgrade



*** Keywords ***
Fetch the Serial number for SW2 
    Login to DUT
    Go to System Page
    ${SW2_Serial_Number}=  Fetch the Serial number
    Set Global Variable  ${SW2_Serial_Number} 
    Logout from DUT