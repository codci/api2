import requests


class RequestFr(object):
    def __init__(self):
        self.url = None
        self.header = None
        self.cookie = None
        self.body = None
        self.json = None
        self.auth = None

        self.response = None

    def get_response_status_code(self):
        """
        Get response status code
        :return: status code
        """
        return str(self.response.status_code)

    def get_response_text(self):
        """
        Get response text
        :return: response text
        """
        return self.response.text

    def get_response_json(self):
        """
        Get response json
        :return: response json
        """
        return self.response.json()

    def get_response_header(self):
        """
        Get response header value from the text of response
        :return: response header value
        """
        if self.response.headers.get('content-type') == "application/json":
            return self.response.json()['headers']
        else:
            return False

    def send_post(self):
        self.response = requests.post(url=self.url, data=self.body, json=self.json, auth=self.auth, headers=self.header)
        return self

    def send_get(self):
        self.response = requests.get(url=self.url, auth=self.auth, headers=self.header)
        return self

    def set_body(self, **kwargs):
        """
        """
        self.body = {}
        self.body.update(kwargs)
        return self

    def set_header(self, **kwargs):
        """
        """
        self.header = {}
        self.header.update(kwargs)
        return self

    def set_json(self, obj):
        """
        """
        self.json = {}
        if str(type(obj)).startswith("<class"):
            self.json.update(**obj.__dict__)
        else:
            self.json.update(obj)

        # self.json.update(kwargs)
        return self
