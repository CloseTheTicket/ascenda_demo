*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${REVIEW_BUTTON}  xpath=//button[2][@type='submit']
${REDEEM_NOW_BUTTON}  xpath=//button[2][@type='submit']
${REWARD_IS_PROCESSING_TEXT}  xpath=//div/h1[text()='Nice one! Your reward is processing']
${VIEW_MY_REWARDS_BUTTON}  xpath=//button//span[text()='View My Rewards']
${ORDER_ID_TEXT}  xpath=//span[@data-testid='order-id-value']


*** Keywords ***
Click Review Button
    [Documentation]  Click element review button
    Wait For Elements State  ${REVIEW_BUTTON}  visible
    Click  selector=${REVIEW_BUTTON}

Click Redeem Now Button
    [Documentation]  Click element redeem now button
    Wait For Elements State  ${REDEEM_NOW_BUTTON}  visible
    Click  selector=${REDEEM_NOW_BUTTON}

Check Rewards Processing Message Is Displayed
    [Documentation]  Assert if Rewards processing text is displayed
    Wait For Elements State  ${REWARD_IS_PROCESSING_TEXT}  visible

Click View My Rewards Button
    [Documentation]  Click view my rewards button
    Wait For Elements State  ${VIEW_MY_REWARDS_BUTTON}  visible
    Click  selector=${VIEW_MY_REWARDS_BUTTON}

Get Rewards Id
    [Documentation]  Get generated rewards id
    Wait For Elements State  ${ORDER_ID_TEXT}  visible
    ${ORDER_ID}=  Browser.Get Property  selector=${ORDER_ID_TEXT}  property=innerText
    Log  ${ORDER_ID}
    Set Suite Variable  ${ORDER_ID}  ${ORDER_ID}
