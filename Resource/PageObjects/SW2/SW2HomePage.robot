*** Settings ***
Library			SeleniumLibrary

# Suite Teardown    Close All Browsers

#Test Setup  Open Chrome


*** Variables ***
${Topology Overview}  Topology Overview
${Logout_button}  //*[@id="u_login"]
${WLAN}  //a[normalize-space()='WLAN']
${Status}  Status  
${Settings_Tab}  //div[@id='id_nav_1']

*** Keywords ***
