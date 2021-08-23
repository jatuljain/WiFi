*** Settings ***


*** Variables ***
${Topology Overview}  Topology Overview
${Logout_button}  btn_logout
${WLAN}  //a[normalize-space()='WLAN']
${SWP2_Image}  css=img[src='images/owl/ap_80s.png?ver=1626255583']
${SWP1_Image}  css=img[src='images/owl/ap_80.png?ver=1626255583']
${ExperiaWiFi_Image}  css=img[src='images/owl/ap_80b.png?ver=1626255583']
${V10A_Image}  css=img[src='images/owl/Experia_Box_owl.png?ver=1626255583']


*** Keywords ***
Get total V10A count
    unselect frame
    select frame  id:frm_main2
    sleep  1s
    ${V10A_count} =  Get Element Count  ${V10A_Image}
    [Return]  ${V10A_count}

Get total SuperWifi2 count
    unselect frame
    select frame  id:frm_main2
    sleep  1s
    ${SW2_count} =  Get Element Count  ${SWP2_Image}
    [Return]  ${SW2_count}
    
Get total SuperWifi1 count
    unselect frame
    select frame  id:frm_main2
    sleep  1s
    ${SW1_count} =  Get Element Count  ${SWP1_Image}
    [Return]  ${SW1_count}

Get total ExperiaWiFi count
    unselect frame
    select frame  id:frm_main2
    sleep  1s
    ${Experia_count} =  Get Element Count  ${ExperiaWiFi_Image}
    [Return]  ${Experia_count}

    