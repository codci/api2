import json

import psycopg2 as psycopg2
import re
from jsonpath_rw import parse
import psycopg2.extras


class FillDBFromJson(object):
    def __init__(self):
        self.json = "city.list.json"
        self.database = 'nbrb'
        self.db_user = 'postgres'
        self.db_password = 'qwerty321'
        self.db_host = 'localhost'
        self.db_port = '5432'

    def parse_json(self):
        """
        Fill database with values from json file - self.json
        """
        conn = psycopg2.connect(database=self.database, user=self.db_user, password=self.db_password, host=self.db_host,
                                port=self.db_port)
        cur = conn.cursor()
        with open(self.json) as json_data:
            d = json.load(json_data)

            for loop, line in enumerate(d):
                _id = line['_id']
                name = line['name'].encode('utf-8').strip()
                if "'" in name:
                    name = re.sub("'", "''", name)
                country = line['country']
                lon = line['coord']['lon']
                lat = line['coord']['lat']
                cur.execute("INSERT INTO coord VALUES ('{}', '{}', '{}')".format(loop, lon, lat))
                cur.execute("INSERT INTO cities VALUES ('{}', '{}', '{}', '{}')".format(_id, name, country, loop))
        conn.commit()
        cur.close()
        conn.close()

    """
    def parse_json2(self):
        conn = psycopg2.connect(database='nbrb', user='postgres', password='qwerty321', host='localhost', port='5432')
        cur = conn.cursor()
        with open(self.json) as json_data:
            d = json.load(json_data)

            for line in d:
                cur_id = line['Cur_ID']
                date = line['Date']
                cur_abbreviation = line['Cur_Abbreviation']
                cur_scale = line['Cur_Scale']
                cur_name = line['Cur_Name'].encode('utf-8').strip()
                cur_official_rate = line['Cur_OfficialRate']
                cur.execute("INSERT INTO currence VALUES ('{}', '{}', '{}', '{}', '{}', '{}')".format(
                    cur_id, date, cur_abbreviation, cur_scale, cur_name, cur_official_rate))
                conn.commit()
        cur.close()
        conn.close()
    """

    def parse_with_jsonpath(self):
        conn = psycopg2.connect(database=self.database, user=self.db_user, password=self.db_password, host=self.db_host,
                                port=self.db_port)
        cur = conn.cursor()

        with open(self.json) as json_data:
            content = json.load(json_data)

            rows = [match.value for match in parse('$.[*]').find(content)]
            for loop, row in enumerate(rows):
                _id = [match.value for match in parse('_id').find(row)][0]
                name = [match.value for match in parse('name').find(row)][0].encode('utf-8').strip()
                name = re.sub("'", "''", name) if "'" in name else name
                country = [match.value for match in parse('country').find(row)][0]
                lon = [match.value for match in parse('coord.lon').find(row)][0]
                lat = [match.value for match in parse('coord.lat').find(row)][0]

                cur.execute("INSERT INTO coord VALUES ('{}', '{}', '{}')".format(loop, lon, lat))
                cur.execute("INSERT INTO cities VALUES ('{}', '{}', '{}', '{}')".format(_id, name, country, loop))

        conn.commit()
        cur.close()
        conn.close()
        return self

FillDBFromJson().parse_json()
