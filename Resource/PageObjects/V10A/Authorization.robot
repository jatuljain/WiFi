*** Settings ***
Library			SeleniumLibrary



*** Variables ***
${BROWSER}		firefox
${HOME_PAGE}     https://mijnmodem.kpn/login.htm
${Device_Type}  V10A
${Advanced}   Advanced
${Username}  //input[@name='ui_user']
${Password}  //input[@name='ui_pws']
${Password_value}   Qwerty1!
${Admin_Password_value}   Qwerty1!
${Login_button}  //tbody/tr[5]/td[1]
${Login_button_PostLogout}  //*[@id="btn_"]
