*** Settings ***
# Library  SeleniumLibrary
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
    Click WiFi Guest Edit button
    Disable Guest SSID Broadcast

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
