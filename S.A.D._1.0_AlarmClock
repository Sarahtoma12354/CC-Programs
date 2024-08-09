-- S.A.D. Sleep Alert Directive 1.0
if peripheral.find("speaker") == nil then
    error("No Speaker Found.")
end

os.setComputerLabel("S.A.D. Alarm Clock")
term.clear()
term.setCursorPos(1,1)
print("S.A.D. Clock Started.")
speaker = peripheral.find("speaker")

while true do
    if peripheral.find("speaker") == nil then
        error("Speaker Removed.")
    end
    if os.time() >= 18.5 then
        speaker.playSound("minecraft:block.bell.use", 3)
        os.sleep(1.5)
        speaker.playSound("minecraft:block.bell.use", 3)
        os.sleep(1.5)
        speaker.playSound("minecraft:block.bell.use", 3)
        os.sleep(180)
    end
    os.sleep(1)
end
