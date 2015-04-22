function debugPrint(s)
  if DEBUG then
    print(s)
  end
end

function sleep(wifi_wakeup)   
  if wifi_wakeup then
    node.dsleep(SLEEP_DURATION_US, 0)
  else
    node.dsleep(SLEEP_DURATION_US, 4)
  end
end

function sendData(data, cb) 
  conn=net.createConnection(net.TCP, false) 
  conn:on("receive", cb)
  conn:connect(DEST_PORT,DEST_HOST)
  debugPrint("Data: \""..data.."\"")
  request = "GET /"..DEVICE_NAME.."/"..data.." HTTP/1.1\r\n\r\n"
  conn:send(request)
  debugPrint(request)
  
  tmr.alarm(1, 2*RETRY_DELAY_MS, 0, function() 
    debugPrint("Send timeout")
    sleep(false)
  end)
end

function connectAndSend(data, cb)
  wifi.setmode(wifi.STATION)
  wifi.sta.config (WIFI_USER,WIFI_PASS)  
  debugPrint("Connecting...") 
  
  i = 0
  tmr.alarm(1, RETRY_DELAY_MS, 1, function()
    if i == RETRY_COUNT then
      tmr.stop(1)
      cb(nil, "")
    end
    
    if wifi.sta.getip() == nil then
      debugPrint("...")
    else
      debugPrint(wifi.sta.getip())
      tmr.stop(1)
      file.remove(DATA)
      tmr.alarm(1, RETRY_DELAY_MS, 0, function()
        sendData(data, cb)
      end)
      return true
    end
  end)
end

function logData()
  gpio.mode(DATA_PIN,gpio.INPUT)
  if file.open(DATA, "a+") ~= true then
    return
  end
  val = gpio.read(DATA_PIN)
  file.write(val)
  file.close()
  debugPrint("wrote " .. val)
end

function logger_main() 
  logData()
  
  data = ""
  if file.open(DATA, "r") then
    data = file.read()
    file.close()
  end
  datalen = string.len(data)
  print(datalen)
  
  if datalen % DATA_XMIT_LEN == 0 then
    connectAndSend(data, function(conn, pl) debugPrint(pl) sleep(false) end)
  else
    --If we're transmitting next time, schedule wakeup with wifi
    sleep((datalen % DATA_XMIT_LEN) == DATA_XMIT_LEN - 1)
  end
end