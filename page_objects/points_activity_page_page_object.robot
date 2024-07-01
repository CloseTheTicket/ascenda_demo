*** Settings ***
Resource    ..${/}resources${/}setup.robot


*** Variables ***
${TOTAL_POINTS_TEXT}  xpath=//h2[@data-testid='formatted-points-balance']


*** Keywords ***
Assert Correct Current Total Rewards Points
    [Documentation]  Assert total value of rewards points
    [Arguments]  ${total_points}
    Get Text  selector=${TOTAL_POINTS_TEXT}  assertion_operator=equal  assertion_expected=${total_points}
