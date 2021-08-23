Documentation  TestCase to verify WLAN ExtraWiFi features

***Settings***
Resource  ../../Resource/PageObjects/SW2/SW2SettingPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/CommonWindowsFunction.robot
Resource  ../../Resource/PageObjects/SW2/SW2_WLAN_ExtraWiFi.robot


Suite Setup  Fetch the Initial WLAN details
Test Setup  Login to DUT


***Test Cases***

Verify total BSSID
    [Documentation]  TestCase to verify WLAN Mesh features through SuperWiFi-2
    [Tags]  SW2  Funtional  WiFi  CheckMeshSSID
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
    Go to Settings Page
    ${Orginal_ssid}=  Get the SSID name
    Set Global Variable  ${Orginal_ssid}
    Go to WLAN Guest Page
    ${Orginal_GuestStatus}=  Get the Guest Network Status
    Set Global Variable  ${Orginal_GuestStatus}
    Logout from DUT