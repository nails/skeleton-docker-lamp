#!/usr/bin/env bash

echo "+--------------------------+"
echo "| Install Framework: Nails |"
echo "+--------------------------+"

# --------------------------------------------------------------------------

echo "... installing Nails"
echo "... downloading skeleton"
curl -s -o ./www/skeleton.zip -L https://github.com/nails/skeleton-app/archive/master.zip

echo "... extracting skeleton"
unzip -q -d ./www ./www/skeleton.zip
mv ./www/skeleton-app-master/[a-zA-Z]* ./www
mv ./www/skeleton-app-master/.[a-zA-Z]* ./www
rm ./www/skeleton.zip
rmdir ./www/skeleton-app-master
