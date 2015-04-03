#!/bin/sh

rm -rf simulations
mkdir simulations

sed \
  -e 's/all.css/sim_all.css/' \
  -e 's/vendors.css/sim_vendors.css/' \
  -e 's/vendors.js/sim_vendors.js/' \
  -e 's/application.js/sim_application.js/' \
  -e 's/templates.js/sim_templates.js/' \
  < www/index.html \
  >> simulations/sim_index.html

cp www/all.css simulations/sim_all.css
cp www/vendors.css simulations/sim_vendors.css
cp www/vendors.js simulations/sim_vendors.js
cp www/application.js simulations/sim_application.js
cp www/templates.js simulations/sim_templates.js
