import uuid

from framework.interface_drivers.http.RequestFr import RequestFr
from tr.Entities.TestCaseEntity import TestCaseEntity
from tr.settings import *


class RequestTestRails(RequestFr):
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

    def request_add_suite(self, project_id):
        """
        send api request to create suite by project id, url:
        https://testrail.a1qa.com/index.php?/api/v2/add_suite/:project_id
        """
        self.url = self._generate_url(api_add_suite, project_id=project_id)
        self.set_header(**content_type)
        self.set_json(name="sdi2", description="auto")
        self.send_post()
        return self

    def request_add_section(self, project_id, suite_id):
        """
        send api request to create section by project id and suite_id, url:
        https://testrail.a1qa.com/index.php?/api/v2/add_section/:project_id
        """
        self.url = self._generate_url(api_add_section, project_id=project_id)
        self.set_header(**content_type)
        self.set_json(suite_id=suite_id, name="new section")
        self.send_post()
        return

    def request_add_test_case(self, section_id, a):
        """
        send api request to create test case by section_id, url:
        https://testrail.a1qa.com/index.php?/api/v2/add_case/:section_id
        """
        self.url = self._generate_url(api_add_tc, section_id=section_id)
        self.set_header(**content_type)
        # self.set_json(**a)
        self.set_json(
            title="test tk", template_id=1, type_id=7, priority_id=3, custom_preconds="some prec",
            custom_steps="some steps", custom_expected="some results"
        )
        self.send_post()
        return self

    def request_add_test_run(self, project_id, suite_id):
        """
        send api request to create test run by project_id, suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/add_run/:project_id
        """
        self.url = self._generate_url(api_add_run, project_id=project_id)
        self.set_header(**content_type)
        self.set_json(suite_id=suite_id, name="run s", include_all=True)

        self.send_post()
        return self

    def request_add_test_results(self, run_id, tests_list):
        """
        send api request to set test results for all test in test run by run_id:
        https://testrail.a1qa.com/index.php?/api/v2/add_results/:run_id
        """
        self.url = self._generate_url(api_add_results, run_id=run_id)
        self.set_header(**content_type)

        results = []
        result = {}
        for test in tests_list:
            result["test_id"] = test
            result["status_id"] = 1
            result["comment"] = "Pass"
            results.append(result)

        self.set_json(results=results)

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

    def api_del_suite(self, suite_id):
        """
        send api request to delete test suite by suite_id:
        https://testrail.a1qa.com/index.php?/api/v2/delete_suite/:suite_id
        """
        self.url = self._generate_url(api_del_section, suite_id=suite_id)
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

    @staticmethod
    def uniqual_string(template):
        return uuid.uuid4().hex

    @staticmethod
    def uniqual_string(template):
        return uuid.uuid4().hex

# RequestTestRails().request_get_suite(855)
# RequestTestRails().request_add_test_results(2, [1, 3, 4, 5])
a = TestCaseEntity()
