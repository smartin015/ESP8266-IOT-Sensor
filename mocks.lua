
file = {txt = ""}
function file.open()
  return true
end

function file.write(v)
  file.txt = file.txt .. v
end

function file.close()
end

function file.remove()
  file.txt = ""
end

function file.read()
  return file.txt
end

tmr = {}
function tmr.alarm(a, b, c, f)
  f()
end

function tmr.delay(us)
end

wifi = {STATION = 0, sta = {}}
function wifi.setmode(station)
end

function wifi.sta.config(usr, pass)
end

function wifi.sta.getip() 
  return "127.0.0.1"
end


net = {onfunc = nil, sentval = nil}
function net.createConnection()
  return net
end
function net.on(self, v, fn)  
  net.onfunc = fn
end
function net.connect(self, port, host)
end
function net.send(self, val)
  net.sentval = val
  net.onfunc()
end

node = {sleepcnt = 0}
function node.dsleep()
  node.sleepcnt = node.sleepcnt + 1
end

gpio = {INPUT=1, testval=0}
function gpio.mode()
end
function gpio.read()
  return gpio.testval
end


function resettest()
  gpio.testval = 0
  node.sleepcnt = 0
  net.onfunc = nil
  net.sentval = nil
  dofile('config.lua')
end