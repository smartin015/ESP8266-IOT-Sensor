--Location of data logging file
DATA = "data.chr"

--The number of data points to gather before transmitting them
DATA_XMIT_LEN = 10

--Deep sleep mode until next data point
SLEEP_DURATION_US = 60*1000*1000

--Pin to read from
DATA_PIN = 5

--Number of times to wait for connection before giving up this round
RETRY_COUNT = 4
RETRY_DELAY_MS = 1500

DEST_HOST = "192.168.1.23"
DEST_PORT = 8802

WIFI_USER = "JarvisMarkI"
WIFI_PASS = "oakdale43"

DEVICE_NAME = "dev02"

DEBUG = false