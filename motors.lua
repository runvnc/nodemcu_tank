--motors.lua
 
speed_ = {a=0, b=0}
dir_ = {a=1, b=1}
 
function selectPinOut(motor)
  local pin = 3
  if motor == 'b' then pin = 4 end
  gpio.mode(pin, gpio.OUTPUT)
  return pin
end
   
-- motor = a or b
-- dir = 1 or -1 (forward or backward)
function setDir(motor, dir)
  --if dir_[motor] == dir then return end
  if motor == 'b' then dir = dir*-1 end
  local pin = selectPinOut(motor)
  local outp = gpio.HIGH
  if dir == -1 then outp = gpio.LOW end
  gpio.write(pin, outp)
  dir_[motor] = dir
end

-- motor = a or b
-- speed = float 1 to 1000
function setSpeed(motor, speed)
  --if speed_[motor] == speed then return end  
  local pin = 1
  if motor == 'b' then pin = 2 end
  pwm.setduty(pin, speed)
  speed_[motor] = speed
end

function initMotors()
  pwm.setup(1, 1000, 0)
  pwm.setup(2, 1000, 0)
end

initMotors()

