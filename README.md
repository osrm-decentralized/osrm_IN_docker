## OSRM deployment with docker image

* Install Git LFS as outlined at https://git-lfs.github.com/

* Download processed files from Git LFS

    ```git
    git lfs pull
    ```

* Run

    ```docker
    docker run -d -p 5000:5000 -v "${PWD}/data:/data" docker.pkg.github.com/osrm-decentralized/osrm_in_docker/osrm_in:latest
    ```

    * `-d` : detached, will run in background

    To run in terminal where you can see stdout messages and do Ctrl+C to terminate:,

    ```docker
    docker run --rm -it -p 5000:5000 -v "${PWD}/data:/data" docker.pkg.github.com/osrm-decentralized/osrm_in_docker/osrm_in:latest
    ```

## OSRM frontend

Note: If deploying on a web server, replace "localhost" with your own IP address or url.

Run detached:

```docker
docker run -e OSRM_BACKEND='http://localhost:5000' -e OSRM_CENTER='21.963,77.432' -e OSRM_ZOOM='5' -d -p 9966:9966 osrm/osrm-frontend
```

Again for terminal with `CTRL`+`C`:

```docker
docker run -e OSRM_BACKEND='http://localhost:5000' -e OSRM_CENTER='21.963,77.432' -e OSRM_ZOOM='5' --rm -it -p 9966:9966 osrm/osrm-frontend
```

## Development

* Download latest India osm.pbf to this folder:

    ```shell script
    wget -O data/india-latest.osm.pbf https://download.geofabrik.de/asia/india-latest.osm.pbf
    ```

* Process files

    ```docker
    docker run -t -v "${PWD}/data:/data" docker.pkg.github.com/osrm-decentralized/osrm_in_docker/osrm_in:latest osrm-extract -p /profiles/car-modified.lua /data/india-latest.osm.pbf
    docker run -t -v "${PWD}/data:/data" docker.pkg.github.com/osrm-decentralized/osrm_in_docker/osrm_in:latest osrm-partition /data/india-latest.osrm
    docker run -t -v "${PWD}/data:/data" docker.pkg.github.com/osrm-decentralized/osrm_in_docker/osrm_in:latest osrm-customize /data/india-latest.osrm
    ```

    Note: The Docker image has the modified profiles suitable for India.

* Run OSRM

    ```docker
    docker run -d -p 5000:5000 -v "${PWD}/data:/data" docker.pkg.github.com/osrm-decentralized/osrm_in_docker/osrm_in:latest
    ```
