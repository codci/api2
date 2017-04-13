import json
import re
import psycopg2

from jsonpath_rw import parse
from test_project.Resources.settings import cities_list_sources, database_name, db_host, db_port, db_user_password,\
    db_username


class FillDBFromJson(object):
    def __init__(self):
        self.json = cities_list_sources
        self.database = database_name
        self.db_user = db_username
        self.db_password = db_user_password
        self.db_host = db_host
        self.db_port = db_port

    def parse_json(self):
        """
        Fill database with values from json file
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

    def parse_with_jsonpath(self):
        """
        NOT USED !!!
        Fill database with values from json file (jsonpath)
        """
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
