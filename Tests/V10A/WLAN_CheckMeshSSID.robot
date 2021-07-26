Documentation  TestCase to WLAN features

***Settings***
Resource   ../../Resource/Telnet.robot
Resource  ../../Resource/PageObjects/V10A/AdministrationPage.robot
Resource  ../../Resource/PageObjects/V10A/RebootPage.robot
Resource  ../../Resource/PageObjects/WLANGuestNetwork.robot
Resource  ../../Resource/CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot


Suite Setup  Fetch the Initial WLAN details
# Test Setup  Login to DUT


***Test Cases***

Verify total BSSID
    [Tags]  V10A  Funtional  WiFi2.4  WiFi  CheckMeshSSID
    Login to DUT
    ${CountofV10A}=  Get total V10A count
    ${CountofSW2}=  Get total SuperWifi2 count
    ${CountofSW1}=  Get total SuperWifi1 count
    ${CountofExperiaWiFi}=  Get total ExperiaWiFi count
    ${Total_APs}=  Evaluate       ${CountofSW2} + ${CountofSW1} + ${CountofV10A} + ${CountofExperiaWiFi}
    ${Guest_status}=    Get Regexp Matches    ${Orginal_GuestStatus}   switch_on
    IF  ${Guest_status}  
        ${Total_APs}=  Evaluate       ${Total_APs}*4
    ELSE
        ${Total_APs}=  Evaluate       ${Total_APs}*2
    END
    log  Total APs are ${Total_APs}
    Logout from DUT
    ${BroadCasted_BSSID}=  Fetch BSSID Broadcast  ${Orginal_ssid}
    log  Broadcasted BSSID MACs are ${BroadCasted_BSSID}
    ${BroadCasted_Count}  Get length  ${BroadCasted_BSSID}
    Should Be True	${Total_APs} == ${BroadCasted_Count}



*** Keywords ***
Fetch the Initial WLAN details 
    Login to DUT
    Go to WLAN Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Go to WLAN Guest Page
    ${Orginal_GuestStatus}=  Get the Guest Network Status
    Set Global Variable  ${Orginal_GuestStatus}
    Logout from DUT