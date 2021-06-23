*** Settings ***
Library			SeleniumLibrary



*** Variables ***
${BROWSER}		firefox
${HOME_PAGE}     http://192.168.2.10/login.htm
${Device_Type}  SW2
${Authorization}     Authorization
${Advanced}   Advanced
${Username}  //input[@name='ui_user']
${Password}  //input[@name='ui_pws']
${Password_value}   Qwerty1!
${Login_button}  //div[@id='btn_loginbtn']
${Login_button_PostLogout}  //*[@id="btn_"]