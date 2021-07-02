*** Settings ***
# Library  SeleniumLibrary
Library  Screenshot  screenshot_module | pillow 

*** Variables ***
${Guest_Network_Tab}  //div[contains(text(),'Guest Network')]
${Guest_Network_Page}  Guest Network
${Wireless_Guest_Dropdown}  //tbody/tr[1]/td[2]/div/div/a

${Guest_SSID_ToggleBUtton}  //tbody/tr[2]/td[2]/div
${Guest_SSID_SaveSetting}  //tbody/tr/td[2]/div/a/span[2]
${Guest_SSID_EnableDisable}  //tbody/tr[2]/td[2]/div
${Guest_SSID_Disable}  //tbody/tr[1]/td[2]/div/ul/li[2]/a
${Guest_SSID_Enable}  //tbody/tr[1]/td[2]/div/ul/li[1]/a


*** Keywords ***

Go to WLAN Guest Page
    unselect frame
    select frame  id:frm_left
    Click Element  ${Guest_Network_Tab}
    sleep  5s
    wait until page contains  ${Guest_Network_Page}
    unselect frame
    select frame  id:frm_main2
    current frame should contain  ${Guest_Network_Page}

Disable Guest Network
    click element  ${Wireless_Guest_Dropdown}
    click element  ${Guest_SSID_Disable}

Enable Guest Network
    click element  ${Wireless_Guest_Dropdown}
    click element  ${Guest_SSID_Enable}


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
