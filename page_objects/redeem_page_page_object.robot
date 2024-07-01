*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${REDEEM_NOW_BUTTON}  xpath=//button[@type='submit']


*** Keywords ***
Click Redeem Now Button
    [Documentation]  Click element redeem now button
    Wait For Elements State  ${REDEEM_NOW_BUTTON}  visible
    Click  selector=${REDEEM_NOW_BUTTON}

Assert Gift Card Value Button Selected
    [Documentation]  Assert button with gift card value is selected
    [Arguments]  ${button_value}
    Wait For Elements State  xpath=//button[text()='${button_value}']  visible
    Get Attribute  selector=xpath=//button[text()='${button_value}']
    ...    attribute=data-state
    ...    assertion_operator=equals
    ...    assertion_expected=checked
