from test_rails_lc.models.BaseEntity import BaseEntity


class TestRunEntity(BaseEntity):
    def __init__(self):
        self.suite_id = None
        self.name = None
        self.include_all = None
