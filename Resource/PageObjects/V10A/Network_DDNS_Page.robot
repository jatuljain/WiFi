*** Variables ***
${DDNS_Tab}  //a[normalize-space()='Dynamic DNS']
${menu_right}  //div[@class='menu_right']
${DDNS_Content}  Dynamic DNS
${DDNS_Check}=  //tbody/tr/td[2]/span/a
${DDNS_save_setting}  //*[@id="save"]/span[2]
${DDNS_Account_Email}  //input[@name='ddns_account']
${DDNS_Password}  //input[@name='ddns_password']
${DDNS_DomainName}  //input[@name='ddns_domain_name']



*** Keywords ***
Go to DDNS tab
    unselect frame
    Click Element  ${DDNS_Tab}
    sleep  2s
    select frame  id:frm_main2
    wait until page contains  ${DDNS_Content}  30s



Get DDNS Status
    ${DDNS_Check_Status} =  get element attribute  ${DDNS_Check}  class
    ${DDNS_Check_Status}=  Convert To String  ${DDNS_Check_Status}
    ${status}=  Get Regexp Matches  ${DDNS_Check_Status}  arcTransformChecked
    IF  ${status}
       ${DDNS_Check_Status}  Set Variable  1
    ELSE
       ${DDNS_Check_Status}  Set Variable  0
    END
    [return]  ${DDNS_Check_Status}

# Call Set the DDNS with parameter ON or OFF
Set DDNS
    [Arguments]    ${DDNS}
    IF  '${DDNS}' == 'ON'
       Enable DDNS
    ELSE IF  '${DDNS}' == '1'
       Enable DDNS
    ELSE
       Disable DDNS
    END
    
Enable DDNS
    ${DDNS_Status}=  Get DDNS Status
    IF  ${DDNS_Status}
        log   DDNS is already enabled
    ELSE
        Check DDNS Checkbox
    END

Disable DDNS
    ${DDNS_Status}=  Get DDNS Status
    IF  ${DDNS_Status}
        Check DDNS Checkbox
    ELSE
        log   DDNS is already Disabled
    END

Check DDNS Checkbox
    click Element  ${DDNS_Check}


Save DDNS Setting
    click element  ${DDNS_save_setting}
    # sleep  5s
    wait until Element Is Visible  ${DDNS_save_setting}  60s


Set Account E-mail for DDNS
    [Arguments]    ${account}
    unselect frame
    select frame  id:frm_main2
    Clear Element Text  ${DDNS_Account_Email}
    press keys  ${DDNS_Account_Email}  ${account}

Set Password or Key for DDNS
    [Arguments]    ${Password}
    unselect frame
    select frame  id:frm_main2
    Clear Element Text  ${DDNS_Password}
    press keys  ${DDNS_Password}  ${Password}

Set Domain name for DDNS
    [Arguments]    ${DomainName}
    unselect frame
    select frame  id:frm_main2
    Clear Element Text  ${DDNS_DomainName}
    press keys  ${DDNS_DomainName}  ${DomainName}
