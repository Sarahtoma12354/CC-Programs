-- Tuff auto generation program

craftTable = peripheral.wrap("left")

local slots = {}


slots.tuff = 1
slots.flint = 2
slots.deepslate = 3
slots.andesite = 4
slots.cobblestone = 5
slots.pebble = 6
slots.gravel = 7
slots.stick = 8
slots.chest = 9

slots.shovel = 10
slots.deployer = 10
slots.depot = 11

slots.slab = 12
slots.water = 13
slots.lava = 14
slots.bamboo = 15
slots.dirt = 16
slots.press = 16

isStill = true

function refuel()
  if isStill == false then
    return false
  end

  turtle.select(slots.lava)
  turtle.refuel()
  turtle.placeDown()

  if turtle.getFuelLevel() < (turtle.getFuelLimit()/2) then
    sleep(0.2)
    refuel()
  end
end


function putAway(item, count)
  turtle.select(slots[item])
  return turtle.drop(count)
end

function take(item)
  turtle.select(slots[item])
  return turtle.suck()
end

function farmBamboo()
  isStill = false

  refuel()

  turtle.forward()
  turtle.select(slots.deployer)
  turtle.digUp()
  turtle.select(slots.depot)
  turtle.digDown()

  turtle.select(slots.dirt)
  turtle.placeDown()
  turtle.select(slots.bamboo)
  turtle.up()
  turtle.placeDown()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(slots.press)
  turtle.dig()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(slots.bamboo)

  count = 0

  if turtle.getItemDetail(slots.bamboo) then
    count = turtle.getItemDetail(slots.bamboo).count
  end

  while count < 48 do
    sleep(1)

    if turtle.getItemDetail(slots.bamboo) then
      count = turtle.getItemDetail(slots.bamboo).count
    end

    if turtle.inspect() then
      turtle.dig()
    end
  end

  if turtle.inspect() then
    turtle.dig()
  end
  turtle.forward()
  turtle.digDown()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(slots.press)
  turtle.place()
  turtle.down()
  turtle.select(slots.dirt)
  turtle.digDown()
  turtle.select(slots.deployer)
  turtle.placeUp()
  turtle.select(slots.depot)
  turtle.placeDown()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()



  isStill = true
end

function farmCobblestone()
  isStill = false

  refuel()

  turtle.forward()
  turtle.select(slots.deployer)
  turtle.digUp()
  turtle.select(slots.depot)
  turtle.digDown()
  turtle.up()
  turtle.select(slots.slab)
  turtle.digUp()
  turtle.down()

  turtle.select(slots.slab)
  turtle.placeUp()
  turtle.select(slots.water)
  turtle.placeUp()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(slots.lava)
  turtle.place()
  turtle.down()

  turtle.select(slots.cobblestone)
  count = 0

  if turtle.getItemDetail(slots.cobblestone) then
    count = turtle.getItemDetail(slots.cobblestone).count
  end

  while count < 30 do
    sleep(1)

    if turtle.getItemDetail(slots.cobblestone) then
      count = turtle.getItemDetail(slots.cobblestone).count
    end

    if turtle.inspectUp() then
      turtle.digUp()
    end
  end

  if turtle.inspectUp() then
    turtle.digUp()
  end
  turtle.up()

  turtle.select(slots.lava)
  turtle.place()
  turtle.select(slots.water)
  turtle.placeUp()
  turtle.select(slots.slab)
  turtle.digUp()
  turtle.up()
  turtle.placeUp()
  turtle.down()

  turtle.select(slots.deployer)
  turtle.placeUp()
  turtle.select(slots.depot)
  turtle.placeDown()

  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()



  isStill = true
end


function stall(reason)
  if reason == "bamboo" then
    sleep(30)
    if turtle.getItemDetail(slots.bamboo) then
      print("Thank you.")
    else
      stall("bamboo")
    end
  elseif reason == "flint" then

    refuel()
    turtle.forward()
    turtle.select(slots.shovel)
    turtle.dropUp()

    turtle.select(slots.gravel)
    turtle.dropDown(1)
    deployer = peripheral.wrap("top")
    while deployer.list()[1] do
      turtle.turnLeft()
      turtle.turnLeft()
      turtle.forward()
      turtle.turnLeft()
      turtle.turnLeft()
      turtle.forward()
      sleep(10)
    end
    turtle.select(slots.gravel)
    turtle.suckDown()
    turtle.select(slots.flint)
    turtle.suckDown()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
  end
