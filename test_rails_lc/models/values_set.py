from framework.support.common_functons import get_unique_string_from_template

from framework.support.common_functons import get_random_digit
from test_rails_lc.models.TestCaseEntity import TestCaseEntity
from test_rails_lc.models.TestResultEntity import TestResultEntity
from test_rails_lc.models.TestRunEntity import TestRunEntity
from test_rails_lc.models.TestSectionEntity import TestSectionEntity
from test_rails_lc.models.TestSuiteEntity import TestSuiteEntity


def create_test_case_entity():
    tce = TestCaseEntity()
    tce.title = get_unique_string_from_template("tk-{}")
    tce.template_id = 1
    tce.type_id = 7
    tce.priority_id = get_random_digit(1, 4)
    tce.custom_preconds = get_unique_string_from_template("precondition {}")
    tce.custom_steps = get_unique_string_from_template("steps: {}")
    tce.custom_expected = get_unique_string_from_template("results: {}")
    return tce


def create_test_result_entity():
    tre = TestResultEntity()
    tre.status_id = get_random_digit(1, 2)
    tre.comment = get_unique_string_from_template("comment: {}")
    return tre


def create_test_run_entity(suite_id):
    trne = TestRunEntity()
    trne.suite_id = suite_id
    trne.name = get_unique_string_from_template("run_name - {}")
    trne.include_all = True
    return trne


def create_test_section_entity(suite_id):
    tscne = TestSectionEntity()
    tscne.suite_id = suite_id
    tscne.name = get_unique_string_from_template("section_name - {}")
    return tscne


def create_test_suite_entity():
    tse = TestSuiteEntity()
    tse.description = get_unique_string_from_template("suite_description: {}")
    tse.name = get_unique_string_from_template("suite_name - {}")
    return tse
