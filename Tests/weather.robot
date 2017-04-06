*** Settings ***
Documentation     A test suite with a tests to assert  servises.

Library           ../libraries/RequestDemoLibrary.py
Library           ../libraries/PostgreLibrary.py
Library           Collections
Resource          Common.robot

*** Variables ***
${STATUSCODE}     200

*** Test Cases ***
Test request weather by name
    ${city_dict}  get random city
    ${city_name}  Get From Dictionary  ${city_dict}  name
    request weather by city name  ${city_name}
    Status Code Should Be  ${STATUSCODE}

    ${actual_data}  get response json
    Assert response for all cities by name  ${city_name}  ${actual_data}

Test request weather by name and country
    ${city_dict}  get random city
    ${city_name}  Get From Dictionary  ${city_dict}  name
    ${city_country}  Get From Dictionary  ${city_dict}  country
    request weather by city name and country code  ${city_name}  ${city_country}
    Status Code Should Be  ${STATUSCODE}

    ${actual_data}  get response json
    Assert response for all cities by name  ${city_name}  ${actual_data}

Test request weather by id
    ${city_dict}  get random city
    ${city_id}  Get From Dictionary  ${city_dict}  _id
    request weather by city id  ${city_id}
    Status Code Should Be  ${STATUSCODE}

    ${actual_data}  get response json
    Assert responce with db data  ${city_dict}  ${actual_data}

Test request weather by coordinates
    ${city_dict}  get random city
    ${lat}  Get From Dictionary  ${city_dict}  lat
    ${lon}  Get From Dictionary  ${city_dict}  lon
    request weather by coordinates  ${lat}  ${lon}
    Status Code Should Be  ${STATUSCODE}

    ${actual_data}  get response json
    Assert responce with db data  ${city_dict}  ${actual_data}

Test request weather for several city IDs
    ${first_city_dict}  get random city
    ${second_city_dict}  get random city
    ${first_city_id}  Get From Dictionary  ${first_city_dict}  _id
    ${second_city_id}  Get From Dictionary  ${second_city_dict}  _id
    request weather for several cities  ${first_city_id}  ${second_city_id}
    Status Code Should Be  ${STATUSCODE}

    Assert several sities responce  ${first_city_dict}  ${second_city_dict}


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