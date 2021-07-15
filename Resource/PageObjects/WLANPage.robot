*** Settings ***
# Library  SeleniumLibrary
Library  Screenshot  screenshot_module | pillow 

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
${WPS_Check}=  //tbody/tr[13]/td[2]/span[1]/a

${Authentication_ID}  


${Cancel_Button}  cancel

*** Keywords ***
Go to WLAN Page
    unselect frame
    Click Element  ${WLAN_Tab}
    sleep  5s
    wait until page contains  Access Points
    select frame  id:frm_main2
    current frame should contain  ${wlan_page}
    # wait until page contains  ${wlan_page}  10s


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


Get the 2.4Ghz channel id from GUI
    current frame should contain  Channel
    ${current_2.4Ghz_Channel}=  Get selected list value  ${2.4Ghz_Channel}
    log  ${current_2.4Ghz_Channel} is Current 2.4Ghz channel
    [return]  ${current_2.4Ghz_Channel}


Get the 5Ghz channel id from GUI
    current frame should contain  Channel
    ${current_5Ghz_Channel}=  Get selected list value  ${5Ghz_Channel}
    log  ${current_5Ghz_Channel} is Current 5Ghz channel
    [return]  ${current_5Ghz_Channel}

  
Get the wifi Password
    ${current_ssid_password} =  get element attribute  ${ssid_password_2.4G}  value
    log  ${current_ssid_password} is Current ssid Password
    [return]  ${current_ssid_password}

Set the wifi Password
    [Arguments]   ${ssid_password}  
    Input Text  ${ssid_password_2.4G}  ${ssid_password}


Set the 2.4Ghz Channel ID to 1
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  ${2.4Ghz_ChannelID_Value}
    click element  ${WLAN_save_setting}
    sleep  10s


Set 2.4Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[${item label}]/a



Set 5Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${5Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[2]/ul/li[${item label}]/a

    
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
    log  ${WPS_Check_Status} is Current WPS Status
    [return]  ${WPS_Check_Status}


Set the WPS
    [Arguments]    ${WPS}
    IF  '${WPS}' == 'arcTransformChecked'
       Set the WPS ON
    ELSE
       Set the WPS OFF
    END
    
Set the WPS ON
    ${WPS_Status}=  Get WPS Status
    ${status}=    Get Regexp Matches    ${WPS_Status}   arcTransformChecked
    IF  ${status}
        log   WPS is already enabled
    ELSE
        Enable WPS
    END

Set the WPS OFF
    ${WPS_Status}=  Get WPS Status
    ${status}=    Get Regexp Matches    ${WPS_Status}   arcTransformChecked
    IF  ${status}
        Disable WPS
    ELSE
        log   WPS is already Disabled
    END

Enable WPS
    click Element  ${WPS_Check}

Disable WPS
    click Element  ${WPS_Check}


Save the WiFi setting
    wait until page contains  Save settings  60s
    click element  ${WLAN_save_setting}
    Run Keyword And Ignore Error  Handle Alert
    sleep  10s
    # Wait Until Page Does Not Contain  Waiting for WLAN synchronization  80s
    # wait until Element Is Not Visible  Save settings  65s
    wait until Element Is Visible  ${Cancel_Button}  65s
    sleep  2s

Enable SSID Broadcast
    click element  ${SSID_Broadcast_Visible_on}

Disable SSID Broadcast
    click Element  ${SSID_Broadcast_Visible_off}
