os.setComputerLabel("Tuff Farm Manager")
term.setTextColor(colors.pink)
term.clear()
term.setCursorPos(1,1)

shell.run("wget", "https://github.com/Sarahtoma12354/CC-Programs/raw/refs/heads/main/TuffGenMain.lua", "startup.lua")

print("Welcome to the tuff farm! to start, place the following items into the highlighted slots.")


turtle.select(1)
print("First, a mechanical press")
while true do
  if turtle.getItemDetail(1) then
    if turtle.getItemDetail(1).name == "create:mechanical_press" then
      break
    end
  end
  sleep(1)
end

turtle.select(2)
print("Second, a basin")
while true do
  if turtle.getItemDetail(2) then
    if turtle.getItemDetail(2).name == "create:basin" then
      break
    end
  end
  sleep(1)
end

turtle.select(3)
print("Third, a deployer")
while true do
  if turtle.getItemDetail(3) then
    if turtle.getItemDetail(3).name == "create:deployer" then
      break
    end
  end
  sleep(1)
end

turtle.select(4)
print("Fourth, a depot")
while true do
  if turtle.getItemDetail(4) then
    if turtle.getItemDetail(4).name == "create:depot" then
      break
    end
  end
  sleep(1)
end

turtle.select(9)
print("Fifth, a chest")
while true do
  if turtle.getItemDetail(9) then
    if turtle.getItemDetail(9).name == "minecraft:chest" then
      break
    end
  end
  sleep(1)
end

turtle.select(12)
print("Sixth, two non-flammable slabs")
while true do
  if turtle.getItemDetail(12) then
    if turtle.getItemDetail(12).count >= 2 then
      break
    end
  end
  sleep(1)
end

turtle.select(13)
print("Seventh, a water bucket")
while true do
  if turtle.getItemDetail(13) then
    if turtle.getItemDetail(13).name == "minecraft:water_bucket" then
      break
    end
  end
  sleep(1)
end

turtle.select(14)
print("Eighth, a lava bucket")
while true do
  if turtle.getItemDetail(14) then
    if turtle.getItemDetail(14).name == "minecraft:lava_bucket" then
      break
    end
  end
  sleep(1)
end

turtle.select(15)
print("Ninth, a piece of bamboo")
while true do
  if turtle.getItemDetail(15) then
    if turtle.getItemDetail(15).name == "minecraft:bamboo" then
      break
    end
  end
  sleep(1)
end

turtle.select(16)
print("Tenth, a block of dirt")
while true do
  if turtle.getItemDetail(16) then
    if turtle.getItemDetail(16).name == "minecraft:dirt" then
      break
    end
  end
  sleep(1)
end

turtle.select(5)
print("Finally, any furnace fuel")
while true do
  if turtle.getItemDetail(5) then
    if turtle.getItemDetail(5).count > 0 then
      break
    end
  end
  sleep(1)
end

print("Thank you. Building...")

turtle.select(5)
turtle.refuel()
turtle.select(1)
turtle.placeUp()
turtle.select(2)
turtle.placeDown()
turtle.forward()
turtle.up()
turtle.select(12)
turtle.placeUp()
turtle.select(3)
turtle.down()
turtle.placeUp()
turtle.select(4)
turtle.placeDown()
turtle.turnLeft()
turtle.turnLeft()
turtle.forward()
turtle.turnLeft()
turtle.turnLeft()

term.setTextColor(colors.red)
print("- Tuff generator built.")
print("- Please place a crafting table in the top peripheral slot and a diamond pickaxe in the bottom one.")
print("- Lava is to be input to the basin, and rotation to either machine that requires it.")
print("- Positions for lava and water above the basin and in place of the deployer respectively must be contained however you see fit.")
print("- After those are done, restart the turtle.")
