*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${TERMS_CONDITIONS_CHECKBOX_TEXT}    xpath=//div[1]/label/span[2]/b[1]
${ACCEPT_BUTTON}    xpath=//button[@type='submit']
${BALANCE_TEXT}  xpath=//p/span[text()='You have:']


*** Keywords ***
# Check If Popup Has Been Loaded
#     [Documentation]  Keyword to assert if popup is already displayed
#     [Arguments]  ${text_to_assert}  ${REDEEM_NOW_BUTTON}  visible
#     Wait Until Page Contains  text=${text_to_assert}  timeout=30s

Tick Terms And Conditions Checbox
    [Documentation]  Keyword to handle clicking terms and conditions checkbox
    Wait For Elements State  ${TERMS_CONDITIONS_CHECKBOX_TEXT}  visible
    Click  selector=${TERMS_CONDITIONS_CHECKBOX_TEXT}

Click Accept Button On Terms And Conditions Popup
    [Documentation]  Keyword to handle clicking Accept button
    Wait For Elements State  ${TERMS_CONDITIONS_CHECKBOX_TEXT}  visible
    Click  selector=${TERMS_CONDITIONS_CHECKBOX_TEXT}

