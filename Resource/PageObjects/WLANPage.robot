*** Settings ***
Library  SeleniumLibrary
Library  Screenshot  screenshot_module | pillow 

*** Variables ***
${WLAN_Tab}  //a[normalize-space()='WLAN']
${2.4Ghz_Channel}  //select[@name='wchan_24g_both']
${2.4Ghz_ChannelID_dropdown}  //tbody/tr[@id='tr_wchan_both']/td[@class='tdText']/div[1]
${WLAN_save_setting}  //*[@id="save"]/span[2]
${2.4Ghz_ChannelID_Value}  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[2]/a
# ${2.4Ghz_ChannelID_Value}  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[2]/a
${WPA Encryption}  //select[@id='cypher_suite_24g']
${5Ghz_Channel}  //select[@name='wchan_5g_both']
${wlan_page}  Restore WiFi Defaults
${ssid_name_2.4G}  wl_ssid_24g
${ssid_password_2.4G}  sharedkey_24g


*** Keywords ***
Go to WLAN Page
    Click Element  ${WLAN_Tab}
    sleep  5s
    wait until page contains  Access Points
    select frame  id:frm_main2
    current frame should contain  ${wlan_page}
    # wait until page contains  ${wlan_page}  10s

Get the 2.4Ghz channel id from GUI
    current frame should contain  Channel
    ${current_2.4Ghz_Channel}=  Get selected list value  ${2.4Ghz_Channel}
    log  ${current_2.4Ghz_Channel} is Current 2.4Ghz channel
    [return]  ${current_2.4Ghz_Channel}


Get the 5Ghz channel id from GUi
    current frame should contain  Channel
    ${current_5Ghz_Channel}=  Get selected list value  ${5Ghz_Channel}
    log  ${current_5Ghz_Channel} is Current 5Ghz channel
    [return]  ${current_5Ghz_Channel}

Get the SSID name
    current frame should contain  Channel
    ${current_ssid}  get element attribute  ${ssid_name_2.4G}  value
    log  ${current_ssid} is Current ssid
    
Get the wifi Password
    ${current_ssid_password} =  get element attribute  ${ssid_password_2.4G}  value
    log  ${current_ssid_password} is Current ssid Password

Set the 2.4Ghz Channel ID to 1
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  ${2.4Ghz_ChannelID_Value}
    click element  ${WLAN_save_setting}
    sleep  10s


Set the 2.4Ghz Channel ID with value
    [Arguments]    ${item label}
    click element  ${2.4Ghz_ChannelID_dropdown}
    click element  //*[@id="tr_wchan_both"]/td[2]/div[1]/ul/li[${item label}]/a
    click element  ${WLAN_save_setting}
    Capture page screenshot  ChannelID_${item label}.png
    # take screenshot  ChannelID_${item label}.jpg
    sleep  15s
    