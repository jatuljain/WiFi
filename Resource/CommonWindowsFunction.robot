*** Settings ***
Library           Process
Library    Collections
Library  String

*** Variables ***
${cmd}  netsh wlan show network mode=bssid | Select-String -Pattern "jacques" -Context 1,16



*** Test Cases ***
Example
    # Execute Command  powershell.exe  "netsh wlan show network mode=\"bssid\" | Select-String -Pattern "jacques" -Context 1,16"
    # ${result}=  Start Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe ${cmd}  shell=True
    # ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    ${result}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${cmd}  shell=True
    log  ${result.stdout}
    ${Analyser_ChannelID_5Ghz}=  String.get regexp matches  ${result.stdout}  = Channel.*: (\\d+)  1
    log  Analyser 5Ghz Channel ID is ${Analyser_ChannelID_5Ghz}
    # [return]  ${result_5Ghz[0]}
    # close all connection
    