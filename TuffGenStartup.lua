os.setComputerLabel("Tuff Farm Manager")
term.setTextColor(colors.pink)
term.clear()
term.setCursorPos(1,1)

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

turtle.select(slots.chest)
print("Fifth, a chest")
while true do
  if turtle.getItemDetail(slots.chest) then
    if turtle.getItemDetail(slots.chest).name == "minecraft:chest" then
      break
    end
  end
  sleep(1)
end

turtle.select(slots.slab)
print("Sixth, two non-flammable slabs")
while true do
  if turtle.getItemDetail(slots.slab) then
    if turtle.getItemDetail(slots.slab).count >= 2 then
      break
    end
  end
  sleep(1)
end

turtle.select(slots.water)
print("Seventh, a water bucket")
while true do
  if turtle.getItemDetail(slots.water) then
    if turtle.getItemDetail(slots.water).name == "minecraft:water_bucket" then
      break
    end
  end
  sleep(1)
end

turtle.select(slots.lava)
print("Eighth, a lava bucket")
while true do
  if turtle.getItemDetail(slots.lava) then
    if turtle.getItemDetail(slots.lava).name == "minecraft:lava_bucket" then
      break
    end
  end
  sleep(1)
end

turtle.select(slots.bamboo)
print("Ninth, a piece of bamboo")
while true do
  if turtle.getItemDetail(slots.bamboo) then
    if turtle.getItemDetail(slots.bamboo).name == "minecraft:bamboo" then
      break
    end
  end
  sleep(1)
end

turtle.select(slots.dirt)
print("Tenth, a block of dirt")
while true do
  if turtle.getItemDetail(slots.dirt) then
    if turtle.getItemDetail(slots.dirt).name == "minecraft:dirt" then
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
turtle.up
turtle.select(slots.slab)
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

print("Tuff generator built. Connect a lava input to the basin and rotation to either the press or deployer and restart this computer.")
