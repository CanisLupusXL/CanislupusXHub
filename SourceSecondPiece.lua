local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Second Piece Last Update 31/03/2027", "DarkTheme")
local Tab = Window:NewTab("Main")
local PortalTab = Window:NewTab("Portal")
local SkillTab = Window:NewTab("Skill")
local Misc = Window:NewTab("Misc")
local Section = Tab:NewSection("Main")
local PortalConfig = PortalTab:NewSection("Auto Portal")
local SkillConfig = SkillTab:NewSection("Auto Skill")
local MiscConfig = Misc:NewSection("Misc")
local Weaponlist = {}


getgenv().savefilename = "Second_Piece_"..game.Players.LocalPlayer.Name..".txt"

function sex()
    -- reads jsonfile
    local jsonData = readfile(savefilename)
    local data = game:GetService("HttpService"):JSONDecode(jsonData)

    -- global values

    getgenv().Weapon = data.Weapon 
    getgenv().MethodSpin = data.MethodSpin
    getgenv().AutoSpinFruits = data.AutoSpinFruits
    getgenv().AutoEquipTool = data.AutoEquipTool
    getgenv().AutoAttack = data.AutoAttack
    getgenv().AutoChest = data.AutoChest
    getgenv().AutoAllBoss = data.AutoAllBoss
    getgenv().AutoSkillZ = data.AutoSkillZ
    getgenv().AutoSkillX = data.AutoSkillX
    getgenv().AutoSkillC = data.AutoSkillC
    getgenv().AutoSkillV = data.AutoSkillV
    getgenv().AutoPortal = data.AutoPortal
    getgenv().AutoBusoHaki = data.AutoBusoHaki
    getgenv().AutoKenHaki = data.AutoKenHaki

    ---// updates the json file
    function updatejson()

        local xdata = {
            Weapon = getgenv().Weapon,
            MethodSpin = getgenv().MethodSpin,
            AutoEquipTool = getgenv().AutoEquipTool,
            AutoAttack = getgenv().AutoAttack,
            AutoChest = getgenv().AutoChest,
            AutoAllBoss = getgenv().AutoAllBoss,
            AutoSkillZ = getgenv().AutoSkillZ,
            AutoSkillX = getgenv().AutoSkillX,
            AutoSkillC = getgenv().AutoSkillC,
            AutoSkillV = getgenv().AutoSkillV,
            AutoPortal = getgenv().AutoPortal,
            AutoBusoHaki  = getgenv().AutoBusoHaki,
            AutoKenHaki  = getgenv().AutoKenHaki,
            AutoSpinFruits = getgenv().AutoSpinFruits
        }

        local json = game:GetService("HttpService"):JSONEncode(xdata)
        writefile(savefilename, json)

end


for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(Weaponlist,v.Name)
end

-------Main--------

local WeaponName = Section:NewDropdown("Select Weapons", "Select Weapon to Equip", Weaponlist, function(bool)
    getgenv().Weapon = bool
    updatejson()
end)

Section:NewButton("Refreshes Weapons", nil, function()
    Weaponlist = {}
    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(Weaponlist,v.Name)
    WeaponName:Refresh(Weaponlist)
       end
  end)

Section:NewToggle("Auto Equip Select Weapon", nil, function(bool)
    getgenv().AutoEquipTool = bool
    updatejson()
end)

Section:NewToggle("Auto Attack", nil, function(bool)
    getgenv().AutoAttack = bool
    updatejson()
end)

Section:NewToggle("Auto Chests", nil, function(bool)
    getgenv().AutoChest = bool
    updatejson()
end)

Section:NewToggle("Auto AllBoss", nil, function(bool)
    getgenv().AutoAllBoss = bool
    updatejson()
end)

------ Portal Tab ------

PortalConfig:NewToggle("Auto Portal", nil, function(bool)
    getgenv().AutoPortal = bool
    updatejson()
end)

------ Skill Tab ------

SkillConfig:NewToggle("Z", nil, function(bool)
    getgenv().AutoSkillZ = bool
    updatejson()
end)

SkillConfig:NewToggle("X", nil, function(bool)
    getgenv().AutoSkillX = bool
    updatejson()
end)

SkillConfig:NewToggle("C", nil, function(bool)
    getgenv().AutoSkillC = bool
    updatejson()
end)

SkillConfig:NewToggle("V", nil, function(bool)
    getgenv().AutoSkillV = bool
    updatejson()
end)


-------Misc--------

MiscConfig:NewDropdown("Select Methods", "Select Method to Spin", {"Gem", "Beli"}, function(bool)
    getgenv().MethodSpin = bool
    updatejson()
end)

MiscConfig:NewToggle("Auto Spin Fruits", nil, function(bool)
    getgenv().AutoSpinFruits = bool
    updatejson()
end)


MiscConfig:NewToggle("Auto Buso Haki", nil, function(bool)
    getgenv().AutoBusoHaki = bool
    updatejson()
end)

MiscConfig:NewToggle("Auto Ken Haki", nil, function(bool)
    getgenv().AutoKenHaki = bool
    updatejson()
end)


MiscConfig:NewKeybind("Hid Gui", nil, Enum.KeyCode.LeftControl, function()
	Library:ToggleUI()
end)

end -- sex() function end

--------------------------------------------------
--------------------------------------------------

if isfile(savefilename) then -- checks if file exist or not
    sex()
