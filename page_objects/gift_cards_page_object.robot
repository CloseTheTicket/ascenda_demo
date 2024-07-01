*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${GIFT_CARD_SEARCH_TEXTFIELD}  id=giftCardSearch


*** Keywords ***
Search Gift Cards By Brand
    [Documentation]  Input brand to be searched on gift cards brand textfield
    [Arguments]  ${BRAND_NAME}
    Wait For Elements State  ${GIFT_CARD_SEARCH_TEXTFIELD}  visible
    Fill Text  selector=${GIFT_CARD_SEARCH_TEXTFIELD}  txt=${BRAND_NAME}

Click On Gift Card Result
    [Documentation]  Click on gift card product based on gift card name
    [Arguments]  ${GIFT_CARD_NAME}
    Wait For Elements State  xpath=//h2[text()='${GIFT_CARD_NAME}']  visible
    Click  selector=xpath=//h2[text()='${GIFT_CARD_NAME}']
