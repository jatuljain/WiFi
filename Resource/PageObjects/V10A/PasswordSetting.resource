
*** Variables ***
${Old_Password}  //input[@name='userOldPswd']
${UserNew_Password}  //input[@name='userNewPswd']
${UserCon_Password}  //input[@name='userConPswd']
${Save_Setting}  //div[@id='btn_save']
${timeout}  //input[@id='ui_timeout']
${timeout_value}  2
${ui_timeout}  Login Idle Time Out
${emptyPassword}

${UserNew_Password_PostFR}      //input[@name='ui_new_pws']
${UserNew_Password_Retype_PostFR}      //input[@name='ui_retype_pws']
${Modify}      //span[@class='ButtonMiddle green']

*** Keywords ***
Reset the Password
    set selenium speed  0.25s
    unselect frame
    select frame  id:frm_main2
    press keys  ${Old_Password}  ${emptyPassword}
    press keys  ${UserNew_Password}  ${Admin_Password_value}
    press keys  ${UserCon_Password}  ${Admin_Password_value}
    Clear Element Text  ${timeout}
    press keys  ${timeout}  ${timeout_value}
    click element  ${Save_Setting}
    # Run Keyword And Ignore Error  Handle Alert
    sleep  6s
    # wait until page contains  ${ui_timeout}  10s
    Logout from DUT
    sleep  2s
    Open Browser			${HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    press keys  ${Password}  ${Password_value}
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  2s
    Run Keyword And Ignore Error  Change the device login password


Update the Password
    [Arguments]    ${Old_Password_Value}
    set selenium speed  0.25s
    unselect frame
    select frame  id:frm_main2
    press keys  ${Old_Password}  ${Old_Password_Value}
    press keys  ${UserNew_Password}  ${Admin_Password_value}
    press keys  ${UserCon_Password}  ${Admin_Password_value}
    click element  ${Save_Setting}
    sleep  6s

Update the timeout
    [Arguments]    ${new_timeout_value}
    set selenium speed  0.25s
    unselect frame
    select frame  id:frm_main2
    Clear Element Text  ${timeout}
    press keys  ${timeout}  ${new_timeout_value}
    click element  ${Save_Setting}
    sleep  6s

Change the device login password
    press keys  ${UserNew_Password_PostFR}  ${Password_value}
    press keys  ${UserNew_Password_Retype_PostFR}  ${Password_value}
    click element  ${Modify}
    sleep  5s
    wait until page contains  ${Topology Overview}  15s
