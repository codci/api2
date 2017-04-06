*** Settings ***
Documentation     A test suite with a tests to assert  servises.

Library           ../libraries/RequestDemoLibrary.py
Library           ../libraries/PostgreLibrary.py
Library           Collections
Resource          Common.robot

*** Variables ***
${STATUSCODE}     404
${INVALID_SITY_NAME}  incorrect_city
${INVALID_SITY_CODE}  123456789

*** Test Cases ***
Test request weather by name invalid value
    request weather by city name  ${INVALID_SITY_NAME}
    Status Code Should Be  ${STATUSCODE}
    ${responce}  get response json

Test request weather by name and country invalid city name
    ${city_dict}  get random city
    ${city_country}  Get From Dictionary  ${city_dict}  country
    request weather by city name and country code  ${INVALID_SITY_NAME}  ${city_country}
    Status Code Should Be  ${STATUSCODE}
    ${responce}  get response json

Test request weather by name and country invalid country code
    ${city_dict}  get random city
    ${city_name}  Get From Dictionary  ${city_dict}  name
    request weather by city name and country code  ${city_name}  ${INVALID_SITY_NAME}
    Status Code Should Be  ${STATUSCODE}
    ${responce}  get response json

Test request weather by name and country invalid city name and country code
    request weather by city name and country code  ${INVALID_SITY_NAME}  ${INVALID_SITY_NAME}
    Status Code Should Be  ${STATUSCODE}
    ${responce}  get response json

Test request weather by city id invalid value
    request weather by city id  ${INVALID_SITY_CODE}
    Status Code Should Be  ${STATUSCODE}
    ${actual_data}  get response json


Test request weather for several city IDs one of the city name values is invalid
    ${second_city_dict}  get random city
    ${second_city_id}  Get From Dictionary  ${second_city_dict}  _id
    request weather for several cities  ${INVALID_SITY_CODE}  ${second_city_id}
    Status Code Should Be  ${STATUSCODE}
    ${responce}  get response json

Test request weather for several city IDs invalid values
    request weather for several cities  ${INVALID_SITY_CODE}  ${INVALID_SITY_CODE}
    Status Code Should Be  ${STATUSCODE}
    ${responce}  get response json



# *** Keywords ***
# Status Code Should Be
#     [Arguments]  ${expected_response_code}
#     ${status}  Get Response Status Code
#     Should Be Equal  ${status}  ${expected_response_code}
#
#
# Assert several sities responce
#     [Arguments]  ${first_exp_data}  ${second_exp_data}
#     ${expected_data_lsit}  create list  ${first_exp_data}  ${second_exp_data}
#
#     ${actual_data}  get response json
#     ${actual_data_list}  Pop From Dictionary  ${actual_data}  list
#     : FOR    ${act_data}    ${exp_data}    IN ZIP    ${actual_data_list}    ${expected_data_lsit}
#     \    Assert responce with db data  ${exp_data}  ${act_data}
#
# Parse response
#     [Arguments]  ${actual_data}
#
#     ${id}  Get From Dictionary  ${actual_data}  id
#     ${name}  Get From Dictionary  ${actual_data}  name
#     ${sys}  Get From Dictionary  ${actual_data}  sys
#     ${country}  Get From Dictionary  ${sys}  country
#     ${coord}  Get From Dictionary  ${actual_data}  coord
#     ${lat}  Get From Dictionary  ${coord}  lat
#     ${lon}  Get From Dictionary  ${coord}  lon
#
#     ${actual_data_list}  Create List  ${id}  ${name}  ${country}  ${lat}  ${lon}
#     [return]  ${actual_data_list}
#
# Assert responce with db data
#     [Arguments]  ${expected_data}  ${actual_data}
#     ${id}  Get From Dictionary  ${expected_data}  _id
#     Dictionary Should Contain Item  ${actual_data}  id  ${id}
#
#     ${name}  Get From Dictionary  ${expected_data}  name
#     Dictionary Should Contain Item  ${actual_data}  name  ${name}
#
#     ${sys}  Get From Dictionary  ${actual_data}  sys
#     ${country}  Get From Dictionary  ${expected_data}  country
#     Dictionary Should Contain Item  ${sys}  country  ${country}
#
#     ${coord}  Get From Dictionary  ${actual_data}  coord
#     ${lat}  Get From Dictionary  ${expected_data}  lat
#     ${lat}  Round coordinates  ${lat}
#     Dictionary Should Contain Item  ${coord}  lat  ${lat}
#
#     ${lon}  Get From Dictionary  ${expected_data}  lon
#     ${lon}  Round coordinates   ${lon}
#     Dictionary Should Contain Item  ${coord}  lon  ${lon}
#
#
# Assert response for all cities by name
#     [Arguments]  ${name}  ${response}
#     ${actual_data_list}  parse response  ${response}
#     ${exp_data_list}  get city by name  ${name}
#     List Should Contain Value  ${exp_data_list}  ${actual_data_list}
#
# Round coordinates
#     [Arguments]  ${value}
#     ${value}  Evaluate  "%.2f" % ${value}
#     ${value}  Evaluate  "%g" % ${value}
#     [return]  ${value}
#
#
#Convert response to dict
#    ${new_actual_data}  CREATE DICTIONARY
#    ${actual_data}  get response json
#    ${actual_data_list}  Pop From Dictionary  ${actual_data}  list  default=${actual_data}
#    : FOR    ${act_data}   IN    ${actual_data_list}
#     \    ${new_actual_data}  Evaluate  dict(${new_actual_data}.items() + ${act_data}.items())
#     [return]  ${new_actual_data}