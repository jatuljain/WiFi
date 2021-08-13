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

${Authentication_dropdown}  //tbody/tr[@class='security_mode']/td[@class='tdTextTa_20']/div[1]
${Authentication_Method}  //select[@name='securitymode']


${WPS_Check}  //select[@name='wirewps']
${WPS_dropdown}  //tbody/tr[7]/td[2]/div/div/span


${Compatibility_Mode_Check}  //select[@name='wireldpc']
${Compatibility_Mode_dropdown}  //tbody/tr[8]/td[2]/div/div/span



${2.4GHzMode_dropdown}  //tbody/tr/td/table[3]/tbody/tr[1]/td[2]/div
${2.4GHz_Mode}  //table[3]/tbody/tr[1]/td[2]/div/div/span
# ${5GHz_Mode}   //select[@name='mode_5g']

${5GHzMode_dropdown}  //tbody/tr/td/table[3]/tbody/tr[2]/td[2]/div
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
    IF  '${Authentication}' == 'wpa2wpa3'
        ${Authentication_ID}  Set Variable  1
    ELSE IF  '${Authentication}' == 'wpa3'
        ${Authentication_ID}  Set Variable  2
    ELSE IF  '${Authentication}' == 'wpa2'
        ${Authentication_ID}  Set Variable  3    
    ELSE IF  '${Authentication}' == 'wpawpa2'
        ${Authentication_ID}  Set Variable  4
    ELSE IF  '${Authentication}' == 'open'
        ${Authentication_ID}  Set Variable  5
    END
    click element  ${Authentication_dropdown}
    click element  //table[1]/tbody/tr[3]/td[2]/div/ul/li[${Authentication_ID}]/a

Get 2.4GHz Mode  
    # ${current_2.4GHz_Mode}=  Get selected list value  ${2.4GHz_Mode}
    ${current_2.4GHz_Mode}=  Get Text  ${2.4GHz_Mode}
    log  ${current_2.4GHz_Mode} is Current 2.4GHz Mode
    [return]  ${current_2.4GHz_Mode}

Set 2.4GHz Mode 
    [Arguments]    ${Mode}
    IF  '${Mode}' == 'b/g/n'
        ${Mode_ID}  Set Variable  1
    ELSE IF  '${Mode}' == 'n/ax'
        ${Mode_ID}  Set Variable  2
    ELSE IF  '${Mode}' == 'g/n/ax'
        ${Mode_ID}  Set Variable  3    
    ELSE IF  '${Mode}' == 'b/g/n/ax'
        ${Mode_ID}  Set Variable  4
    END
    click element  ${2.4GHzMode_dropdown}
    click element  //table[3]/tbody/tr[1]/td[2]/div/ul/li[${Mode_ID}]/a

Get 5GHz Mode  
    ${current_5GHz_Mode}=  Get Text  ${5GHz_Mode}
    log  ${current_5GHz_Mode} is Current 5GHz Mode
    [return]  ${current_5GHz_Mode}

Set 5GHz Mode 
    [Arguments]    ${Mode}
    IF  '${Mode}' == 'n/ac'
        ${Mode_ID}  Set Variable  1
    ELSE IF  '${Mode}' == 'an/ac'
        ${Mode_ID}  Set Variable  2
    ELSE IF  '${Mode}' == 'n/ac/ax'
        ${Mode_ID}  Set Variable  3    
    ELSE IF  '${Mode}' == 'an/ac/ax'
        ${Mode_ID}  Set Variable  4
    END
    click element  ${5GHzMode_dropdown}
    click element  //table[3]/tbody/tr[2]/td[2]/div/ul/li[${Mode_ID}]/a



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

