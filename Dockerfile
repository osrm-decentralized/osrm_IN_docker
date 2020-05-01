#
# build OSRM data
#
FROM osrm/osrm-backend AS build

COPY profiles /profiles
COPY india-latest.osm.pbf /data

RUN osrm-extract -p /profiles/car-modified.lua /data/india-latest.osm.pbf

RUN rm /data/india-latest.osm.pbf

RUN osrm-partition /data/india-latest.osrm
RUN osrm-customize /data/india-latest.osrm

#
# productionize OSRM data
#

FROM osrm/osrm-backend

COPY --from=build /data /data
COPY --from=build /profiles /profiles

CMD ["osrm-routed", "--algorithm", "mld", "/data/india-latest.osrm"]
