*** Settings ***
Resource    ..${/}resources${/}setup.robot
Resource    ..${/}resources${/}test_data.robot


*** Keywords ***
Create Ascenda API Session
    [Documentation]  Initialize API session for Ascenda API
    Create Session    API_SESSION    ${BASE_URL}

Create API Session For Webhook
    [Documentation]  Initialize API session for webhook url
    Create Session    WEBHOOK_SESSION    url=${WEBHOOK_URL}

Create Token
    [Documentation]  https://docs.ascenda.com/reference/post_oauth-token
    Create Ascenda API Session
    [Arguments]    ${endpoint}
    ...    ${grant_type}
    ...    ${client_id} 
    ...    ${client_secret}
    ...    ${audience}
    &{headers}=    Create Dictionary    Content-Type=application/json
    &{body}=    Create Dictionary
    ...    grant_type=${grant_type}
    ...    client_id=${client_id}
    ...    client_secret=${client_secret}
    ...    audience=${audience}
    ${body_json}=    Json.Dumps    ${body}
    ${resp}=    POST On Session
    ...     API_SESSION
    ...     ${endpoint}
    ...     data=${body_json}
    ...     headers=${headers}
    ...     expected_status=200
    ${BEARER_TOKEN}=    Set Variable  Bearer ${resp.json()['access_token']}
    Set Global Variable    ${BEARER_TOKEN}    ${BEARER_TOKEN}

Create User
    [Documentation]  https://docs.ascenda.com/reference/post_users
    [Arguments]    ${endpoint} 
    ...    ${partner_user_id}
    ...    ${email}
    ...    ${phone_number}
    ...    ${status}
    ...    ${first_name}
    ...    ${last_name}
    ...    ${birthdate}
    ...    ${gender}
    ...    ${country_code}
    &{headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}   Content-Type=application/json
    &{body}=    Create Dictionary
    ...    partner_user_id=${partner_user_id}
    ...    email=${email}
    ...    phone_number=${phone_number}
    ...    status=${status}
    ...    first_name=${first_name}
    ...    last_name=${last_name}
    ...    birthdate=${birthdate}
    ...    gender=${gender}
    ...    country_code=${country_code}
    ${body_json}=    Json.Dumps    ${body}
    ${resp}=    POST On Session
    ...     API_SESSION
    ...     ${endpoint}
    ...     data=${body_json}
    ...     headers=${headers}
    ...     expected_status=201
    ${USER_ID}=    Set Variable  ${resp.json()['id']}
    Set Global Variable    ${USER_ID}    ${USER_ID}

Mock Post Webhook Payload
    [Documentation]  https://docs.ascenda.com/reference/webhook-payload-format 
    ...    Webhook sent to url: https://webhook.site/#!/view/bb9d5b04-ad34-4917-8699-ce24d4506ab8

    ${json_file}=    Get File    ${CURDIR}/../test_data_files/sample_webhook_payload.json
    ${json_file}=    Load Json From File    ${CURDIR}/../test_data_files/sample_webhook_payload.json
    ${json_object}=    Update Value To Json    ${json_file}    $..data.user_id    ${USER_ID}
    Dump JSON To File    ${CURDIR}/../test_data_files/sample_webhook_payload.json    ${json_object}
    ${json_file}=    Get File    ${CURDIR}/../test_data_files/sample_webhook_payload.json

    &{headers}=    Create Dictionary    Content-Type=application/json
    Create API Session For Webhook
    ${resp}=    POST
    ...  ${POST_WEBHOOK_URL}
    ...  data=${json_file}
    ...  expected_status=200

Get Webhook Payload
    [Documentation]  https://docs.ascenda.com/reference/webhook-payload-format 
    ...    Webhook sent to url: https://webhook.site/#!/view/bb9d5b04-ad34-4917-8699-ce24d4506ab8
    Create API Session For Webhook
    ${resp}=  GET
    ...  ${WEBHOOK_URL}
    ...  expected_status=200
    Log  ${resp.json()}
    Set Global Variable    ${WEBHOOK_RESPONSE}    ${resp}

Create Transaction
    [Documentation]  https://docs.ascenda.com/reference/post_loyalty-transactions
    [Arguments]    ${endpoint}
    ...    ${user_id}
    ...    ${transaction_reference}
    ...    ${posting_date}
    ...    ${amount}
    ...    ${international_currency}
    ...    ${is_international}
    ...    ${account_type}
    ...    ${description}
    ...    ${merchant_category_code}
    ...    ${merchant_descriptor}
    ...    ${merchant_id}
    ...    ${card_bin}
    ...    ${card_last_4}
    ...    ${processor_mid_type}
    &{headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}   Content-Type=application/json
    &{body}=    Create Dictionary
    ...    user_id=${user_id}
    ...    transaction_reference=${transaction_reference}
    ...    posting_date=${posting_date}
    ...    amount=${amount}
    ...    international_currency=${international_currency}
    ...    is_international=${is_international}
    ...    account_type=${account_type}
    ...    description=${description}
    ...    merchant_category_code=${merchant_category_code}
    ...    merchant_descriptor=${merchant_descriptor}
    ...    merchant_id=${merchant_id}
    ...    card_bin=${card_bin}
    ...    card_last_4=${card_last_4}
    ...    processor_mid_type=${processor_mid_type}
    ${body_json}=    Json.Dumps    ${body}
    ${resp}=    POST On Session
    ...     API_SESSION
    ...     ${endpoint}
    ...     data=${body_json}
    ...     headers=${headers}
    ...     expected_status=201