end


function craft(item)
  if isStill == false then
    return false
  end
  if item == "pebble" then
    if not turtle.getItemDetail(slots.cobblestone) then
      farmCobblestone()
    elseif turtle.getItemDetail(slots.cobblestone).count < 2 then
      farmCobblestone()
    end

    turtle.select(slots.chest)
    turtle.place()

    tuff = putAway("tuff")
    flint = putAway("flint")
    deepslate = putAway("deepslate")
    andesite = putAway("andesite")
    --cobblestone = putAway("cobblestone")
    pebble = putAway("pebble")
    gravel = putAway("gravel")
    stick = putAway("stick")
    slab = putAway("slab")
    water = putAway("water")
    lava = putAway("lava")
    bamboo = putAway("bamboo")
    dirt = putAway("dirt")

    turtle.select(slots.cobblestone)
    turtle.transferTo(1)

    turtle.select(1)
    craftTable.craft()

    turtle.transferTo(slots.pebble)

    if tuff then
      take("tuff")
    end
    if flint then
      take("flint")
    end
    if deepslate then
      take("deepslate")
    end
    if andesite then
      take("andesite")
    end
    if pebble then
      take("pebble")
    end
    if gravel then
      take("gravel")
    end
    if stick then
      take("stick")
    end
    if slab then
      take("slab")
    end
    if water then
      take("water")
    end
    if lava then
      take("lava")
    end
    if bamboo then
      take("bamboo")
    end
    if dirt then
      take("dirt")
    end

    turtle.select(slots.chest)
    turtle.dig()

  elseif item == "gravel" then
    if not turtle.getItemDetail(slots.pebble) then
      craft("pebble")
    end

    turtle.select(slots.chest)
    turtle.place()

    tuff = putAway("tuff")
    flint = putAway("flint")
    deepslate = putAway("deepslate")
    andesite = putAway("andesite")
    cobblestone = putAway("cobblestone")
    --pebble = putAway("pebble")
    gravel = putAway("gravel")
    stick = putAway("stick")
    slab = putAway("slab")
    water = putAway("water")
    lava = putAway("lava")
    bamboo = putAway("bamboo")
    dirt = putAway("dirt")

    turtle.select(slots.pebble)
    count = turtle.getItemDetail().count

    turtle.transferTo(2, math.floor(count/4))
    turtle.transferTo(1, math.ceil(count/4))
    turtle.transferTo(5, math.ceil(count/4))

    turtle.select(1)
    craftTable.craft()

    if count % 4 ~= 0 then
      turtle.transferTo(5)
      turtle.select(2)
      turtle.transferTo(slots.gravel)
      turtle.select(5)
      turtle.transferTo(slots.pebble)
    else
      turtle.transferTo(slots.gravel)
    end

    if tuff then
      take("tuff")
    end
    if flint then
      take("flint")
    end
    if deepslate then
      take("deepslate")
    end
    if andesite then
      take("andesite")
    end
    if pebble then
      take("pebble")
    end
    if gravel then
      take("gravel")
    end
    if stick then
      take("stick")
    end
    if slab then
      take("slab")
    end
    if water then
      take("water")
    end
    if lava then
      take("lava")
    end
    if bamboo then
      take("bamboo")
    end
    if dirt then
      take("dirt")
    end
    turtle.select(slots.chest)
    turtle.dig()

    return true
  elseif item == "stick" then
    if not turtle.getItemDetail(slots.bamboo) then
      print("Out of bamboo. Please replace.")
      stall("bamboo")
    elseif turtle.getItemDetail(slots.bamboo).count < 3 then
      farmBamboo()
    end

    turtle.select(slots.chest)
    turtle.place()

    tuff = putAway("tuff")
    flint = putAway("flint")
    deepslate = putAway("deepslate")
    andesite = putAway("andesite")
    cobblestone = putAway("cobblestone")
    pebble = putAway("pebble")
    gravel = putAway("gravel")
    stick = putAway("stick")
    slab = putAway("slab")
    water = putAway("water")
    lava = putAway("lava")
    --bamboo = putAway("bamboo")
    dirt = putAway("dirt")

    turtle.select(slots.bamboo)
    turtle.transferTo(1)

    turtle.select(1)
    turtle.transferTo(5, math.floor(turtle.getItemDetail(1).count/2))
    craftTable.craft(turtle.getItemDetail(1).count - 1)

    if turtle.getItemDetail(5) then
      turtle.select(5)
      turtle.transferTo(slots.bamboo)
    end

    turtle.select(1)
    turtle.transferTo(slots.bamboo)
    turtle.select(2)
    turtle.transferTo(slots.stick)

    if tuff then
      take("tuff")
    end
    if flint then
      take("flint")
    end
    if deepslate then
      take("deepslate")
    end
    if andesite then
      take("andesite")
    end
    if cobblestone then
      take("cobblestone")
    end
    if pebble then
      take("pebble")
    end
    if gravel then
      take("gravel")
    end
    if stick then
      take("stick")
    end
    if slab then
      take("slab")
    end
    if water then
      take("water")
    end
    if lava then
      take("lava")
    end
    --if bamboo then
    --  take("bamboo")
    --end
    if dirt then
      take("dirt")
    end


    turtle.select(slots.chest)
    turtle.dig()

    return true

  elseif item == "shovel" then
    if not turtle.getItemDetail(slots.gravel) then
      craft("gravel")
    end
    if not turtle.getItemDetail(slots.cobblestone) then
      farmCobblestone()
    elseif turtle.getItemDetail(slots.cobblestone).count < 1 then
      farmCobblestone()
    end

    if not turtle.getItemDetail(slots.stick) then
      craft("stick")
    elseif turtle.getItemDetail(slots.stick).count < 2 then
      craft("stick")
    end

    turtle.select(slots.chest)
    turtle.place()

    tuff = putAway("tuff")
    flint = putAway("flint")
    deepslate = putAway("deepslate")
    andesite = putAway("andesite")
    if turtle.getItemDetail(slots.cobblestone).count - 1 > 0 then
      cobblestone = putAway("cobblestone", ((turtle.getItemDetail(slots.cobblestone).count - 1)))
    else
      cobblestone = false
    end

    pebble = putAway("pebble")
    gravel = putAway("gravel")

    if turtle.getItemDetail(slots.stick).count - 2 > 0 then
      stick = putAway("stick", ((turtle.getItemDetail(slots.stick).count - 2)))
    else
      stick = false
    end


    slab = putAway("slab")
    water = putAway("water")
    lava = putAway("lava")
    bamboo = putAway("bamboo")
    dirt = putAway("dirt")

    turtle.select(slots.cobblestone)
    turtle.transferTo(1)
    turtle.select(slots.stick)
    turtle.transferTo(5, 1)
    turtle.transferTo(9)

    turtle.select(1)
    craftTable.craft()
    turtle.transferTo(slots.shovel)


    if tuff then
      take("tuff")
    end
    if flint then
      take("flint")
    end
    if deepslate then
      take("deepslate")
    end
    if andesite then
      take("andesite")
    end
    if cobblestone then
      take("cobblestone")
    end
    if pebble then
      take("pebble")
    end
    if gravel then
      take("gravel")
    end
    if stick then
      take("stick")
    end
    if slab then
      take("slab")
    end
    if water then
      take("water")
    end
    if lava then
      take("lava")
    end
    if bamboo then
      take("bamboo")
    end
    if dirt then
      take("dirt")
    end
    turtle.select(slots.chest)
    turtle.dig()

    stall("flint")

    return true

  elseif item == "andesite" then
    count = 0
    if turtle.getItemDetail(slots.flint) then
      count = turtle.getItemDetail(slots.flint).count
      while count < 2 do
        craft("shovel")
        count = turtle.getItemDetail(slots.flint).count
      end
    end

    if not turtle.getItemDetail(slots.flint) then
      while count < 2 do
        craft("shovel")
        count = turtle.getItemDetail(slots.flint).count
      end
    end

    if not turtle.getItemDetail(slots.flint) then
      if turtle.getItemDetail(slots.flint).count < 2 then
        return false
      end
    end

    count = 0
    if turtle.getItemDetail(slots.gravel) then
      count = turtle.getItemDetail(slots.gravel).count
      while count < 2 do
        craft("gravel")
        count = turtle.getItemDetail(slots.gravel).count
      end
    end

    if not turtle.getItemDetail(slots.gravel) then
      while count < 2 do
        craft("gravel")
        count = turtle.getItemDetail(slots.gravel).count
      end
    end

    if not turtle.getItemDetail(slots.gravel) then
      if turtle.getItemDetail(slots.gravel).count < 1 then
        return false
      end
    end

    turtle.select(slots.gravel)
    turtle.dropDown(1)
    turtle.select(slots.flint)
    turtle.dropDown(2)
    basin = peripheral.wrap("bottom")
    while not basin.list()[10] do
      sleep(0.5)
    end
    turtle.select(slots.andesite)
    turtle.suckDown()

  elseif item == "deepslate" then

    count = 0
    if turtle.getItemDetail(slots.flint) then
      count = turtle.getItemDetail(slots.flint).count
      while count < 3 do
        craft("shovel")
        count = turtle.getItemDetail(slots.flint).count
      end
    end

    if not turtle.getItemDetail(slots.flint) then
      while count < 3 do
        craft("shovel")
        count = turtle.getItemDetail(slots.flint).count
      end
    end

    if not turtle.getItemDetail(slots.flint) then
      if turtle.getItemDetail(slots.flint).count < 2 then
        return false
      end
    end

    turtle.select(slots.flint)
    turtle.dropDown(3)
    basin = peripheral.wrap("bottom")
    while not basin.list()[10] do
      sleep(0.5)
    end
    turtle.select(slots.deepslate)
    turtle.suckDown()

  elseif item == "tuff" then
    if not turtle.getItemDetail(slots.andesite) then
      count = 0
      while count < 2 do
        craft("andesite")
        count = turtle.getItemDetail(slots.andesite).count
      end
    elseif turtle.getItemDetail(slots.andesite).count < 2 then
      count = turtle.getItemDetail(slots.andesite).count
      while count < 2 do
        craft("andesite")
        count = turtle.getItemDetail(slots.andesite).count
      end
    end

    if not turtle.getItemDetail(slots.deepslate) then
      count = 0
      while count < 2 do
        craft("deepslate")
        count = turtle.getItemDetail(slots.deepslate).count
      end
    elseif turtle.getItemDetail(slots.deepslate).count < 2 then
      count = turtle.getItemDetail(slots.deepslate).count
      while count < 2 do
        craft("deepslate")
        count = turtle.getItemDetail(slots.deepslate).count
      end
    end

    turtle.select(slots.chest)
    turtle.place()

    tuff = putAway("tuff")
    flint = putAway("flint")
    --deepslate = putAway("deepslate")
    --andesite = putAway("andesite")
    cobblestone = putAway("cobblestone")
    pebble = putAway("pebble")
    gravel = putAway("gravel")
    stick = putAway("stick")
    slab = putAway("slab")
    water = putAway("water")
    lava = putAway("lava")
    bamboo = putAway("bamboo")
    dirt = putAway("dirt")

    turtle.select(slots.andesite)
    count = turtle.getItemDetail(slots.andesite).count
    turtle.transferTo(2, math.ceil(count/2))
    turtle.transferTo(5)
    turtle.select(slots.deepslate)
    count = turtle.getItemDetail(slots.deepslate).count
    turtle.transferTo(1, math.ceil(count/2))
    turtle.transferTo(6)

    turtle.select(1)
    craftTable.craft()

    if turtle.getItemDetail(3) then
      turtle.select(3)
      turtle.transferTo(slots.tuff)

      turtle.select(2)
      turtle.transferTo(slots.andesite)

      turtle.select(1)
      turtle.transferTo(slots.deepslate)
    else
      turtle.select(1)
      turtle.transferTo(slots.tuff)
    end

    if tuff then
      take("tuff")
    end
    if flint then
      take("flint")
    end
    --[[
    if deepslate then
      take("deepslate")
    end
    if andesite then
      take("andesite")
    end
    ]]--
    if cobblestone then
      take("cobblestone")
    end
    if pebble then
      take("pebble")
    end
    if gravel then
      take("gravel")
    end
    if stick then
      take("stick")
    end
    if slab then
      take("slab")
    end
    if water then
      take("water")
    end
    if lava then
      take("lava")
    end
    if bamboo then
      take("bamboo")
    end
    if dirt then
      take("dirt")
    end

    turtle.select(slots.chest)
    turtle.dig()

    return true

  end
end

tuffCount = 0

while true do
  if turtle.getItemDetail(slots.tuff) then
    tuffCount = turtle.getItemDetail(slots.tuff).count
  else
    tuffCount = 0
  end

  if tuffCount < 56 then
    craft("tuff")
  else
    sleep(10)
  end
end
