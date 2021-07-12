*** Variables ***
${menu_right}  //div[@class='menu_right']
${Reboot_Tab}  //a[normalize-space()='Reboot']
${Reboot_Content}  REBOOT ROUTER
${Reboot_Router}   //tbody/tr[2]/td/div[1]/a/span[2]




*** Keywords ***

Go to Reboot Page
    unselect frame
    Click Element  ${menu_right}
    sleep  2s
    Click Element  ${Reboot_Tab}
    # sleep  5s
    select frame  id:frm_main2
    wait until page contains  ${Reboot_Content}

    
Reboot the DUT
    click element  ${Reboot_Router}
    Run Keyword And Ignore Error   Handle Alert
    Run Keyword And Ignore Error   Handle Alert
    sleep  120s

