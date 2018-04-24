-- control.lua

function getDir(x, y)
  if y <= 0 then
    return 1
  else
    return -1
  end
end
  
function speed(x, y)
  return math.sqrt(x^2+y^2)*10/11
end
 
function turnRatio(x, y)
  local x_ = math.abs(x)
  local y_ = math.abs(y)
  return math.abs(x_/(y_+0.00001))/4.0
end
  
function motorParams(x, y)
  local res = {a={}, b={}}
  res.dir = getDir(x, y)
  local spd = speed(x, y)
  local turn = turnRatio(x, y)
  --print('spd=',spd,'turn=',turn)
  if spd > 0 and spd < 500 then spd = 500 end
  if x == 0 then
    res.a.speed = spd
    res.b.speed = spd
  elseif x > 0 then
    res.b.speed = spd
    res.a.speed = math.max(0, spd - (spd*turn))
    res.a.speed = math.min(500, res.a.speed)    
  elseif x < 0 then
    res.a.speed = spd
    res.b.speed = math.max(0, spd - (spd*turn))
    res.b.speed = math.min(500, res.b.speed)
  end
  res.a.speed=math.min(1000, res.a.speed)
  res.b.speed=math.min(1000, res.b.speed)
  return res
end


print("Loaded motor control functions.")
 
