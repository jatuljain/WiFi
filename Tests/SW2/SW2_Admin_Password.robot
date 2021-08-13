Documentation  TestCase to Verify Admin Password Update on SuperWiFi2


***Settings***
Resource  ../../Resource/PageObjects/SW2/SW2CommonFunction.robot
Resource  ../../Resource/PageObjects/SW2/SW2_SystemPage.robot
Resource  ../../Resource/PageObjects/SW2/SW2_System_Admin_PasswordPage.robot
Library  DataDriver  ../../TestData/TestData_Admin_Password.csv


Default Tags   SW2   Funtional  AdminPassword

# Suite Setup  Fetch the Initial Admin Password
Test Setup  Login to DUT
Test Teardown  Cleanup

Test Template  Verify setting Admin Password



*** Test Cases ***
Change the Admin Password to ${Admin_Password} for SW2
    [Documentation]  TestCase to Verify Admin Password Update on SuperWiFi2


*** Keywords ***
Verify setting Admin Password
    [Arguments]  ${Admin_Password}
    Go to System Page
    Go to Admin Password Page
    Set new Admin Password  ${Admin_Password}  ${Password_value}
    Save Updated Admin Password  
    Logout from DUT
    Login to DUT with Updated New Password  ${Admin_Password}
    Logout from DUT
    Set Global Variable  ${Admin_Password}



Fetch the Initial Admin Password
    Login to DUT
    Go to System Page
    Go to Admin Password Page
    ${Orginal_Admin_Password}=  Get the Admin Password
    Set Global Variable  ${Orginal_Admin_Password}
    Logout from DUT

Cleanup
    Login to DUT with Updated New Password  ${Admin_Password}
    Go to System Page
    Go to Admin Password Page
    Set new Admin Password  ${Password_value}  ${Admin_Password}
    Save Updated Admin Password  
    Logout from DUT
