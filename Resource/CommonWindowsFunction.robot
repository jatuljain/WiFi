*** Settings ***
Library           Process
Library    Collections
Library  String

*** Variables ***
${SSID}  jacquesSW2
${disconnect_cmd}  netsh wlan disconnect
${cmd}  netsh wlan show network mode=bssid | Select-String -Pattern "${SSID}" -Context 1,16
${disable_WiFi_Adaptor_cmd}  netsh interface set interface "Wi-Fi" disable
${enable_WiFi_Adaptor_cmd}  netsh interface set interface "Wi-Fi" enable



*** Keywords ***
Disable the WiFi Adaptor
    ${disable_result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${disable_WiFi_Adaptor_cmd}  shell=True
    log  ${disable_result.stdout}
    log  ${disable_result.stderr}

Enable the WiFi Adaptor
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${enable_WiFi_Adaptor_cmd}  shell=True


Fetch the Channel IDs from Windows Analyser
    # Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${disconnect_cmd}  shell=True
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz[0]} and ${Analyser_ChannelID_5Ghz[1]}
    [return]  ${Analyser_ChannelID_5Ghz[0]}  ${Analyser_ChannelID_5Ghz[1]}
    # close all connection

Fetch the 2.4GHz Channel IDs from Windows Analyser
    # Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${disconnect_cmd}  shell=True
    Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  Channel.*: (\\d+)  1
    log  Analyser Channel IDs are ${Analyser_ChannelID_5Ghz[0]} and ${Analyser_ChannelID_5Ghz[1]}
    [return]  ${Analyser_ChannelID_5Ghz[0]}  ${Analyser_ChannelID_5Ghz[1]}
    # close all connection