*** Settings ***

*** Variables ***
${Extra_WiFi_Tab}  //div[contains(text(),'Extra Wi-Fi')]
${Extra_WiFi_Page}  Extra Wi-Fi

${Extra_WiFi_24_Dropdown}  //td[1]/table/tbody/tr[1]/td[2]/div/div/a
${Extra_WiFi_5_Dropdown}  //td[2]/table/tbody/tr[1]/td[2]/div/div/a

${Extra_WiFi_24_Disable}  //td[1]/table/tbody/tr[1]/td[2]/div/ul/li[2]/a
${Extra_WiFi_5_Disable}  //td[2]/table/tbody/tr[1]/td[2]/div/ul/li[2]/a
${Extra_WiFi_24_Enable}  //td[1]/table/tbody/tr[1]/td[2]/div/ul/li[1]/a
${Extra_WiFi_5_Enable}  //td[2]/table/tbody/tr[1]/td[2]/div/ul/li[1]/a



${SSID_Broadcast_24_Dropdown}  //td[1]/table/tbody/tr[2]/td[2]/div/div/a
${SSID_Broadcast_5_Dropdown}  //td[2]/table/tbody/tr[2]/td[2]/div/div/a

${SSID_Broadcast_24_Disable}  //td[1]/table/tbody/tr[2]/td[2]/div/ul/li[2]/a
${SSID_Broadcast_5_Disable}  //td[2]/table/tbody/tr[2]/td[2]/div/ul/li[2]/a
${SSID_Broadcast_24_Enable}  //td[1]/table/tbody/tr[2]/td[2]/div/ul/li[1]/a
${SSID_Broadcast_5_Enable}  //td[2]/table/tbody/tr[2]/td[2]/div/ul/li[1]/a

${SSID_Broadcast_24_Dropdown}  //td[1]/table/tbody/tr[2]/td[2]/div/div/a
${SSID_Broadcast_5_Dropdown}  //td[2]/table/tbody/tr[2]/td[2]/div/div/a

${SSID_Broadcast_24_Disable}  //td[1]/table/tbody/tr[2]/td[2]/div/ul/li[2]/a
${SSID_Broadcast_5_Disable}  //td[2]/table/tbody/tr[2]/td[2]/div/ul/li[2]/a
${SSID_Broadcast_24_Enable}  //td[1]/table/tbody/tr[2]/td[2]/div/ul/li[1]/a
${SSID_Broadcast_5_Enable}  //td[2]/table/tbody/tr[2]/td[2]/div/ul/li[1]/a

${Extra_ssid_name_2.4G}  //input[@id='extra24gname']
${Extra_ssid_name_5G}  //input[@id='extra5gname']
${Extra_ssid_Password_24G}  //input[@id='PreSharedKey24ID']
${Extra_ssid_Password_5G}  //input[@id='PreSharedKey5ID']


${WiFi_steering_Dropdown}  //tbody/tr[4]/td[2]/div[1]/div[1]/a[1]

${WiFi_steering_Disable}  //tr[4]/td[2]/div/ul/li[2]/a
${WiFi_steering_Enable}  //tr[4]/td[2]/div/ul/li[1]/a


${Extra_WiFi_BandSteering_Popup_Yes}  //html/body/div[4]/div/div/div[1]/a/span[2] 
${Extra_WiFi_BandSteering_Popup_No}  //html/body/div[4]/div/div/div[2]/a/span[2] 
${Extra_WiFi_SaveSetting}  //td[2]/table/tbody/tr/td[2]/div/a/span[2] 




*** Keywords ***

Go to WLAN Extra Wi-Fi Page
    unselect frame
    select frame  id:frm_left
    Click Element  ${Extra_WiFi_Tab}
    sleep  3s
    wait until page contains  ${Extra_WiFi_Page}
    unselect frame
    select frame  id:frm_main2
    current frame should contain  ${Extra_WiFi_Page}

Disable Extra Wi-Fi Network 2.4GHz
    click element  ${Extra_WiFi_24_Dropdown}
    click element  ${Extra_WiFi_24_Disable}

Enable Extra Wi-Fi Network 2.4GHz
    click element  ${Extra_WiFi_24_Dropdown}
    click element  ${Extra_WiFi_24_Enable}


Disable Extra Wi-Fi Network 5GHz
    click element  ${Extra_WiFi_5_Dropdown}
    click element  ${Extra_WiFi_5_Disable}

Enable Extra Wi-Fi Network 5GHz
    click element  ${Extra_WiFi_5_Dropdown}
    click element  ${Extra_WiFi_5_Enable}


Save Extra Wi-Fi Network Settings
    click element  ${Extra_WiFi_SaveSetting}
    # Handle Alert
    sleep  15s

Save Extra Wi-Fi Network Settings with Sterring Yes
    click element  ${Extra_WiFi_SaveSetting}
    Run keyword and Ignore Error  Handle WiFi steering Popup Yes
    sleep  15s

Save Extra Wi-Fi Network Settings with Sterring No
    click element  ${Extra_WiFi_SaveSetting}
    Run keyword and Ignore Error  Handle WiFi steering Popup No
    sleep  15s


Handle WiFi steering Popup Yes
    click element  ${Extra_WiFi_BandSteering_Popup_Yes}

Handle WiFi steering Popup No
    click element  ${Extra_WiFi_BandSteering_Popup_No}

Enable SSID Broadcast 2.4GHz 
    click element  ${SSID_Broadcast_24_Dropdown}
    click element  ${SSID_Broadcast_24_Enable}


Hide SSID Broadcast 2.4GHz 
    click element  ${SSID_Broadcast_24_Dropdown}
    click element  ${SSID_Broadcast_24_Disable}


Enable SSID Broadcast 5GHz 
    click element  ${SSID_Broadcast_5_Dropdown}
    click element  ${SSID_Broadcast_5_Enable}

Hide SSID Broadcast 5GHz 
    click element  ${SSID_Broadcast_5_Dropdown}
    click element  ${SSID_Broadcast_5_Disable}

Set Extra Wifi SSID 24GHz
    [Arguments]    ${ssid}
    Input Text  ${Extra_ssid_name_2.4G}  ${ssid}

Set Extra Wifi SSID 5GHz
    [Arguments]    ${ssid}
    Input Text  ${Extra_ssid_name_5G}  ${ssid}

Set Extra Wifi SSID Password 24GHz
    [Arguments]    ${ssid}
    Input Text  ${Extra_ssid_Password_24G}  ${ssid}

Set Extra Wifi SSID Password 5GHz
    [Arguments]    ${ssid}
    Input Text  ${Extra_ssid_Password_5G}  ${ssid}


Disable Extra Wi-Fi WiFi steering
    click element  ${WiFi_steering_Dropdown}
    click element  ${WiFi_steering_Disable}

Enable Extra Wi-Fi WiFi steering
    click element  ${WiFi_steering_Dropdown}
    click element  ${WiFi_steering_Enable}


