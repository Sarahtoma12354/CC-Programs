-- M.A.G.I.C. Movement Assistance and Guidance Intelligence Coordinator Lift Operator 1.0

if peripheral.find("modem") == false then
    printError("No modem found, please place one next to the computer.")
end

os.setComputerLabel("M.A.G.I.C Lift Operator")
term.clear()
term.setCursorPos(1,1)
print("M.A.G.I.C Lift Operator")

modem = peripheral.find("modem")
gearshift = peripheral.wrap("top")
modem.open(887)
local extend = false

while true do
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if extend == false then
        if message == "extend" and distance <= 5 then
            gearshift.move(6, 1)
            modem.transmit(887, 887, "extending")
            extend = true
        end
    else
        if message == "extend" and distance >= 12 then
            gearshift.move(6, -1)
            modem.transmit(887, 887, "retracting")
            extend = false
        end
    end
end
