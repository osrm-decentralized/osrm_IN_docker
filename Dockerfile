FROM osrm/osrm-backend

RUN mkdir -p /data /profiles
COPY profiles /profiles
COPY india-latest.osm.pbf /data

RUN osrm-extract -p /profiles/car-modified.lua /data/india-latest.osm.pbf
RUN ls -lR
RUN osrm-partition /data/india-latest.osrm
RUN ls -lR
RUN osrm-customize /data/india-latest.osrm
RUN ls -lR

CMD ["osrm-routed", "--algorithm", "mld", "/data/india-latest.osrm"]

