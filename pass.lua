
local function fileTest()
    file = io.open("masterPass.txt", "r")
    print(file:read())
    file:close()
end

if not pcall(fileTest) then
    file = io.open("masterPass.txt", "w")
    print("Please input the master password:")
    userMasterPass = io.read()
    file:write(userMasterPass)
    file:close()
    print("Password accepted, thank you.")
    os.sleep(3)
end

term.clear()


while true do
    print("Please input password:")
    userPass = io.read("*")
    file = io.open("masterPass.txt", "r")
    readMasterPass = file:read()
    file:close()

    if userPass == readMasterPass then
        print("Password accepted.")
        rs.setOutput("back", true)
    else
        print("Incorrect password.")
    end
    os.sleep(3)
    rs.setOutput("back", false)
    term.clear()
    os.sleep(0.05)
end