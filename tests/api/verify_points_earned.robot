*** Settings ***
Resource    ..${/}..${/}keywords${/}global_keywords.robot


*** Test Cases ***
Verify points earned e2e test
    [Documentation]  verify correct conversion of points.
    ...    for every 1 dollar spent the account will earn 0.75 loyalty points.

    global_keywords.Create Token
    ...    ${CREATE_TOKEN_ENDPOINT}
    ...    client_credentials
    ...    ${CLIENT_ID}
    ...    ${CLIENT_SECRET}
    ...    ${AUDIENCE}

    Generate Random User Data

    global_keywords.Create User
    ...    ${USERS_ENDPOINT}
    ...    ${PARTNER_USER_ID}
    ...    ${RANDOM_EMAIL}
    ...    +6587654321
    ...    active
    ...    ${RANDOM_FNAME}
    ...    ${RANDOM_LNAME}
    ...    1987-11-21
    ...    male
    ...    ${RANDOM_COUNTRY_CODE}

    Mock Post Webhook Payload
    Get Webhook Payload
    Assert Webhook Payload User Should Be Enrolled

    global_keywords.Create Transaction
    ...    ${TRANSACTIONS_ENDPOINT}
    ...    ${USER_ID}
    ...    1234
    ...    2024-06-28
    ...    1
    ...    USD
    ...    false
    ...    platinum
    ...    lorem ipsum transaction
    ...    1234
    ...    lorem ipsum merchant
    ...    1234
    ...    123456
    ...    1234
    ...    MC_AUTH_LOC_ID

    Wait For Batch Job
    Get Transaction Points History Of User
    ...    ${USER_ID}
    Assert Correct Transaction Points Earned


*** Keywords ***
Assert Correct Transaction Points Earned
    [Documentation]  Keyword to assert transaction details with correct points earned for user
    Should Be Equal    ${LATEST_TRANSACTION_HISTORY.json()['data'][0]['type']}    points_transaction
    Should Be Equal    ${LATEST_TRANSACTION_HISTORY.json()['data'][0]['user_id']}    ${USER_ID}
    Should Be Equal    ${LATEST_TRANSACTION_HISTORY.json()['data'][0]['amount']}    ${0.75}

Wait For Batch Job
    [Documentation]    Wait for the batch job to complete approx. 15-20mins
    Log    Waiting for the batch job to completion.
    Log To Console  Waiting for the batch job completion.
    Sleep    16 minutes  reason=Waiting for the batch job completion.
