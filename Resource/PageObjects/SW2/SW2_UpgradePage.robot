***Settings***
Library			SeleniumLibrary


*** Variables ***
${UpgradePage_Password}  //input[@id='checkpswd']
${Submit}    //form/div/a/span[2]
${Firmware_Update}      //*[@id="443"]
${Firmware_Update_Word}      Firmware Update
${Upgrade_Password}  aNteTOkoUnmPOo
${UpgradePage_Browse_File}  //input[@name='owlsinglefile']
${Upgrade_Image}  C:\\WE620242-99_2.00.16_dbg1.bin
${Upgrade_Button}  //tbody/tr[4]/td[2]/div/a/span[2]

***Keywords***
Login to Upgrade Home Page
    [Arguments]    ${Password_value}  ${SW2_IP}
    ${Upgrade_HOME_PAGE}   Set Variable   http://${SW2_IP}/firmware_upgrade_manual.htm
	Open Browser			${Upgrade_HOME_PAGE} 	${BROWSER}
    Maximize Browser Window
    Sleep  2s
    press keys  ${UpgradePage_Password}  ${Password_value}
    Sleep  2s
    Click Element  ${Submit}
    Sleep  2s
    Wait Until Page Contains  ${Firmware_Update_Word}  10s
    # Wait Until Page Contains Element  ${Firmware_Update}  10s


Choose file and upgrade
    Choose File  ${UpgradePage_Browse_File}  ${Upgrade_Image}
    sleep  2s
    click element  ${Upgrade_Button}
    Handle Alert
    Handle Alert
    sleep  240s
    Close All Browsers 

