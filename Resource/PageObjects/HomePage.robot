*** Settings ***
Library			SeleniumLibrary

# Suite Teardown    Close All Browsers

#Test Setup  Open Chrome


*** Variables ***
${Topology Overview}  Topology Overview
${Logout_button}  btn_logout
${WLAN}  //a[normalize-space()='WLAN']