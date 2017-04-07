import requests

from Resources.settings import *


class RequestDemoLibrary(object):
    def __init__(self):
        self.response = None
        self.appid = '5cd28c042b69726f86aea45ec4a0fb38'

    def request_weather_by_city_name(self, city_name):
        """
        Send request to api.openweathermap.org/data/2.5/weather?q={city_name}&APPID={UID}
        :param city_name: name of the city f.e 'Avenir'
        """
        url = by_city_name.format(city_name, self.appid)
        print url
        self.response = requests.get(url)
        return self

    def request_weather_by_city_name_and_country_code(self, city_name, country_code):
        """
        Send request to api.openweathermap.org/data/2.5/weather?q={city name},{country_code}&APPID={UID}
        :param city_name: name of the city f.e 'Aylsham'
        :param country_code: code of country f.e 'CA'
        """
        url = by_city_name_country.format(city_name, country_code, self.appid)
        print url
        self.response = requests.get(url)
        return self

    def request_weather_by_city_id(self, city_id):
        """
        Send request to api.openweathermap.org/data/2.5/weather?id={city id}&APPID={UID}
        :param city_id: ID of the city f.e 6176150
        """
        url = by_city_id.format(city_id, self.appid)
        print url
        self.response = requests.get(url)
        return self

    def request_weather_by_coordinates(self, lat, lon):
        """
        Send request to api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&APPID={UID}
        :param lat: latitude f.e 50.900108
        :param lon: longitude f.e -111.551758
        """
        url = by_location.format(lat, lon, self.appid)
        print url
        self.response = requests.get(url)
        return self

    def request_weather_for_several_cities(self, *args):
        """
        :param city_name: name of the city f.e 'Avenir'
        """
        sity_id = ",".join(map(str, args))
        url = fo_group_by_city_id.format(sity_id, self.appid)
        print url
        self.response = requests.get(url)
        return self

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

    def get_response_authorization_status(self):
        """
        Get response authorization status value from the text of response
        :return: response authorization status
        """
        if self.response.headers.get('content-type') == "application/json":
            return self.response.json()['authenticated']
        else:
            return False

    def get_response_header(self):
        """
        Get response header value from the text of response
        :return: response header value
        """
        if self.response.headers.get('content-type') == "application/json":
            return self.response.json()['headers']
        else:
            return False
