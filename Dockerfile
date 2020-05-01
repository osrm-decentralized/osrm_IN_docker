FROM osrm/osrm-backend

RUN mkdir -p /data /profiles
COPY profiles /profiles
COPY india-latest.osm.pbf /data
RUN osrm-extract -p /profiles/car-modified.lua /data/india-latest.osm.pbf && \
    osrm-partition /data/india-latest.osm.osrm && \
    osrm-customize /data/india-latest.osm.osrm

CMD ["osrm-routed", "--algorithm", "mld", "/data/india-latest.osm.osrm"]

