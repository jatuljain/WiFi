*** Variables ***
${Network_Tab}  //a[normalize-space()='Network']
${LAN_IP}  LAN IP
${first_octet_GW}  //tr[2]/td/table/tbody/tr[2]/td[2]/span[1]/div/div/input
${second_octet_GW}  //tr[2]/td/table/tbody/tr[2]/td[2]/span[3]/div/div/input
${third_octet_GW}  //tr[2]/td/table/tbody/tr[2]/td[2]/span[5]/div/div/input
${forth_octet_GW}  //tr[2]/td/table/tbody/tr[2]/td[2]/span[7]/div/div/input

${first_octet_mask}  //tbody/tr[3]/td[2]/span[1]/div/div/input
${second_octet_mask}  //tbody/tr[3]/td[2]/span[3]/div/div/input
${third_octet_mask}  //tbody/tr[3]/td[2]/span[5]/div/div/input
${forth_octet_mask}  //tbody/tr[3]/td[2]/span[7]/div/div/input

${first_octet_StartIP}  //tbody/tr[1]/td[2]/span[1]/div/div/input
${second_octet_StartIP}  //tbody/tr[1]/td[2]/span[3]/div/div/input
${third_octet_StartIP}  //tbody/tr[1]/td[2]/span[5]/div/div/input
${forth_octet_StartIP}  //tbody/tr[1]/td[2]/span[7]/div/div/input

${first_octet_EndIP}  //tr[3]/td/table/tbody/tr[2]/td[2]/span[1]/div/div/input
${second_octet_EndIP}  //tr[3]/td/table/tbody/tr[2]/td[2]/span[3]/div/div/input
${third_octet_EndIP}  //tr[3]/td/table/tbody/tr[2]/td[2]/span[5]/div/div/input
${forth_octet_EndIP}  //tr[3]/td/table/tbody/tr[2]/td[2]/span[7]/div/div/input


*** Keywords ***
Go to Network Page
    unselect frame
    Click Element  ${Network_Tab}
    # sleep  5s
    select frame  id:frm_main2
    wait until page contains  ${LAN_IP}  10s


Get the Network Gateway from GUI
    ${first_octet_value}  get element attribute  ${first_octet_GW}  value
    log  ${first_octet_value} is Current first octet value
    ${second_octet_value}  get element attribute  ${second_octet_GW}  value
    log  ${second_octet_value} is Current first octet value
    ${third_octet_value}  get element attribute  ${third_octet_GW}  value
    log  ${third_octet_value} is Current first octet value
    ${forth_octet_value}  get element attribute  ${forth_octet_GW}  value
    log  ${forth_octet_value} is Current first octet value
    ${Gatway_IP}=  Catenate   SEPARATOR=.  ${first_octet_value}  ${second_octet_value}   ${third_octet_value}  ${forth_octet_value} 
    [return]  ${Gatway_IP}

Get the Network SubnetMask from GUI
    ${first_octet_value}  get element attribute  ${first_octet_mask}  value
    log  ${first_octet_value} is Current first octet value
    ${second_octet_value}  get element attribute  ${second_octet_mask}  value
    log  ${second_octet_value} is Current first octet value
    ${third_octet_value}  get element attribute  ${third_octet_mask}  value
    log  ${third_octet_value} is Current first octet value
    ${forth_octet_value}  get element attribute  ${forth_octet_mask}  value
    log  ${forth_octet_value} is Current first octet value
    ${SubnetMask_IP}=  Catenate   SEPARATOR=.  ${first_octet_value}  ${second_octet_value}   ${third_octet_value}  ${forth_octet_value} 
    [return]  ${SubnetMask_IP}


Get the DHCP Start IP from DHCP Pool from GUI
    ${first_octet_value}  get element attribute  ${first_octet_StartIP}  value
    log  ${first_octet_value} is Current first octet value
    ${second_octet_value}  get element attribute  ${second_octet_StartIP}  value
    log  ${second_octet_value} is Current first octet value
    ${third_octet_value}  get element attribute  ${third_octet_StartIP}  value
    log  ${third_octet_value} is Current first octet value
    ${forth_octet_value}  get element attribute  ${forth_octet_StartIP}  value
    log  ${forth_octet_value} is Current first octet value
    ${Start_IP}=  Catenate   SEPARATOR=.  ${first_octet_value}  ${second_octet_value}   ${third_octet_value}  ${forth_octet_value} 
    [return]  ${Start_IP}

Get the DHCP End IP from DHCP Pool from GUI
    ${first_octet_value}  get element attribute  ${first_octet_EndIP}  value
    log  ${first_octet_value} is Current first octet value
    ${second_octet_value}  get element attribute  ${second_octet_EndIP}  value
    log  ${second_octet_value} is Current first octet value
    ${third_octet_value}  get element attribute  ${third_octet_EndIP}  value
    log  ${third_octet_value} is Current first octet value
    ${forth_octet_value}  get element attribute  ${forth_octet_EndIP}  value
    log  ${forth_octet_value} is Current first octet value
    ${EndIP_IP}=  Catenate   SEPARATOR=.  ${first_octet_value}  ${second_octet_value}   ${third_octet_value}  ${forth_octet_value} 
    [return]  ${EndIP_IP}

    