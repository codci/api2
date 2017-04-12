from test_rails_lc.models.BaseEntity import BaseEntity


class TestCaseEntity(BaseEntity):
    def __init__(self):
        self.title = None
        self.template_id = None
        self.type_id = None
        self.priority_id = None
        self.custom_preconds = None
        self.custom_steps = None
        self.custom_expected = None
