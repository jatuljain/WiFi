*** Settings ***
Library			Telnet
Library    Collections
Library  String



*** Keywords ***
Telnet to DUT Console
    Open Connection  192.168.2.254	prompt_is_regexp=yes  prompt=#
    Login  ls  date  login_prompt=#  password_prompt=#
    # Execute Command	 ls

Get the 2.4Ghz channel id from console
    ${out}=  Execute Command  cat /etc/config/.glbcfg |grep 24G_Channel=
    log  ${out}
    ${result}=  String.get regexp matches  ${out}  =(\\d+)  1
    log  2.4Ghz Channel ID from console is ${result[0]}
    [return]  ${result[0]}


Get the 5Ghz channel id from console
    ${out_5Ghz}=  Execute Command  cat /etc/config/.glbcfg |grep 5G_Channel=
    log  ${out_5Ghz}
    ${result_5Ghz}=  String.get regexp matches  ${out_5Ghz}  =(\\d+)  1
    log  5Ghz Channel ID from console is ${result_5Ghz[0]}
    [return]  ${result_5Ghz[0]}
    
Get the SSID from console
    ${ssid_console}=  Execute Command  cat /etc/config/.glbcfg |grep ARC_WLAN_24G_SSID_0_ESSID
    log  ${ssid_console}
    ${result_ssid}=  String.get regexp matches  ${ssid_console}  =(.*)  1
    
    log  SSID from console is ${result_ssid[0]}
    [return]  ${result_ssid[0]}
    
Get the SSID Password from console
    ${ssid_Password_console}=  Execute Command  cat /etc/config/.glbcfg |grep ARC_WLAN_5G_SSID_0_WPA_Passphrase
    log  ${ssid_Password_console}
    ${result_ssid}=  String.get regexp matches  ${ssid_Password_console}  =(.*)  1
    
    log  SSID Password from console is ${result_ssid[0]}
    [return]  ${result_ssid[0]}  


Get the UPnP Status from console
    ${UPnP_console}=  Execute Command  cat /etc/config/.glbcfg |grep ARC_UPNP_Enable
    log  ${UPnP_console}
    ${result_upnp}=  String.get regexp matches  ${UPnP_console}  =(.*)  1
    ${result_upnp[0]}  Strip String  ${result_upnp[0]} 
    log  UPnP status from console is ${result_upnp[0]}
    [return]  ${result_upnp[0]}