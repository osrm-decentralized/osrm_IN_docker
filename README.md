## OSRM deployment with Docker image

* Download processed files

    ```bash
    bash download-files.sh
    ```

* Run

    ```docker
    sudo docker run -d --name osrm_in -p 5000:5000 -v "${PWD}/data:/data" sriharithalla/osrm_in:latest
    ```

    * `-d` : detached, will run in background

    To run in terminal where you can see stdout messages and do Ctrl+C to terminate:,

    ```docker
    sudo docker run --rm -it -p 5000:5000 -v "${PWD}/data:/data" sriharithalla/osrm_in:latest
    ```

## OSRM frontend

Note: If deploying on a web server, replace "localhost" with your own IP address or url.

Run detached:

```docker
sudo docker run -e OSRM_BACKEND='http://localhost:5000' -e OSRM_CENTER='21.963,77.432' -e OSRM_ZOOM='5' -d -p 9966:9966 osrm/osrm-frontend
```

Again for terminal with `CTRL`+`C`:

```docker
sudo docker run -e OSRM_BACKEND='http://localhost:5000' -e OSRM_CENTER='21.963,77.432' -e OSRM_ZOOM='5' --rm -it -p 9966:9966 osrm/osrm-frontend
```

## Development

* Download latest India osm.pbf to this folder:

    ```shell script
    wget -O data/india-latest.osm.pbf https://download.geofabrik.de/asia/india-latest.osm.pbf
    ```

* Pull latest Docker file

    ```docker
    sudo docker pull sriharithalla/osrm_in:latest
    ```

  Or, if you would like to build the image locally, first pull the profiles submodule. Otherwise, continue to next step of processing files.
  
  ```git
  git submodule update --init --recursive
  ```
  
  Build the image
  
  ```docker
  sudo docker build -t osrm_in .
  ```
  
  Now continue processing. You will have to replace the image name `sriharithalla/osrm_in` with `osrm_in` (or any other tag that you used in the command above).

* Process files

    ```docker
    sudo docker run -t -v "${PWD}/data:/data" sriharithalla/osrm_in:latest osrm-extract -p /profiles/car-modified.lua /data/india-latest.osm.pbf
    sudo docker run -t -v "${PWD}/data:/data" sriharithalla/osrm_in:latest osrm-partition /data/india-latest.osrm
    sudo docker run -t -v "${PWD}/data:/data" sriharithalla/osrm_in:latest osrm-customize /data/india-latest.osrm
    ```

    Note: The Docker image has the modified profiles suitable for India.

* Run OSRM

    ```docker
    sudo docker run -d --name osrm_in -p 5000:5000 -v "${PWD}/data:/data" sriharithalla/osrm_in:latest
    ```