else
    local xdata = {
        Weapon = nil,
        MethodSpin = nil,
        AutoEquipTool = false,
        AutoAttack = false,
        AutoChest = false,
        AutoAllBoss = false,
        AutoSkillZ = false,
        AutoSkillX = false,
        AutoSkillC = false,
        AutoSkillV = false,
        AutoPortal = false,
        AutoBusoHaki = false,
        AutoKenHaki = false,
        AutoSpinFruits = false

    }
    local json = game:GetService("HttpService"):JSONEncode(xdata)
    writefile(savefilename, json)

    sex()
end

function getclosest()
	local MinDistance = math.huge
	   local ClosestObject
	   for i,v in pairs(game.Workspace.Lives:GetDescendants()) do
			if v.Name == "HumanoidRootPart" and v.Parent.Name ~= game.Players.LocalPlayer.Name then
			   local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
			   if dist < MinDistance then
				   MinDistance, ClosestObject = dist, v
			   end
		   end
	   end
	   return ClosestObject
end


task.spawn(function ()
	while task.wait() do pcall(function()
		if getgenv().AutoEquipTool and not game.Players.LocalPlayer.Character:FindFirstChild(getgenv().Weapon) then
			print("Equiping . . .")
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(getgenv().Weapon))
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait(0.75) do pcall(function()
		if getgenv().AutoAttack and game.Players.LocalPlayer.Character:FindFirstChild(getgenv().Weapon) then
			game:GetService("VirtualInputManager"):SendMouseButtonEvent(600, 10, 0, true, game, 1)
		   end
	   end)
	end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoChest then
            for i,v in pairs(game.Workspace.Chests:GetDescendants()) do
                if v.ClassName == "ProximityPrompt" then
                    v.HoldDuration = 0
                   end
                end            
             end
         end)  
    end 
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoChest then
            for i,v in pairs(game.Workspace.Chests:GetDescendants()) do
                if v.ClassName == "ProximityPrompt" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame * CFrame.new(0,0,0)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
                   end
                end            
             end
         end)  
    end 
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoAllBoss then
            for i,v in pairs(game.Workspace.Lives:GetChildren()) do
                if string.find(v.Name,"Natsu") or string.find(v.Name,"Tatsumaki") or string.find(v.Name,"Artoria") or string.find(v.Name,"Sukuna") or string.find(v.Name,"Gojo") or string.find(v.Name,"Kashimo")
				and v.Humanoid.Health > 0 then
					repeat wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
					until v.Humanoid.Health <= 0
                  end
              end
           end
       end)
    end
end)

task.spawn(function ()
	while task.wait(.5) do pcall(function()
		if getgenv().AutoSkillZ then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait(.75) do pcall(function()
		if getgenv().AutoSkillX then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait(.55) do pcall(function()
		if getgenv().AutoSkillC then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "C", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait(.75) do pcall(function()
		if getgenv().AutoSkillV then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "V", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoPortal and game.PlaceId ~= 15049111150 and getclosest().Parent.Humanoid.Health > 0 then
            repeat 
                task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getclosest().CFrame * CFrame.new(0,0,4)
            until getclosest().Parent.Humanoid.Health <= 0
           end
        end)  
    end
end)

task.spawn(function ()
	while task.wait() do pcall(function ()
		if getgenv().AutoPortal and game.PlaceId == 15049111150 then
			for i,v in pairs(game.Workspace.World:GetChildren()) do
				if v.Name == "Portal" then
					for _,v2 in pairs(v:GetChildren()) do
						if v2.Name == "1" or v2.Name == "2" or v2.Name == "3" then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v2.CFrame * CFrame.new(0,-8,0)
							for o_,v3 in pairs(v2:GetDescendants()) do
								if v3.Name == "Frame" and v3:FindFirstChild(game.Players.LocalPlayer.Name) == nil then
									repeat
										task.wait()
									game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
									game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
								until v3:FindFirstChild(game.Players.LocalPlayer.Name) ~= nil
								end
							end
						end
					end
					end
				end
			 end
		end) 
	end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoPortal or getgenv().AutoAllBoss then
            setfflag("HumanoidParallelRemoveNoPhysics", "false")
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "false")
            game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
        end
        
    end)
    end
end)


task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoKenHaki then
            for i,v in pairs(game.Lighting:GetChildren()) do
                if v.Name == "KenHaki" then
                    if v.Enabled == false then
                        repeat
            local args = {[1] = "KenHaki"}game:GetService("ReplicatedStorage").Remotes.SkillHolder:FireServer(unpack(args))
            wait(1.35)    
        until v.Enabled == true
                    end
                end
            end
          end   
       end)   
    end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoBusoHaki then
            for i,v in pairs(game.Workspace.Lives[game.Players.LocalPlayer.Name]:GetChildren()) do
                if v.Name == "Right Arm" and v:FindFirstChild("Haki") == nil then 
            local args = {[1] = "BusoHaki"}game:GetService("ReplicatedStorage").Remotes.SkillHolder:FireServer(unpack(args))
            
                end
            end
          end  
      end)   
    end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if getgenv().AutoSpinFruits then        
for i,v in pairs(game.Workspace.Shop:GetDescendants()) do
    if v.Name == "Object" then
        if getgenv().AutoSpinFruits and getgenv().MethodSpin == "Gem" and v.Value == "RandomDemonFruit" and game.PlaceId == 15049111150 then
            v.Parent.HoldDuration = 0
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame * CFrame.new(0,0,0)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
		elseif getgenv().AutoSpinFruits and getgenv().MethodSpin == "Beli" and v.Value == "RandomDemonFruitBeli" and game.PlaceId == 15049111150 then
			v.Parent.HoldDuration = 0
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame * CFrame.new(0,0,0)
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
                 end
               end
            end
           end     
        end)   
    end
end)
