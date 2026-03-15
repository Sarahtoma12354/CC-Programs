--C.A.T. Chat Activated Terminal Storage Manager 1.0

inventory = peripheral.find("inventory_manager")
chat = peripheral.find("chat_box")
reds = peripheral.find("redstone_relay")

bufferName = "minecraft:barrel_0"
buffer = peripheral.wrap(bufferName)
reds.setOutput("bottom", true)

--Returns table of index: itemTables
local function refreshItems()
  reds.setOutput("bottom", true)
  local items = {};
  local storageContainers = {peripheral.find("inventory")}
  --print(storageContainers)
  for storageIndex, storagePeripheral in pairs(storageContainers) do
    --print(storageIndex, storagePeripheral)
    for itemIndex, itemTable in pairs(storagePeripheral.list()) do
      table.insert(items, itemTable)
    end
  end
  return items
end



--Returns table of storagePeripheral: count
local function findItem(desiredItem, desiredCount)
  local desiredItemTable = {}
  local storageContainers = {peripheral.find("inventory")}
  for storageIndex, storagePeripheral in pairs(storageContainers) do
    for itemIndex, itemTable in pairs(storagePeripheral.list()) do
      if itemTable.name == desiredItem then
        if itemTable.count >= desiredCount then
          if desiredItemTable[storagePeripheral] then
            desiredItemTable[storagePeripheral] = desiredItemTable[storagePeripheral] + desiredCount
          else
            desiredItemTable[storagePeripheral] = desiredCount
          end
          return desiredItemTable, true
        else
          if desiredItemTable[storagePeripheral] then
            desiredItemTable[storagePeripheral] = desiredItemTable[storagePeripheral] + itemTable.count
          else
            desiredItemTable[storagePeripheral] = itemTable.count
          end
          desiredCount = desiredCount - itemTable.count
        end
      end
    end
  end
  return desiredItemTable, false
end

local function prepareItem(desiredItem, desiredCount)
  local items, status = findItem(desiredItem, desiredCount)
  if not status then
    return false
  end
  local slots = {}
  for storagePeripheral, itemCount in pairs(items) do
    for itemIndex, itemTable in pairs(storagePeripheral.list()) do
      if itemTable.name == desiredItem then
        table.insert(slots, itemIndex)
      end
    end
    for _, slot in pairs(slots) do
      reds.setOutput("bottom", true)
      itemsMoved = storagePeripheral.pushItems(peripheral.getName(buffer), slot, desiredCount)
      desiredCount = desiredCount - itemsMoved
    end
    slots = {}
  end
  return true
end

local function sendItems(desiredItems)
  for item, count in pairs(desiredItems) do
    prepareItem(item, count)
    result = inventory.addItemToPlayer("north", {name=item, count=count})
    chat.sendToastToPlayer(result .. " of " .. item .. " have been added.", "Storage System", "Sarahtoma")
  end
end

local function takeItems(desiredItems)
  for item, count in pairs(desiredItems) do
    reds.setOutput("bottom", false)
    result = inventory.removeItemFromPlayer("north", {name=item, count=count})
    chat.sendToastToPlayer(result .. " of " .. item .. " have been removed.", "Storage System", "Sarahtoma")
  end
end

while true do
  local event, username, message, uuid, isHidden, messageUtf8 = os.pullEvent("chat")
  if username == "Sarahtoma" then
    if string.lower(string.sub(message, 1, 4)) == "give" then
      item = string.sub(message, 6, string.find(message, " ", 6)-1)
      count = tonumber(string.sub(message, string.find(message, " ", 6)+1, -1))
      sendItems({[item] = count})
    elseif string.lower(string.sub(message, 1, 4)) == "take" then
      item = string.sub(message, 6, string.find(message, " ", 6)-1)
      count = tonumber(string.sub(message, string.find(message, " ", 6)+1, -1))
      print(item, count)
      takeItems({[item] = count})
    end
  end
end
