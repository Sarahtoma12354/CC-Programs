-- M.A.G.I.C. Movement Assistance and Guidance Intelligence Coordinator Lift Notifier 1.0

if peripheral.find("modem") == false then
  printError("No modem found, please equip one.")
end

term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.pink)
print("M.A.G.I.C Lift Notifier Started")

modem = peripheral.find("modem")
modem.open(887)
while true do
  modem.transmit(887, 887, "extend")
  os.sleep(0.5)
end
