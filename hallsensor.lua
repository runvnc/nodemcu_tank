-- speed control hall 
 
function setupInterrupt(name, pin)
  do
    gpio.mode(pin, gpio.INT)
    local before=0
    local function countMotor(level, now, count)
      local elapsed = now - before
      print( level, elapsed, count )
      before = now
    end
    gpio.trig(pin, "down", count_motor)
  end
end

