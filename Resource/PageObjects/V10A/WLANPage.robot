*** Settings ***
Library  Screenshot  screenshot_module | pillow
Library    String


*** Variables ***
${WLAN_Tab}  //a[normalize-space()='WLAN']
${2.4Ghz_Channel}  //select[@name='wchan_24g_both']
${Authentication_Method}  //select[@name='security_type_24g']
${Authentication_dropdown}  //tbody/tr[1]/td/table[2]/tbody/tr[5]/td[2]/div
${2.4Ghz_ChannelID_dropdown}  //tbody/tr[@id='tr_wchan_both']/td[@class='tdText']/div[1]
${5Ghz_ChannelID_dropdown}  //tbody/tr[@id='tr_wchan_both']/td[@class='tdText']/div[2]
${2.4Ghz_Bandwidth_dropdown}  //tbody/tr[@id='tr_bandwidth_both']/td[@class='tdText']/div[1]
${5Ghz_Bandwidth_dropdown}  //tbody/tr[@id='tr_bandwidth_both']/td[@class='tdText']/div[2]
${WLAN_save_setting}  //*[@id="save"]/span[2]
${2.4Ghz_ChannelID_Value}  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[2]/a
# ${2.4Ghz_ChannelID_Value}  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[2]/a
${WPA_Encryption}  //select[@id='cypher_suite_24g']
${WPA_Encryption_dropdown}  //tbody/tr[6]/td[2]/div
                    # //select[@name='cypher_suite_24g']
${WPA_Encryption_AES}  //tbody/tr[6]/td[2]/div/ul/li/a
${5Ghz_Channel}  //select[@name='wchan_5g_both']
${wlan_page}  Restore WiFi Defaults
${ssid_name_2.4G}  wl_ssid_24g
${ssid_password_2.4G}  sharedkey_24g

${SSID_Broadcast_Visible_on}  //tbody/tr[3]/td[2]/div
# ${SSID_Broadcast_Visible_off}  .switch_button_24g.switch_off
${SSID_Broadcast_Visible_off}   //tbody/tr[3]/td[2]/div
${ENABLE_WIFI}=  ENABLE_WIFI
${IGMP_Snooping_ToggelButton}=  //tbody/tr[12]/td[2]/div
${WPS_Check}=  //tbody/tr[14]/td[2]/span[1]/a
# ${WPS_Check}=  //input[@id='wps_enable_24g']

${Authentication_ID}  
# ${24Ghz_Mode}  //select[@name='wchan_24g']
${24Ghz_Mode}  //table[2]/tbody/tr[9]/td[2]/div[1]/div/span
${5Ghz_Mode}  //table[2]/tbody/tr[9]/td[2]/div[2]/div/span
${2.4Ghz_Mode_dropdown}  //tbody/tr[@id='tr_wmode_both']/td[@class='tdText']/div[1]
${5Ghz_Mode_dropdown}  //tbody/tr[@id='tr_wmode_both']/td[@class='tdText']/div[2]


${Cancel_Button}  cancel


# ${24Ghz_Bandwith}  //select[@name='bandwidth_24g'] 
# ${5Ghz_Bandwith}  //select[@name='bandwidth_5g_both'] 


${24Ghz_Bandwith}  //tbody/tr[12]/td[2]/div[1]/div/span 
${5Ghz_Bandwith}  //tbody/tr[12]/td[2]/div[2]/div/span 
${2.4Ghz_Channel_Value}  //tbody/tr[10]/td[2]/div[1]/div/span
${5Ghz_Channel_Value}  //tbody/tr[10]/td[2]/div[2]/div/span


*** Keywords ***
Go to WLAN Page
    unselect frame
    Click Element  ${WLAN_Tab}
    sleep  5s
    wait until page contains  Access Points
    select frame  id:frm_main2
    # current frame should contain  ${wlan_page}
    # wait until page contains  ${wlan_page}  10s
    wait until Element Is Visible  ${ssid_name_2.4G}  60s



Get the SSID name
    current frame should contain  Channel
    ${current_ssid}  get element attribute  ${ssid_name_2.4G}  value
    log  ${current_ssid} is Current ssid
    [return]  ${current_ssid}

Set the SSID name
    [Arguments]    ${ssid}
    Input Text  ${ssid_name_2.4G}  ${ssid}


Get the Authentication Method  ## To get Security Mode
    current frame should contain  Channel
    ${current_Authentication_Method}=  Get selected list value  ${Authentication_Method}
    log  ${current_Authentication_Method} is Current Authentication_Method
    [return]  ${current_Authentication_Method}

Set the Authentication Method
    [Arguments]    ${Authentication}
    IF  '${Authentication}' == 'wpa2'
        ${Authentication_ID}  Set Variable  0
    ELSE
        ${Authentication_ID}  Set Variable  1
    END
    click element  ${Authentication_dropdown}
    # click element  //tbody/tr[5]/td[2]/div/ul/li[${Authentication_ID}]/a
    click element  //table[2]/tbody/tr[5]/td[2]/div/ul/li/a
    


