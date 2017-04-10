*** Settings ***
Documentation     A test suite with negative tests to assert https://openweathermap.org/current servises.

Library           ../Libraries/RequestDemoLibrary.py
Library           ../Libraries/PostgreLibrary.py
Library           Collections
Resource          ../Resources/common.robot
Test Teardown     Teardown negative weather

*** Variables ***
${NON_EXISTENT_CITY_NAME}  qwerty
${INVALID_CITY_NAME}  qwertyuiop
${NON_EXISTENT_CITY_ID}  123123123
${NON_EXISTENT_CITY_ID_2}  1234567801
${INVALID_CITY_ID}  qwertyuiop
${INVALID_CITY_ID_2}  qwertyuioa
${INVALID_COUNTRY_CODE}  QWERTY
${INVALID_COORDINATE}  1234.56789
${STATUSCODE 404}  404
${STATUSCODE 400}  400
${STATUSCODE 0}  0

${404_MESAGE}  city not found
${400_MESAGE_city_id_group}  ${INVALID_CITY_ID}  is not a city id
${400_MESAGE_city_id_single}  ${INVALID_CITY_ID}  is not a city ID
${400_MESAGE_coordanate}  ${INVALID_COORDINATE}  is not a float
${0_MESAGE}  Error

*** Test Cases ***
Test request weather by name - non-existent value
    [Documentation]  6. Call current weather data By city name  non-existent value
    request weather by city name  ${NON_EXISTENT_CITY_NAME}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}

Test request weather by name - invalid value
    [Documentation]  7. Call current weather data By city name invalid value
    request weather by city name  ${INVALID_CITY_NAME}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}


Test request weather by name and country - invalid city name
    [Documentation]  8. Call current weather data By city name and country code invalid city name value
    ${city_dict}  get random city
    ${city_country}  Get From Dictionary  ${city_dict}  country
    request weather by city name and country code  ${INVALID_CITY_NAME}  ${city_country}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}

Test request weather by name and country - invalid country code
    [Documentation]  9. Call current weather data By city name and country code invalid country code value
    ${city_dict}  get random city
    ${city_name}  Get From Dictionary  ${city_dict}  name
    request weather by city name and country code  ${city_name}  ${INVALID_COUNTRY_CODE}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}

Test request weather by name and country - invalid city name and country code
    [Documentation]  10. Call current weather data By city name and country code invalid city name and country code values
    request weather by city name and country code  ${INVALID_CITY_NAME}  ${INVALID_COUNTRY_CODE}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}

Test request weather by name and country - city name and country code does not match
    [Documentation]  11. Call current weather data By city name and country code city name does not match with country code
    request weather by city name and country code  ${INVALID_CITY_NAME}  ${INVALID_COUNTRY_CODE}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}

Test request weather by city id invalid value
    [Documentation]  12. Call current weather data By city id invalid data
    request weather by city id  ${INVALID_CITY_ID}
    Status Code Should Be  ${STATUSCODE 400}
    Assert responce with error  ${STATUSCODE 400}  ${400_MESAGE_city_id_single}

Test request weather by city id - non existent value
    [Documentation]  13. Call current weather data By city id non existent id
    request weather by city id  ${NON_EXISTENT_CITY_ID}
    Status Code Should Be  ${STATUSCODE 404}
    Assert responce with error  ${STATUSCODE 404}  ${404_MESAGE}

Test request weather by geographic coordinates - lat is invalid value
    [Documentation]  14. Call current weather data By geographic coordinates lat is invalid value
    ${city_dict}  get random city
    ${lon}  Get From Dictionary  ${city_dict}  lon
    request weather by coordinates  ${INVALID_COORDINATE}  ${lon}
    Status Code Should Be  ${STATUSCODE 400}
    Assert responce with error  ${STATUSCODE 400}  ${400_MESAGE_coordanate}

Test request weather by geographic coordinates - lon is invalid value
    [Documentation]  15. Call current weather data By geographic coordinates lon is invalid value
    ${city_dict}  get random city
    ${lat}  Get From Dictionary  ${city_dict}  lat
    request weather by coordinates  ${lat}  ${INVALID_COORDINATE}
    Status Code Should Be  ${STATUSCODE 400}
    Assert responce with error  ${STATUSCODE 400}  ${400_MESAGE_coordanate}

Test request weather by geographic coordinates - invalid values
    [Documentation]  16. Call current weather data By geographic coordinates both values are invalid
    request weather by coordinates  ${INVALID_COORDINATE}  ${INVALID_COORDINATE}
    Status Code Should Be  ${STATUSCODE 400}
    Assert responce with error  ${STATUSCODE 400}  ${400_MESAGE_coordanate}

Test request weather for several city IDs - one of the has non-existan value
    [Documentation]  17. Call current weather data  for several city IDs one of the cities have non existent value
    ${city_dict}  get random city
    ${city_id}  Get From Dictionary  ${city_dict}  _id
    request weather for several cities  ${NON_EXISTENT_CITY_ID}  ${city_id}
    Status Code Should Be  ${STATUSCODE 0}
    Assert responce with error  ${STATUSCODE 0}  ${0_MESAGE}

Test request weather for several city IDs - both cities have non-existan value
    [Documentation]  18. Call current weather data  for several city IDs both cities have non existent values
    request weather for several cities  ${NON_EXISTENT_CITY_ID}  ${NON_EXISTENT_CITY_ID_2}
    Status Code Should Be  ${STATUSCODE 0}
    Assert responce with error  ${STATUSCODE 0}  ${0_MESAGE}

Test request weather for several city IDs - one of the city has incorrect format
    [Documentation]  19. Call current weather data for several city IDs one of the cities have incorrect format
    ${city_dict}  get random city
    ${city_id}  Get From Dictionary  ${city_dict}  _id
    request weather for several cities  ${city_id}  ${INVALID_CITY_ID}
    Status Code Should Be  ${STATUSCODE 400}
    Assert responce with error  ${STATUSCODE 400}  ${400_MESAGE_city_id_group}

Test request weather for several city IDs - incorrect values format
    [Documentation]  20. Call current weather data for several city IDs both cities have incorrect format
    request weather for several cities  ${INVALID_CITY_ID}  ${INVALID_CITY_ID_2}
    Status Code Should Be  ${STATUSCODE 400}
    Assert responce with error  ${STATUSCODE 400}  ${400_MESAGE_city_id_group}

Test request weather for several city IDs - same id values
    [Documentation]  21. Call current weather data for several city IDs both cities have same id value
    ${city_dict}  get random city
    ${city_id}  Get From Dictionary  ${city_dict}  _id
    request weather for several cities  ${city_id}  ${city_id}
    Status Code Should Be  ${STATUSCODE 0}
    Assert responce with error  ${STATUSCODE 0}  ${0_MESAGE}


*** Keywords ***
Generate expected responce dict
    [Arguments]  ${err_code}  ${err_message}
    ${error_dict}  create dictionary  cod=${err_code}  message=${err_message}
    [Return]  ${error_dict}

Assert responce with error
    [Arguments]  ${err_code}  ${err_msg}
    ${exp_responce}  Generate expected responce dict  ${err_code}  ${err_msg}
    ${act_responce}  get response json
    Should Be Equal  ${act_responce}  ${exp_responce}

Teardown negative weather
    ${responce}  get response json
    validate schema openweathermap  ${responce}  Error
    Teardown action