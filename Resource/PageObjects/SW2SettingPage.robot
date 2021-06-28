*** Variables ***
${Wireless Settings}  Wireless Settings
${Settings_Tab}  //div[@id='id_nav_1']
${2.4Ghz_Channel}  //select[@name='wchan_24g_both']
${2.4Ghz_ChannelID_dropdown}  //tbody/tr[@id='wireless_24ghz']/td[@class='tdTextTa_20']/div[1]
${5Ghz_ChannelID_dropdown}  //tbody/tr[@id='wireless_5ghz']/td[@class='tdTextTa_20']/div[1]
${2.4Ghz_Bandwidth_dropdown}  //table[3]/tbody[1]/tr[3]/td[2]/div[1]
${5Ghz_Bandwidth_dropdown}  //table[3]/tbody[1]/tr[4]/td[2]/div[1]
${WLAN_save_setting}  //span[@class='ButtonMiddle tapurple']
${WLAN_save_setting_Popup}  //body//div[@id='msgbox']//div//div//div[1]
# ${2.4Ghz_ChannelID_Value}  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[2]/a
${2.4Ghz_ChannelID_Value}  //tr[@id='wireless_24ghz']//li[1]/a
${WPA Encryption}  //select[@id='cypher_suite_24g']
${5Ghz_Channel}  //select[@name='wchan_5g_both']
${wlan_page}  Restore WiFi Defaults
${ssid_name_2.4G}  ORIGESSID
${ssid_password_2.4G}  PreSharedKeyID



***Keywords***

Go to Settings Page
    unselect frame  
    select frame  name:topFrame  
    click element  ${Settings_Tab}
    Sleep  2s
    unselect frame 
    select frame  id:frm_main2
    wait until page contains  ${Wireless Settings}  5s

Get the SSID name
    current frame should contain  Channel
    ${current_ssid}  get element attribute  ${ssid_name_2.4G}  value
    log  ${current_ssid} is Current ssid
    [return]  ${current_ssid}

Set the SSID name
    [Arguments]    ${ssid}
    Input Text  ${ssid_name_2.4G}  ${ssid}

Get the wifi Password
    ${current_ssid_password} =  get element attribute  ${ssid_password_2.4G}  value
    log  ${current_ssid_password} is Current ssid Password
    [return]  ${current_ssid_password}
    
Set the wifi Password
    [Arguments]    ${ssid_password}  
    Input Text  ${ssid_password_2.4G}  ${ssid_password}  


Set 2.4Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_24ghz']//li[${item label}]/a

Set 5Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[${item label}]/a


Set 2.4Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[3]/td[2]/div/ul/li[${item label}]/a


Set 5Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[4]/td[2]/div/ul/li[${item label}]/a


Set 2.4Ghz Channel ID to Auto
    Login to DUT
    Go to WLAN Page
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_24ghz']//li[1]/a
    Save the WiFi setting
    Logout from DUT

Set 5Ghz Channel ID to Auto
    Login to DUT
    Go to WLAN Page
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[1]/a
    Save the WiFi setting
    Logout from DUT

Save the WiFi setting
    click element  ${WLAN_save_setting}
    sleep  2s
    Click element  ${WLAN_save_setting_Popup}
    sleep  15s