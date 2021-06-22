*** Settings ***
Library			SeleniumLibrary
Resource  ../Resource/PageObjects/SW2Authorization.robot
Resource  ../Resource/PageObjects/SW2HomePage.robot



*** Keywords ***
Login to DUT
	Open Browser			${HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    press keys  ${Password}  ${Password_value}
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  2s
    select frame  id:frm_main2
    wait until page contains  ${Status}  10s


Logout from DUT
    unselect frame  
    select frame  name:topFrame  
    Click Element  ${Logout_button}
    sleep  2s
    Close All Browsers