Get 2.4GHz Mode
    ${current_24Ghz_Mode}=  Get Text  ${24Ghz_Mode}
    # ${current_24Ghz_Mode}=  Get selected list Label  ${24Ghz_Mode}
    log  ${current_24Ghz_Mode} is Current Wireless Method
    [return]  ${current_24Ghz_Mode}

Get 5GHz Mode  
    # ${current_5Ghz_Mode}=  Get selected list value  ${5Ghz_Mode}
    ${current_5Ghz_Mode}=  Get Text  ${5Ghz_Mode}
    log  ${current_5Ghz_Mode} is Current Wireless Method
    [return]  ${current_5Ghz_Mode}


Get 2.4GHz Bandwith
    # ${current_24Ghz_Bandwith}=  Get selected list value  ${24Ghz_Bandwith}
    ${current_24Ghz_Bandwith}=  Get Text  ${24Ghz_Bandwith}
    log  ${current_24Ghz_Bandwith} is Current 2.4Ghz Bandwith 
    [return]  ${current_24Ghz_Bandwith}


Get 5GHz Bandwith
    # ${current_5Ghz_Bandwith}=  Get selected list value  ${5Ghz_Bandwith}
    ${current_5Ghz_Bandwith}=  Get Text  ${5Ghz_Bandwith}
    log  ${current_5Ghz_Bandwith} is Current 5Ghz Bandwith 
    [return]  ${current_5Ghz_Bandwith}
     



Get the Encryption Type
    ${current_WPA_Encryption}=  Get selected list value  ${WPA_Encryption}
    log  ${current_WPA_Encryption} is Current WPA Encryption
    [return]  ${current_WPA_Encryption}

Set the Encryption Type
    [Arguments]    ${WPA_Encryption}
    click element  ${WPA_Encryption_dropdown}
    click element  ${WPA_Encryption_AES}


Get the 2.4Ghz channel id from GUI
    current frame should contain  Channel
    # ${current_2.4Ghz_Channel}=  Get selected list value  ${2.4Ghz_Channel}
    ${current_2.4Ghz_Channel}=  Get Text  ${2.4Ghz_Channel_Value}
    [return]  ${current_2.4Ghz_Channel}


Get the 5Ghz channel id from GUI
    current frame should contain  Channel
    # ${current_5Ghz_Channel}=  Get selected list value  ${5Ghz_Channel_Value}
    ${current_5Ghz_Channel}=  Get Text  ${5Ghz_Channel_Value}
    [return]  ${current_5Ghz_Channel}

  
Get the wifi Password
    ${current_ssid_password} =  get element attribute  ${ssid_password_2.4G}  value
    [return]  ${current_ssid_password}

Set the wifi Password
    [Arguments]   ${ssid_password}  
    Input Text  ${ssid_password_2.4G}  ${ssid_password}


Set the 2.4Ghz Channel ID to 1
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  ${2.4Ghz_ChannelID_Value}
    click element  ${WLAN_save_setting}
    sleep  10s


Set 2.4Ghz Mode
    [Arguments]    ${Mode}
    IF  '${Mode}' == 'b/g'
        ${Mode_ID}  Set Variable  1
    ELSE IF  '${Mode}' == 'b/g/n'
        ${Mode_ID}  Set Variable  2
    ELSE IF  '${Mode}' == 'n'
        ${Mode_ID}  Set Variable  3    
    END
    click element  ${2.4Ghz_Mode_dropdown}
    click element  //*[@id="tr_wmode_both"]/td[2]/div[1]/ul/li[${Mode_ID}]/a

Set 5Ghz Mode
    [Arguments]    ${Mode}
    IF  '${Mode}' == 'a/n'
        ${Mode_ID}  Set Variable  1
    ELSE IF  '${Mode}' == 'a/n/ac'
        ${Mode_ID}  Set Variable  2
    END
    click element  ${5Ghz_Mode_dropdown}
    click element  //*[@id="tr_wmode_both"]/td[2]/div[2]/ul/li[${Mode_ID}]/a


Set 2.4Ghz Mode the value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_Mode_dropdown}
    click element  //*[@id="tr_wmode_both"]/td[2]/div[1]/ul/li[${item label}]/a



Set 5Ghz Mode the value
    [Arguments]    ${item label}
    click element  ${5Ghz_Mode_dropdown}
    click element  //*[@id="tr_wmode_both"]/td[2]/div[2]/ul/li[${item label}]/a

 
Set 2.4Ghz Channel ID
    [Arguments]    ${ChannelID}
    IF  '${ChannelID}' == 'Auto all'
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
    click element  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[${ChannelID_ID}]/a



Set 5Ghz Channel ID
    [Arguments]    ${ChannelID}
    IF  '${ChannelID}' == 'Auto all'
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
    click element  //*[@id="tr_wchan_both"]/td[2]/div[2]/ul/li[${ChannelID_ID}]/a

    
Set 2.4Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[${item label}]/a



Set 5Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[2]/ul/li[${item label}]/a

    
Set 2.4Ghz Bandwith
    [Arguments]    ${Bandwith_Value}
    IF  '${Bandwith_Value}' == '20 MHz'
        ${Bandwith_ID}  Set Variable  1
    ELSE IF  '${Bandwith_Value}' == '20/40 MHz'
        ${Bandwith_ID}  Set Variable  2
    END

    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //*[@id="tr_bandwidth_both"]/td[2]/div[1]/ul/li[${Bandwith_ID}]/a


