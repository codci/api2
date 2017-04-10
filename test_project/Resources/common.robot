*** Settings ***
Documentation     A test suite with a tests to assert  servises.

Library           ../api_call_builders/RequestDemoLibrary.py
Library           ../sql_query_builders/PostgreLibrary.py
Library           ../Libraries/JSONSchemaValidator.py
Library           Collections
Library           SSHLibrary


*** Variables ***
${HOST}      qa-auto-07
${USERNAME}  testuser
${PASSWORD}  P@ssword123@!

${NON_EXISTENT_CITY_NAME}  qwerty
${INVALID_CITY_NAME}  qwertyuiop
${NON_EXISTENT_CITY_ID}  123123123
${NON_EXISTENT_CITY_ID_2}  1234567801
${INVALID_CITY_ID}  qwertyuiop
${INVALID_CITY_ID_2}  qwertyuioa
${INVALID_COUNTRY_CODE}  QWERTY
${INVALID_COORDINATE}  1234.56789
${STATUSCODE}     200
${STATUSCODE 404}  404
${STATUSCODE 400}  400
${STATUSCODE 0}  0

${404_MESAGE}  city not found
${400_MESAGE_city_id_group}  ${INVALID_CITY_ID}  is not a city id
${400_MESAGE_city_id_single}  ${INVALID_CITY_ID}  is not a city ID
${400_MESAGE_coordanate}  ${INVALID_COORDINATE}  is not a float
${0_MESAGE}  Error

*** Keywords ***
Status Code Should Be
    [Arguments]  ${expected_response_code}
    ${status}  Get Response Status Code
    Should Be Equal  ${status}  ${expected_response_code}


Assert several sities responce
    [Arguments]  ${first_exp_data}  ${second_exp_data}
    ${expected_data_lsit}  create list  ${first_exp_data}  ${second_exp_data}
    ${actual_data}  get response json
    ${actual_data_list}  Pop From Dictionary  ${actual_data}  list
    : FOR    ${act_data}    ${exp_data}    IN ZIP    ${actual_data_list}    ${expected_data_lsit}
    \    Assert responce with db data  ${exp_data}  ${act_data}

Parse response
    [Arguments]  ${actual_data}
    ${id}  Get From Dictionary  ${actual_data}  id
    ${name}  Get From Dictionary  ${actual_data}  name
    ${sys}  Get From Dictionary  ${actual_data}  sys
    ${country}  Get From Dictionary  ${sys}  country
    ${coord}  Get From Dictionary  ${actual_data}  coord
    ${lat}  Get From Dictionary  ${coord}  lat
    ${lon}  Get From Dictionary  ${coord}  lon

    ${actual_data_list}  Create List  ${id}  ${name}  ${country}  ${lat}  ${lon}
    [return]  ${actual_data_list}

Assert responce with db data
    [Arguments]  ${expected_data}  ${actual_data}
    ${id}  Get From Dictionary  ${expected_data}  _id
    Dictionary Should Contain Item  ${actual_data}  id  ${id}

    ${name}  Get From Dictionary  ${expected_data}  name
    Dictionary Should Contain Item  ${actual_data}  name  ${name}

    ${sys}  Get From Dictionary  ${actual_data}  sys
    ${country}  Get From Dictionary  ${expected_data}  country
    Dictionary Should Contain Item  ${sys}  country  ${country}

    ${coord}  Get From Dictionary  ${actual_data}  coord
    ${lat}  Get From Dictionary  ${expected_data}  lat
    ${lat}  Round coordinates  ${lat}
    Dictionary Should Contain Item  ${coord}  lat  ${lat}

    ${lon}  Get From Dictionary  ${expected_data}  lon
    ${lon}  Round coordinates   ${lon}
    Dictionary Should Contain Item  ${coord}  lon  ${lon}


Assert response for all cities by name
    [Arguments]  ${name}  ${response}
    ${actual_data_list}  parse response  ${response}
    ${exp_data_list}  get city by name  ${name}
    List Should Contain Value  ${exp_data_list}  ${actual_data_list}

Round coordinates
    [Arguments]  ${value}
    ${value}  Evaluate  "%.2f" % ${value}
    ${value}  Evaluate  "%g" % ${value}
    [return]  ${value}

Teardown action
    Run Keyword If Test Failed   Connection by ssh

Connection by ssh
    Open Connection  ${HOST}
    Login  ${USERNAME}  ${PASSWORD}
    ${output}=  Execute Command  cat /home/testuser/logs/log.log | grep ERROR
    Log  ${output}  ERROR
    Close Connection
