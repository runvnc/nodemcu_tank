wifi.setmode(wifi.SOFTAP)
ipcfg = {
  ip="192.168.1.2",
  netmask="255.255.255.0",
  gateway="192.168.1.2"
}
res=wifi.ap.setip(ipcfg)
   
cfg={}
cfg.ssid="vehicle"
cfg.pwd="livesay1"
ok=wifi.ap.config(cfg)
print(wifi.ap.getip())
 
 
