dofile('mocks.lua')
dofile('logger.lua')

-- Test simple collection
resettest()
DEBUG = false
DATA_XMIT_LEN = 5

for i=1,DATA_XMIT_LEN do
  logger_main()
end
assert(node.sleepcnt == DATA_XMIT_LEN)
assert(net.sentval == "GET /dev01/00000 HTTP/1.1\r\n\r\n")


-- Test varied collection
resettest()
DEBUG = false
DATA_XMIT_LEN = 10
for i=1,DATA_XMIT_LEN do
  gpio.testval = i % 2
  logger_main()
end
assert(node.sleepcnt == DATA_XMIT_LEN)
assert(net.sentval == "GET /dev01/1010101010 HTTP/1.1\r\n\r\n")

print('Test success')