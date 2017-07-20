import re

sign1 = "NO PARKING (SANITATION BROOM SYMBOL) 8AM-9AM EXCEPT SUNDAY <----> (SUPERSEDED BY SP-156C DATED 1-22-98)"
sign2 = "Property line"
sign3 = "NO PARKING (SANITATION BROOM SYMBOL) TUESDAY FRIDAY 11AM-12:30PM <-> (SUPERSEDES SP-360C)"          
sign4 = "1 HOUR METERED PARKING 8:30AM-7PM EXCEPT SUNDAY <-> (SUPERSEDES SP-145EB)"
sign5 = "NO PARKING ANYTIME --> (SUPERSEDES SP-854CA)"
sign6 = "3 HMP COMMERCIAL VEHICLES ONLY OTHERS NO STANDING 7AM-6PM EXCEPT SUNDAY --> 6 HMP 6PM-MIDNIGHT EXCEPT SUNDAY --> (SUPERSEDED BY PS-4FA)"
sign7 = "2 HMP COMMERCIAL VEHICLES ONLY OTHERS NO STANDING 7AM-1 PM EXCEPT SUNDAY <-> (SUPERSEDED BY PS-314C)"

# what's the best way to represent a schedule as a data structure?
# let's see if we can use python to grab key information

# first attempt: let's try to grab the times

# regex code helped out by https://regex101.com/ as well as countless headaches

def parse_time_periods(input_string):
  # input is sign description
  # output is a size 7 array, each representing sunday to saturday, one day, and the time they are available
  regex_time_parse = '(\d?\d)(:(\d\d))?\s?([AP]M)'
  # this regex will find all the times associated with the string
  # need to include a space too for example this sign:
  # 2 HMP COMMERCIAL VEHICLES ONLY OTHERS NO STANDING 7AM-1 PM EXCEPT SUNDAY <-> (SUPERSEDED BY PS-314C)                  
  if "ANYTIME" in input_string:
    # this should be self explanatory
    return [0] * 48
  
  # replace midnight and noon with the proper times  
  if "MIDNIGHT" in input_string:
    input_string = input_string.replace("MIDNIGHT", "12AM")
  
  if "NOON" in input_string:
    input_string = input_string.replace("NOON", "12PM")
    
  # now, use the regex to get the times from the string
  
  matches = re.findall(regex_time_parse, input_string)
  if not matches:
    print "there are no times in this string"
    return
  print "number of matches: " + str(len(matches))
  
  # now we have to go through all the times and assign them to an array
  times_array = [0] * 48
  #if times_array[1] is 1, that means 00:30 to 1:00 is when the rules of the sign applied
  # now we have the problem of converting the time to half hours
  start_time = int(matches[0][0]) * 2
  if matches[0][2]:
    start_time += 1
  if matches[0][3] == "PM":
    start_time += 24
  
  if matches[1][0] == "12AM":
    end_time = 48
  else:
    end_time = int(matches[1][0]) * 2
    if matches[1][2]:
      end_time += 1
    if matches[1][3] == "PM":
      end_time += 24
    
  for i in xrange(start_time, end_time):
    times_array[i] = 1
    
  print times_array
  return times_array

# get the days from the string
def parse_days(input_string):
  # have an except flag, basically to take care of cases where the sign says "EXCEPT SUNDAY"
  except_flag = False
  regex_day_parse = 'SUNDAY|MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY'
  if "EXCEPT" in input_string:
    except_flag = True
  # we do regex because there are multiple days in one sign 
  days_array = [0] * 7
  days_dict = {"SUNDAY": 0, "MONDAY": 1, "TUESDAY": 2, "WEDNESDAY": 3, "THURSDAY": 4, "FRIDAY": 5, "SATURDAY": 6}
  # 0 represents parking sign not in effect, 1 is parking sign is in effect for that day
  matches = re.findall(regex_day_parse, input_string)
  if not matches:
    print "there are no days in this string"
    return [1] * 7
  print "number of matches: " + str(len(matches))
  for i in xrange(0, len(matches)):
    print matches[i]
    if except_flag:
      for j in xrange(0, 7):
        if days_dict[matches[i]] != j:
          days_array[j] = 1
    else:
      for j in xrange(0, 7):
        if days_dict[matches[i]] == j:
          days_array[j] = 1
  print days_array
  return days_array

def parse_description(input_string):
  if "NO PARKING" in input_string:
    return "No Parking"
  #replace with regex later
  if "NO STANDING" in input_string:
    return "No Parking"
  if "NO STOPPING" in input_string:
    return "No Parking"
  if "HMP" in input_string:
    return "HMP"
  # regex for HMP: (\d?\d)\s?HMP
  else:
    return "DESCRIPTION"
def parse_sign(input_string):
  sign_descriptions = input_string.split(">")
  sign_array = []
  
  for i in xrange(0, len(sign_descriptions)):
    description_array = [None] * 5
    description_array[0] = parse_description(sign_descriptions[i])
    description_array[1] = parse_days(sign_descriptions[i])
    description_array[2] = parse_time_periods(sign_descriptions[i])
    description_array[3] = sign_descriptions[i]
    description_array[4] = "SIGN ID"
    sign_array.append(description_array)
  
  print "Final array: "
  print sign_array
  
  return
