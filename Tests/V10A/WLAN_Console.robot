*** Settings ***

Documentation  TestCase to check Channel ID
Resource  ../../Resource/CommonFunction.robot
Resource  ../../Resource/Telnet.robot

Test Setup  Telnet to DUT Console
Test Teardown     Close All Connections

***Test Cases***

Get the 2.4Ghz channel id from console
    Get the 2.4Ghz channel id from console
    
Get the 5Ghz channel id from console
    Get the 5Ghz channel id from console