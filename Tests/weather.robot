*** Settings ***
Documentation     A test suite with a positive tests for api.openweathermap.org servises (call current weather data).

Library           ../Libraries/RequestDemoLibrary.py
Library           ../Libraries/PostgreLibrary.py
Library           Collections
Resource          ../Resources/common.robot
Test Teardown     Teardown action

*** Variables ***
${STATUSCODE}     200

*** Test Cases ***
Test request weather by name
    [Documentation]  1. Call current weather data By city name
    ${city_dict}  get random city
    ${city_name}  Get From Dictionary  ${city_dict}  name
    request weather by city name  ${city_name}
    Status Code Should Be  ${STATUSCODE}
    ${actual_data}  get response json
    Assert response for all cities by name  ${city_name}  ${actual_data}

Test request weather by name and country
    [Documentation]  2. Call current weather data By city name and country code
    ${city_dict}  get random city
    ${city_name}  Get From Dictionary  ${city_dict}  name
    ${city_country}  Get From Dictionary  ${city_dict}  country
    request weather by city name and country code  ${city_name}  ${city_country}
    Status Code Should Be  ${STATUSCODE}
    ${actual_data}  get response json
    Assert response for all cities by name  ${city_name}  ${actual_data}

Test request weather by id
    [Documentation]  3. Call current weather data By city id
    ${city_dict}  get random city
    ${city_id}  Get From Dictionary  ${city_dict}  _id
    request weather by city id  ${city_id}
    Status Code Should Be  ${STATUSCODE}
    ${actual_data}  get response json
    Assert responce with db data  ${city_dict}  ${actual_data}

Test request weather by coordinates
    [Documentation]  4. Call current weather data By geographic coordinates
    ${city_dict}  get random city
    ${lat}  Get From Dictionary  ${city_dict}  lat
    ${lon}  Get From Dictionary  ${city_dict}  lon
    request weather by coordinates  ${lat}  ${lon}
    Status Code Should Be  ${STATUSCODE}
    ${actual_data}  get response json
    Assert responce with db data  ${city_dict}  ${actual_data}

Test request weather for several city IDs
    [Documentation]  5. Call current weather data  for several city IDs
    ${first_city_dict}  get random city
    ${second_city_dict}  get random city
    ${first_city_id}  Get From Dictionary  ${first_city_dict}  _id
    ${second_city_id}  Get From Dictionary  ${second_city_dict}  _id
    request weather for several cities  ${first_city_id}  ${second_city_id}
    Status Code Should Be  ${STATUSCODE}
    Assert several sities responce  ${first_city_dict}  ${second_city_dict}
