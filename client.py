import time, requests

from prometheus_client import start_http_server, Counter, Gauge, Summary

COUNTER =  Counter('google_counter','Counter for Google ping', ['status'])
GAUGE = Gauge('google_gauge','Gauge for Google ping',['status'])
REQUEST_TIME = Gauge('request_processing_seconds', 'Time spent processing request')

url = 'http://www.google.com/'


def request_google():
    time0 = time.time()
    response = requests.get(url)
    duration = time.time() - time0
    status_code = response.status_code
    res = {'status_code': status_code, 'duration': duration}
    REQUEST_TIME.set(duration)
    print(res)
    if status_code == 200:
        COUNTER.labels(status='OK').inc()
        GAUGE.labels(status='OK').set(1)
    else:
        COUNTER.labels(status='KO').inc()
        GAUGE.labels(status='KO').set(0)
    return res

if __name__ == '__main__':
    # Start server
    start_http_server(8000)

    # Refresh data every 15s
    while True:
        request_google()
        time.sleep(15)
