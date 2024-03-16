
local x = 0
local y = 0

local monitor = peripheral.find("monitor")
monitor.setCursorPos(1, 1)
monitor.clear()

while x < 4 do
    monitor.write("Hello world")
    monitor.setCursorPos(monitor.getCursorPos(x), monitor.getCursorPos(y))
    x = x + 1
    os.sleep(0.5)
end

while y < 4 do
    monitor.scroll(1)
    y = y + 1
    os.sleep(0.5)
end