--testpins
 
print("Top of testpins.lua")
   
for pin=8,9,1 do
  gpio.mode(pin, gpio.INPUT)
end    

print("Set pin mode")

function outp()
  print("------------------------")
  for pin=8,9,1 do
    local val = gpio.read(pin)
    print(pin,val)
  end
  print("-----------------------------")
end
 
--tmr.create():alarm(100,1,outp)

print("Loaded testpins.lua")

  
