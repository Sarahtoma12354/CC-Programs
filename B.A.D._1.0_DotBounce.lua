--B.A.D. Boredom Avoidance Directive Dot Bounce 1.0
--Argument Order: "Dot Text", (Text Scale), (Background Color), (Text Color), (Dot Speed)
--Use "_" to skip arguments!

if peripheral.find("monitor") == nil then
    print("Please place a monitor next to the computer.")
    error("No Monitor Found.")
end

local args = {...}

for i, v in pairs(args) do
  if v == "_" then
    args[i] = nil
  end
end

dotChar = args[1] or "\x07"

local function printDot(x, y)
  monitor.setCursorPos(x - string.len(dotChar), y)
  monitor.clear()
  monitor.write(dotChar)
end

os.setComputerLabel("B.A.D. Dot Bounce")
monitor = peripheral.find("monitor")
xMax, yMax = monitor.getSize()
term.clear()
term.setCursorPos(1, 1)
print("B.A.D. Dot Bounce Started")
dir = {}

monitor.setTextScale(tonumber(args[2]) or 1)
monitor.setBackgroundColor(tonumber(args[3]) or colors.black)
monitor.setTextColor(tonumber(args[4]) or colors.white)

local function waitClick()
  local event, side, x, y = os.pullEvent("monitor_touch")
end

local function bounce()
  dir.x = ((math.random(2) * 2) - 3)
  dir.y = ((math.random(2) * 2) - 3)
  monitor.setCursorPos(math.floor(xMax/2 + math.random(-3, 3) + (string.len(dotChar)/2)), math.floor(yMax/2 + math.random(-3, 3)))

  while true do
    x, y = monitor.getCursorPos()
    if x < xMax and x > 0 and y < yMax and y > 0 then
      printDot(x + dir.x, y + dir.y)
    end

    if x >= xMax or x < 3 + (string.len(dotChar) - 1) then
      dir.x = dir.x * -1
      printDot(x + dir.x, y + dir.y)
    end

    if y >= yMax or y < 2 then
      dir.y = dir.y * -1
      printDot(x + dir.x, y + dir.y)
    end
    sleep(tonumber(args[5]) or 0.25)
  end
end

while true do
  parallel.waitForAny(waitClick, bounce)
end
