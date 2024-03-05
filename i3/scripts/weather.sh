#!/usr/bin/env python3

from pycurl import Curl, FOLLOWLOCATION, HTTPGET, WRITEDATA, error as CurlError
import sys
import os
from io import BytesIO
import json
from json import JSONDecodeError
from typing import List
from urllib.parse import urlencode
from subprocess import CalledProcessError

# https://openweathermap.org/current
# https://openweathermap.org/weather-conditions

OPENWEATHERMAP_API_KEY = '585e41329c746ce3eb928f7d94c6672e'
LOCATION_NAME = 'Tyumen'

SYMBOL_DEGREE = '\u00B0'

ICON_WIND = '\uf72e'
ICON_CLEAR = '\uf185'
ICON_CLOUDS = '\uf0c2'
ICON_RAIN = '\uf73d'
ICON_THUNDERSTORM = '\uf76c'
ICON_SNOW = '\uf2dc'
ICON_SMOG = '\uf75f'

request = Curl()
request.setopt(
    request.URL,
    'https://api.openweathermap.org/data/2.5/weather?' + urlencode({
        'q': LOCATION_NAME,
        'appid': OPENWEATHERMAP_API_KEY,
        'units': 'metric',
        'lang': 'en'
    })
)
request.setopt(FOLLOWLOCATION, True)
request.setopt(HTTPGET, True)
buffer = BytesIO()
request.setopt(WRITEDATA, buffer)
try:
    request.perform()
except (CurlError) as e:
    print(e, file=sys.stderr)
    sys.exit(os.EX_DATAERR)
request.close()

try:
    weather_data = json.loads(buffer.getvalue())
except (JSONDecodeError, CalledProcessError) as e:
    print(e, file=sys.stderr)
    sys.exit(os.EX_DATAERR)

output: List[str] = []

if (
    'weather' in weather_data
    and len(weather_data['weather']) > 0
    and 'id' in weather_data['weather'][0]
):
    weather_id = weather_data['weather'][0]['id']
    if (200 <= weather_id <= 232):
        output.append(ICON_THUNDERSTORM)
    elif (300 <= weather_id <= 321 or 500 <= weather_id <= 531):
        output.append(ICON_RAIN)
    elif (600 <= weather_id <= 622):
        output.append(ICON_SNOW)
    elif (701 <= weather_id <= 781):
        output.append(ICON_SMOG)
    elif (weather_id == 800):
        output.append(ICON_CLEAR)
    elif (801 <= weather_id <= 804):
        output.append(ICON_CLOUDS)

if ('name' in weather_data):
    output.append(weather_data['name'])

if ('main' in weather_data and 'temp' in weather_data['main']):
    output.append(
        str(round(weather_data['main']['temp'])) + SYMBOL_DEGREE + 'C'
    )

if ('wind' in weather_data and 'speed' in weather_data['wind']):
    output.append(ICON_WIND)
    #    m/s
    # --------- = m/s * 3.6
    # 1000/3600
    output.append(str(round(weather_data['wind']['speed'] * 3.6)))
    output.append('km/h')
print(' '.join(output))

sys.exit(os.EX_OK)