Set 5Ghz Bandwith
    [Arguments]    ${Bandwith_Value}
    IF  '${Bandwith_Value}' == '20 MHz'
        ${Bandwith_ID}  Set Variable  1
    ELSE IF  '${Bandwith_Value}' == '20/40 MHz'
        ${Bandwith_ID}  Set Variable  2
    ELSE IF  '${Bandwith_Value}' == '20/40/80 MHz'
        ${Bandwith_ID}  Set Variable  3
    END
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //*[@id="tr_bandwidth_both"]/td[2]/div[2]/ul/li[${Bandwith_ID}]/a

Set 2.4Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //*[@id="tr_bandwidth_both"]/td[2]/div[1]/ul/li[${item label}]/a


Set 5Ghz Bandwith with value
    [Arguments]    ${item label}
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //*[@id="tr_bandwidth_both"]/td[2]/div[2]/ul/li[${item label}]/a


Set 2.4Ghz Channel ID to Auto
    Login to DUT
    Go to WLAN Page
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[1]/a
    Save the WiFi setting
    Logout from DUT

Set 5Ghz Channel ID to Auto
    Login to DUT
    Go to WLAN Page
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[2]/ul/li[1]/a
    Save the WiFi setting
    Logout from DUT


Set 2.4Ghz Channel ID to Auto and Bandwith to Default
    Login to DUT
    Go to WLAN Page
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[1]/a
    click element  ${2.4Ghz_Bandwidth_dropdown}
    click element  //*[@id="tr_bandwidth_both"]/td[2]/div[1]/ul/li[1]/a    
    Save the WiFi setting
    Logout from DUT

Set 5Ghz Channel ID to Auto and Bandwith to Default
    Login to DUT
    Go to WLAN Page
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[2]/ul/li[1]/a
    click element  ${5Ghz_Bandwidth_dropdown}
    click element  //*[@id="tr_bandwidth_both"]/td[2]/div[2]/ul/li[3]/a    
    Save the WiFi setting
    Logout from DUT


Get the IGMP Snooping Status
    ${IGMP_Snooping_Status} =  get element attribute  ${IGMP_Snooping_ToggelButton}  class
    log  ${IGMP_Snooping_Status} is Current IGMP Snooping Status
    [return]  ${IGMP_Snooping_Status}


Set the IGMP Snooping
    [Arguments]    ${igmp}
    ${status}=    Get Regexp Matches    ${igmp}   switch_on
    IF  ${status}
        Set the IGMP Snooping ON
    ELSE
        Set the IGMP Snooping OFF
    END


Set the IGMP Snooping ON
    ${IGMP_Snooping_Status}=  Get the IGMP Snooping Status
    ${status}=    Get Regexp Matches    ${IGMP_Snooping_Status}   switch_on
    IF  ${status}
        log   IGMP Snooping is already enabled
    ELSE
        Enable IGMP Snooping Status
    END


Set the IGMP Snooping OFF
    ${IGMP_Snooping_Status}=  Get the IGMP Snooping Status
    ${status}=    Get Regexp Matches    ${IGMP_Snooping_Status}   switch_off
    IF  ${status}
        log   IGMP Snooping is already Disabled
    ELSE
        Disable IGMP Snooping Status
    END

Enable IGMP Snooping Status
    click Element  ${IGMP_Snooping_ToggelButton}

Disable IGMP Snooping Status
    click Element  ${IGMP_Snooping_ToggelButton}


Get WPS Status
    ${WPS_Check_Status} =  get element attribute  ${WPS_Check}  class
    ${WPS_Check_Status}=  Convert To String  ${WPS_Check_Status}
    ${status}=  Get Regexp Matches  ${WPS_Check_Status}  arcTransformChecked
    IF  ${status}
       ${WPS_Check_Status}  Set Variable  1
    ELSE
       ${WPS_Check_Status}  Set Variable  0
    END
    [return]  ${WPS_Check_Status}

# Call Set the WPS with parameter ON or OFF
Set WPS
    [Arguments]    ${WPS}
    IF  '${WPS}' == 'ON'
       Set the WPS ON
    ELSE IF  '${WPS}' == '1'
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
    click Element  ${WPS_Check}

Disable WPS
    click Element  ${WPS_Check}


Save the WiFi setting
    # wait until page contains  Save settings  60s
    wait until Element Is Visible  ${Cancel_Button}  60s
    click element  ${WLAN_save_setting}
    Run Keyword And Ignore Error  Handle Alert
    sleep  10s
    # Wait Until Page Does Not Contain  Waiting for WLAN synchronization  80s
    # wait until Element Is Not Visible  Save settings  65s
    wait until Element Is Visible  ${Cancel_Button}  60s
    sleep  2s

Enable SSID Broadcast
    click element  ${SSID_Broadcast_Visible_on}

Disable SSID Broadcast
    click Element  ${SSID_Broadcast_Visible_off}
