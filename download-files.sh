#!/usr/bin/env bash

cd data
rm -rf *

wget -rkpN -e robots=off --no-parent --no-directories --reject "india-latest.osm.pbf,index.html,index.html.tmp" https://files.sriharithalla.com/routing/india/
