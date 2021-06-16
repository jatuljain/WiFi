*** Settings ***
Library			SeleniumLibrary



*** Variables ***
${BROWSER}		firefox
${HOME_PAGE}     https://mijnmodem.kpn/login.htm
${Authorization}     Authorization
${Advanced}   Advanced
${Username}  //input[@name='ui_user']
${Password}  //input[@name='ui_pws']
${Password_value}   Qwerty1!
${Login_button}  //tbody/tr[5]/td[1]
${Login_button_PostLogout}  //*[@id="btn_"]


#Suite Teardown    Close All Browsers

# Test Setup  CommonFuntion.Login to DUT
