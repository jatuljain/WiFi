*** Settings ***
Library           Process
Library    Collections
Library  String

*** Variables ***
${SSID}  AtulJain
${disconnect_cmd}  netsh wlan disconnect
${cmd}  netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,16
${disable_WiFi_Adaptor_cmd}  netsh interface set interface "Wi-Fi" disable
${enable_WiFi_Adaptor_cmd}  netsh interface set interface "Wi-Fi" enable
${Connect_SSID}  netsh wlan connect name="${SSID}" ssid="${SSID}" interface="Wi-Fi"
${ping_gateway}  ping 192.168.2.254
${profile_name}  Wi-Fi-AtulJain.xml
${export_profile_cmd}  netsh wlan export profile name="${profile_name}"
${add_profile_cmd}  netsh wlan add profile filename=\"WiFiProfile\\${profile_name}"

*** Keywords ***
Disable the WiFi Adaptor
    ${disable_result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${disable_WiFi_Adaptor_cmd}  shell=True
    log  ${disable_result.stdout}
    log  ${disable_result.stderr}

Enable the WiFi Adaptor
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${enable_WiFi_Adaptor_cmd}  shell=True


Fetch the Channel IDs from Windows Analyser
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz}
    [return]  ${Analyser_ChannelID_5Ghz}

Fetch the 2.4GHz Channel IDs from Windows Analyser
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz} 
    [return]  ${Analyser_ChannelID_5Ghz} 


Export WiFi Profile
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${export_profile_cmd}  shell=True
    log  ${result.stdout}

Add WiFi Profile
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${add_profile_cmd}  shell=True
    log  ${result.stdout}

Connect to SSID
    [Arguments]    ${SSID}
    Add WiFi Profile    
    Set Variable  ${Connect_SSID}  netsh wlan connect name="${SSID}" ssid="${SSID}" interface="Wi-Fi"
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${Connect_SSID}  shell=True
    log  ${result.stdout}
    [Return]  ${result.stdout}

Ping to Gateway
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${ping_gateway}  shell=True
    log  ${result.stdout}
    [return]  ${result.stdout} 