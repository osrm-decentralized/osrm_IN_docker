## Get OSM data

Download latest India osm .pbf to this folder:

https://download.geofabrik.de/asia/india-latest.osm.pbf


## OSRM deployment with docker image

Build
```
docker build -t osrm_in .
```

Run
```
docker run -d -p 5000:5000 osrm_in
```

-`-d` : detached, will run in background

To run in terminal where you can see stdout messages and do Ctrl+C to terminate:,
```
docker run --rm -it -p 5000:5000 osrm_in
```

## OSRM frontend

Note: If deploying on a web server, replace "localhost" with your own IP address or url.

Run detached:
```
docker run -e OSRM_BACKEND='http://localhost:5000' -e OSRM_CENTER='21.963,77.432' -e OSRM_ZOOM='5' -d -p 9966:9966 osrm/osrm-frontend
```

again for terminal with ctrl+c :
```
docker run -e OSRM_BACKEND='http://localhost:5000' -e OSRM_CENTER='21.963,77.432' -e OSRM_ZOOM='5' --rm -it -p 9966:9966 osrm/osrm-frontend
```


