*** Variables ***


${AdminPassword_Tab}  //div[contains(text(),'Admin Password')]
${Old_Password}  //input[@id='userOldPswdID']
${New_Password_ID}  //input[@id='userNewPswdID']
${Confirm_Password_ID}  //input[@id='userConPswdID']

${Admin_Password_Page}  Admin Password
${Current_Password}  Current Password

${Save_Button}  //tbody[1]/tr[1]/td[3]/div[1]/a[1]/span[2]

***Keywords***


Go to Admin Password Page
    unselect frame
    select frame  name:leftFrame
    Click element  ${AdminPassword_Tab}
    unselect frame
    select frame  id:frm_main2
    wait until element is visible  ${Old_Password}


Get the Admin Password
    # unselect frame
    # select frame  name:frm_main2
    ${Old_Password}=  Get selected list value  ${Old_Password}
    log  ${Old_Password} is Current Password
    [return]  ${Old_Password}

Set new Admin Password
    [Arguments]    ${Password}  ${Old_Password_value}
    Input Text   ${Old_Password}  ${Old_Password_value}
    Input Text   ${New_Password_ID}   ${Password}
    Input Text   ${Confirm_Password_ID}   ${Password}


Save Updated Admin Password  
    click element  ${Save_Button}
    sleep  15s