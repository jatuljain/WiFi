***Settings ***
Resource  Restore_Save_Upload.robot
Resource  PasswordSetting.resource

*** Variables ***
${Administration_Tab}  //a[normalize-space()='Administration']
${Administration_Content}  Router Login Name




*** Keywords ***
Go to Administration Page
    unselect frame
    Click Element  ${Administration_Tab}
    # sleep  5s
    select frame  id:frm_main2
    wait until page contains  ${Administration_Content}
  
