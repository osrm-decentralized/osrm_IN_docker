FROM osrm/osrm-backend:latest

COPY profiles/profiles /profiles

CMD ["osrm-routed", "--algorithm", "mld", "/data/india-latest.osrm"]
