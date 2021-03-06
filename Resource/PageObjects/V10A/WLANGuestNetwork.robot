*** Settings ***
Library  Screenshot  screenshot_module | pillow 

*** Variables ***
${Guest_Network_Tab}  //a[normalize-space()='Guest Network']
${Guest_Network_Page}  Guest Network
${Guest_Network_Edit_Button}  //tbody/tr[2]/td[5]/div/a/span[2]

${Guest_SSID_ToggleBUtton}  //tbody/tr[2]/td[2]/div
${Guest_SSID_SaveSetting}  //tbody/tr[5]/td/div[1]/a/span[2]
${Guest_SSID_EnableDisable}  //tbody/tr[2]/td[2]/div


*** Keywords ***

Go to WLAN Guest Page
    unselect frame
    Click Element  ${Guest_Network_Tab}
    sleep  5s
    wait until page contains  Guest Network
    select frame  id:frm_main2
    current frame should contain  ${Guest_Network_Page}

Disable Guest Network
    ${current_GuestNetwork_Status}=  Get the Guest Network Status
    ${status}=    Get Regexp Matches    ${current_GuestNetwork_Status}   switch_off
    IF  ${status}
        log   Guest Network is already disabled
    ELSE
        # Click WiFi Guest Edit button
        Disable Guest SSID Broadcast
    END

Enable Guest Network
    ${current_GuestNetwork_Status}=  Get the Guest Network Status
    ${status}=    Get Regexp Matches    ${current_GuestNetwork_Status}   switch_on
    IF  ${status} 
        log   Guest Network is already Enabled
    ELSE
        # Click WiFi Guest Edit button
        Enable Guest SSID Broadcast
    END

Save Guest WiFi Network Settings
    click element  ${Guest_SSID_SaveSetting}
    # Handle Alert
    sleep  15s

Click WiFi Guest Edit button
    click element  ${Guest_Network_Edit_Button}


Enable Guest SSID Broadcast
    click element  ${Guest_SSID_ToggleBUtton}

Disable Guest SSID Broadcast
    click Element  ${Guest_SSID_ToggleBUtton}


Get the Guest Network Status
    Click WiFi Guest Edit button
    ${current_GuestNetwork_Status} =  get element attribute  ${Guest_SSID_ToggleBUtton}  class
    log  ${current_GuestNetwork_Status} is Current Guest Network Status
    [return]  ${current_GuestNetwork_Status}

