import MinePi
from MinePi import Channels

import sys
import RPi.GPIO as GPIO
import time

if len(sys.argv) != 2:
    print("Usage: client <username>")
    exit()

# Flash LEDs for one second to check circuit
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

GPIO.setup(22, GPIO.OUT)
GPIO.setup(23, GPIO.OUT)
GPIO.setup(24, GPIO.OUT)

GPIO.output(22, GPIO.HIGH)
GPIO.output(23, GPIO.HIGH)
GPIO.output(24, GPIO.HIGH)
time.sleep(1)

GPIO.output(22, GPIO.LOW)
GPIO.output(23, GPIO.LOW)
GPIO.output(24, GPIO.LOW)

username = sys.argv[1]

print("Polling")
while True:
    # Poll server
    state = MinePi.get(username)

    # Update LEDs to represent state
    if state[Channels.GREEN] > 0:
        GPIO.output(22, GPIO.HIGH)
    else:
        GPIO.output(22, GPIO.LOW)

    if state[Channels.YELLOW] > 0:
        GPIO.output(22, GPIO.HIGH)
    else:
        GPIO.output(22, GPIO.LOW)

    if state[Channels.RED] > 0:
        GPIO.output(22, GPIO.HIGH)
    else:
        GPIO.output(22, GPIO.LOW)