Set 2.4Ghz Channel ID
    [Arguments]    ${ChannelID}
    IF  '${ChannelID}' == 'Auto'
        ${ChannelID_ID}  Set Variable  1
    ELSE IF  '${ChannelID}' == '1'
        ${ChannelID_ID}  Set Variable  2
    ELSE IF  '${ChannelID}' == '2'
        ${ChannelID_ID}  Set Variable  3        
    ELSE IF  '${ChannelID}' == '3'
        ${ChannelID_ID}  Set Variable  4
    ELSE IF  '${ChannelID}' == '4'
        ${ChannelID_ID}  Set Variable  5        
    ELSE IF  '${ChannelID}' == '5'
        ${ChannelID_ID}  Set Variable  6
    ELSE IF  '${ChannelID}' == '6'
        ${ChannelID_ID}  Set Variable  7        
    ELSE IF  '${ChannelID}' == '7'
        ${ChannelID_ID}  Set Variable  8
    ELSE IF  '${ChannelID}' == '8'
        ${ChannelID_ID}  Set Variable  9
    ELSE IF  '${ChannelID}' == '9'
        ${ChannelID_ID}  Set Variable  10
    ELSE IF  '${ChannelID}' == '10'
        ${ChannelID_ID}  Set Variable  11        
    ELSE IF  '${ChannelID}' == '11'
        ${ChannelID_ID}  Set Variable  12
    ELSE IF  '${ChannelID}' == '12'
        ${ChannelID_ID}  Set Variable  13       
    ELSE IF  '${ChannelID}' == '13'
        ${ChannelID_ID}  Set Variable  14
    END
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_24ghz']//li[${ChannelID_ID}]/a

Set 5Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[${item label}]/a

Set 5Ghz Channel ID
    [Arguments]    ${ChannelID}
    IF  '${ChannelID}' == 'Auto'
        ${ChannelID_ID}  Set Variable  1
    ELSE IF  '${ChannelID}' == '36'
        ${ChannelID_ID}  Set Variable  2
    ELSE IF  '${ChannelID}' == '40'
        ${ChannelID_ID}  Set Variable  3        
    ELSE IF  '${ChannelID}' == '44'
        ${ChannelID_ID}  Set Variable  4
    ELSE IF  '${ChannelID}' == '48'
        ${ChannelID_ID}  Set Variable  5        
    ELSE IF  '${ChannelID}' == '52'
        ${ChannelID_ID}  Set Variable  6
    ELSE IF  '${ChannelID}' == '56'
        ${ChannelID_ID}  Set Variable  7        
    ELSE IF  '${ChannelID}' == '60'
        ${ChannelID_ID}  Set Variable  8
    ELSE IF  '${ChannelID}' == '64'
        ${ChannelID_ID}  Set Variable  9
    ELSE IF  '${ChannelID}' == '100'
        ${ChannelID_ID}  Set Variable  10
    ELSE IF  '${ChannelID}' == '104'
        ${ChannelID_ID}  Set Variable  11        
    ELSE IF  '${ChannelID}' == '108'
        ${ChannelID_ID}  Set Variable  12
    ELSE IF '${ChannelID}' == '112'
        ${ChannelID_ID}  Set Variable  13       
    ELSE IF  '${ChannelID}' == '116'
        ${ChannelID_ID}  Set Variable  14
    ELSE IF  '${ChannelID}' == '120'
        ${ChannelID_ID}  Set Variable  15       
    ELSE IF  '${ChannelID}' == '124'
        ${ChannelID_ID}  Set Variable  16
    ELSE IF  '${ChannelID}' == '128'
        ${ChannelID_ID}  Set Variable  17
    ELSE IF  '${ChannelID}' == '132'
        ${ChannelID_ID}  Set Variable  18
    ELSE IF  '${ChannelID}' == '136'
        ${ChannelID_ID}  Set Variable  19
    ELSE IF  '${ChannelID}' == '140'
        ${ChannelID_ID}  Set Variable  20
    END
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[${ChannelID_ID}]/a


Get 2.4Ghz Bandwith
    ${current_2.4GHz_Bandwith}=  Get Text  ${2.4GHz_Bandwith}
    log  ${current_2.4GHz_Bandwith} is Current 2.4GHz Bandwith
    [return]  ${current_2.4GHz_Bandwith}


