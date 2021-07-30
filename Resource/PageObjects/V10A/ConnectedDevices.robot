*** Variables ***
${Connected_Devices}  //a[normalize-space()='Connected Devices']
${Device_Mac_Address}  	//tr[1]/td/table/tbody/tr/td/table/tbody/tr[2]/td[3]
${Device_Mac_Address_5G}  //td[normalize-space()='5G RE']//preceding::td[1]  
${Device_Mac_Address_24G}  //td[normalize-space()='2.4G']//preceding::td[1]  
# ${Device_Mac_Address_LAN}  //td[normalize-space()='LAN']//preceding::td[1]  
# # ${Device_Mac_Address_LAN}  //td[normalize-space()='LAPTOP']//preceding::td[1]  
# ${Device_Mac_Address_LAN}  //td[normalize-space()='LAPTOP*']//following::td[2]


*** Keywords ***
Go to Connected Devices Page
    Click element  ${Connected_Devices}
    select frame  id:frm_main2
    wait until page contains  	Manage Internet Access

Get the MAC Address from Connected Devices list
    ${Mac_Address}=  Get Text   ${Device_Mac_Address}
    log  ${Mac_Address} is MAC Address connected to devices
    [return]  ${Mac_Address}

# Get the MAC Address of WiFi Connected Devices list
#     # ${Mac_Address}=  Get Text   ${Device_Mac_Address_5G}
#     log  ${Mac_Address} is MAC Address connected to devices
#     [return]  ${Mac_Address}

Get the MAC Address of WiFi Connected Devices list
    ${Mac_Address}=       Create List
    @{Mac_Address_WebElement5Ghz}=  Get WebElements   ${Device_Mac_Address_5G}
    @{Mac_Address_WebElement24Ghz}=  Get WebElements   ${Device_Mac_Address_24G}
    @{Mac_Address_WebElement}=  Combine Lists  ${Mac_Address_WebElement5Ghz}  ${Mac_Address_WebElement24Ghz}
    FOR  ${Mac_list}  IN   @{Mac_Address_WebElement}
        ${Mac_add}=  Get Text  ${Mac_list}
        log  MAC element from list ${Mac_add}
        Append To List  ${Mac_Address}  ${Mac_add}
    END
    ${Connected_Devices_Mac_Address_GUI}=  Change the MAC Address type  ${Mac_Address}
    [return]  ${Connected_Devices_Mac_Address_GUI}
    
Get the MAC Address of LAN Connected Devices list
    ${hostname}=  Set Variable    hostname
    ${hostname_Laptop}=  Run Process  C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe  ${hostname}  shell=True
    ${Mac_Address}=       Create List
    ${Device_Mac_Address_LAN}=  Set Variable  //td[normalize-space()='${hostname_Laptop.stdout}']//following::td[2]  
    @{Mac_Address_WebElement}=  Get WebElements   ${Device_Mac_Address_LAN}
    FOR  ${Mac_list}  IN   @{Mac_Address_WebElement}
        ${Mac_add}=  Get Text  ${Mac_list}
        Append To List  ${Mac_Address}  ${Mac_add}
    END
    ${LAN_Connected_Devices_Mac_Address_GUI}=  Change the MAC Address type  ${Mac_Address}
    [return]  ${LAN_Connected_Devices_Mac_Address_GUI}