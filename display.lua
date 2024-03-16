
local monitor = peripheral.find("monitor")
monitor.setCursorPos(1, 1)

while x < 4 then
    monitor.write("Hello world")
    x = x + 1
    os.sleep(0.5)
end

while y < 4 then
    monitor.scroll(1)
    y = y + 1
    os.sleep(0.5)
end