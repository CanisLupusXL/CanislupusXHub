repeat wait() until game:IsLoaded()

function loadSave()
    for _,v in pairs(game.Players:GetPlayers()) do
    if v.Name == game.Players.LocalPlayer.Name then
    local HttpService = game:GetService("HttpService")
    if (readfile and isfile and isfile("1yrsZHUB\\"..v.Name.."1YRSZHUB.txt")) then
        _G.SettingsUi = HttpService:JSONDecode(readfile("1yrsZHUB\\"..v.Name.."SecondPiece.txt"));
        
        end
    end
end
end

function saveSettings()
   for _,v in pairs(game.Players:GetPlayers()) do
    if v.Name == game.Players.LocalPlayer.Name then
    local json;
    local HttpService = game:GetService("HttpService");
    if (writefile) then
        json = HttpService:JSONEncode(_G.SettingsUi);
        makefolder("1yrsZHUB")
        writefile("1yrsZHUB\\"..v.Name.."SecondPiece.txt", json);
    end
end
end
end



local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Second Piece", HidePremium = false, SaveConfig = false, ConfigFolder = nil})
local Tab1 = Window:MakeTab({Name = "Main",Icon = nil,PremiumOnly = false})
local PortalTab = Window:MakeTab({Name = "Portal",Icon = nil,PremiumOnly = false})
local SkilTab = Window:MakeTab({Name = "Skill",Icon = nil,PremiumOnly = false})
local Tab2 = Window:MakeTab({Name = "Misc",Icon = nil,PremiumOnly = false})
local Weaponlist = {}


_G.SettingsUi = {
	Weapon = nil;
	MethodSpin = nil;
	AutoEquipTool = false;
	AutoAttack = false;
	AutoChest = false;
	AutoAllBoss = false;
	SkillZ = false;
	SkillX = false;
	SkillC = false;
	SkillV = false;
	AutoSpinFruits = false;
	AutoKenHaki = false;
	AutoBusoHaki = false;

    }

_G.StopAllFrame = nil

for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(Weaponlist,v.Name)
end


local Dropdown = Tab1:AddDropdown({
	Name = "Select Weapon",
	Default = nil,
	Options = Weaponlist,
	Callback = function(bool)
		_G.SettingsUi.Weapon = bool
		saveSettings()
	end    
})

Tab1:AddButton({
	Name = "Refresh Weapon",
	Callback = function()
      		Weaponlist = {}
  for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(Weaponlist,v.Name)
        end
        Dropdown:Refresh((Weaponlist),true)
        Dropdown:Set(nil)
  	end    
})

Tab1:AddToggle({
	Name = "Auto Equip Select Weapon",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoEquipTool = bool
		saveSettings()
	end    
})

Tab1:AddToggle({
	Name = "Auto Attack",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoAttack = bool
		saveSettings()
	end    
})

Tab1:AddToggle({
	Name = "Auto Chest",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoChest = bool
		saveSettings()
	end    
})

Tab1:AddToggle({
	Name = "Auto All Boss",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoAllBoss = bool
		saveSettings()
	end    
})

SkilTab:AddToggle({
	Name = "Z",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.SkillZ = bool
		saveSettings()
	end    
})

SkilTab:AddToggle({
	Name = "X",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.SkillX = bool
		saveSettings()
	end    
})

SkilTab:AddToggle({
	Name = "C",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.SkillC = bool
		saveSettings()
	end    
})

SkilTab:AddToggle({
	Name = "V",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.SkillV = bool
		saveSettings()
	end    
})

local FruitsSelect = Tab2:AddDropdown({
	Name = "Select Mehod",
	Default = nil,
	Options = {"Gem", "Beli"},
	Callback = function(bool)
		_G.SettingsUi.MethodSpin = bool
		saveSettings()
	end    
})

Tab2:AddToggle({
	Name = "Spin Fruits",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoSpinFruits = bool
		saveSettings()
	end    
})

Tab2:AddToggle({
	Name = "Auto KenHaki",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoKenHaki = bool
		saveSettings()
	end    
})

Tab2:AddToggle({
	Name = "Auto BusoHaki",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoBusoHaki = bool
		saveSettings()
	end    
})


Tab2:AddButton({
	Name = "Destroy Gui",
	Callback = function()
      		OrionLib:Destroy()
  	end    
})

