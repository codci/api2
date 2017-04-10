# Service properties
url_main = 'http://api.openweathermap.org/data/2.5/{}'
by_city_name = url_main.format('weather?q={}&APPID={}')
by_city_name_country = url_main.format('weather?q={},{}&APPID={}')
by_city_id = url_main.format('weather?id={}&APPID={}')
fo_group_by_city_id = url_main.format('group?id={}&APPID={}')
by_location = url_main.format('weather?lat={}&lon={}&APPID={}')

# DB properties
database_name = 'nbrb'
db_username = 'postgres'
db_user_password = 'qwerty321'
db_host = 'localhost'
db_port = '5432'

# Json schemas
valid_json_schema = 'Resources\json_schemas\weather_valid_schema.json'
error_json_schema = 'Resources\json_schemas\weather_error_schema.json'