Get Transaction Points History Of User
    [Documentation]  https://docs.ascenda.com/reference/get_users-user-id-points-transactions
    [Arguments]    ${user_id}
    &{headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}   Content-Type=application/json
    ${resp}=    GET On Session
    ...     API_SESSION
    ...     /users/${user_id}/${TRANSACTIONS_HISTORY_ENDPOINT}
    ...     headers=${headers}
    ...     expected_status=200
    Log  ${resp.json()}
    Set Global Variable    ${LATEST_TRANSACTION_HISTORY}    ${resp}

Get Client Id And Client Secret
    [Documentation]  Keyword to parse client_id and client_secret values from JSON source file
    #import json from file
    ${json_file}=    Get File    ${CURDIR}/../test_data_files/client_secret_client_id_config.json
    ${json_file}=    Load Json From File    ${CURDIR}/../test_data_files/client_secret_client_id_config.json

    #parse json obj and start conversion and trim
    ${json_file}=	Get Value From Json	${json_file}	$..client_id
    ${CLIENT_ID}=    Convert JSON To String	${json_file}
    ${CLIENT_ID}=    Evaluate    ${CLIENT_ID}[1:-1].strip('"')    json
    Log    ${CLIENT_ID}

    #import json from file
    ${json_file}=    Get File    ${CURDIR}/../test_data_files/client_secret_client_id_config.json
    ${json_file}=    Load Json From File    ${CURDIR}/../test_data_files/client_secret_client_id_config.json

    #parse json obj and start conversion and trim
    ${json_file}=	Get Value From Json	${json_file}	$..client_secret
    ${CLIENT_SECRET}=    Convert JSON To String	${json_file}
    ${CLIENT_SECRET}=    Evaluate    ${CLIENT_SECRET}[1:-1].strip('"')    json
    Log    ${CLIENT_SECRET}

    Set Global Variable    ${CLIENT_ID_FROM_JSON_FILE}    ${CLIENT_ID}
    Set Global Variable    ${CLIENT_SECRET_FROM_JSON_FILE}    ${CLIENT_SECRET}

Top Up/Deduct Points
    [Documentation]  https://docs.ascenda.com/reference/createpointadjustment
    [Arguments]    ${endpoint}
    ...    ${adjustment_type}
    ...    ${user_id}
    ...    ${descriptor}
    ...    ${amount}
    ...    ${reference_id}
    ...    ${reason}
    ...    ${expiry}
    &{headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}   Content-Type=application/json
    &{body}=    Create Dictionary
    ...    adjustment_type=${adjustment_type}
    ...    user_id=${user_id}
    ...    descriptor=${descriptor}
    ...    amount=${amount}
    ...    reference_id=${reference_id}
    ...    reason=${reason}
    ...    expiry=${expiry}
    ${body_json}=    Json.Dumps    ${body}
    ${resp}=    POST On Session
    ...     API_SESSION
    ...     ${endpoint}
    ...     data=${body_json}
    ...     headers=${headers}
    ...     expected_status=201

Create Login Link
    [Documentation]  https://docs.ascenda.com/reference/post_users-id-login-link
    [Arguments]    ${endpoint}
    ...    ${session_reference}
    &{headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}   Content-Type=application/json
    &{body}=    Create Dictionary
    ...    session_reference=${session_reference}
    ${body_json}=    Json.Dumps    ${body}
    ${resp}=    POST On Session
    ...     API_SESSION
    ...     ${endpoint}
    ...     data=${body_json}
    ...     headers=${headers}
    ...     expected_status=200
    Log  ${resp.json()}
    ${GENERATED_LOGIN_LINK}=    Set Variable  ${resp.json()['login_link']}
    Set Global Variable    ${GENERATED_LOGIN_LINK}    ${resp.json()['login_link']}

Generate Random User Data
    [Documentation]  Keyword to generate random data for user
    ${PARTNER_USER_ID}=  Generate Random String
    Set Global Variable  ${PARTNER_USER_ID}
    ${RANDOM_EMAIL}=  Email
    Set Global Variable  ${RANDOM_EMAIL}
    ${RANDOM_FNAME}=  First Name
    Set Global Variable  ${RANDOM_FNAME}
    ${RANDOM_LNAME}=  Last Name
    Set Global Variable  ${RANDOM_LNAME}
    ${RANDOM_COUNTRY_CODE}=  Country Code
    Set Global Variable  ${RANDOM_COUNTRY_CODE}

Assert Webhook Payload User Should Be Enrolled
    [Documentation]  Keyword to assert json payload that user status is "enrolled"
    Should Be Equal    ${WEBHOOK_RESPONSE.json()['data']['status']}    enrolled
