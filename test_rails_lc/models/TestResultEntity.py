from test_rails_lc.models.BaseEntity import BaseEntity


class TestResultEntity(BaseEntity):
    def __init__(self):
        self.status_id = None
        self.comment = None
