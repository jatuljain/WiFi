*** Settings ***
Library           Process
Library    Collections
Library  String


*** Variables ***
# ${SSID}  AtulJain
${disconnect_cmd}  netsh wlan disconnect
# ${cmd}  netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,16
${disable_WiFi_Adaptor_cmd}  netsh interface set interface "Wi-Fi" disable
${enable_WiFi_Adaptor_cmd}  netsh interface set interface "Wi-Fi" enable
# ${Connect_SSID}  netsh wlan connect name="${SSID}" ssid="${SSID}" interface="Wi-Fi"
${ping_gateway}  ping 192.168.2.254
${LAN_MAC_cmd}  ipconfig /all | Select-String -Pattern "Wi-Fi" -Context 1,10
# ${profile_name}  Wi-Fi-AtulJain.xml
# ${profile_name}  Wi-Fi-${SSID}.xml
# ${export_profile_cmd}  netsh wlan export profile name="${profile_name}"
# ${add_profile_cmd}  netsh wlan add profile filename=\"WiFiProfile\\${profile_name}"

*** Keywords ***
Disable the WiFi Adaptor
    ${disable_result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${disable_WiFi_Adaptor_cmd}  shell=True
    log  ${disable_result.stdout}
    log  ${disable_result.stderr}

Enable the WiFi Adaptor
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${enable_WiFi_Adaptor_cmd}  shell=True


Fetch the Channel IDs from Windows Analyser
    [Arguments]    ${SSID}
    ${cmd}=  Set Variable   netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,16
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz}
    [return]  ${Analyser_ChannelID_5Ghz}

Fetch the 2.4GHz Channel IDs from Windows Analyser
    [Arguments]    ${SSID}
    ${cmd}=  Set Variable   netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,16
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz} 
    [return]  ${Analyser_ChannelID_5Ghz} 


Export WiFi Profile
    [Arguments]    ${SSID}
    ${profile_name}=  Set Variable  Wi-Fi-${SSID}.xml
    ${export_profile_cmd}=  Set Variable   netsh wlan export profile name="${profile_name}"
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${export_profile_cmd}  shell=True
    log  ${result.stdout}

Add WiFi Profile
    [Arguments]    ${SSID}
    ${profile_name}=  Set Variable    Wi-Fi-${SSID}.xml
    ${add_profile_cmd}=  Set Variable    netsh wlan add profile filename=\"WiFiProfile\\${profile_name}"
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${add_profile_cmd}  shell=True
    log  ${result.stdout}

Connect to SSID
    [Arguments]    ${SSID}
    Add WiFi Profile   ${SSID}
    ${Connect_SSID}=  Set Variable    netsh wlan connect name="${SSID}" ssid="${SSID}" interface="Wi-Fi"
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${Connect_SSID}  shell=True
    log  ${result.stdout}
    [Return]  ${result.stdout}

Ping to Gateway
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${ping_gateway}  shell=True
    log  ${result.stdout}
    [return]  ${result.stdout} 


Get the MAC address for Wi-Fi LAN devices from Windows
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${LAN_MAC_cmd}  shell=True
    log  ${result.stdout}
    @{LAN_MAC_cmd}=  String.get regexp matches  ${result.stdout}  Physical Address.*: (.*)\n  1
    # ${Updated_Mac} =	Replace String Using Regexp	 ${LAN_MAC_cmd}  :  -
    ${Updated_Mac}=  Create List 
    FOR  ${MAC}  IN  @{LAN_MAC_cmd}
        # ${MAC_type}  Evaluate    type(${MAC})
        # log  type is ${MAC_type}
        ${Updated_MAC_Val} =	Replace String Using Regexp	 ${MAC}  :  -
        log  Updated MAC is ${Updated_MAC_Val}
        Append To List	${Updated_Mac}  ${Updated_MAC_Val}
    END
    [return]  ${Updated_Mac} 


# Pass the list of MAC address and change it
Change the MAC Address type
    [Arguments]    ${MAC_GUI}
    ${Updated_Mac_List}=  Create List 
    FOR  ${MAC}  IN  @{MAC_GUI}
        ${Updated_MAC_GUI} =	Replace String Using Regexp	 ${MAC}  :  -
        log  Updated MAC is ${Updated_MAC_GUI}
        Append To List	${Updated_Mac_List}  ${Updated_MAC_GUI}
    END
    [return]  ${Updated_Mac_List}
