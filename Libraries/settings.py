# url_main = 'http://www.nbrb.by/API/ExRates/{}'
# rates = "/Rates/{}"

url_main = 'http://api.openweathermap.org/data/2.5/{}'
by_city_name = url_main.format('weather?q={}&APPID={}')
by_city_name_country = url_main.format('weather?q={},{}&APPID={}')
by_city_id = url_main.format('weather?id={}&APPID={}')
fo_group_by_city_id = url_main.format('group?id={}&APPID={}')
by_location = url_main.format('weather?lat={}&lon={}&APPID={}')