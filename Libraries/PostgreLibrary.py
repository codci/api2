import psycopg2
from psycopg2 import extras

from Resources.settings import *


class PostgreLibrary(object):
    def __init__(self):
        self.database = database_name
        self.db_user = db_username
        self.db_password = db_user_password
        self.db_host = db_host
        self.db_port = db_port
        try:
            self.conn = psycopg2.connect(database=self.database, user=self.db_user, password=self.db_password,
                                         host=self.db_host, port=self.db_port)
            self.cursor = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        except psycopg2.OperationalError as e:
            raise e

    def __del__(self):
        try:
            print("Closing db connection...")
            self.cursor.close()
            self.conn.close()
            print("DB connection closed successfully")
        except psycopg2.OperationalError as e:
            print("Failed to close db connection")
            raise e

    def select_from_bd(self, query):
        """
        execute query to db, results will be saved in self.cursor
        :param query: query that should be executed
        """
        try:
            self.cursor.fetchall()
        except psycopg2.ProgrammingError:
            pass
        self.cursor.execute(query)
        return self

    def insert_to_db(self, query):
        """
        execute query to db, and commit changes
        :param query: query that should be executed
        """
        self.cursor.execute(query)
        self.conn.commit()
        return self

    def get_city_by_name(self, name):
        """
        Select all data of city by name from db
        :param name: name of the city that should be selected
        """
        query = "SELECT _id, name, country, lat, lon FROM cities INNER JOIN coord " \
                "ON cities.coord = coord.id WHERE name = '{}';".format(name)
        self.select_from_bd(query)
        cities_list = self.cursor.fetchall()
        for loop, city in enumerate(cities_list):
            cities_list[loop]['lat'] = float('%g' % round(city['lat'], 2))
            cities_list[loop]['lon'] = float('%g' % round(city['lon'], 2))
        return cities_list

    def get_random_city(self):
        """
        Select all data of random city from db
        """
        psycopg2.extensions.register_type(psycopg2.extensions.UNICODE, self.cursor)
        psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY, self.cursor)
        query = "SELECT _id, name, country, lat, lon FROM cities INNER JOIN coord " \
                "ON cities.coord = coord.id ORDER BY random() LIMIT 1;"
        self.select_from_bd(query)
        return self.cursor.fetchone()
