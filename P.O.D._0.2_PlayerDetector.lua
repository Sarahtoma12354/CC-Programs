-- P.O.D. - Player Online Detector Ver 0.2

-- Modem Detection
if peripheral.find("modem") == nil then
    error("No Modem Found.")
end
modem = peripheral.find("modem")

os.setComputerLabel("P.O.D. Player Detector 0.2")
term.clear()
term.setCursorPos(1,1)
print("P.O.D. Version 0.2 Live Test")

while true do
-- File Preperation
PlayerLog = "PlayerLog2"
log = io.open(PlayerLog, "r")
if log == nil then
    log = io.open(PlayerLog, "w")
    io.close(log)
    log = io.open(PlayerLog, "r")
end
io.input(log)

-- Time Preperation
time = (os.epoch("utc")/1000)-10800
time_table = os.date("*t", time)

-- File Writing
data = io.read("*all")
dataEnd = 0
lastDataEnd = 0
lastLastDataEnd = 0
repeat
    lastLastDataEnd = lastDataEnd
    lastDataEnd = dataEnd
    dataEnd = string.find(data, "\n", lastDataEnd + 1)
until dataEnd == nil
data = string.sub(data, lastLastDataEnd)

if string.sub(data, string.find(data, " ", 16), -1)-time <= -120 then
    io.close(log)
    log = io.open(PlayerLog, "a")
    io.output(log)

    if time_table.min < 10 then
        io.write(time_table.day .. "/" .. time_table.month .. "/" .. time_table.year .. " at " .. time_table.hour .. ":0" .. time_table.min .. " " .. time .. "\n")
    else
        io.write(time_table.day .. "/" .. time_table.month .. "/" .. time_table.year .. " at " .. time_table.hour .. ":" .. time_table.min .. " " .. time .. "\n")
    end
end

io.close(log)
os.sleep(60)
end
