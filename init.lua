print("Startup in 12 seconds..")

function startup()
  print("Starting.")
  dofile('wifi.lua')
  dofile('web2.lua')
  dofile('motors.lua')
  dofile('control.lua')
  dofile('testpins.lua')  
end
  
tmr.alarm(0,12000,0,startup)
