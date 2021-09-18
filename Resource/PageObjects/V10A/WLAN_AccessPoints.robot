*** Settings ***
Library    Collections

*** Variables ***
${Access Points}  //a[normalize-space()='Access Points']
${serial_numbers_Locator}  //*[contains(text(), 'SWP2')]/../../../../tr[7]/td[1]
${SW2_IP_Locator}  //*[contains(text(), 'SWP2')]/../../../../tr[8]/td[1]

*** Keywords ***
Go to Access Points Page
    unselect frame
    Click Element  ${Access Points}
    sleep  5s
    select frame  id:frm_main2
    wait until page contains  Access Points


Fetch the Serial numbers from Access Point Page
    ${Serial_Numbers}=       Create List
    @{Serial_Number_WebElement}=  Get WebElements   ${serial_numbers_Locator}
    FOR  ${Serial_Number_list}  IN   @{Serial_Number_WebElement}
        ${Serial_add}=  Get Text  ${Serial_Number_list}
        log  Serial Number element from list ${Serial_add}
        Append To List  ${Serial_Numbers}  ${Serial_add}
    END
    log  ${Serial_Numbers} are Current serial number for SW2
    [return]  ${Serial_Numbers}


Fetch the IPs of SW2 from Access Point Page
    ${SW_IP}=       Create List
    @{SW_IP_WebElement}=  Get WebElements   ${SW2_IP_Locator}
    FOR  ${SW2_IP_list}  IN   @{SW_IP_WebElement}
        ${SW_IP_add}=  Get Text  ${SW2_IP_list}
        log  Serial Number element from list ${SW_IP_add}
        Append To List  ${SW_IP}  ${SW_IP_add}
    END
    log  ${SW_IP} are Current serial number for SW2
    [return]  ${SW_IP}


 