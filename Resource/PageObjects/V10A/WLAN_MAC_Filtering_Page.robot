*** Settings ***

*** Variables ***
${MAC_Filtering_Tab}  //a[normalize-space()='MAC Filtering']
${MAC_Filtering_Page}  Enable MAC Filter
${MAC_Filter_Enable}  //tbody/tr[2]/td[2]/span[1]/a
${MAC_Filter_Disable}  //tbody/tr[2]/td[2]/span[2]/a

${MAC_Filter_mode_dropdown}  //tbody/tr[3]/td[2]/div/div/a
${MAC_Filter_mode_Accept}  //tbody/tr[3]/td[2]/div/ul/li[1]/a
${MAC_Filter_mode_Reject}  //tbody/tr[3]/td[2]/div/ul/li[2]/a

${Save_Button}  //tbody/tr[3]/td/div[2]/a/span[2]

${MAC_FirstOctect}  //tr[2]/td[2]/span[1]/div[1]/div[1]/input[1]
${MAC_SecondOctect}  //tr[2]/td[2]/span[2]/div[1]/div[1]/input[1]
${MAC_ThirdOctect}  //tr[2]/td[2]/span[3]/div[1]/div[1]/input[1]
${MAC_FourthOctect}  //tr[2]/td[2]/span[4]/div[1]/div[1]/input[1]
${MAC_FifthOctect}  //tr[2]/td[2]/span[5]/div[1]/div[1]/input[1]
${MAC_SixthOctect}  //tr[2]/td[2]/span[6]/div[1]/div[1]/input[1]

${2MAC_FirstOctect}  //tr[3]/td[2]/span[1]/div[1]/div[1]/input[1]
${2MAC_SecondOctect}  //tr[3]/td[2]/span[2]/div[1]/div[1]/input[1]
${2MAC_ThirdOctect}  //tr[3]/td[2]/span[3]/div[1]/div[1]/input[1]
${2MAC_FourthOctect}  //tr[3]/td[2]/span[4]/div[1]/div[1]/input[1]
${2MAC_FifthOctect}  //tr[3]/td[2]/span[5]/div[1]/div[1]/input[1]
${2MAC_SixthOctect}  //tr[3]/td[2]/span[6]/div[1]/div[1]/input[1]


*** Keywords ***

Go to MAC Filtering Page
    unselect frame
    Click Element  ${MAC_Filtering_Tab}
    sleep  5s
    select frame  id:frm_main2
    current frame should contain  ${MAC_Filtering_Page}

Enable MAC Filter
    Click Element  ${MAC_Filter_Enable} 

Disable MAC Filter
    Click Element  ${MAC_Filter_Disable}
    
Accept MAC Filter Mode
    click element  ${MAC_Filter_mode_dropdown}
    click element  ${MAC_Filter_mode_Accept} 

Reject MAC Filter Mode
    click element  ${MAC_Filter_mode_dropdown}
    click element  ${MAC_Filter_mode_Reject}


Add MAC entry for WiFi connected device

Add MAC entry for LAN connected device
    ${first_Octect}  ${second_Octect}  ${third_Octect}  ${forth_Octect}  ${fifth_Octect}  ${sixth_Octect} =  Get the MAC address octects for Wi-Fi LAN devices from Windows 
    log  ${first_Octect} ${second_Octect} ${third_Octect} ${forth_Octect} ${fifth_Octect} ${sixth_Octect}
    Clear Element Text  ${MAC_FirstOctect}
    press keys  ${MAC_FirstOctect}  ${first_Octect}
    Clear Element Text  ${MAC_SecondOctect}
    press keys  ${MAC_SecondOctect}  ${second_Octect}
    Clear Element Text  ${MAC_ThirdOctect}
    press keys  ${MAC_ThirdOctect}  ${third_Octect}
    Clear Element Text  ${MAC_FourthOctect}
    press keys  ${MAC_FourthOctect}  ${forth_Octect}
    Clear Element Text  ${MAC_FifthOctect}
    press keys  ${MAC_FifthOctect}  ${fifth_Octect}
    Clear Element Text  ${MAC_SixthOctect}
    press keys  ${MAC_SixthOctect}  ${sixth_Octect}

Add second MAC entry for LAN connected device
    ${first_Octect}  ${second_Octect}  ${third_Octect}  ${forth_Octect}  ${fifth_Octect}  ${sixth_Octect} =  Get the MAC address octects for Wi-Fi LAN devices from Windows 
    log  ${first_Octect} ${second_Octect} ${third_Octect} ${forth_Octect} ${fifth_Octect} ${sixth_Octect}
    press keys  ${2MAC_FirstOctect}  ${first_Octect}
    press keys  ${2MAC_SecondOctect}  ${second_Octect}
    press keys  ${2MAC_ThirdOctect}  ${third_Octect}
    press keys  ${2MAC_FourthOctect}  ${forth_Octect}
    press keys  ${2MAC_FifthOctect}  ${fifth_Octect}
    press keys  ${2MAC_SixthOctect}  ${sixth_Octect}

Add nth MAC entry with values
    [Arguments]  ${nth}  ${first_Octect}  ${second_Octect}  ${third_Octect}  ${forth_Octect}  ${fifth_Octect}  ${sixth_Octect}
    log  ${first_Octect} ${second_Octect} ${third_Octect} ${forth_Octect} ${fifth_Octect} ${sixth_Octect}
    ${nth}=  Evaluate  ${nth}+1
    Clear Element Text  //tr[${nth}]/td[2]/span[1]/div[1]/div[1]/input[1]
    press keys  //tr[${nth}]/td[2]/span[1]/div[1]/div[1]/input[1]  ${first_Octect}
    Clear Element Text  //tr[${nth}]/td[2]/span[2]/div[1]/div[1]/input[1]
    press keys  //tr[${nth}]/td[2]/span[2]/div[1]/div[1]/input[1]  ${second_Octect}
    Clear Element Text  //tr[${nth}]/td[2]/span[3]/div[1]/div[1]/input[1]
    press keys  //tr[${nth}]/td[2]/span[3]/div[1]/div[1]/input[1]  ${third_Octect}
    Clear Element Text  //tr[${nth}]/td[2]/span[4]/div[1]/div[1]/input[1]
    press keys  //tr[${nth}]/td[2]/span[4]/div[1]/div[1]/input[1]  ${forth_Octect}
    Clear Element Text  //tr[${nth}]/td[2]/span[5]/div[1]/div[1]/input[1]
    press keys  //tr[${nth}]/td[2]/span[5]/div[1]/div[1]/input[1]  ${fifth_Octect}
    Clear Element Text  //tr[${nth}]/td[2]/span[6]/div[1]/div[1]/input[1]
    press keys  //tr[${nth}]/td[2]/span[6]/div[1]/div[1]/input[1]  ${sixth_Octect}

    

Add MAC entry in MAC Filter page
    ${first_Octect}  ${second_Octect}  ${third_Octect}  ${forth_Octect}  ${fifth_Octect}  ${sixth_Octect} =  Get the MAC address octects for Wi-Fi LAN devices from Windows 
    log  ${first_Octect} ${second_Octect} ${third_Octect} ${forth_Octect} ${fifth_Octect} ${sixth_Octect}
    

Save MAC Filter Settings
    click element  ${Save_Button}
    # Handle Alert
    sleep  10s