Set 2.4Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[3]/td[2]/div/ul/li[${item label}]/a

Set 2.4Ghz Bandwith
    [Arguments]    ${Bandwith}
    IF  '${Bandwith}' == '20MHz'
        ${Bandwith_ID}  Set Variable  1
    ELSE IF  '${Bandwith}' == '20/40MHz'
        ${Bandwith_ID}  Set Variable  2
    ELSE IF  '${Bandwith}' == '40MHz'
        ${Bandwith_ID}  Set Variable  3    
    END
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[3]/td[2]/div/ul/li[${Bandwith_ID}]/a


Get 5Ghz Bandwith
    ${current_5GHz_Bandwith}=  Get Text  ${5GHz_Bandwith}
    log  ${current_5GHz_Bandwith} is Current 5GHz Bandwith
    [return]  ${current_5GHz_Bandwith}



Set 5Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[4]/td[2]/div/ul/li[${item label}]/a

Set 5Ghz Bandwith
    [Arguments]    ${Bandwith}
    IF  '${Bandwith}' == '20MHz'
        ${Bandwith_ID}  Set Variable  1
    ELSE IF  '${Bandwith}' == '20/40MHz'
        ${Bandwith_ID}  Set Variable  2
    ELSE IF  '${Bandwith}' == '20/40/80MHz'
        ${Bandwith_ID}  Set Variable  3      
    ELSE IF  '${Bandwith}' == '160MHz'
        ${Bandwith_ID}  Set Variable  4    
    END
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[4]/td[2]/div/ul/li[${Bandwith_ID}]/a


Set 2.4Ghz Channel ID to Auto and Bandwith to Default
    Login to DUT
    Go to Settings Page
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_24ghz']//li[1]/a
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[3]/td[2]/div/ul/li[1]/a
    Save the WiFi setting
    Logout from DUT


Set 2.4Ghz Channel ID to Auto
    Login to DUT
    Go to Settings Page
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_24ghz']//li[1]/a
    Save the WiFi setting
    Logout from DUT

Set 5Ghz Channel ID to Auto
    Login to DUT
    Go to Settings Page
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[1]/a
    Save the WiFi setting
    Logout from DUT

Set 5Ghz Channel ID to Auto and Bandwith to Default
    Login to DUT
    Go to Settings Page
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //tr[@id='wireless_5ghz']//li[1]/a
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //table[3]/tbody/tr[4]/td[2]/div/ul/li[3]/a
    Save the WiFi setting
    Logout from DUT

Save the WiFi setting
    click element  ${WLAN_save_setting}
    sleep  2s
    Click element  ${WLAN_save_setting_Popup}
    sleep  2s
    Run Keyword And Ignore Error  Handle WiFi GuestNetwork Popup
    sleep  20s

Handle WiFi GuestNetwork Popup
    Click element  ${WLAN_save_setting_Popup}

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

Set WPS
    [Arguments]    ${WPS}
    IF  '${WPS}' == '1'
       Set the WPS Enable
    ELSE
       Set the WPS Disable
    END
    
Set the WPS Enable
    ${WPS_Status}=  Get WPS Status
    # ${status}=    Get Regexp Matches    ${WPS_Status}   arcTransformChecked
    IF  ${WPS_Status}
        log   WPS is already enabled
    ELSE
        Enable WPS
    END

Set the WPS Disable
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

Set Compatibility Mode Status
    [Arguments]    ${Compatibility}
    IF  '${Compatibility}' == '1'
       Set the Compatibility Enable
    ELSE
       Set the Compatibility Disable
    END
    

Set the Compatibility Enable
    click element  ${Compatibility_Mode_dropdown}
    click element  //table[3]/tbody/tr[8]/td[2]/div/ul/li[1]


Set the Compatibility Disable
    click element  ${Compatibility_Mode_dropdown}
    click element  //table[3]/tbody/tr[8]/td[2]/div/ul/li[2]

