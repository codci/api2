from test_rails_lc.models.BaseEntity import BaseEntity


class TestSuiteEntity(BaseEntity):
    def __init__(self):
        self.description = None
        self.name = None
