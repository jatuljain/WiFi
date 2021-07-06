*** Variables ***
${System_Tab}  //div[@id='id_nav_2']
${Restart}  Restart
${System_Information}  System Information
${Restart_Button}  //tbody/tr/td[2]/div/a/span[2]
${Restart_And_FacrotyRecovery_Tab}  //tr[5]/td/table/tbody/tr/td/a/div/div[1]

***Keywords***

Go to System Page
    unselect frame  
    select frame  name:topFrame  
    click element  ${System_Tab}
    Sleep  2s
    unselect frame 
    select frame  id:frm_main2
    wait until page contains  ${System_Information}  5s


Click on Restart
    unselect frame
    select frame  id:frm_main2
    Click element  ${Restart_Button}
    Handle Alert
    Handle Alert
    Sleep  120s


Click on Restart and Factory Recovery
    unselect frame
    select frame  name:leftFrame
    Click Element  ${Restart_And_FacrotyRecovery_Tab}
