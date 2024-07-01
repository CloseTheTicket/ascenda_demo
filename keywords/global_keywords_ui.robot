*** Settings ***
Resource    ..${/}resources${/}setup.robot
Resource    ..${/}resources${/}test_data.robot


*** Keywords ***
Set Browser Instance
    [Documentation]  Set initial browser selection and instance
    Set Browser Timeout  3m
    New Browser  browser=chromium  headless=True
