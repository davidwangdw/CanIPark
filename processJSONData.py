# this file will be used to parse through the geoJSON data given to us by NYC DOT
# preprocessing this will avoid the slowdown on the actual iOS app end
# 
# We need five pieces of information:
# 1. The street sign ID number, shown as SG_ORDER_N
# 2. The latitude, shown in the coordinates
# 3. The longitude, shown in the coordinates
# 4. The actual sign description, shown as SIGNDESC1
# 5. The object ID, used to create the dict, shown as OBJECTID
# David Wang

import json
from collections import defaultdict

with open('CanIPark/parkingData.geojson') as data_file:
	data = json.load(data_file)

d = defaultdict(list)

for feature in data['features']:

	d[feature['properties']['SG_ORDER_N']].append([feature['properties']['OBJECTID'],feature['properties']['SIGNDESC1'], feature['geometry']['coordinates']])

with open('JSONData.json', 'w') as f:
	json.dump(d, f)

