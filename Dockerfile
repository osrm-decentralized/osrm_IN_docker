FROM osrm/osrm-backend

COPY profiles/profiles /profiles

CMD ["osrm-routed", "--algorithm", "mld", "/data/india-latest.osrm"]
