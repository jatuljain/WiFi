*** Variables ***
${Wireless Settings}  Wireless Settings
${Settings_Tab}  //div[@id='id_nav_1']
${2.4Ghz_Channel}  //select[@name='wchan_24g_both']
${2.4Ghz_ChannelID}  //table[3]/tbody/tr[5]/td[2]/div/div/span
${5Ghz_ChannelID}  //table[3]/tbody/tr[6]/td[2]/div/div/span
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

${SSID_Broadcast_Dropdown}  //tbody/tr[2]/td[2]/div/div/a
${Main_SSID_Disable}  //table[1]/tbody/tr[2]/td[2]/div/ul/li[2]
${Main_SSID_Enable}  //table[1]/tbody/tr[2]/td[2]/div/ul/li[1]

${Authentication_Method}  //select[@name='securitymode']


${WPS_Check}=  //select[@name='wirewps']
${WPS_dropdown}  //tbody/tr[7]/td[2]/div/div/span


${Compatibility_Mode_Check}=  //select[@name='wireldpc']
${Compatibility_Mode_dropdown}  //tbody/tr[8]/td[2]/div/div/span



# ${2.4GHz_Mode}  //select[@name='mode_24g']
${2.4GHz_Mode}  //table[3]/tbody/tr[1]/td[2]/div/div/span
# ${5GHz_Mode}   //select[@name='mode_5g']
${5GHz_Mode}   //table[3]/tbody/tr[2]/td[2]/div/div/span


${2.4GHz_Bandwith}  //table[3]/tbody/tr[3]/td[2]/div/div/span
${5GHz_Bandwith}   //table[3]/tbody/tr[4]/td[2]/div/div/span









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


Get the Authentication Method  ## To get Security Mode
    ${current_Authentication_Method}=  Get selected list value  ${Authentication_Method}
    log  ${current_Authentication_Method} is Current Authentication_Method
    [return]  ${current_Authentication_Method}

Set the Authentication Method
    [Arguments]    ${Authentication}
    IF  '${Authentication}' == 'wpa2'
        ${Authentication_ID}  Set Variable  2
    ELSE
        ${Authentication_ID}  Set Variable  1
    END
    click element  ${Authentication_dropdown}
    click element  //tbody/tr[5]/td[2]/div/ul/li[${Authentication_ID}]/a

Get 2.4GHz Mode  
    # ${current_2.4GHz_Mode}=  Get selected list value  ${2.4GHz_Mode}
    ${current_2.4GHz_Mode}=  Get Text  ${2.4GHz_Mode}
    log  ${current_2.4GHz_Mode} is Current 2.4GHz Mode
    [return]  ${current_2.4GHz_Mode}

Set the 2.4GHz Mode 
    [Arguments]    ${Authentication}
    IF  '${Authentication}' == 'wpa2'
        ${Authentication_ID}  Set Variable  2
    ELSE
        ${Authentication_ID}  Set Variable  1
    END
    click element  ${Authentication_dropdown}
    click element  //tbody/tr[5]/td[2]/div/ul/li[${Authentication_ID}]/a

Get 5GHz Mode  
    ${current_5GHz_Mode}=  Get Text  ${5GHz_Mode}
    log  ${current_5GHz_Mode} is Current 5GHz Mode
    [return]  ${current_5GHz_Mode}

Set the 5GHz Mode 
    [Arguments]    ${Authentication}
    IF  '${Authentication}' == 'wpa2'
        ${Authentication_ID}  Set Variable  2
    ELSE
        ${Authentication_ID}  Set Variable  1
    END
    click element  ${Authentication_dropdown}
    click element  //tbody/tr[5]/td[2]/div/ul/li[${Authentication_ID}]/a


Get the Encryption Type
    ${current_WPA_Encryption}=  Get selected list value  ${WPA_Encryption}
    log  ${current_WPA_Encryption} is Current WPA Encryption
    [return]  ${current_WPA_Encryption}

Set the Encryption Type
    [Arguments]    ${WPA_Encryption}
    click element  ${WPA_Encryption_dropdown}
    click element  ${WPA_Encryption_AES}


Get the wifi Password
    ${current_ssid_password} =  get element attribute  ${ssid_password_2.4G}  value
    log  ${current_ssid_password} is Current ssid Password
    [return]  ${current_ssid_password}
    
Set the wifi Password
    [Arguments]    ${ssid_password}  
    Input Text  ${ssid_password_2.4G}  ${ssid_password}  


Get 2.4Ghz Channel ID
    ${current_2.4GHz_ChannelID}=  Get Text  ${2.4GHz_ChannelID}
    log  ${current_2.4GHz_ChannelID} is Current 2.4GHz ChannelID
    [return]  ${current_2.4GHz_ChannelID}

Get 5Ghz Channel ID
    ${current_5GHz_ChannelID}=  Get Text  ${5GHz_ChannelID}
    log  ${current_5GHz_ChannelID} is Current 5GHz ChannelID
    [return]  ${current_5GHz_ChannelID}

Set 2.4Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_24ghz']//li[${item label}]/a

Set 5Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[${item label}]/a


Get 2.4Ghz Bandwith
    ${current_2.4GHz_Bandwith}=  Get Text  ${2.4GHz_Bandwith}
    log  ${current_2.4GHz_Bandwith} is Current 2.4GHz Bandwith
    [return]  ${current_2.4GHz_Bandwith}


Set 2.4Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[3]/td[2]/div/ul/li[${item label}]/a


Get 5Ghz Bandwith
    ${current_5GHz_Bandwith}=  Get Text  ${5GHz_Bandwith}
    log  ${current_5GHz_Bandwith} is Current 5GHz Bandwith
    [return]  ${current_5GHz_Bandwith}



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
    sleep  20s


Disable SSID Broadcast
    click element  ${SSID_Broadcast_Dropdown}
    click element  ${Main_SSID_Disable}

Enable SSID Broadcast
    click element  ${SSID_Broadcast_Dropdown}
    click element  ${Main_SSID_Enable}


Get WPS Status
    ${current_WPS_Check}=  Get selected list value  ${WPS_Check}
    log  ${current_WPS_Check} is Current Authentication_Method
    [return]  ${current_WPS_Check}

Set the WPS
    [Arguments]    ${WPS}
    IF  '${WPS}' == '1'
       Set the WPS ON
    ELSE
       Set the WPS OFF
    END
    
Set the WPS ON
    ${WPS_Status}=  Get WPS Status
    # ${status}=    Get Regexp Matches    ${WPS_Status}   arcTransformChecked
    IF  ${WPS_Status}
        log   WPS is already enabled
    ELSE
        Enable WPS
    END

Set the WPS OFF
    ${WPS_Status}=  Get WPS Status
    # ${status}=    Get Regexp Matches    ${WPS_Status}   arcTransformChecked
    IF  ${WPS_Status}
        Disable WPS
    ELSE
        log   WPS is already Disabled
    END

Enable WPS
    click element  ${WPS_dropdown}
    click element  //tbody/tr[7]/td[2]/div/ul/li[2]


Disable WPS
    click element  ${WPS_dropdown}
    click element  //tbody/tr[7]/td[2]/div/ul/li[1]



Get Compatibility Mode Status
    # ${current_Compatibility_Mode_Check}=  Get selected list value  ${Compatibility_Mode_Check}
    ${current_Compatibility_Mode_Check}=  Get Text  ${Compatibility_Mode_dropdown}
    log  ${current_Compatibility_Mode_Check} is Current Compatibility Mode
    [return]  ${current_Compatibility_Mode_Check}
