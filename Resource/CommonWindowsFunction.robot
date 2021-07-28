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
${WiFi_LAN_MAC_cmd}  ipconfig /all | Select-String -Pattern "Wireless LAN adapter Wi-Fi" -Context 1,10
${LAN_MAC_cmd}  ipconfig /all | Select-String -Pattern "Ethernet adapter Ethernet" -Context 1,10
# ${LAN_MAC_cmd}  ipconfig /all | Select-String -Pattern "Ethernet adapter Ethernet" -Context 1,10   |  findstr "Physical"
# ${profile_name}  Wi-Fi-AtulJain.xml
# ${profile_name}  Wi-Fi-${SSID}.xml
# ${export_profile_cmd}  netsh wlan export profile name="${profile_name}"
# ${add_profile_cmd}  netsh wlan add profile filename=\"WiFiProfile\\${profile_name}"

# ${WiFi_Count_BSSID}   netsh wlan show all | Select-String -Pattern "TC-6" -Context 1,65

*** Keywords ***
Disable the WiFi Adaptor
    ${disable_result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${disable_WiFi_Adaptor_cmd}  shell=True
    log  ${disable_result.stdout}
    log  ${disable_result.stderr}

Enable the WiFi Adaptor
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${enable_WiFi_Adaptor_cmd}  shell=True


Fetch the Channel IDs from Windows Analyser
    [Arguments]    ${SSID}
    ${cmd}=  Set Variable   netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,65
    # Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True  stdout=${TEMPDIR}/stdout.txt
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz}
    [return]  ${Analyser_ChannelID_5Ghz}

Fetch the 2.4GHz Channel IDs from Windows Analyser
    [Arguments]    ${SSID}
    ${cmd}=  Set Variable   netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,65
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True  stdout=${TEMPDIR}/stdout.txt
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


Get IP from console for WiFi Interface
    FOR  ${VAR}  IN RANGE    3
        ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${WiFi_LAN_MAC_cmd}  shell=True
        log  ${result.stdout}
        ${WiFi_LAN_IP_cmd}=  String.get regexp matches  ${result.stdout}  IPv4 Address.*: ([0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}).*\n  1
      EXIT For Loop If  ${WiFi_LAN_IP_cmd} != []
      sleep  10s
    END
    [return]  ${WiFi_LAN_IP_cmd}[0] 
    

Ping to Gateway
    ${WiFi_Client_IP}=  Get IP from console for WiFi Interface  
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${ping_gateway} -S ${WiFi_Client_IP}  shell=True
    log  ${result.stdout}
    [return]  ${result.stdout} 


#This function will get the MAC address of WiFi connected LAN device
Get the MAC address for Wi-Fi LAN devices from Windows
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${WiFi_LAN_MAC_cmd}  shell=True
    log  ${result.stdout}
    @{WiFi_LAN_MAC_cmd}=  String.get regexp matches  ${result.stdout}  Physical Address.*: (.*)\n  1
    [return]  ${WiFi_LAN_MAC_cmd}[-1] 


Get the MAC address for LAN devices from Windows
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${LAN_MAC_cmd}  shell=True
    log  ${result.stdout}
    @{LAN_MAC_cmd}=  String.get regexp matches  ${result.stdout}  Physical Address.*: (.*)\n  1
    [return]  ${LAN_MAC_cmd} 


# Pass the list of MAC address and change it from : tp -
Change the MAC Address type
    [Arguments]    ${MAC_GUI}
    ${Updated_Mac_List}=  Create List 
    FOR  ${MAC}  IN  @{MAC_GUI}
        ${Updated_MAC_GUI} =	Replace String Using Regexp	 ${MAC}  :  -
        log  Updated MAC is ${Updated_MAC_GUI}
        Append To List	${Updated_Mac_List}  ${Updated_MAC_GUI}
    END
    [return]  ${Updated_Mac_List}

Check SSID Broadcast
    [Arguments]    ${SSID}
    ${Broadcast_SSID}=  Set Variable    netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,16
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${Broadcast_SSID}  shell=True
    log  ${result.stdout}
    [Return]  ${result.stdout}




# This function will fetch all the BSSID broadcasting for a particular SSID and returns all the MAC address for the BSSID broadcasting
Fetch BSSID Broadcast
    [Arguments]    ${SSID}
    ${Broadcast_SSID}=  Set Variable    netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,65
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${Broadcast_SSID}  shell=True  stdout=${TEMPDIR}/stdout.txt
    log  ${result.stdout}
    ${output}=  Replace String Using Regexp  ${result.stdout}  \n  \t
    log   ${output}
    ${ssid}=  Get Regexp Matches  ${output}   (${SSID}.*?) SSID   1
    log  ${ssid}
    ${ssid}=    Catenate    @{ssid} 
    ${total_bssid}=  Get Regexp Matches   ${ssid}  ([0-9a-fA-F]:?){12}  
    [Return]  ${total_bssid}


Assign static IP to WiFi client
    [Arguments]    ${IP}  ${Mask}  ${Gateway} 
    ${Static_IP}=  Set Variable   netsh interface ip set address name= "Wi-Fi" static ${IP} ${Mask} ${Gateway} 
    ${result}=  Run Process   C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${Static_IP}  shell=True  stdout=${TEMPDIR}/stdout.txt
    sleep  1s

Assign dhcp IP to WiFi client
    ${dhcp_IP}=  Set Variable   netsh interface ip set address name= "Wi-Fi" dhcp
    ${result}=  Run Process   C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${dhcp_IP}  shell=True  stdout=${TEMPDIR}/stdout.txt
    sleep  1s


Get first three octet from IP
    [Arguments]    ${IP}
    @{octect} =	Split String	${IP}	.
    ${firstthreeoctat_IP}=  Catenate   SEPARATOR=.  ${octect}[0]  ${octect}[1]   ${octect}[2]
    [return]  ${firstthreeoctat_IP}