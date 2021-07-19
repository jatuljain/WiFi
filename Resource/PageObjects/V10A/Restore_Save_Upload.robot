*** Variables ***
${menu_right}  //div[@class='menu_right']
${Restore_Save_Upload_Setting_Tab}  //a[normalize-space()='Restore/Save/Upload Setting']
${Restore_Content}  Restore to Factory Defaults
${RestoreTOFactoryDefault_Router}   //span[normalize-space()='Restore to Factory Defaults']


*** Keywords ***

Go to Restore Save Upload Setting Page
    unselect frame
    # Click Element  ${menu_right}
    # sleep  2s
    Click Element  ${Restore_Save_Upload_Setting_Tab}
    # sleep  5s
    select frame  id:frm_main2
    wait until page contains  ${Restore_Content}  10s

    
Factory Reset the DUT
    click element  ${RestoreTOFactoryDefault_Router}
    Run Keyword And Ignore Error   Handle Alert
    Run Keyword And Ignore Error   Handle Alert
    sleep  90s

