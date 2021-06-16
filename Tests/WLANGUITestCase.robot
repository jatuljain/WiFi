*** Settings ***
Documentation  TestCase to check Channel ID
Resource  ../Resource/CommonFunction.robot
Resource  ../Resource/PageObjects/WLANPage.robot

Library	   Telnet
Library    Collections
Library    String

Test Setup  Login to DUT
Test Teardown  Logout from DUT


*** Test Cases ***
Verify the current 2.4GHz Channel ID in GUI
    [Documentation]  This Test case is to Check the Channel ID
    [Tags]  Funtional  WiFi
    WLANPage.Go to WLAN Page
    Get the 2.4Ghz channel id from GUI

Verify the current 5GHz Channel ID in GUI
    [Documentation]  This Test case is to Check the Channel ID
    [Tags]  Funtional  WiFi
    WLANPage.Go to WLAN Page
    Get the 5Ghz channel id from GUI

Verify the SSID name from GUI
    [Documentation]  This Test case is to Check the SSID name
    [Tags]  Funtional  WiFi  SSID
    Go to WLAN Page
    Get the SSID name

Verify the WiFi Password from GUI
    [Documentation]  This Test case is to Check the SSID name
    [Tags]  Funtional  WiFi  SSIDPassword
    Go to WLAN Page
    Get the wifi Password