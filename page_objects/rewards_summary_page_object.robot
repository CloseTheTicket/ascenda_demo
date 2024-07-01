*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${REWARDS_ID_TEXTFIELD}  xpath=//div[2]/div[1]/div/input[@id='orderNumber']
${REWARDS_ID_RESULT}  xpath=//h2/span[@data-testid='order-id']
${ORDER_STATUS_TEXT}  xpath=//div[@data-testid='order-status']


*** Keywords ***
Input Rewards Id On Rewards Id Textfield
    [Documentation]  Input text on locator rewards id textfield
    [Arguments]  ${text}
    Wait For Elements State  ${REWARDS_ID_TEXTFIELD}  visible
    Fill Text  selector=${REWARDS_ID_TEXTFIELD}  txt=${text}

Assert Generated Rewards Id Is Confirmed
    [Documentation]  Assert generated rewards id status is confirmed
    ${REWARDS_ID_RESULT_TEXT}=  Browser.Get Property  selector=${REWARDS_ID_RESULT}  property=outerText
    Set Suite Variable  ${REWARDS_ID_RESULT_TEXT}  ${REWARDS_ID_RESULT_TEXT}
    Should Be Equal  first=${ORDER_ID}  second=${REWARDS_ID_RESULT_TEXT}
    ${status_value}=  Get Text  selector=${ORDER_STATUS_TEXT}
    WHILE  $status_value !='Confirmed'  limit=20
        Reload
        ${status_value}=  Get Text  selector=${ORDER_STATUS_TEXT}
    END
