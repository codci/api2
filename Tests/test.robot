*** Settings ***
Documentation     A test suite with a tests to assert  servises.

Library           ../libraries/RequestDemoLibrary.py
Library           ../libraries/PostgreLibrary.py
Library           Collections

*** Variables ***
${STATUSCODE}     200

*** Test Cases ***
Test request weather by name
    ${city_name}  get random city
    request weather by city name  ${city_name}
    Status Code Should Be  ${STATUSCODE}
    Assert responce with db data  ${city_name}

Test request weather by name and country
    ${city_name_and_country}  get random city and country
    ${name}  Get From Dictionary  ${city_name_and_country}  name
    ${country}  Get From Dictionary  ${city_name_and_country}  country
    request weather by city name and country code  ${name}  ${country}
    Status Code Should Be  ${STATUSCODE}
    Assert responce with db data  ${city_name}

Test request weather by id
    ${city_id}  get random city id
    request weather by city id  ${city_id}
    Status Code Should Be  ${STATUSCODE}

Test request weather by coordinates
    ${city_coord}  get random geographic coordinates
    ${lat}  Get From Dictionary  ${city_coord}  lat
    ${lon}  Get From Dictionary  ${city_coord}  lon
    request weather by coordinates  ${lat}  ${lon}
    Status Code Should Be  ${STATUSCODE}

Test request weather for several city IDs
    ${second_city_id}  get random city id
    ${first_city_id}  get random city id
    request weather for several cities  ${first_city_id}  ${second_city_id}
    Status Code Should Be  ${STATUSCODE}


*** Keywords ***
Status Code Should Be
    [Arguments]  ${expected_response_code}
    ${status}  Get Response Status Code
    Should Be Equal  ${status}  ${expected_response_code}


Get expected data by name
    [Arguments]  ${city_name}
    ${expected_data}  get city by name  ${city_name}


Get expected data by id
    [Arguments]  ${city_name}
    ${expected_data}  get city by name  ${city_name}


Get expected data by location
    [Arguments]  ${city_name}
    ${expected_data}  get city by name  ${city_name}


Assert responce with db data
    [Arguments]  ${expected_data}
    ${actual_data}  get response json

    ${id}  Get From Dictionary  ${expected_data}  _id
    Dictionary Should Contain Item  ${actual_data}  id  ${id}

    ${name}  Get From Dictionary  ${expected_data}  name
    Dictionary Should Contain Item  ${actual_data}  name  ${name}

    ${sys}  Get From Dictionary  ${actual_data}  sys
    ${country}  Get From Dictionary  ${expected_data}  country
    Dictionary Should Contain Item  ${sys}  country  ${country}

    ${coord}  Get From Dictionary  ${actual_data}  coord
    ${lat}  Get From Dictionary  ${expected_data}  lat
    ${lat}  Evaluate  "%.2f" % ${lat}
    Dictionary Should Contain Item  ${coord}  lat  ${lat}

    ${lon}  Get From Dictionary  ${expected_data}  lon
    ${lon}  Evaluate  "%.2f" % ${lon}
    Dictionary Should Contain Item  ${coord}  lon  ${lon}