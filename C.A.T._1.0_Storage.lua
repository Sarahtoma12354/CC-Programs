--C.A.T. Chat Activated Terminal Storage Manager 1.0

term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.pink)
print("Managing Storage.")
term.setTextColor(colors.lime)

inventory = peripheral.find("inventory_manager")
chat = peripheral.find("chat_box")
reds = peripheral.find("redstone_relay")

bufferName = "minecraft:barrel_0"
buffer = peripheral.wrap(bufferName)
reds.setOutput("bottom", true)

username = nil

--Returns table of index: itemTables
local function refreshItems()
  reds.setOutput("bottom", true)
  local items = {};
  local storageContainers = {peripheral.find("inventory")}
  for storageIndex, storagePeripheral in pairs(storageContainers) do
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
  reds.setOutput("bottom", true)
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
      itemsMoved = storagePeripheral.pushItems(peripheral.getName(buffer), slot, desiredCount)
      desiredCount = desiredCount - itemsMoved
    end
    slots = {}
  end
  return true
end

local function sendItems(desiredItems)
  for item, count in pairs(desiredItems) do
    items = refreshItems()
    foundItem = nil
    prevItem = nil
    for index, itemTable in pairs(items) do
      if string.find(itemTable.name, item) then
        if foundItem ~= prevItem and foundItem and prevItem then
          chat.sendToastToPlayer("Multiple results found for " .. item .. ", please sharpen your search.", "Storage System", username)
          foundItem = "minecraft:air"
          break
        end
        prevItem = foundItem
        foundItem = itemTable.name
      end
    end
    if foundItem then
      prepareItem(foundItem, count)
      reds.setOutput("bottom", true)
      sleep(0.2)
      print("Trying to give " .. count .. " of " .. foundItem)
      result = inventory.addItemToPlayer("up", {name=foundItem, count=count})
      chat.sendToastToPlayer(result .. " of " .. foundItem .. " have been added.", "Storage System", username)
    else
      chat.sendToastToPlayer("No results for " .. item .. " found.", "Storage System", username)
    end
  end
end

local function takeItems(desiredItems)
  for item, count in pairs(desiredItems) do
    items = inventory.getItems()
    foundItem = nil
    prevItem = nil
    for index, itemTable in pairs(items) do
      if string.find(itemTable.name, item) then
        if foundItem ~= prevItem and foundItem and prevItem then
          chat.sendToastToPlayer("Multiple results found for " .. item .. ", please sharpen your search.", "Storage System", username)
          foundItem = "minecraft:air"
          break
        end
        prevItem = foundItem
        foundItem = itemTable.name
      end
    end
    if foundItem then
      reds.setOutput("bottom", false)
      sleep(0.2)
      print("Trying to take " .. count .. " of " .. foundItem)
      result = inventory.removeItemFromPlayer("up", {name=foundItem, count=count})
      chat.sendToastToPlayer(result .. " of " .. foundItem .. " have been removed.", "Storage System", username)
    else
      chat.sendToastToPlayer("No results for " .. item .. " found.", "Storage System", username)
    end
  end
end

local function searchInv(search, count)
  items = inventory.getItems()
  itemList = {}
  foundItem = nil
  prevItem = nil
  for index, itemTable in pairs(items) do
    if string.find(itemTable.name, search) then
      prevItem = foundItem
      foundItem = itemTable.name
      itemList[itemTable.name] = count or itemTable.count
      if foundItem ~= prevItem and foundItem and prevItem then
        chat.sendToastToPlayer("Multiple results found for " .. item .. ", please sharpen your search.", "Storage System", username)
        itemList = {["minecraft:air"] = 0}
        break
      end
    end
  end
  if not next(itemList) then
    chat.sendToastToPlayer("No results found for " .. item .. ", please broaden your search.", "Storage System", username)
  end
  return itemList
end

local function searchStorage(search, count)
  print("Searching for " .. search)
  items = refreshItems()
  itemList = {}
  foundItem = nil
  prevItem = nil
  for index, itemTable in pairs(items) do
    if string.find(itemTable.name, search) then
      itemList[itemTable.name] = count or itemTable.count
      if foundItem ~= prevItem and foundItem and prevItem then
        chat.sendToastToPlayer("Multiple results found for " .. item .. ", please sharpen your search.", "Storage System", username)
        itemList = {["minecraft:air"] = 0}
        break
      end
      prevItem = foundItem
      foundItem = itemTable.name
    end
  end
  if not next(itemList) then
    chat.sendToastToPlayer("No results found for " .. item .. ", please broaden your search.", "Storage System", username)
  end
  return itemList
end

local function itemCount(desiredItems)
  items = refreshItems()
  desiredCount = 0
  print("Trying to find " .. item)
  for item, count in pairs(desiredItems) do
    for index, itemTable in pairs(items) do
      if string.find(itemTable.name, item) then
        desiredCount = desiredCount + itemTable.count
      end
    end
  end
  chat.sendToastToPlayer(desiredCount .. " of \"*" .. item .. "*\" have been found.", "Storage System", username)
end

while true do
  event, username, message, uuid, isHidden, messageUtf8 = os.pullEvent("chat")
  if username == "Sarahtoma" then
    if string.lower(string.sub(message, 1, 4)) == "give" then
      item = string.sub(message, 6, (string.find(message, " ", 6) or 0)-1)
      if string.find(message, " ", 6) then
        count = tonumber(string.sub(message, string.find(message, " ", 6)+1, -1)) or 1
      else
        count = 1
      end
      desiredItems = searchStorage(item, count)
      if not desiredItems["minecraft:air"] then
        sendItems(desiredItems)
      end
    elseif string.lower(string.sub(message, 1, 4)) == "take" then
      if string.lower(string.sub(message, 6, 10)) == "hand" then
        item = inventory.getItemInHand().name
      else
        item = string.sub(message, 6, (string.find(message, " ", 6) or 0)-1)
      end
      if string.lower(string.sub(message, 6, 10)) == "hand" then
        count = tonumber(string.sub(message, 12, -1))
      elseif string.find(message, " ", 6) then
        count = tonumber(string.sub(message, string.find(message, " ", 6)+1, -1)) or 1
      else
        count = 1
      end
      desiredItems = searchInv(item, count)
      if not desiredItems["minecraft:air"] then
        takeItems(desiredItems)
      end
    elseif string.lower(string.sub(message, 1, 4)) == "find" then
      item = string.sub(message, 6, (string.find(message, " ", 6) or 0)-1)
      count = 0
      --desiredItems = searchStorage(item, count)
      --if not desiredItems["minecraft:air"] then
      --  itemCount(desiredItems)
      --end
      itemCount({[item] = count})
    end
  end
end
