import uuid
from random import randint


def get_unique_string():
    return uuid.uuid4().hex[:8]


def get_unique_string_from_template(template):
    return template.format(get_unique_string())


def get_random_digit(lower=0, upper=100):
    return randint(lower, upper)
