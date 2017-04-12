*** Settings ***
Documentation    Suite description
Library           ../api_call_builders/RequestTR.py
Library           ../models/values_set.py
Library           Collections

*** Variables ***
${Project_id}   2

*** Test Cases ***
Test test case life cicle
    [Documentation]  Emulate testcase lifecicle in testrails system
    ${suite_id}  create test suite  ${Project_id}
    ${section_id}  create section  ${Project_id}  ${suite_id}
    ${test_case_id}  create test case  ${section_id}
    assert test case data  ${test_case_id}
    ${test_run_id}  create test run  ${Project_id}  ${suite_id}
    ${test_id}  Get test id from test run  ${test_run_id}
    set test result to test case  ${test_id}
    delete test run  ${test_run_id}
    delete test case  ${test_case_id}
    delete test suite section  ${section_id}
    delete test suite  ${suite_id}

*** Keywords ***
Create test suite
    [Documentation]  1-2. request to create suite, assert responce status code and get id of the created suite
    [Arguments]  ${project_id}
    ${ts_entity}  create test suite entity
    ${ts_dict}  call method  ${ts_entity}  get_dict

    request add suite  ${project_id}  ${ts_dict}
    status code should be  200
    ${responce}  get response json
    ${suite_id}  Get From Dictionary  ${responce}  id
    [Return]  ${suite_id}

Create section
    [Documentation]  3-4. request to create section in suite, assert responce status code and get id of the created section
    [Arguments]  ${project_id}  ${suite_id}
    ${section_entity}  create test section entity  ${suite_id}
    ${section_dict}  call method  ${section_entity}  get_dict

    request add section  ${project_id}  ${section_dict}
    status code should be  200
    ${responce}  get response json
    ${section_id}  Get From Dictionary  ${responce}  id
    [Return]  ${section_id}

Create test case
    [Documentation]  5. request to create test case, assert responce status code and get id of the created test case
    [Arguments]  ${section_id}
    ${tc_entity}  create test case entity
    ${tc_dict}  call method  ${tc_entity}  get_dict

    request add test case  ${section_id}  ${tc_dict}
    status code should be  200
    ${responce}  get response json
    ${test_case_id}  Get From Dictionary  ${responce}  id
    [Return]  ${test_case_id}

Assert test case data
    [Documentation]  6. request to get test case by id and assert all fields are same with template
    [Arguments]  ${test_case_id}
    request get test case  ${test_case_id}
    status code should be  200
    ${responce}  get response json
    # assert json data with что-то

Create test run
    [Documentation]  7-8. request to create test run, assert responce status code and get id of the created test run
    [Arguments]  ${project_id}  ${suite_id}
    ${run_entity}  create test run entity  ${suite_id}
    ${run_dict}  call method  ${run_entity}  get_dict

    request add test run  ${project_id}  ${run_dict}
    status code should be  200
    ${responce}  get response json
    ${test_run_id}  Get From Dictionary  ${responce}  id
    [Return]  ${test_run_id}

Set test result to test case
    [Documentation]  9. request to add results of test case, assert responce status code
    [Arguments]  ${test_id}
    ${result_entity}  create test result entity
    ${result_dict}  call method  ${result_entity}  get_dict

    request add test results  ${test_id}  ${result_dict}
    ${responce}  get response json
    status code should be  200

Delete test run
    [Documentation]  10. request to delete test run, assert responce status code
    [Arguments]  ${run_id}
    request del run  ${run_id}
    status code should be  200

Delete test case
    [Documentation]  11. request to delete test case, assert responce status code
    [Arguments]  ${test_case_id}
    request del test case  ${test_case_id}
    status code should be  200

Delete test suite section
    [Documentation]  12. request to delete test suite section, assert responce status code
    [Arguments]  ${section_id}
    request del section  ${section_id}
    status code should be  200

Delete test suite
    [Documentation]  13. request to delete test suite, assert responce status code
    [Arguments]  ${suite_id}
    request del suite  ${suite_id}
    status code should be  200

Status Code Should Be
    [Arguments]  ${expected_response_code}
    ${status}  Get Response Status Code
    Should Be Equal  ${status}  ${expected_response_code}

Get test id from test run
    [Arguments]  ${run_id}
    request get tests from test run  ${run_id}
    status code should be  200
    ${responce}  get response json
    ${test}  get from list  ${responce}  0
    ${test_id}  Get From Dictionary  ${test}  id
    [Return]  ${test_id}
