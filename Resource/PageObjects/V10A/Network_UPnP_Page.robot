*** Variables ***
${UPnP_Tab}  //a[normalize-space()='UPnP']
${menu_right}  //div[@class='menu_right']
${UPnP_Content}  UPnP function
${UPnP_Check}=  //tbody/tr/td[2]/span/a
${UPnP_save_setting}  //*[@id="save"]/span[2]

*** Keywords ***
Go to UPnP tab
    unselect frame
    Click Element  ${menu_right}
    sleep  2s
    Click Element  ${UPnP_Tab}
    sleep  2s
    select frame  id:frm_main2
    wait until page contains  ${UPnP_Content}  60s



Get UPnP Status
    ${UPnP_Check_Status} =  get element attribute  ${UPnP_Check}  class
    ${UPnP_Check_Status}=  Convert To String  ${UPnP_Check_Status}
    ${status}=  Get Regexp Matches  ${UPnP_Check_Status}  arcTransformChecked
    IF  ${status}
       ${UPnP_Check_Status}  Set Variable  1
    ELSE
       ${UPnP_Check_Status}  Set Variable  0
    END
    [return]  ${UPnP_Check_Status}

# Call Set the UPnP with parameter ON or OFF
Set UPnP
    [Arguments]    ${UPnP}
    IF  '${UPnP}' == 'ON'
       Enable UPnP
    ELSE IF  '${UPnP}' == '1'
       Enable UPnP
    ELSE
       Disable UPnP
    END
    
Enable UPnP
    ${UPnP_Status}=  Get UPnP Status
    IF  ${UPnP_Status}
        log   UPnP is already enabled
    ELSE
        Check UPnP Checkbox
    END

Disable UPnP
    ${UPnP_Status}=  Get UPnP Status
    IF  ${UPnP_Status}
        Check UPnP Checkbox
    ELSE
        log   UPnP is already Disabled
    END

Check UPnP Checkbox
    click Element  ${UPnP_Check}


Save UPnP Setting
    click element  ${UPnP_save_setting}
    sleep  10s
    wait until Element Is Visible  ${UPnP_save_setting}  60s
