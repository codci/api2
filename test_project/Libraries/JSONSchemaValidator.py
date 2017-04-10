import json
import os

from jsonschema import ValidationError
from jsonschema import validate

from test_project.Resources.settings import error_json_schema, valid_json_schema


class JSONSchemaValidator(object):

    def validate_schema_openweathermap(self, actual, schema):
        """
        assert json schema for requests from api.openweathermap.org
        """
        resources_dir = os.path.abspath(os.getcwd())
        relative_schema_path = valid_json_schema if schema == 'Valid' else error_json_schema
        schema_data = open(os.path.join(resources_dir, relative_schema_path))
        self.validate_schema(actual, json.load(schema_data))
        return self

    @staticmethod
    def validate_schema(act_json, exp_schema):
        """
        assert json schema
        :param act_json: json data that should be validate
        :param exp_schema: file schema of which must match the json file
        """
        try:
            return validate(act_json, exp_schema)
        except ValidationError as e:
            print("Failed to validate Json: {} \nWith validation schema: {}\nWith error: {}".format(
                act_json, exp_schema, e))
        return None
