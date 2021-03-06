# this file will be used to parse through the geoJSON data given to us by NYC DOT
# preprocessing this will avoid the slowdown on the actual iOS app end
# 
# We need five pieces of information:
# 1. The street sign ID number, shown as SG_ORDER_N
# 2. The latitude, shown in the coordinates
# 3. The longitude, shown in the coordinates
# 4. The actual sign description, shown as SIGNDESC1
# 5. The object ID, used to create the dict, shown as OBJECTID
# We will also include the starting and ending points of the signs on the block
# David Wang

import json
from collections import defaultdict

with open('CanIPark/parkingData.geojson') as data_file:
    data = json.load(data_file)

d = defaultdict(list)

for feature in data['features']:

    d[feature['properties']['SG_ORDER_N']].append([feature['properties']['OBJECTID'],feature['properties']['SIGNDESC1'], feature['geometry']['coordinates']])

for key in d:
    
    latitudeStart = d[key][0][2][1]
    latitudeEnd = d[key][0][2][1]
    longitudeStart = d[key][0][2][0]
    longitudeEnd = d[key][0][2][0]

    for sublist in d[key]:
        if sublist[2][1] < latitudeStart:
            latitudeStart = sublist[2][1]
            longitudeStart = sublist[2][0]
        if sublist[2][1] > latitudeEnd:
            latitudeEnd = sublist[2][1]
            longitudeEnd = sublist[2][0]

    d[key].append([[latitudeStart, longitudeStart], [latitudeEnd, longitudeEnd]])

with open('JSONData.json', 'w') as f:
    json.dump(d, f)

