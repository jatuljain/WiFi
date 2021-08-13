*** Settings ***
Library			SeleniumLibrary



*** Variables ***
${BROWSER}		firefox
${HOME_PAGE}     http://192.168.2.23/login.htm
${Device_Type}  SW2
${Authorization}     Authorization
${Advanced}   Advanced
${Username}  //input[@name='ui_user']
${Password}  //input[@name='ui_pws']
${Password_value}   Qwerty1!
${Login_button}  //div[@id='btn_loginbtn']
${Login_button_PostLogout}  //*[@id="btn_"]
${Admin_Factory_Password_value}  CKJ9r4.GXG
${New_Password}  //input[@name='ui_new_pws']
${ReType_New_Password}  //input[@name='ui_retype_pws']

${Default_Language_Tab}  //div[@class='nav_lang']
${English_Language}  //html/body/div/a[1]/div
${Modify_Password}  //tbody/tr[6]/td[1]/div/a/span[2]
${Overview_Text}  //title[normalize-space()='Overview']
# ${English_Language}  //html/body/div/a[1]/div