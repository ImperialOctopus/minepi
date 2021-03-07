from enum import Enum
import requests


class Channels(Enum):
    def __str__(self):
        return str(self.name).lower()

    WHITE = 0
    ORANGE = 1
    MAGENTA = 2
    LIGHT_BLUE = 3
    YELLOW = 4
    LIME = 5
    PINK = 6
    GRAY = 7
    LIGHT_GRAY = 8
    CYAN = 9
    PURPLE = 10
    BLUE = 11
    BROWN = 12
    GREEN = 13
    RED = 14
    BLACK = 15


def get(username):
    request = requests.get(
        "https://firestore.googleapis.com/v1/projects/mine-pi/databases/(default)/documents/users/" + username)

    if request.status_code != 200:
        raise Exception(
            f"Error fetching player data, status code: {request.status_code}")

    if not 'fields' in request.json():
        return {}

    fields = request.json()['fields']
    result = {}

    for channel in Channels:
        if str(channel) in fields and "integerValue" in fields[str(channel)]:
            result[channel] = int(fields[str(channel)]["integerValue"])
        else:
            result[channel] = 0

    return result
