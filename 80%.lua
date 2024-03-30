local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Second Piece", HidePremium = false, SaveConfig = true, ConfigFolder = "Second_Piece"})
local Tab1 = Window:MakeTab({Name = "Main",Icon = nil,PremiumOnly = false})
local PortalTab = Window:MakeTab({Name = "Portal",Icon = nil,PremiumOnly = false})
local SkilTab = Window:MakeTab({Name = "Skill",Icon = nil,PremiumOnly = false})
local Tab2 = Window:MakeTab({Name = "Misc",Icon = nil,PremiumOnly = false})
local Weaponlist = {}
_G.Weapon = nil

for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(Weaponlist,v.Name)
end


local Dropdown = Tab1:AddDropdown({
	Name = "Select Weapon",
	Default = nil,
	Options = Weaponlist,
	Callback = function(bool)
		_G.Weapon = bool
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
		_G.AutoEquipTool = bool
	end    
})

Tab1:AddToggle({
	Name = "Auto Attack",
	Default = nil,
	Callback = function(bool)
		_G.AutoAttack = bool
	end    
})

Tab1:AddToggle({
	Name = "Auto Chest",
	Default = nil,
	Callback = function(bool)
		_G.AutoChest = bool
	end    
})

Tab1:AddToggle({
	Name = "Auto All Boss",
	Default = nil,
	Callback = function(bool)
		_G.AutoAllBoss = bool
	end    
})

SkilTab:AddToggle({
	Name = "Z",
	Default = nil,
	Callback = function(bool)
		_G.SkillZ = bool
	end    
})

SkilTab:AddToggle({
	Name = "X",
	Default = nil,
	Callback = function(bool)
		_G.SkillX = bool
	end    
})

SkilTab:AddToggle({
	Name = "C",
	Default = nil,
	Callback = function(bool)
		_G.SkillC = bool
	end    
})

SkilTab:AddToggle({
	Name = "V",
	Default = nil,
	Callback = function(bool)
		_G.SkillV = bool
	end    
})

local FruitsSelect = Tab2:AddDropdown({
	Name = "Select Mehod",
	Default = nil,
	Options = {"Gem", "Beli"},
	Callback = function(bool)
		_G.MethodSpin = bool
	end    
})

Tab2:AddToggle({
	Name = "Spin Fruits",
	Default = nil,
	Callback = function(bool)
		_G.AutoSpinFruits = bool
	end    
})

Tab2:AddToggle({
	Name = "Auto KenHaki",
	Default = nil,
	Callback = function(bool)
		_G.AutoKenHaki = bool
	end    
})

Tab2:AddToggle({
	Name = "Auto BusoHaki",
	Default = nil,
	Callback = function(bool)
		_G.AutoBusoHaki = bool
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
		_G.AutoPortal = bool
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
		if _G.AutoEquipTool and not game.Players.LocalPlayer.Character:FindFirstChild(_G.Weapon) then
			print("Equiping . . .")
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(_G.Weapon))
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.AutoAttack and game.Players.LocalPlayer.Character:FindFirstChild(_G.Weapon) then
			game:GetService("VirtualInputManager"):SendMouseButtonEvent(600, 10, 0, true, game, 1)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SkillZ then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SkillX then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SkillC then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "C", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
	while task.wait() do pcall(function()
		if _G.SkillV then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, nil)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "V", false, nil)
		   end
	   end)
	end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if _G.AutoChest then
            for i,v in pairs(game.Workspace.Chests:GetDescendants()) do
                if v.ClassName == "ProximityPrompt" then
                    v.HoldDuration = 0
                elseif v.ClassName == "ProximityPrompt" and v.HoldDuration == 0 then
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
        if _G.AutoSpinFruits then        
for i,v in pairs(game.Workspace.Shop:GetDescendants()) do
    if v.Name == "Object" then
        if _G.MethodSpin == "Gem" and v.Value == "RandomDemonFruit" then
            v.Parent.HoldDuration = 0
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.Parent.CFrame * CFrame.new(0,0,0)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, nil)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, nil)
		elseif  _G.MethodSpin == "Beli" and v.Value == "RandomDemonFruitBeli" then
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
        if _G.AutoAllBoss then
            for i,v in pairs(game.Workspace.Lives:GetChildren()) do
                if string.find(v.Name,"Natsu") or string.find(v.Name,"Tatsumaki") or string.find(v.Name,"Artoria") or string.find(v.Name,"Sukuna") or string.find(v.Name,"Gojo") or string.find(v.Name,"Kashimo") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
                  end
              end
           end
       end)
    end
end)

task.spawn(function ()
    while task.wait() do pcall(function ()
        if _G.AutoKenHaki then
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
        if _G.AutoBusoHaki then
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
        if _G.AutoPortal and game.PlaceId ~= 15049111150 and getclosest().Parent.Humanoid.Health > 0 then
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
		if _G.AutoPortal and game.PlaceId == 15049111150 then
			for i,v in pairs(game.Workspace.World:GetChildren()) do
				if v.Name == "Portal" then
					for _,v2 in pairs(v:GetChildren()) do
						if v2.Name == "1" or v2.Name == "2" or v2.Name == "3" then
							local PortalStats = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v2.Position).Magnitude
							local MagStats = 100
							repeat
								wait()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v2.CFrame
							until PortalStats < MagStats
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


OrionLib:Init()
