*** Variables ***
${System_Tab}  //div[@id='id_nav_2']
${Restart}  Restart
${System_Information}  System Information
${Restart_Button}  //tbody/tr/td[2]/div/a/span[2]
${RestoreToFactoryDefault_Button}  //tr[2]/td/form/table[2]/tbody/tr/td/div/a/span[2]
# ${Restart_And_FacrotyRecovery_Tab}  //tr[5]/td/table/tbody/tr/td/a/div/div[1]
${Restart_And_FacrotyRecovery_Tab}  //div[contains(text(),'Restart / Factory recovery')]
${Factory_Reset}   Factory Reset


***Keywords***


Reboot the DUT
    unselect frame
    select frame  id:frm_main2
    Click element  ${Restart_Button}
    Handle Alert
    Handle Alert
    Sleep  120s

Factory Reset the DUT
    unselect frame
    select frame  id:frm_main2
    Click element  ${RestoreToFactoryDefault_Button}
    Handle Alert
    Handle Alert
    Sleep  120s


Click on Restart and Factory Recovery Tab
    unselect frame
    select frame  name:leftFrame
    Click Element  ${Restart_And_FacrotyRecovery_Tab}
    unselect frame
    select frame  id:frm_main2
    wait until page contains  ${Factory_Reset}
    
