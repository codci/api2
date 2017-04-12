from test_rails_lc.models.BaseEntity import BaseEntity


class TestSectionEntity(BaseEntity):
    def __init__(self):
        self.suite_id = None
        self.name = None
