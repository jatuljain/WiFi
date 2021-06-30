*** Variables ***
${Connected_Devices}  //div[contains(text(),'My Devices')]
${Device_Mac_Address_5G}  //td[normalize-space()='5GHz']//preceding-sibling::td[2]  
${Device_Mac_Address_LAN}  //td[normalize-space()='LAN']//preceding-sibling::td[2]  



*** Keywords ***
Go to Connected Devices Page
    unselect frame  
    select frame  name:leftFrame
    Click element  ${Connected_Devices}
    unselect frame 
    select frame  id:frm_main2
    wait until page contains  	SWP2



Get the MAC Address of WiFi Connected Devices list
    ${Mac_Address}=       Create List
    @{Mac_Address_WebElement}=  Get WebElements   ${Device_Mac_Address_5G}
    FOR  ${Mac_list}  IN   @{Mac_Address_WebElement}
        ${Mac_add}=  Get Text  ${Mac_list}
        log  MAC element from list ${Mac_add}
        Append To List  ${Mac_Address}  ${Mac_add}
    END
    log  ${Mac_Address} is MAC Address connected to devices
    [return]  ${Mac_Address}