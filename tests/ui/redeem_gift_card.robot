*** Settings ***
Resource    ..${/}..${/}keywords${/}global_keywords.robot
Resource    ..${/}..${/}keywords${/}global_keywords_ui.robot
Resource    ..${/}..${/}page_objects${/}landing_page_page_object.robot
Resource    ..${/}..${/}page_objects${/}gift_cards_page_object.robot
Resource    ..${/}..${/}page_objects${/}redeem_page_page_object.robot
Resource    ..${/}..${/}page_objects${/}checkout_page_page_object.robot
Resource    ..${/}..${/}page_objects${/}rewards_summary_page_object.robot
Resource    ..${/}..${/}page_objects${/}nav_bar_page_object.robot
Resource    ..${/}..${/}page_objects${/}points_activity_page_page_object.robot

# Test Teardown  Close All Browsers
Test Teardown  Browser.Close Page  page=ALL


*** Test Cases ***
Redeem gift card
    [Documentation]  Verify successful redeeming of gift cards via UI
    global_keywords.Create Token
    ...    ${CREATE_TOKEN_ENDPOINT}
    ...    client_credentials
    ...    ${CLIENT_ID}
    ...    ${CLIENT_SECRET}
    ...    ${AUDIENCE}

    # Generate Random User Data

    # global_keywords.Create User
    # ...    ${USERS_ENDPOINT}
    # ...    ${PARTNER_USER_ID}
    # ...    ${RANDOM_EMAIL}
    # ...    +6587654321
    # ...    active
    # ...    ${RANDOM_FNAME}
    # ...    ${RANDOM_LNAME}
    # ...    1987-11-21
    # ...    male
    # ...    ${RANDOM_COUNTRY_CODE}

    # Mock Post Webhook Payload
    # Get Webhook Payload
    # Assert Webhook Payload User Should Be Enrolled
    Generate Random Reference Id
    global_keywords.Top Up/Deduct Points
    ...    ${POINTS_ADJUSTMENTS_ENDPOINT}
    ...    goodwill
    ...    93eea83e-0216-4717-9611-fff4afe7ff4b
    ...    lorem imsum descriptor data
    ...    ${20000}
    ...    ${RANDOM_REFERENCE_ID}
    ...    lorem ipsum reason
    ...    ${24}

    global_keywords.Create Login Link
    ...  ${BASE_URL}${USERS_ENDPOINT}/93eea83e-0216-4717-9611-fff4afe7ff4b${LOGIN_LINK_ENDPOINT}
    ...  ${RANDOM_REFERENCE_ID}

    global_keywords_ui.Set Browser Instance
    New Page  ${GENERATED_LOGIN_LINK}

    # landing_page_page_object.Tick Terms And Conditions Checbox
    # landing_page_page_object.Click Accept Button On Terms And Conditions Popup

    nav_bar_page_object.Click On Redeem Rewards Menu
    nav_bar_page_object.Click On Gift Cards Menu
    gift_cards_page_object.Search Gift Cards By Brand  Apple
    gift_cards_page_object.Click On Gift Card Result  GIFT_CARD_NAME=Apple Gift Card
    redeem_page_page_object.Assert Gift Card Value Button Selected  button_value=$20
    redeem_page_page_object.Click Redeem Now Button
    checkout_page_page_object.Click Review Button
    checkout_page_page_object.Click Redeem Now Button
    checkout_page_page_object.Get Rewards Id
    checkout_page_page_object.Click View My Rewards Button
    rewards_summary_page_object.Input Rewards Id On Rewards Id Textfield  text=${ORDER_ID}
    rewards_summary_page_object.Assert Generated Rewards Id Is Confirmed
    nav_bar_page_object.Click On Profile Icon
    nav_bar_page_object.Click On Points Activity Link
    points_activity_page_page_object.Assert Correct Current Total Rewards Points  total_points=18,000 Rewards Points
    Generate Random Reference Id
    global_keywords.Top Up/Deduct Points
    ...    ${POINTS_ADJUSTMENTS_ENDPOINT}
    ...    goodwill
    ...    93eea83e-0216-4717-9611-fff4afe7ff4b
    ...    lorem imsum descriptor data
    ...    ${-18000}
    ...    ${RANDOM_REFERENCE_ID}
    ...    deduct points for teardown
    ...    ${24}


*** Keywords ***
Generate Random Reference Id
    [Documentation]  Keyword for generation of reference_id for top up
    ${RANDOM_REFERENCE_ID}=    Get Time
    Set Suite Variable    ${RANDOM_REFERENCE_ID}    ${RANDOM_REFERENCE_ID}
