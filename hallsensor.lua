-- speed control hall 
dofile('motors.lua')

maxDuty = 1023
gain = 0.9
duty_ = {a=0, b=0}
targetRPMs_ = {a = 0, b = 0}

rpms = {a=0, b=0} 
  
STP = false
  
function rpmFromInterval(microseconds)
  local revolved = 1 --/ detectedPerRevolution
  local microsecondsPerMinute = 60*1000*1000
  return revolved / (microseconds/microsecondsPerMinute)
end
 
function adjustDuty(duty, targetRPMs, measuredRPMs)
  local error = targetRPMs - measuredRPMs
  if targetRPMs == 0 then bias = 0 else bias = 500 end
  local newDuty = (error * gain) + bias
  newDuty = math.min(maxDuty, newDuty)
  newDuty = math.max(300, newDuty)
  return newDuty
end 

before_ = 0 
now_ = 0
level_ = 0
   
function setupInterrupt(name, pin)
  do
    gpio.mode(pin, gpio.INT)
    local before=-9999
    local function rpmFromSensor(level, now, count)
      if STP then return end
      local microseconds = now - before
      local measuredRPM = rpmFromInterval(microseconds)
      if measuredRPM>10000 or level ~= 0 then
        before = now
        return
      end 
      rpms[name] = rpmFromInterval(microseconds)
      before_= before
      now_ = now
      before = now
      level_ = level
      local adjusted = adjustDuty(duty_[name], targetRPMs_[name], rpms[name])
      if math.abs(duty_[name] - adjusted)>=1 then
        setDuty(name, adjusted)
      end
    end
    gpio.trig(pin, "down", rpmFromSensor)
  end  
end        
    
setupInterrupt('a', 6)
--setupInterrupt('b', 7)

function printSpeeds()
  print("Motor A RPM:", rpms.a, 'duty A:', duty_.a, before_,now_, level_)
  --print("Motor B RPM:", duty_.b)
  --if duty_.a == 0 and targetRPMs_.a ~= 0 then
  --   setDuty('a', 200)
  --end
  --if duty_.b == 0 and targetRPMs_.b ~= 0 then
  --   setDuty('b', 200)
  --end
end 

tmr.create():alarm(300,1,printSpeeds)

