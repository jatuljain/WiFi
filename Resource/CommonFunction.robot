*** Settings ***
Resource  ../Resource/PageObjects/V10A/Authorization.robot
Resource  ../Resource/PageObjects/V10A/HomePage.robot
Resource  ../Resource/PageObjects/V10A/WLANPage.robot



*** Keywords ***
Login to DUT
	Open Browser			${HOME_PAGE} 	${BROWSER}
	# Click Element       ${ACCPET_COOKIE}
    Maximize Browser Window
    Sleep  2s
    press keys  ${Password}  ${Password_value}
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  5s
    wait until page contains  ${Topology Overview}  15s


Factory Reset Login to DUT
	Open Browser			${HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    Click Element  ${Login_button}
    Sleep  5s
    wait until page contains  ${Topology Overview}  15s
    Go to Administration Page
    Reset the Password
    


Logout from DUT
    unselect frame
    Click Element  ${Logout_button}
    sleep  2s
    # wait until page contains  ${Login_button}  10s
    Close All Browsers

