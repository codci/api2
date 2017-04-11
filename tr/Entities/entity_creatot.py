from tr.Entities.TestCaseEntity import TestCaseEntity
from tr.Entities.TestResultEntity import TestResultEntity
from tr.Entities.TestRunEntity import TestRunEntity
from tr.Entities.TestSectionEntity import TestSectionEntity
from tr.Entities.TestSuiteEntity import TestSuiteEntity


def create_test_case_entity():
    tce = TestCaseEntity()
    tce.title = "test tk"
    tce.template_id = 1
    tce.type_id = 7
    tce.priority_id = 3
    tce.custom_preconds = "some prec"
    tce.custom_steps = "some steps"
    tce.custom_expected = "some results"
    return tce


def create_test_result_entity():
    tre = TestResultEntity()
    tre.test_id = 5
    tre.status_id = 1
    tre.comment = "Pass"
    return tre


def create_test_run_entity():
    trne = TestRunEntity()
    trne.suite_id = 5
    trne.name = "run s"
    trne.include_all = True
    return trne


def create_test_section_entity():
    tscne = TestSectionEntity()
    tscne.suite_id = 777
    tscne.name = "new section"
    return tscne


def create_test_suite_entity():
    tse = TestSuiteEntity()
    tse.description = "sdi2"
    tse.name = "auto"
    return tse

