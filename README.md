
# NodeMCU Tank control with gamepad over HTTP on Wifi access point

![Tank](tank.jpg?raw=true "Tank")

## Software outline

`web2.lua` uses `httpserver.lua` to create a web server that 1) serves the web page with the JavaScript for control
and 2) handles a single command with joystick position updates.

`index.html` contains JavaScript code to read the Analog stick #2 axes position and send GET requests as the stick moves.

`control.lua` converts the joystick coordinates to motor speeds and `motors.lua` uses the `pwm` module to set the
speed and direction of the motors.

`wifi.lua` sets up a local wifi access point with ip address `192.168.1.2` as the address. 

`init.lua` runs at boot and loads the other files including the web server.

