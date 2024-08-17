--B.A.D. Boredom Avoidance Directive Monitor Scroll 1.0

if (peripheral.find("monitor") ~= nil) == false then
    print("Please place a monitor next to the computer.")
    error("No Monitor Found.")
end

os.setComputerLabel("B.A.D. Monitor Scroll")
term.clear()
term.setCursorPos(1,1)
print("B.A.D. Monitor Scroll Started")
monitor = peripheral.find("monitor")
monitor.setCursorPos(1,1)
x, y = monitor.getSize()
print("Program Started.")
while true do
    if (peripheral.find("monitor") ~= nil) == false then
        print("Monitor Removed.")
        error("No Monitor Found.")
    end
    monitor.setCursorPos(1,1)
    monitor.scroll(-1)
    for i = 0, x do
        num = math.random(16)
        monitor.setTextColor(num^2)
        if num%2 == 0 then
            monitor.write("1")
        else
            monitor.write("0")
        end
    end
    os.sleep(0.1)
end
