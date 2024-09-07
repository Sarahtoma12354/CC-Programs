--B.A.D. Boredom Avoidance Directive Pipe Generation 1.2

if (peripheral.find("monitor") ~= nil) == false then
    print("Please place a monitor next to the computer.")
    error("No Monitor Found.")
end

os.setComputerLabel("B.A.D. Pipe Generation")
term.clear()
term.setCursorPos(1,1)
print("B.A.D. Pipe Generation Started")
monitor = peripheral.find("monitor")
monitor.setCursorPos(1,1)
monitor.clear()
xMax, yMax = monitor.getSize()
loops = 0
chars = {}
chars.up = "\x95"
chars.right = "\x83"
chars.down = "\x95"
chars.left = "\x83"
chars.upLeft = "\x95"
chars.upRight = "\x97"
chars.downLeft = "\x81"
chars.downRight = "\x83"
status = {}
status.direction = 0 -- 0 = up, 1 = right, 2 = down, 3 = left
status.turn = false
status.turnDirection = 0
monitor.setCursorPos(math.floor(xMax/2), math.floor(yMax/2))
print("Program Started.")
while true do
    if (peripheral.find("monitor") ~= nil) == false then
        print("Monitor Removed.")
        error("No Monitor Found.")
    end
    loops = loops + 1
    x, y = monitor.getCursorPos()
--    status.direction = (math.random(4)-1)
    status.turnDirection = (math.random(4)-1)
    if math.random(2) == 1 then
      status.turn = true
    else
      status.turn = false
    end

    if status.turn == true then
      if status.turnDirection == 0 then
        if status.direction == 0 then
          monitor.write(chars.up)
          monitor.setCursorPos(x, y-1)
          status.direction = 0
        elseif status.direction == 1 then
          monitor.write(chars.downLeft)
          monitor.setCursorPos(x, y-1)
          status.direction = 0
        elseif status.direction == 2 then
          monitor.write(chars.down)
          monitor.setCursorPos(x, y+1)
          status.direction = 2
        elseif status.direction == 3 then
          monitor.write(chars.left)
          monitor.setCursorPos(x, y-1)
          status.direction = 0
        end
      elseif status.turnDirection == 1 then
        if status.direction == 0 then
          monitor.write(chars.upRight)
          monitor.setCursorPos(x+1, y)
          status.direction = 1
        elseif status.direction == 1 then
          monitor.write(chars.right)
          monitor.setCursorPos(x+1, y)
          status.direction = 1
        elseif status.direction == 2 then
          monitor.write(chars.downRight)
          monitor.setCursorPos(x+1, y)
          status.direction = 1
        elseif status.direction == 3 then
          monitor.write(chars.left)
          monitor.setCursorPos(x-1, y)
          status.direction = 3
        end
      elseif status.turnDirection == 2 then
        if status.direction == 0 then
          monitor.write(chars.up)
          monitor.setCursorPos(x, y-1)
          status.direction = 0
        elseif status.direction == 1 then
          monitor.write(chars.upLeft)
          monitor.setCursorPos(x, y+1)
          status.direction = 2
        elseif status.direction == 2 then
          monitor.write(chars.down)
          monitor.setCursorPos(x, y+1)
          status.direction = 2
        elseif status.direction == 3 then
          monitor.write(chars.upRight)
          monitor.setCursorPos(x, y+1)
          status.direction = 2
        end
      elseif status.turnDirection == 3 then
        if status.direction == 0 then
          monitor.write(chars.upLeft)
          monitor.setCursorPos(x-1, y)
          status.direction = 3
        elseif status.direction == 1 then
          monitor.write(chars.right)
          monitor.setCursorPos(x+1, y)
          status.direction = 1
        elseif status.direction == 2 then
          monitor.write(chars.downLeft)
          monitor.setCursorPos(x-1, y)
          status.direction = 3
        elseif status.direction == 3 then
          monitor.write(chars.left)
          monitor.setCursorPos(x-1, y)
          status.direction = 3
        end
      end
    elseif status.direction == 0 then
      monitor.write(chars.up)
      monitor.setCursorPos(x, y-1)
    elseif status.direction == 1 then
      monitor.write(chars.right)
      monitor.setCursorPos(x+1, y)
    elseif status.direction == 2 then
      monitor.write(chars.down)
      monitor.setCursorPos(x, y+1)
    elseif status.direction == 3 then
      monitor.write(chars.left)
      monitor.setCursorPos(x-1, y)
    end

    if x <= 0 then
      monitor.setCursorPos(xMax, y)
    elseif x > xMax + 1 then
      monitor.setCursorPos(1, y)
    end

    if y <= 0 then
      monitor.setCursorPos(x, yMax)
    elseif y > yMax + 1 then
      monitor.setCursorPos(x, 1)
    end
    if loops >= (((xMax * yMax)/2)*3) then
      os.sleep(0.5)
      monitor.clear()
      loops = 0
    end

    if loops % 4 == 0 then
      monitor.setTextColor(colors.white)
    elseif loops % 4 == 1 or loops % 4 == 3 then
      monitor.setTextColor(colors.lightGray)
    elseif loops % 4 == 2 then
      monitor.setTextColor(colors.gray)
    end

    os.sleep(0.05)
end
