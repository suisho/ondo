require 'pi_piper'
require 'firebase'
base_uri = 'https://torid-fire-7950.firebaseio.com/'

firebase = Firebase::Client.new(base_uri)

value = 0
PiPiper::Spi.begin do |spi|
  raw = spi.write [0b01101000,0]
  value = ((raw[0]<<8) + raw[1]) & 0x03FF
end
volt = (value * 3300)/1024
degree = (volt - 500)/10
puts degree

#response = firebase.push("degree", {degree: degree, time: Time.now})
time = Time.now
response = firebase.push("degree_log", {  degree: degree, time: time})
response = firebase.set("last-degree", degree)
