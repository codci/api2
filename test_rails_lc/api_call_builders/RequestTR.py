from framework.interface_drivers.http.RequestFr import RequestFr
from test_rails_lc.settings import user, password, server_addr, api_add_suite, content_type, api_del_suite,\
    api_get_tests_by_run_id, api_add_section, api_del_tc, api_add_result, api_add_run, api_add_tc, api_del_run,\
    api_del_section, api_get_suite_by_id, api_get_tc_by_id


class RequestTR(RequestFr):
    def __init__(self):
        RequestFr.__init__(self)
        self.auth = (user, password)

    @staticmethod
    def _generate_url(api_path, **kwargs):
        """
        get url from server path and api path
        :param api_path:
        :return: full api url path
        """
        return server_addr + api_path.format(**kwargs)

    def request_add_suite(self, project_id, ts_body):
        """
        send api request to create suite by project id, url:
        https://testrail.a1qa.com/index.php?/api/v2/add_suite/:project_id
        """
        self.url = self._generate_url(api_add_suite, project_id=project_id)
        self.set_header(**content_type)
        self.set_json(ts_body)
        self.send_post()
        return self

    def request_add_section(self, project_id, section_body):
        """
        send api request to create section by project id and suite_id, url:
        https://testrail.a1qa.com/index.php?/api/v2/add_section/:project_id
        """
        self.url = self._generate_url(api_add_section, project_id=project_id)
        self.set_header(**content_type)
        self.set_json(section_body)
        self.send_post()
        return

    def request_add_test_case(self, section_id, tc_body):
        """
        send api request to create test case by section_id, url:
        https://testrail.a1qa.com/index.php?/api/v2/add_case/:section_id
        """
        self.url = self._generate_url(api_add_tc, section_id=section_id)
        self.set_header(**content_type)
        self.set_json(tc_body)
        self.send_post()
        return self

    def request_add_test_run(self, project_id, run_body):
        """
        send api request to create test run by project_id, suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/add_run/:project_id
        """
        self.url = self._generate_url(api_add_run, project_id=project_id)
        self.set_header(**content_type)
        self.set_json(run_body)
        self.send_post()
        return self

    def request_add_test_results(self, test_id, result_body):
        """
        send api request to set test results for all test in test run by run_id:
        https://testrail.a1qa.com/index.php?/api/v2/add_results/:run_id
        """
        self.url = self._generate_url(api_add_result, test_id=test_id)
        self.set_header(**content_type)
        self.set_json(result_body)
        self.send_post()
        return self

    def request_del_run(self, run_id):
        """
        send api request to delete test run by run_id:
        https://testrail.a1qa.com/index.php?/api/v2/delete_run/:run_id
        """
        self.url = self._generate_url(api_del_run, run_id=run_id)
        self.set_header(**content_type)
        self.send_post()
        return self

    def request_del_test_case(self, case_id):
        """
        send api request to delete test case by case_id:
        https://testrail.a1qa.com/index.php?/api/v2/delete_case/:case_id
        """
        self.url = self._generate_url(api_del_tc, case_id=case_id)
        self.set_header(**content_type)
        self.send_post()
        return self

    def request_del_section(self, section_id):
        """
        send api request to delete section by section_id:
        https://testrail.a1qa.com/index.php?/api/v2/delete_section/:section_id
        """
        self.url = self._generate_url(api_del_section, section_id=section_id)
        self.set_header(**content_type)
        self.send_post()
        return self

    def request_del_suite(self, suite_id):
        """
        send api request to delete test suite by suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/delete_suite/:suite_id
        """
        self.url = self._generate_url(api_del_suite, suite_id=suite_id)
        self.set_header(**content_type)
        self.send_post()
        return self

    def request_get_suite(self, suite_id):
        """
        send api request to get test suite by suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/get_suites/:suite_id
        """
        self.url = self._generate_url(api_get_suite_by_id, suite_id=suite_id)
        self.set_header(**content_type)
        self.send_get()
        return self

    def request_get_test_case(self, case_id):
        """
        send api request to get test suite by suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/get_suites/:suite_id
        """
        self.url = self._generate_url(api_get_tc_by_id, case_id=case_id)
        self.set_header(**content_type)
        self.send_get()
        return self

    def request_get_tests_from_test_run(self, run_id):
        """
        send api request to get test suite by suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/get_suites/:suite_id
        """
        self.url = self._generate_url(api_get_tests_by_run_id, run_id=run_id)
        self.set_header(**content_type)
        self.send_get()
        return self
