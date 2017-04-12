# settings to API
server_addr = "https://testrail.a1qa.com/index.php?"
api_add_suite = "/api/v2/add_suite/{project_id}"
api_add_section = "/api/v2/add_section/{project_id}"
api_add_tc = "/api/v2/add_case/{section_id}"
api_add_run = "/api/v2/add_run/{project_id}"
api_add_result = "/api/v2/add_result/{test_id}"

api_del_run = "/api/v2/delete_run/{run_id}"
api_del_tc = "/api/v2/delete_case/{case_id}"
api_del_section = "/api/v2/delete_section/{section_id}"
api_del_suite = "/api/v2/delete_suite/{suite_id}"


api_get_suite_by_id = "/api/v2/get_suite/{suite_id}"
api_get_tc_by_id = "/api/v2/get_case/{case_id}"
api_get_tests_by_run_id = "/api/v2/get_tests/{run_id}"

user = "d.sokol"
password = "sdiitra11"

content_type = {'Content-Type': 'application/json'}
