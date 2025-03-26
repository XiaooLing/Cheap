local function convertToFullWidth(text)
    local fullWidthNumbers = {
        ["0"] = "０", ["1"] = "１", ["2"] = "２", ["3"] = "３", ["4"] = "４",
        ["5"] = "５", ["6"] = "６", ["7"] = "７", ["8"] = "８", ["9"] = "９"
    }
    return text:gsub("%d", fullWidthNumbers) -- Replace each number with its full-width equivalent
end

local UserName = game.Players.LocalPlayer.Name
local players = {UserName}

local TextChannel = game.TextChatService.TextChannels.RBXGeneral
local function sign(text)
for i = 1,1000 do
local args = {
    [1] = "ReturningBigSign3Name",
    [2] = tostring(i),
    [3] = text
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Cemeter1y"):FireServer(unpack(args))
local args2 = {
    [1] = "ReturningBigSign2Name",
    [2] = tostring(i),
    [3] = text
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Cemeter1y"):FireServer(unpack(args2))
local args3 = {
    [1] = "ReturningCommercialWords",
    [2] = i,
    [4] = text
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Cemeter1y"):FireServer(unpack(args3))
end
local args = {
    [1] = "Sign",
    [2] = "SignWords",
    [3] = text
}

for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player.Character and player.Character:FindFirstChild("Sign") then
        player.Character.Sign.ToolSound:FireServer(unpack(args))
    end
end
end

local function bundle(i)
    local HttpService = game:GetService("HttpService")
    local url

    if tonumber(i) then
        url = "https://catalog.roblox.com/v1/bundles/" .. i .. "/details"
    else
        url = "https://catalog.roblox.com/v1/search/items?Category=Characters&Keyword=" .. HttpService:UrlEncode(i)
    end

    local function Request()
        local success, Response = pcall(function()
            return game:HttpGetAsync(url)
        end)
        if not success then
            task.wait(10)
            return Request()
        end
        return Response
    end

    local Response = Request()
    local Body = HttpService:JSONDecode(Response)

    -- If searching by keyword, pick a random bundle
    if not tonumber(i) then
        if Body.data and #Body.data > 0 then
            local randomIndex = math.random(1, #Body.data)
            local selectedBundleId = Body.data[randomIndex].id
            url = "https://catalog.roblox.com/v1/bundles/" .. selectedBundleId .. "/details"
            Response = Request() -- Fetch bundle details
            Body = HttpService:JSONDecode(Response)
        else
            warn("No bundles found for keyword: " .. i)
            return
        end
    end

    if Body.errors then
        warn("Bundle not found. Error: " .. HttpService:JSONEncode(Body.errors))
        return
    end

    -- Initialize bundle parts
    local bundleParts = {1, 1, 1, 1, 1, 1}

    -- Populate the bundleParts table
    if Body.items then
        for _, item in ipairs(Body.items) do
            local itemName = item.name:lower()
            if itemName:find("torso") then
                bundleParts[1] = item.id
            elseif itemName:find("right arm") then
                bundleParts[2] = item.id
            elseif itemName:find("left arm") then
                bundleParts[3] = item.id
            elseif itemName:find("right leg") then
                bundleParts[4] = item.id
            elseif itemName:find("left leg") then
                bundleParts[5] = item.id
            elseif itemName:find("head") then
                bundleParts[6] = item.id
            end
        end
    end

    local args = {
        [1] = "CharacterChange",
        [2] = bundleParts,
        [3] = "BundleChanged"
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Avata1rOrigina1l"):FireServer(unpack(args))

    -- Check if TextChannel exists
    if TextChannel then
        TextChannel:SendAsync("Bundle Found! Name: " .. Body.name)
    end
end

-- Function to print the avatar appearance of a specific user by User ID or username
local function copy(userInput)
    local userId
    
    -- Check if the input is a number (UserId) or a string (username)
    if type(userInput) == "number" then
        userId = userInput
    elseif type(userInput) == "string" then
        -- Get the UserId from the username
        local success, id = pcall(function()
            return game.Players:GetUserIdFromNameAsync(userInput)
        end)
        
        if success then
            userId = id
        else
            print("Failed to retrieve UserId from username.")
            return
        end
    else
        print("Invalid input. Please provide a UserId or a username.")
        return
    end
    
    -- Get the humanoid description for the user
    local description = game.Players:GetHumanoidDescriptionFromUserId(userId)

    -- Print out the components of the description
    if description then
        -- Wait before applying each component
        wait(1)  -- Added wait before the initial action
        
        local args = {
            [1] = "CharacterChange",
            [2] = {
                [1] = description.Torso,
                [2] = description.RightArm,
                [3] = description.LeftArm,
                [4] = description.RightLeg,
                [5] = description.LeftLeg,
                [6] = description.Head
            },
            [3] = "BundleChanged"
        } game:GetService("ReplicatedStorage").RE:FindFirstChild("1Avata1rOrigina1l"):FireServer(unpack(args))

wait(0.1)
local properties = {
    "Shirt", "Pants", "Face", "HairAccessory",
    "HatAccessory", "NeckAccessory", "ShouldersAccessory",
    "FrontAccessory", "BackAccessory", "WaistAccessory"
}

-- Iterate through the properties and handle accessories
for _, property in pairs(properties) do
    local value = description[property]
    if value then
        -- Check if the value contains multiple IDs (comma-separated)
        local ids = string.split(value, ",") -- Splits the IDs into a table
        for _, id in pairs(ids) do
            local args = {
                [1] = "wear",
                [2] = tonumber(id) -- Ensure the ID is treated as a number
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Updat1eAvata1r"):FireServer(unpack(args))
            wait(0.1) -- Small delay for each accessory
        end
    else
        print("No value for property:", property)
    end
end
    else
        TextChannel:SendAsync("Failed to retrieve description.")
    end
end

local historys = {}
local function res(sc, uc)
local r = game:HttpGetAsync("https://xiaol.pythonanywhere.com/?sc=" .. game.HttpService:UrlEncode(sc) .. "&uc=" .. game.HttpService:UrlEncode(uc))
print(r)
local success, data = pcall(function()
        return game.HttpService:JSONDecode(r)
    end)

    if success then
        print("Response:", data["response"])
return data["response"]
    else
        warn("Request failed:", data)
    end
end

local an = "Fez"
local ap = "Talk less and Straight to point."

TextChannel.MessageReceived:Connect(function(input)
local SenderName = input.TextSource.Name
local ExactText = input.Text
local input = input.text:lower()
local Num = input:gsub("%s+", "")

function isPlayer(name)
    for _, storedName in ipairs(players) do
        if storedName == name then
            return true  -- Name found, return true
        end
    end
    return false  -- Name not found, return false
end

if isPlayer(SenderName) then
if input:sub(1,6) == "/sign " then
local text = input:sub(7)
sign(text)
end

if input:sub(1,7) == "/bundle" then
local number = Num:sub(8)
if number == "random" then
number = math.random(1,5000)
bundle(number)
else
bundle(number)
end
end

if input == "/r6 torso1" then
local args = {
    [1] = "CharacterChange",
    [2] = {
        [1] = 15365110905,
        [2] = 1,
        [3] = 1,
        [4] = 1,
        [5] = 1,
        [6] = 1
    },
    [3] = "Roblox20"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Avata1rOrigina1l"):FireServer(unpack(args))
elseif input == "/r6 torso2" then
local args = {
    [1] = "CharacterChange",
    [2] = {
        [1] = 17900036764,
        [2] = 1,
        [3] = 1,
        [4] = 1,
        [5] = 1,
        [6] = 1
    },
    [3] = "Roblox20"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Avata1rOrigina1l"):FireServer(unpack(args))
end

if SenderName == UserName and input:sub(1,11) == "/giveacces " then
local target = ExactText:sub(12)
if game.Players[target] then
table.insert(players, target)
TextChannel:SendAsync(convertToFullWidth("Gaved Acces To : " .. target))
end
if not game.Players[target] then
TextChannel:SendAsync("Player Not Found.")
end
end
else return
end

if input:sub(1,6) == "/copy " then
local User = ExactText:sub(7)
copy(User)
end

if input == "/plrs" then
local c = 0
for _, p in ipairs(game.Players:GetPlayers()) do
c = c+1
end
TextChannel:SendAsync(convertToFullWidth(c .. " Players in Game."))
end

if input:sub(1,4) == "/cal" then
local ToCal = input:sub(5)
TextChannel:SendAsync(convertToFullWidth("--> " .. loadstring("return " .. ToCal)()))
end

if input == "/joke" then
local data = game:HttpGetAsync("https://pastebin.com/raw/PU8muDfB")
local body = game.HttpService:JSONDecode(data)
local joc =  math.random(1, 2)
if joc == 1 then
TextChannel:SendAsync(convertToFullWidth("-> " .. body.jokes[math.random(1, #body.jokes)]))
elseif joc == 2 then
TextChannel:SendAsync(convertToFullWidth("-> " .. body.chuck[math.random(1, #body.chuck)]))
end
elseif input == "/joke2" then
local data = game:HttpGetAsync("https://raw.githubusercontent.com/sameerkumar18/geek-joke-api/master/data.json")
local body = game.HttpService:JSONDecode(data)
TextChannel:SendAsync(convertToFullWidth("--> " .. body[math.random(1,#body)]))
end

if input:sub(1, 8) == "/search " then
    local key = input:sub(9)
    local response = game:HttpGetAsync("https://catalog.roblox.com/v1/search/items/?category=all&keyword=" .. key .. "&limit=10&sortType=&sortAggregation=All")
    local body = game.HttpService:JSONDecode(response)

    -- Count all items first
    local itemCount = 0
    for _, i in ipairs(body.data) do
        itemCount = itemCount + 1
    end
   if c == 10 then
TextChannel:SendAsync(convertToFullWidth("10") .. "+ items found.")
   else
       TextChannel:SendAsync(convertToFullWidth(tostring(itemCount)) .. " items found.")
   end
    -- Now try to wear all items
    for _, i in ipairs(body.data) do
        if i.itemType == "Asset" then
            local args = {
                [1] = "wear",
                [2] = tonumber(i.id)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Updat1eAvata1r"):FireServer(unpack(args))
            wait(1.5) -- Small delay for each accessory
local args = {
                [1] = "wear",
                [2] = tonumber(i.id)
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Updat1eAvata1r"):FireServer(unpack(args))
        else
            bundle(i.id)
            wait(3)
        end
    end
end

if input:sub(1,4) =="/ai " then
if not historys[SenderName] then
historys[SenderName] = ""
end
local res = res("your name is " .. an .. ", " .. ap .. ", Here is conversation History: " .. historys[SenderName] .. '. You run in a game environment using Lua, inside a player client script, meaning you can only execute client-side code. The player is always game.Players.LocalPlayer. If you Ever need to Execute a code use exe("code")', input:sub(5))
TextChannel:SendAsync(res)
if select(2, historys[SenderName]:gsub("\n", "")) > 10 then
historys[SenderName] = historys[SenderName]:gsub("^[^\n]*\n[^\n]*\n", "", 1)
end

historys[SenderName] = historys[SenderName] .. "\n User: " .. input:sub(5) .. "\n System: " .. res
local exe = string.match(res, 'exe%("(.-)"%)') 
if exe then
loadstring(exe)()
end
end

if input == "/unban" then
for _, i in ipairs(workspace:GetDescendants()) do
if string.match(i.Name, "BannedBlock") then
i:Destroy()
end
end
end

if input:sub(1,4) == "/an " then
an = ExactText:sub(5)
end

if input:sub(1,4) == "/ap " then
ap = ExactText:sub(5)
end

if input == "/dh" then
historys[SenderName] = ""
end
end)