PortalTab:AddToggle({
	Name = "Auto Portal",
	Default = nil,
	Callback = function(bool)
		_G.SettingsUi.AutoPortal = bool
		saveSettings()
	end    
})


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
		if _G.SettingsUi.AutoEquipTool and not game.Players.LocalPlayer.Character:FindFirstChild(_G.SettingsUi.Weapon) then
			print("Equiping . . .")
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(_G.SettingsUi.Weapon))
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait(0.5) do pcall(function()
		if _G.SettingsUi.AutoAttack and game.Players.LocalPlayer.Character:FindFirstChild(_G.SettingsUi.Weapon) then
			game:GetService("VirtualInputManager"):SendMouseButtonEvent(600, 10, 0, true, game, 1)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SettingsUi.SkillZ then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SettingsUi.SkillX then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SettingsUi.SkillC then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "C", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SettingsUi.SkillV then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "V", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if _G.SettingsUi.AutoChest then
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
        if _G.SettingsUi.AutoChest then
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
        if _G.SettingsUi.AutoSpinFruits then        
for i,v in pairs(game.Workspace.Shop:GetDescendants()) do
    if v.Name == "Object" then
        if _G.SettingsUi.MethodSpin == "Gem" and v.Value == "RandomDemonFruit" then
            v.Parent.HoldDuration = 0
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame * CFrame.new(0,0,0)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
		elseif  _G.SettingsUi.MethodSpin == "Beli" and v.Value == "RandomDemonFruitBeli" then
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

task.spawn(function ()
    while task.wait() do pcall(function ()
        if _G.SettingsUi.AutoAllBoss then
            for i,v in pairs(game.Workspace.Lives:GetChildren()) do
                if string.find(v.Name,"Natsu") or string.find(v.Name,"Tatsumaki") or string.find(v.Name,"Artoria") or string.find(v.Name,"Sukuna") or string.find(v.Name,"Gojo") or string.find(v.Name,"Kashimo")
				and v.Humanoid.Health > 0 and not _G.StopAllFrame then
					repeat wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
					until v.Humanoid.Health <= 0 or _G.StopAllFrame
                  end
              end
           end
       end)
    end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if _G.SettingsUi.AutoKenHaki then
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
        if _G.SettingsUi.AutoBusoHaki then
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
        if _G.SettingsUi.AutoPortal and game.PlaceId ~= 15049111150 and getclosest().Parent.Humanoid.Health > 0 then
            repeat 
                task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getclosest().CFrame * CFrame.new(0,0,4)
            until getclosest().Parent.Humanoid.Health <= 0 or _G.StopAllFrame
           end
        end)  
    end
end)

task.spawn(function ()
	while task.wait() do pcall(function ()
		if _G.SettingsUi.AutoPortal and game.PlaceId == 15049111150 then
			for i,v in pairs(game.Workspace.World:GetChildren()) do
				if v.Name == "Portal" then
					_G.StopAllFrame = true
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
	while wait() do pcall(function ()
		if  _G.SettingsUi.AutoPortal and game.PlaceId ~= 15049111150 then
			game:GetService("ReplicatedStorage").Remotes.Ready:FireServer()
		end
	end)
	end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if _G.SettingsUi.AutoPortal or _G.SettingsUi.AutoAllBoss then
            setfflag("HumanoidParallelRemoveNoPhysics", "false")
            setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "false")
            game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
        end
        
    end)
    end
end)

loadSave()

if _G.SettingsUi.Weapon then
	_G.SettingsUi.Weapon = bool
end

if _G.SettingsUi.MethodSpin then
	_G.SettingsUi.MethodSpin = bool
end

if _G.SettingsUi.AutoEquipTool then
	_G.SettingsUi.AutoEquipTool = true
end

if _G.SettingsUi.AutoAttack then
	_G.SettingsUi.AutoAttack = true
end

if _G.SettingsUi.AutoChest then
	_G.SettingsUi.AutoChest = true
end

if _G.SettingsUi.AutoAllBoss then
	_G.SettingsUi.AutoAllBoss = true
end

if _G.SettingsUi.SkillZ then
	_G.SettingsUi.SkillZ = true
end

if _G.SettingsUi.SkillX then
	_G.SettingsUi.SkillX = true
end

if _G.SettingsUi.SkillC then
	_G.SettingsUi.SkillC = true
end

if _G.SettingsUi.SkillV then
	_G.SettingsUi.SkillV = true
end

if _G.SettingsUi.AutoSpinFruits then
	_G.SettingsUi.AutoSpinFruits = true
end

if _G.SettingsUi.AutoKenHaki then
	_G.SettingsUi.AutoKenHaki = true
end


if _G.SettingsUi.AutoBusoHaki then
	_G.SettingsUi.AutoBusoHaki = true
end



OrionLib:Init()
