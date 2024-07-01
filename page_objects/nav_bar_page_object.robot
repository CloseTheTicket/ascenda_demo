*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${ACCEPT_BUTTON}    xpath=//button[@type='submit']
${REDEEM_REWARDS_MENU}   xpath=//button[text()='Redeem Rewards']
${GIFT_CARDS_MENU}  xpath=//strong[text()='Gift Cards']
${BALANCE_TEXT}  xpath=//p/span[text()='You have:']
${PROFILE_ICON_NAV_BAR}  xpath=//*[@id="radix-:rc:-trigger-radix-:rd:"]
${POINTS_ACTIVITY_LINK}  xpath=//li[2]/a[@data-testid='header-avatar-dropdown-link']


*** Keywords ***
Click On Redeem Rewards Menu
    [Documentation]  Keyword to handle clicking of Redeed Rewards menu
    #Wait For Elements State  ${REDEEM_REWARDS_MENU}  visible
    Click  selector=${REDEEM_REWARDS_MENU}

Click On Gift Cards Menu
    [Documentation]  Keyword to handle clicking of Gift Cards menu
    Hover  selector=${REDEEM_REWARDS_MENU}
    Wait For Elements State  ${REDEEM_REWARDS_MENU}  visible
    Click  selector=${GIFT_CARDS_MENU}

Click On Profile Icon
    [Documentation]  Click on profile icon on nav bar menu
    Click  selector=${PROFILE_ICON_NAV_BAR}

Click On Points Activity Link
    [Documentation]  Click on points activity link on nav bar menu
    Click  selector=${POINTS_ACTIVITY_LINK}
