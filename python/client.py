import requests
import sys
import RPi.GPIO as GPIO
import time

if len(sys.argv) != 2:
    print("Usage: client <username>")
    exit()

# Flash LEDs for one second to check circuit
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

GPIO.setup(22,GPIO.OUT)
GPIO.setup(23,GPIO.OUT)
GPIO.setup(24,GPIO.OUT)

GPIO.output(22,GPIO.HIGH)
GPIO.output(23,GPIO.HIGH)
GPIO.output(24,GPIO.HIGH)
time.sleep(1)

GPIO.output(22,GPIO.LOW)
GPIO.output(23,GPIO.LOW)
GPIO.output(24,GPIO.LOW)

# Get player data
username = sys.argv[1]
x = requests.get("https://firestore.googleapis.com/v1/projects/mine-pi/databases/(default)/documents/users/" + username)

if x.status_code != 200:
  print("Error fetching player data")
  exit()

fields = x.json()['fields']

print(fields)

if "green" in fields and fields["green"] > 0:
	GPIO.output(22,GPIO.HIGH)
else:
	GPIO.output(22,GPIO.LOW)
	
if "yellow" in fields and fields["yellow"] > 0:
	GPIO.output(23,GPIO.HIGH)
else:
	GPIO.output(23,GPIO.LOW)

if "red" in fields and fields["red"] > 0:
	GPIO.output(24,GPIO.HIGH)
else:
	GPIO.output(24,GPIO.LOW)

time.sleep(10)

GPIO.output(22,GPIO.LOW)
GPIO.output(23,GPIO.LOW)
GPIO.output(24,GPIO.LOW)
