
-- Serving static files
dofile('httpserver.lua')
dofile('control.lua')

httpServer:listen(80)

-- Custom API
-- Get text/html

httpServer:use('/', function(req, res)
  file.open("index.html")
  local html_ = file.read()
  file.close()
  res:send(html_) 
end)
 
httpServer:use('/cmd', function(req, res)
  --print(req.query.x, req.query.y)
  local params = motorParams(req.query.x*1, req.query.y*1)
  --print("dir=",params.dir)
  --print("a speed=",params.a.speed, 'b speed=',params.b.speed)
  --print("b speed=",params.b.speed)
  setSpeed('a', params.a.speed)
  setSpeed('b', params.b.speed)
  setDir('a', params.dir)
  setDir('b', params.dir)
  res:send('{"ok":true}') 
end)
