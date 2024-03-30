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
	Weapon = bool;
	MethodSpin = bool;
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
	Default = _G.SettingsUi.Weapon,
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
	Default = _G.SettingsUi.AutoEquipTool,
	Callback = function(bool)
		_G.SettingsUi.AutoEquipTool = bool
		saveSettings()
		if bool then
			AutoEquipTool()
		end
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

function AutoEquipTool()
	spawn(function ()
		while _G.SettingsUi.AutoEquipTool do wait() pcall(function ()
			if _G.SettingsUi.AutoEquipTool and not game.Players.LocalPlayer.Character:FindFirstChild(_G.SettingsUi.Weapon) then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(_G.SettingsUi.Weapon))
			  end
		   end)
		end
	end)
end



loadSave()

if _G.SettingsUi.Weapon then
	_G.SettingsUi.Weapon = bool
end

if _G.SettingsUi.MethodSpin then
	_G.SettingsUi.MethodSpin = bool
end

if _G.SettingsUi.AutoEquipTool then
	AutoEquipTool()
end

if _G.SettingsUi.AutoAttack then
	
end

if _G.SettingsUi.AutoChest then
	
end

if _G.SettingsUi.AutoAllBoss then
	
end

if _G.SettingsUi.SkillZ then
	
end

if _G.SettingsUi.SkillX then
	
end

if _G.SettingsUi.SkillC then
	
end

if _G.SettingsUi.SkillV then
	
end

if _G.SettingsUi.AutoSpinFruits then
	
end

if _G.SettingsUi.AutoKenHaki then
	
end


if _G.SettingsUi.AutoBusoHaki then
	
end



OrionLib:Init()
