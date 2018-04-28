
# NodeMCU Tank control with gamepad over HTTP on Wifi access point

![Tank](tankmain.jpg?raw=true "Tank")

## Hardware

### Chasis

There are several similar tank chassis kits on Amazon such as [Kit](https://www.amazon.com/Tracked-Platform-Aluminum-Chassis-Arduino/dp/B0746FTL9Z/ref=sr_1_fkmr2_3?ie=UTF8&qid=1524948074&sr=8-3-fkmr2&keywords=nodemcu+tank+chassis).

## Brains

The NodeMCU and motor drive shield are also available on Amazon such as [NodeMCU and motor shield](https://www.amazon.com/KOOKYE-ESP8266-ESP-12E-NodeMcu-Expansion/dp/B01C6MR62E/ref=sr_1_9?s=hi&ie=UTF8&qid=1524948220&sr=1-9&keywords=nodemcu)

## Hardware assembly

![Motor shield](shield.jpg?raw=true "Shield")

The chassis and motor shield kits should contain enough documentation for assembling the kit and connecting to the wires.  I was lucky because I have an older brother who is a mechanical/electrical engineer who did the "hard" parts.  This approach was quite effective so I highly recommend it.  If you don't have one of those, hopefully the photos I uploaded will help.  My goal for this github was mainly to share the lua code I used.

Note that the photos show some "extra" resistors and wires connected on the IO pins on the motor shield and to a few motor leads.  I believe we connected to pins 6 and 7. This is for reading the hall effect sensors that are attached to the motors in order to create a control loop for speed.  I was not able to get the speed control loop to work properly so that code is not checked in.  Just setting the duty on the motors works fine for control for now.  

## Operation

When you turn on the power switch on the motor shield the NodeMCU boots up and creates a wifi access point named 'vehicle'.  The password is set in wifi.lua.  Once you connect to that wifi network you can go to Google Chrome and hit `http://192.168.1.2`.  You will need a USD Gamepad like an XBox 360 controller clone.  Then use the right analog stick to control the tank (if everything is working).  If it doesn't work the first thing to check is the source code which should be some JavaScript for sending each joystick position update in a simple HTTP GET request.

## Software outline

`web2.lua` uses `httpserver.lua` to create a web server that 1) serves the web page with the JavaScript for control
and 2) handles a single command with joystick position updates.

`index.html` contains JavaScript code to read the Analog stick #2 axes position and send GET requests as the stick moves.

`control.lua` converts the joystick coordinates to motor speeds and `motors.lua` uses the `pwm` module to set the
speed and direction of the motors.

`wifi.lua` sets up a local wifi access point with ip address `192.168.1.2` as the address.

`init.lua` runs at boot and loads the other files including the web server.

