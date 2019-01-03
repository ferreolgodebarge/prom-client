# prom-client

This repository deploys a prometheus client python server, a prometheus server targetting the client server, and grafana.
It runs on Linux distributions.


## Steps

1. Clone the repository

```
git clone https://github.com/ferreolgodebarge/prom-client.git
```

2. Enter the folder
```
cd prom-client
```

3. Source the python virtual environment
```
source venv/bin/activate
```

4. Execute install.sh
```
./install.sh
```

You will have access to :

- Python prometheus client server: http://localhost:8000/
- Prometheus server : http://localhost:9090/
- Grafana server : http://localhost:3000/
