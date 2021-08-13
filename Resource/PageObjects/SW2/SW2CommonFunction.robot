*** Settings ***
Library			SeleniumLibrary
Resource  SW2Authorization.robot
Resource  SW2HomePage.robot



*** Keywords ***
Login to DUT
	Open Browser			${HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    Change Default Language to English
    press keys  ${Password}  ${Password_value}
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  2s
    Wait Until Page Contains Element  ${Overview_Text}  10s
    select frame  id:frm_main2
    wait until page contains  ${Status}  10s


Factory Reset Login to DUT
	Open Browser			${HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    Change Default Language to English
    press keys  ${Password}  ${Admin_Factory_Password_value}
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  5s
    wait until page contains  New password  15s
    press keys  ${New_Password}  ${Password_value}
    press keys  ${ReType_New_Password}  ${Password_value}
    Click Element  ${Modify_Password}
    Sleep  10s
    Wait Until Page Contains Element  ${Overview_Text}  10s
    select frame  id:frm_main2
    wait until page contains  ${Status}  10s


Logout from DUT
    unselect frame  
    select frame  name:topFrame  
    Click Element  ${Logout_button}
    sleep  2s
    Close All Browsers


Change Default Language to English
    select frame  name:topFrame
    Click Element  ${Default_Language_Tab}
    unselect frame
    Click Element  ${English_Language}
    Sleep  2s
    wait until page contains  Username  5s
    unselect frame


Login to DUT with Updated New Password
    [Arguments]    ${New_Password}
    Open Browser			${HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    Change Default Language to English
    press keys  ${Password}  ${New_Password}
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  5s    