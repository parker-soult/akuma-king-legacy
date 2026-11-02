function runAutoAccept()
	local t1 = {
		"EnterTheGame",
		{}
	}
	local ok, result = pcall(function()
		game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction:InvokeServer(unpack(t1))
	end)

	if ok then
		print("AutoAccept executed successfully.")

		return true
	else
		warn("Failed to execute AutoAccept: ", result)

		return false
	end
end

runAutoAccept()
wait(1)

local Players = game:GetService("Players")

repeat
	Client = Players.LocalPlayer
	wait()
until Client
local PlaceId = game.PlaceId

local TeleportService = game:GetService("TeleportService")

-- Fixed: do not overwrite Players service
Char = Client.Character
local NeedNoClip = false
Client.CharacterAdded:Connect(function(c)
	Char = c
	NeedNoClip = false
end)
vu = game:GetService("VirtualUser")
Sea1 = game.PlaceId == 4520749081
Sea2 = game.PlaceId == 6381829480
Sea3 = game.PlaceId == 15759515082
MaxLevelOfSea = MaxLevelOfSea or 0
MinLevelOfSea = MinLevelOfSea or 0
cheatKey = cheatKey or {}
myWeapon = {
	Melee = "",
	Sword = "",
	Fruit = ""
}
addSkill = "?"
_G.Weapon = _G.Weapon or "Combat"
_G.Settings = {
	Select_Weapon = "Sword",
	Weapon = "Combat",
	Auto_Sea31 = false,
	Select_Skill = true,
	SkillZ = false,
	SkillX = false,
	SkillC = false,
	SkillV = false,
	SkillB = false,
	SkillE = false
}

-- Fixed: status indicators
_G.redcircle = "🔴"
_G.greencircle = "🟢"
_G.HopDelay = _G.HopDelay or 5

_G.Settings.HopDelay = _G.Settings.HopDelay or 5
_G.Settings.PositionFarm = _G.Settings.PositionFarm or "Above"
_G.Settings.Bring_Nearest_Mobs_Together = _G.Settings.Bring_Nearest_Mobs_Together or false
_G.Settings.ObservationHak = _G.Settings.ObservationHak or false
_G.Settings.Auto_Farm_Level1 = _G.Settings.Auto_Farm_Level1 or false
_G.Settings.Auto_Sea21 = _G.Settings.Auto_Sea21 or false
_G.Settings.Monter_Hop = _G.Settings.Monter_Hop or false
_G.Settings.auto_third_event = _G.Settings.auto_third_event or false
_G.Settings.auto_jacko = _G.Settings.auto_jacko or false

-- Fixed: initialize leaked globals to avoid nil errors
SelectMaterial = SelectMaterial or "Rusted Scrap"
MMon = MMon or ""
selectedBoss = selectedBoss or ""
Spectate = Spectate or false
Flys = Flys or false
InfGeppo = InfGeppo or false
BuyDevilFruit = BuyDevilFruit or false
BringDevilFruit = BringDevilFruit or false
DevilFruitSelected = DevilFruitSelected or ""
PlayerESP = PlayerESP or false
DevilFruitESP = DevilFruitESP or false
LegacyIslandESP = LegacyIslandESP or false
HydraIslandESP = HydraIslandESP or false
GhostShipESP = GhostShipESP or false
Number = Number or math.random(1, 1000000)
Default = Default or "None"
DropdownInfo = DropdownInfo or {}
selectbosss = selectbosss or {}
Speed = Speed or 25




local s1 = "zensave1"
local v7 = Client.Name .. " Config.json"

function SaveSettings()
	if not writefile then
		warn("SaveSettings: writefile not available")
		return
	end
	local ok, json = pcall(function()
		return game:GetService("HttpService"):JSONEncode(_G.Settings)
	end)
	if not ok then
		warn("SaveSettings: JSONEncode failed", json)
		return
	end
	local folder = s1 .. "/King Legacy"
	pcall(function()
		if not isfolder(s1) then makefolder(s1) end
		if not isfolder(folder) then makefolder(folder) end
		writefile(folder .. "/" .. v7, json)
	end)
end
function LoadSettings()

-- Fixed: keep myWeapon and _G.Weapon updated
task.spawn(function()
	while task.wait(2) do
		pcall(function()
			if not Client or not Client.Character then return end
			for _, child in pairs(Client.Character:GetChildren()) do
				if child:IsA("Tool") then
					local tip = child.ToolTip
					if tip == "Combat" or tip == "Melee" then
						myWeapon.Melee = child.Name
						if _G.Settings.Select_Weapon == "Melee" then _G.Weapon = child.Name end
					elseif tip == "Sword" then
						myWeapon.Sword = child.Name
						if _G.Settings.Select_Weapon == "Sword" then _G.Weapon = child.Name end
					elseif tip == "Fruit Power" then
						myWeapon.Fruit = child.Name
						myWeapon["Fruit Power"] = child.Name
						if _G.Settings.Select_Weapon == "Fruit" then _G.Weapon = child.Name end
					end
				end
			end
			for _, child in pairs(Client.Backpack:GetChildren()) do
				if child:IsA("Tool") then
					local tip = child.ToolTip
					if tip == "Combat" or tip == "Melee" then
						myWeapon.Melee = child.Name
					elseif tip == "Sword" then
						myWeapon.Sword = child.Name
					elseif tip == "Fruit Power" then
						myWeapon.Fruit = child.Name
						myWeapon["Fruit Power"] = child.Name
					end
				end
			end
		end)
	end
end)

	local HttpService = game:GetService("HttpService")
	local path = s1 .. "/King Legacy/" .. v7
	if not isfile or not isfile(path) then
		return
	end
	local ok, data = pcall(function()
		return HttpService:JSONDecode(readfile(path))
	end)
	if ok and type(data) == "table" then
		for k, v in pairs(data) do
			_G.Settings[k] = v
		end
	else
		warn("LoadSettings failed or corrupt config")
	end
end

LoadSettings()

-- Fixed: keep myWeapon and _G.Weapon updated
task.spawn(function()
	while task.wait(2) do
		pcall(function()
			if not Client or not Client.Character then return end
			for _, child in pairs(Client.Character:GetChildren()) do
				if child:IsA("Tool") then
					local tip = child.ToolTip
					if tip == "Combat" or tip == "Melee" then
						myWeapon.Melee = child.Name
						if _G.Settings.Select_Weapon == "Melee" then _G.Weapon = child.Name end
					elseif tip == "Sword" then
						myWeapon.Sword = child.Name
						if _G.Settings.Select_Weapon == "Sword" then _G.Weapon = child.Name end
					elseif tip == "Fruit Power" then
						myWeapon.Fruit = child.Name
						myWeapon["Fruit Power"] = child.Name
						if _G.Settings.Select_Weapon == "Fruit" then _G.Weapon = child.Name end
					end
				end
			end
			for _, child in pairs(Client.Backpack:GetChildren()) do
				if child:IsA("Tool") then
					local tip = child.ToolTip
					if tip == "Combat" or tip == "Melee" then
						myWeapon.Melee = child.Name
					elseif tip == "Sword" then
						myWeapon.Sword = child.Name
					elseif tip == "Fruit Power" then
						myWeapon.Fruit = child.Name
						myWeapon["Fruit Power"] = child.Name
					end
				end
			end
		end)
	end
end)

Client.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
GUI = Client.PlayerGui
Repli = game:GetService("ReplicatedStorage")
QuestManager = game:GetService("ReplicatedStorage").Chest.Modules.QuestManager
task.spawn(function()
	while task.wait() do
		pcall(function()
			if NeedNoClip then
				if Client and (Client:FindFirstChild("Character") and Client.Character.Humanoid.Sit == true) then
					Client.Character.Humanoid.Sit = false
				end

				for _, descendant in pairs(Char:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.CanCollide = false
					end
				end

				if Char and not Char.UpperTorso:FindFirstChild("BodyClip") then
					local BodyVelocity = Instance.new("BodyVelocity")

					BodyVelocity.Parent = Char.UpperTorso
					BodyVelocity.Name = "BodyClip"

					local vector3 = Vector3.new(math.huge, math.huge, math.huge)

					BodyVelocity.Velocity = Vector3.new(0, 1, 0)
					BodyVelocity.MaxForce = vector3
				else
					if not (Char and (Char.UpperTorso:FindFirstChild("BodyClip") and Char and Char.UpperTorso:FindFirstChild("BodyClip"))) then
						return
					end

					Char.UpperTorso:FindFirstChild("BodyClip").MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					Char.UpperTorso:FindFirstChild("BodyClip").Velocity = Vector3.new(0, 0, 0)
				end
			else
				if not (Char and Char.UpperTorso:FindFirstChild("BodyClip")) then
					return
				end

				Char.UpperTorso:FindFirstChild("BodyClip"):Destroy()
			end
		end)
	end
end)

local u16 = nil
local ToolTip = nil

function getTool()
	for _, child in pairs(Client.Character:GetChildren()) do
		if child:IsA("Tool") then
			if child.ToolTip == "Fruit Power" then
				addSkill = "DF"
			end

			u16 = tostring(child.Name)
			ToolTip = child.ToolTip
		end
	end

	return u16
end

local t2 = {
	CheckOnCooldown = function(p1)
		getTool()

		local v21 = string.upper(p1 or "Z")
		local SkillCooldown = Client.PlayerGui.SkillCooldown
		local DFFrame = nil
		local v24

		if ToolTip ~= "Sword" then
			if ToolTip ~= "Combat" then
				if ToolTip ~= "Fruit Power" then
					if DFFrame and DFFrame:FindFirstChild(v21) then
						v24 = DFFrame[v21]

						return not v24:FindFirstChild("Locked").Visible and v24.Frame.Frame.AbsoluteSize.X > 0 and true or false
					else
						return true
					end
				end

				DFFrame = SkillCooldown:FindFirstChild("DFFrame")
			else
				DFFrame = SkillCooldown:FindFirstChild("FSFrame")
			end
		else
			DFFrame = SkillCooldown:FindFirstChild("SWFrame")
		end

		if DFFrame and DFFrame:FindFirstChild(v21) then
			v24 = DFFrame[v21]

			return not v24:FindFirstChild("Locked").Visible and v24.Frame.Frame.AbsoluteSize.X > 0 and true or false
		else
			return true
		end
	end
}

function getPlayerMaterial(p2)
	local ok, data = pcall(function()
		local HttpService = game:GetService("HttpService")
		local raw = Client.PlayerStats:FindFirstChild("Material") and Client.PlayerStats.Material.Value
		if not raw or raw == "" then return {} end
		return HttpService:JSONDecode(raw)
	end)
	if not ok or type(data) ~= "table" then
		return 0
	end
	for k, v in pairs(data) do
		if k == p2 then
			return v
		end
	end
	return 0
end

QuestMaterial = {
	["3350"] = {
		Material = "Ice Crystal",
		Kills = "Azlan [Lv. 3300]",
		QuestTitle = "Kill 4 Azlan",
		Level = 3300
	},
	["3375"] = {
		Material = "Magma Crystal",
		Kills = "The Volcano [Lv. 3325]",
		QuestTitle = "Kill 4 The Volcano",
		Level = 3325
	},
	["3475"] = {
		Material = "Dark Beard\'s Totem",
		Kills = "Sally [Lv. 3450]",
		QuestTitle = "Kill 1 Sally",
		Level = 3450
	},
	["3575"] = {
		Material = "Lucidus\'s Totem",
		Kills = "Vice Admiral [Lv. 3500]",
		QuestTitle = "Kill 5 Vice Admiral",
		Level = 3500
	}
}

function GetQuestData(p3)
	local Value = Client.PlayerStats.lvl.Value
	local okQM, QuestMod = pcall(function() return require(game.ReplicatedStorage.Chest.Modules.QuestManager) end)
	if not okQM or not QuestMod then
		warn("QuestManager require failed")
		return {LevelRequired=1, Mob="Bandit [Lv. 5]", QuestTitle="Kill 5 Bandit", NPC={CFrame=CFrame.new(0,0,0)}}
	end
	local v29, v30, v31 = pairs(QuestMod)
	local t3 = {}

	while true do
		local v33

		v31, v33 = v29(v30, v31)

		if v31 == nil then
			break
		end

		if not v33.DailyQuest then
			local _ = v33.Level ~= 0

			tonumber(v33.Mob:match("Lv%. (%d+)"))

			if v33.Mob:match("Lv") and (p3 or v33.Level <= Value) then
				table.insert(t3, {
					LevelRequired = v33.Level or 1,
					Mob = (function()
						return Value >= 3300 and Value < 3375 and "Azlan [Lv. 3300]" or v33.Mob
					end)(),
					QuestTitle = (function()
						return Value >= 3300 and Value < 3375 and "Kill 4 Azlan" or v31
					end)(),
					NPC = (function()
						local v35, v36, v37 = pairs(game:GetService("Workspace"):FindFirstChild("AllNPC"):GetChildren())
						local t4 = {}

						while true do
							local v39

							v37, v39 = v35(v36, v37)

							if v37 == nil then
								break
							end

							if v39:GetAttribute("LevelMin") and v33.Level >= v39:GetAttribute("LevelMin") then
								t4[#t4 + 1] = {
									Level = v39:GetAttribute("LevelMin"),
									CFrame = v39.CFrame
								}
							end
						end

						table.sort(t4, function(p4, p5)
							return p4.Level > p5.Level
						end)

						return t4[1]
					end)()
				})
			end
		end
	end

	table.sort(t3, function(p6, p7)
		return p6.LevelRequired > p7.LevelRequired
	end)

	local v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53, t5

	if MaxLevelOfSea > Value or not Sea2 then
		if MaxLevelOfSea > Value or not Sea1 then
			v69, v70, v71 = pairs(QuestMaterial)

			while true do
				v71, v40 = v69(v70, v71)

				if v71 == nil then
					break
				end

				if t3[1] and t3[1].LevelRequired == tonumber(v71) then
					v41, v42, v43 = pairs(SafeMonsters("Mon"))
					v44 = nil

					while true do
						v43, v45 = v41(v42, v43)

						if v43 == nil then
							break
						end

						if v45.Name == t3[1].Mob and (v45:FindFirstChild("Humanoid") and (v45:FindFirstChild("HumanoidRootPart") and v45.Humanoid.Health > 0)) then
							v44 = true
						end
					end

					v46, v47, v48 = pairs(SafeMonsters("Boss"))

					while true do
						v48, v49 = v46(v47, v48)

						if v48 == nil then
							break
						end

						if v49.Name == t3[1].Mob and (v49:FindFirstChild("Humanoid") and (v49:FindFirstChild("HumanoidRootPart") and v49.Humanoid.Health > 0)) then
							v44 = true
						end
					end

					v50, v51, v52 = pairs(game:GetService("ReplicatedStorage").MOB:GetChildren())

					while true do
						v52, v53 = v50(v51, v52)

						if v52 == nil then
							break
						end

						if v53.Name == t3[1].Mob and (v53:FindFirstChild("Humanoid") and (v53:FindFirstChild("HumanoidRootPart") and v53.Humanoid.Health > 0)) then
							v44 = true
						end
					end

					if getPlayerMaterial(v40.Material) > 0 or v44 then
						if getPlayerMaterial(v40.Material) > 0 and not v44 then
							t5 = {
								"QuestSpawnBoss",
								{
									SuccessQuest = "Quest Accepted.",
									BossName = t3[1].Mob,
									LevelNeed = t3[1].LevelRequired,
									QuestName = t3[1].QuestTitle,
									MaterialNeed = v40.Material
								}
							}
							game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack(t5))
						end
					else
						t3[1].Mob = v40.Kills
						t3[1].LevelRequired = v40.Level
						t3[1].QuestTitle = v40.QuestTitle
					end
				end
			end

			return t3[1] or {LevelRequired=1, Mob="Bandit [Lv. 5]", QuestTitle="Kill 5 Bandit", NPC={CFrame=CFrame.new()}}
		end

		-- Sea 1 max level: farm Seasoned Fishman for Sea 2 progression
		if not t3[1] then
			t3[1] = {LevelRequired=2200, Mob="Seasoned Fishman [Lv. 2200]", QuestTitle="Kill 1 Seasoned Fishman", NPC={CFrame=CFrame.new()}}
		end
		t3[1].Mob = "Seasoned Fishman [Lv. 2200]"
		t3[1].LevelRequired = 2200
		t3[1].QuestTitle = "Kill 1 Seasoned Fishman"
	else
		-- Sea 2 max level: farm Ryu
		if not t3[1] then
			t3[1] = {LevelRequired=3950, Mob="Ryu [Lv. 3975]", QuestTitle="Kill 1 Ryu", NPC={CFrame=CFrame.new()}}
		end
		t3[1].Mob = "Ryu [Lv. 3975]"
		t3[1].LevelRequired = 3950
		t3[1].QuestTitle = "Kill 1 Ryu"
	end

	local v55, v56, v57 = pairs(QuestMaterial)

	while true do
		v57, v40 = v55(v56, v57)

		if v57 == nil then
			break
		end

		if t3[1] and t3[1].LevelRequired == tonumber(v57) then
			v41, v42, v43 = pairs(SafeMonsters("Mon"))
			v44 = nil

			while true do
				v43, v45 = v41(v42, v43)

				if v43 == nil then
					break
				end

				if v45.Name == t3[1].Mob and (v45:FindFirstChild("Humanoid") and (v45:FindFirstChild("HumanoidRootPart") and v45.Humanoid.Health > 0)) then
					v44 = true
				end
			end

			v46, v47, v48 = pairs(SafeMonsters("Boss"))

			while true do
				v48, v49 = v46(v47, v48)

				if v48 == nil then
					break
				end

				if v49.Name == t3[1].Mob and (v49:FindFirstChild("Humanoid") and (v49:FindFirstChild("HumanoidRootPart") and v49.Humanoid.Health > 0)) then
					v44 = true
				end
			end

			v50, v51, v52 = pairs(game:GetService("ReplicatedStorage").MOB:GetChildren())

			while true do
				v52, v53 = v50(v51, v52)

				if v52 == nil then
					break
				end

				if v53.Name == t3[1].Mob and (v53:FindFirstChild("Humanoid") and (v53:FindFirstChild("HumanoidRootPart") and v53.Humanoid.Health > 0)) then
					v44 = true
				end
			end

			if getPlayerMaterial(v40.Material) > 0 or v44 then
				if getPlayerMaterial(v40.Material) > 0 and not v44 then
					t5 = {
						"QuestSpawnBoss",
						{
							SuccessQuest = "Quest Accepted.",
							BossName = t3[1].Mob,
							LevelNeed = t3[1].LevelRequired,
							QuestName = t3[1].QuestTitle,
							MaterialNeed = v40.Material
						}
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack(t5))
				end
			else
				t3[1].Mob = v40.Kills
				t3[1].LevelRequired = v40.Level
				t3[1].QuestTitle = v40.QuestTitle
			end
		end
	end

	return t3[1] or {LevelRequired=1, Mob="Bandit [Lv. 5]", QuestTitle="Kill 5 Bandit", NPC={CFrame=CFrame.new()}}
end

local v58, v59

local npcIter, v58, v59 = pairs(game:GetService("Workspace"):FindFirstChild("AllNPC"):GetChildren())

while true do
	v59, v445 = npcIter(v58, v59)

	if v59 == nil then
		break
	end

	if v445:GetAttribute("LevelMax") then
		lvmax = v445:GetAttribute("LevelMax")

		if not MaxLevelOfSea or lvmax > MaxLevelOfSea then
			MaxLevelOfSea = lvmax
		end
	end

	if v445:GetAttribute("LevelMin") then
		lvmin = v445:GetAttribute("LevelMin")

		if not MinLevelOfSea or lvmin < MinLevelOfSea then
			MinLevelOfSea = lvmin
		end
	end
end

function tp(p8)
	pcall(function()
		local Client_ = Client

		if Client_ then
			Client_ = Client.Character
		end

		if not (Client_:FindFirstChild("Humanoid") and Client_.Humanoid.Sit == true) then
			NeedNoClip = true
			v76 = {
				Target = p8.Target or print("mae mung tai."),
				Mod = p8.Mod or CFrame.new(0, 0, 0)
			}
			local hrp = Client_:FindFirstChild("HumanoidRootPart"); if hrp then hrp.CFrame = v76.Target * v76.Mod end

			return
		end

		Client_.Humanoid.Sit = false
		NeedNoClip = true

		local t6 = {
			Target = p8.Target or print("mae mung tai."),
			Mod = p8.Mod or CFrame.new(0, 0, 0)
		}

		local hrp = Client_:FindFirstChild("HumanoidRootPart"); if hrp then hrp.CFrame = t6.Target * t6.Mod end
	end)
end
function Tp(p9)
	local char = Client and Client.Character
	if not char then return end
	local hum = char:FindFirstChild("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if hum and hum.Sit then
		hum.Sit = false
	end

	for _, descendant in pairs(char:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.CanCollide = false
		end
	end

	if hrp:FindFirstChild("BodyClip") then
		hrp.CFrame = p9
		return
	end

	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.Parent = hrp
	BodyVelocity.Name = "BodyClip"
	BodyVelocity.Velocity = Vector3.new(0, 0, 0)
	BodyVelocity.MaxForce = Vector3.new(5, math.huge, 5)
	hrp.CFrame = p9
end
function tp1(p10)
	local LocalPlayer = game.Players.LocalPlayer

	if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = p10
	else
		warn("Player\'s character or HumanoidRootPart not found!")
	end
end

-- Fixed: safe helpers to avoid nil crashes
local function SafeMonsters(folder)
	local mon = workspace:FindFirstChild("Monster")
	if not mon then return {} end
	local f = mon:FindFirstChild(folder)
	return f and f:GetChildren() or {}
end
function SafeNPC(name)
	local npc = workspace:FindFirstChild("AllNPC") and workspace.AllNPC:FindFirstChild(name)
	return npc
end
local function SafeNPCCFrame(name, fallback)
	local npc = SafeNPC(name)
	if npc then return npc.CFrame end
	return fallback or CFrame.new()
end
local function SafeToQuest(name, ...)
	local npc = SafeNPC(name)
	if not npc then
		warn("NPC not found:", name)
		return
	end
	toQuest(npc.CFrame, ...)
end

function EquipTools(p11)
	if not Client.Backpack:FindFirstChild(p11) then
		return
	end

	local v67 = Client.Backpack:FindFirstChild(p11)

	Client.Character.Humanoid:EquipTool(v67)
end
function UnEquipTools(p12)
	if not Client.Character:FindFirstChild(p12) then
		return
	end

	wait(0.5)
	Client.Character:FindFirstChild(p12).Parent = Client.LocalPlayer.Backpack
	wait(0.1)
end

local t7 = { "Melee", "Sword", "Fruit Power" }
local n1 = 1

function Attack()
	_G.Weapon = _G.Weapon or myWeapon.Melee or myWeapon.Sword or myWeapon.Fruit or "Combat"
	if not _G.Weapon or _G.Weapon == "" then return end
	if _G.Settings.Select_Weapon ~= "Melee" then
		if _G.Settings.Select_Weapon ~= "Sword" then
			if _G.Settings.Select_Weapon ~= "all In One" then
				game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer("FS_" .. _G.Weapon .. "_M1")
			else
				local v72 = t7[n1]

				if v72 == "Sword" then
					addSkill = "SW"
					delay(0.1, function()
						game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer("SW_" .. myWeapon.Sword .. "_M1")
					end)
				elseif v72 == "Melee" then
					addSkill = "FS"
					game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer("FS_" .. myWeapon.Melee .. "_M1")
				elseif v72 == "Fruit Power" then
					addSkill = "FP"
					game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer("FP_" .. myWeapon["Fruit Power"] .. "_M1")
				end

				EquipTools(myWeapon[v72])
				n1 = n1 + 1

				if n1 > #t7 then
					n1 = 1
				end
			end
		else
			addSkill = "SW"
			game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer("SW_" .. _G.Weapon .. "_M1")
		end
	else
		addSkill = "FS"
		game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer("FS_" .. _G.Weapon .. "_M1")
	end

	if _G.Settings.Select_Weapon == "all In One" then
		return
	end

	EquipTools(_G.Weapon)
end

local t8 = {
	Z = 0,
	X = 0,
	C = 0,
	V = 0,
	B = 0,
	E = 0
}

local function v73()
	if not _G.Settings.Select_Skill then
		return
	end

	local t9 = {
		{
			key = "Z",
			enabled = _G.Settings.SkillZ,
			holdTime = t8.Z
		},
		{
			key = "X",
			enabled = _G.Settings.SkillX,
			holdTime = t8.X
		},
		{
			key = "C",
			enabled = _G.Settings.SkillC,
			holdTime = t8.C
		},
		{
			key = "V",
			enabled = _G.Settings.SkillV,
			holdTime = t8.V
		},
		{
			key = "B",
			enabled = _G.Settings.SkillB,
			holdTime = t8.B
		},
		{
			key = "E",
			enabled = _G.Settings.SkillE,
			holdTime = t8.E
		}
	}

	for _, v in ipairs(t9) do
		if v.enabled and not t2.CheckOnCooldown(v.key) then
			local VirtualInputManager = game:GetService("VirtualInputManager")

			VirtualInputManager:SendKeyEvent(true, v.key, false, game)
			wait(v.holdTime)
			VirtualInputManager:SendKeyEvent(false, v.key, false, game)
		end
	end
end
local function v77(p13)
	if p13 then
		game:GetService("GuiService").SelectedObject = p13
		task.wait(0.1)
		game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
		task.wait(0.1)
		game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		task.wait(0.1)
		game:GetService("GuiService").SelectedObject = nil
	else
		warn("Invalid UI path provided to ClickUI")
	end
end

function click(p14)
	for _ = 1, p14 or 3 do
		game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
		game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
	end
end
function Click(p15)
	for _ = 1, p15 or 3 do
		game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
		game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
	end
end
function toQuest(p16, p17, p18)
	local v80 = p18 or true
	local v81 = p17 or "QuestLvl"
	local v82 = p16 or (Sea1 and "Elite Pirate" or (Sea3 and "The Squid" or p16))
	local v83 = p17 == 1 and Sea2 and "Elite Pirate" or (p17 == 3 and Sea2 and "The Squid" or v82)
	local v84 = workspace.AllNPC:FindFirstChild(v83)

	if v84 then
		v83 = v84.CFrame
	elseif typeof(v83) ~= "CFrame" then
		warn("toQuest: NPC not found ->", tostring(v83))
		return
	end

	local HumanoidRootPart = v80 and v83 and Client.Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		HumanoidRootPart.CFrame = v83 * CFrame.new(0, 0, -3)
	end

	local HumanoidRootPart2 = game.Players.LocalPlayer.Character.HumanoidRootPart
	local v87, Dialogue, Accept, v90, v91, v92, v93, QuestAccept

	if not HumanoidRootPart2 then
		vu:Button1Down(Vector2.new(1, 1))
		vu:Button1Up(Vector2.new(1, 1))
		wait(0.5)
		v122, v123, v124 = pairs(Client.PlayerGui:GetChildren())

		while true do
			v124, v87 = v122(v123, v124)

			if v124 == nil then
				break
			end

			if string.find(v87.Name, v81) then
				Dialogue = v87:FindFirstChild("Dialogue")

				if Dialogue and Dialogue:FindFirstChild("Accept") then
					Accept = Dialogue.Accept

					if game.PlaceId == 4520749081 or (game.PlaceId == 6381829480 or v80) then
						Accept.Size = UDim2.new(1001, 0, 1001, 0)
						Accept.Text.TextTransparency = 1
						Accept.Position = UDim2.new(0.5, 0, 0.5, 0)
						Accept.AnchorPoint = Vector2.new(0.5, 0.5)
					else
						v90, v91, v92 = pairs(Dialogue:GetChildren())

						while true do
							v92, v93 = v90(v91, v92)

							if v92 == nil then
								break
							end

							if string.find(v93.Name, "Quest") or v93.Name == "QuestAccept" then
								v93.Size = UDim2.new(1001, 0, 1001, 0)
								v93.Text.TextTransparency = 1
								v93.Position = UDim2.new(0.5, 0, 0.5, 0)
								v93.AnchorPoint = Vector2.new(0.5, 0.5)
							end
						end

						if string.find(v87.Text.Text, "Talk") then
							QuestAccept = Dialogue:FindFirstChild("QuestAccept")

							if QuestAccept then
								QuestAccept.Size = UDim2.new(1001, 0, 1001, 0)
								QuestAccept.Text.TextTransparency = 1
								QuestAccept.Position = UDim2.new(0.5, 0, 0.5, 0)
								QuestAccept.AnchorPoint = Vector2.new(0.5, 0.5)
							end
						end
					end

					if Accept then
						Accept:Click()
					end
				end
			end
		end

		return
	end

	HumanoidRootPart2.Anchored = true
	wait(0.1)
	HumanoidRootPart2.Anchored = false
	vu:Button1Down(Vector2.new(1, 1))
	vu:Button1Up(Vector2.new(1, 1))
	wait(0.5)

	local v95, v96, v97 = pairs(Client.PlayerGui:GetChildren())

	while true do
		v97, v87 = v95(v96, v97)

		if v97 == nil then
			break
		end

		if string.find(v87.Name, v81) then
			Dialogue = v87:FindFirstChild("Dialogue")

			if Dialogue and Dialogue:FindFirstChild("Accept") then
				Accept = Dialogue.Accept

				if game.PlaceId == 4520749081 or (game.PlaceId == 6381829480 or v80) then
					Accept.Size = UDim2.new(1001, 0, 1001, 0)
					Accept.Text.TextTransparency = 1
					Accept.Position = UDim2.new(0.5, 0, 0.5, 0)
					Accept.AnchorPoint = Vector2.new(0.5, 0.5)
				else
					v90, v91, v92 = pairs(Dialogue:GetChildren())

					while true do
						v92, v93 = v90(v91, v92)

						if v92 == nil then
							break
						end

						if string.find(v93.Name, "Quest") or v93.Name == "QuestAccept" then
							v93.Size = UDim2.new(1001, 0, 1001, 0)
							v93.Text.TextTransparency = 1
							v93.Position = UDim2.new(0.5, 0, 0.5, 0)
							v93.AnchorPoint = Vector2.new(0.5, 0.5)
						end
					end

					if string.find(v87.Text.Text, "Talk") then
						QuestAccept = Dialogue:FindFirstChild("QuestAccept")

						if QuestAccept then
							QuestAccept.Size = UDim2.new(1001, 0, 1001, 0)
							QuestAccept.Text.TextTransparency = 1
							QuestAccept.Position = UDim2.new(0.5, 0, 0.5, 0)
							QuestAccept.AnchorPoint = Vector2.new(0.5, 0.5)
						end
					end
				end

				if Accept then
					Accept:Click()
				end
			end
		end
	end
end
function Serverhop()
	HopServer(true)
end

function HopServer(p19)
	local v98 = p19 or false
	local HttpService = game:GetService("HttpService")
	local PlaceId = game.PlaceId
	local v101 = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"

	local function v102(p20)
		local ok, res = pcall(function()
			return HttpService:JSONDecode(game:HttpGet(v101 .. (p20 and "&cursor=" .. p20 or "")))
		end)
		if ok then return res end
		return {data = {}, nextPageCursor = nil}
	end

	local nextPageCursor = nil
	local chosenServer = nil

	for _ = 1, 5 do  -- limit pages
		local v104 = v102(nextPageCursor)
		if v104 and v104.data and #v104.data > 0 then
			for _, srv in ipairs(v104.data) do
				if srv.id and srv.id ~= game.JobId and (not srv.playing or srv.playing < (srv.maxPlayers or 100)) then
					chosenServer = srv
					break
				end
			end
		end
		if chosenServer then break end
		nextPageCursor = v104 and v104.nextPageCursor
		if not nextPageCursor then break end
	end

	if v98 then
		if request then
			local t10 = {}
			local okReq, resp = pcall(function()
				return request({
					Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
				})
			end)
			if okReq and resp and resp.Body then
				local data = HttpService:JSONDecode(resp.Body)
				if data and data.data then
					for _, v112 in pairs(data.data) do
						if type(v112) == "table" and tonumber(v112.playing) and tonumber(v112.maxPlayers) and v112.playing < v112.maxPlayers and v112.id ~= game.JobId then
							table.insert(t10, v112.id)
						end
					end
				end
			end
			if #t10 <= 0 then
				return "Couldn't find a server."
			end
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, t10[math.random(1, #t10)], Client)
		else
			warn("request() not available")
		end
	else
		if chosenServer and chosenServer.id then
			game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, chosenServer.id, Client)
		else
			warn("HopServer: no valid server found")
		end
	end
end

function dist(p21, p22, p23)
	local Client_ = Client
	local v114, v115

	if not Client_ then
		v148 = p22 or Client_.HumanoidRootPart.Position
		v149 = Vector3.new
		v150 = p21.X

		if p23 then
			v114 = 0
		else
			v114 = p21.Y
		end

		v151 = v149(v150, v114, p21.Z)
		v152 = Vector3.new
		v153 = v148.X

		if p23 then
			v115 = 0
		else
			v115 = v148.Y
		end

		return (v151 - v152(v153, v115, v148.Z)).magnitude
	end

	Client_ = Client.Character

	local Position = p22 or Client_.HumanoidRootPart.Position
	local vector3New = Vector3.new
	local X = p21.X

	if p23 then
		v114 = 0
	else
		v114 = p21.Y
	end

	local vector3 = vector3New(X, v114, p21.Z)
	local vector3New2 = Vector3.new
	local X2 = Position.X

	if p23 then
		v115 = 0
	else
		v115 = Position.Y
	end

	return (vector3 - vector3New2(X2, v115, Position.Z)).magnitude
end

local n2 = 0

function seaChest()
	wait(3)

	local function v125()
		if not (_G.Settings.Monter_Hop or _G.Settings.Auto_Sea31) then
			return
		end

		task.wait(3.5)
		HopServer(false)
	end

	if (workspace:FindFirstChild("SeaMonster") and (workspace.SeaMonster:FindFirstChild("SeaKing") or workspace.SeaMonster:FindFirstChild("HydraSeaKing")) or not ((function()
		for _, v in ipairs({
			"Legacy Island1",
			"Legacy Island2",
			"Legacy Island3",
			"Legacy Island4"
		}) do
			local v126 = game:GetService("Workspace").Island:FindFirstChild(v)

			if v126 then
				return v126
			end
		end

		return nil
	end)() or (function()
		for _, child in pairs(workspace:FindFirstChild("Island"):GetChildren()) do
			if child.Name:match("Sea King") then
				return true
			end
		end

		return false
	end)())) then
		return
	end

	for _, v in ipairs({
		"Legacy Island1",
		"Legacy Island2",
		"Legacy Island3",
		"Legacy Island4"
	}) do
		local v131 = game:GetService("Workspace").Island:FindFirstChild(v)

		if v131 then
			tp({
				Target = v131.ChestSpawner.CFrame
			})
			-- Client.PlayerStats.beli.Value = Client.PlayerStats.beli.Value + 50 -- client side only, does nothing real
			wait(3)

			if dist(v131.ChestSpawner.Position, Client.Character.HumanoidRootPart.Position) < 10 and Client.PlayerStats.beli.Value > n2 + 1 then
				print(n2, " : ", Client.PlayerStats.beli.Value)
				v125()
			end
		end
	end

	for _, child in pairs(workspace:FindFirstChild("Island"):GetChildren()) do
		if child.Name:match("Sea King") then
			tp({
				Target = child.HydraStand.CFrame
			})
		end
	end
end

local function v135(...)
	local t11 = { ... }
	local v136 = t11[1]
	local p = nil
	local v138, Magnitude

	if type(v136) ~= "vector" then
		if type(v136) ~= "userdata" then
			if type(v136) ~= "number" then
				v179 = math.huge
				v180, v181, v182 = pairs(workspace.Island:GetChildren())
				v183 = nil

				while true do
					v182, v138 = v180(v181, v182)

					if v182 == nil then
						break
					end

					if v138:IsA("Model") then
						Magnitude = (p - v138:GetModelCFrame().p).Magnitude

						if Magnitude < v179 then
							v183 = v138.Name
							v179 = Magnitude
						end
					end
				end

				if v183 then
					return v183
				end

				return
			end

			p = CFrame.new(unpack(t11)).p
		else
			p = v136.Position
		end
	else
		p = v136
	end

	local huge = math.huge
	local v141, v142, v143 = pairs(workspace.Island:GetChildren())
	local Name_ = nil

	while true do
		v143, v138 = v141(v142, v143)

		if v143 == nil then
			break
		end

		if v138:IsA("Model") then
			Magnitude = (p - v138:GetModelCFrame().p).Magnitude

			if Magnitude < huge then
				Name_ = v138.Name
				huge = Magnitude
			end
		end
	end

	if Name_ then
		return Name_
	end
end

local t12 = {}

local function v146(p24)
	for _, child in pairs(workspace.AllNPC:GetChildren()) do
		local v154 = v135(child.CFrame)

		if v154 == v135(p24) then
			if not t12[v154] then
				t12[v154] = {}
			end

			table.insert(t12[v154], child.CFrame)
		end
	end
end

local t13 = {}

function adjustPosition(p25, p26)
	local Disfarm = _G.Disfarm or 7.5

	return p25 * (({
		Above = CFrame.new(0, Disfarm, 0),
		Beside = CFrame.new(Disfarm, 0, 0),
		Lower = CFrame.new(0, -Disfarm, 0)
	})[p26] or CFrame.new())
end
function getTargetPosition(p27, p28)
	local HumanoidRootPart = p27:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		local Position = HumanoidRootPart.Position
		local v155 = Position + (({
			Above = Vector3.new(0, _G.Disfarm or 7.5, 0),
			Beside = Vector3.new(_G.Disfarm or 7.5, 0, 0),
			Lower = Vector3.new(0, -(_G.Disfarm or 7.5), 0)
		})[p28] or Vector3.new())

		if p28 == "Beside" or p28 == "Lower" then
			return CFrame.new(v155, Position)
		else
			return CFrame.new(v155)
		end
	else
		return nil
	end
end
function t13.Bring(p29, p30)
	if _G.Settings.Bring_Nearest_Mobs_Together then
		for _, child in pairs(SafeMonsters("Mon")) do
			local Humanoid = child:FindFirstChild("Humanoid")
			local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

			if child.Name == p29.Name and (Humanoid and (Humanoid.Health > 0 and HumanoidRootPart)) then
				HumanoidRootPart.CFrame = p30
				Humanoid.PlatformStand = true
				Humanoid:ChangeState(11)
				Humanoid:ChangeState(14)
				pcall(function() setscriptable(game.Players.LocalPlayer, "SimulationRadius", true) end)
			end
		end
	end
end
function t13.attack(p31, p32, _)
	local v159 = GetQuestData()
	local children, children2

	if Sea2 then
		children = game:GetService("Workspace"):FindFirstChild("SeaMonster") and game:GetService("Workspace").SeaMonster:GetChildren() or {}
		local gm = game.Workspace:FindFirstChild("GhostMonster")
		children2 = gm and gm:GetChildren() or {}
	elseif Sea3 then
		children = game:GetService("Workspace"):FindFirstChild("SeaMonster") and game:GetService("Workspace").SeaMonster:GetChildren() or {}
		children2 = {}
	else
		local mobFolder = game:GetService("ReplicatedStorage"):FindFirstChild("MOB")
		children = mobFolder and mobFolder:GetChildren() or {}
		children2 = children
	end

	local function v162(p33)
		if p33 and (p33:FindFirstChild("Humanoid") and p33:FindFirstChild("HumanoidRootPart")) then
			local v163 = math.floor(p33.Humanoid.Health / p33.Humanoid.MaxHealth * 100)
			local v164 = p33.Humanoid.Health > 0 and "Alive" or "Dead"

			_G.LabelAutoFarm = string.format("Farming: %s", p33.Name)
			_G.Questname = string.format("Quest: %s", v159.QuestTitle)
			_G.LabelHealth = string.format("Status: %s | Health: %d%%", v164, v163)
		else
			_G.LabelAutoFarm = "No target detected."
		end
	end
	local function v165(p34)
		if not (_G.Settings[p32] and p34.Parent) then
			return
		end

		while true do
			task.wait()

			if p34:FindFirstChild("Humanoid") and p34:FindFirstChild("HumanoidRootPart") then
				local Health = p34.Humanoid.Health
				local Y = p34.HumanoidRootPart.Position.Y

				v162(p34)

				if 0 < Health and (-100 < Y and Y < 1500) then
					tp({
						Target = getTargetPosition(p34, _G.Settings.PositionFarm),
						Mod = _G.Settings.PositionFarm == "Above" and CFrame.Angles(math.rad(-90), 0, 0) or CFrame.new()
					})
					task.spawn(function()
						Attack()
						getgenv().PosMonSkill = p34.HumanoidRootPart
						v73()
					end)

					if not p34:FindFirstChild("Next") then
						t13.Bring(p34, p34.HumanoidRootPart.CFrame)

						local Folder = Instance.new("Folder", p34)

						Folder.Name = "Next"
						task.delay(1, function()
							Folder:Destroy()
						end)
					end
				end
			end

			if p34.Humanoid.Health <= 0 or not (p34.Parent and _G.Settings[p32]) then
				return
			end
		end
	end

	for _, v in ipairs({
		SafeMonsters("Boss"),
		SafeMonsters("Mon"),
		game:GetService("Workspace").SeaMonster:GetChildren(),
		children2,
		children,
		game:GetService("ReplicatedStorage").MOB:GetChildren()
	}) do
		for _, v2 in ipairs(v) do
			if table.find(p31, v2.Name) then
				v165(v2)
			elseif v2:FindFirstChild("Humanoid") and (v2:FindFirstChild("HumanoidRootPart") and v2.Humanoid.Health > 0) then
				tp({
					Target = v2.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0)
				})
			end
		end
	end
end
function t13.find(p35)
	local children, children2

	if Sea2 then
		children = game:GetService("Workspace"):FindFirstChild("SeaMonster") and game:GetService("Workspace").SeaMonster:GetChildren() or {}
		local gm = game.Workspace:FindFirstChild("GhostMonster")
		children2 = gm and gm:GetChildren() or {}
	elseif Sea3 then
		children = game:GetService("Workspace"):FindFirstChild("SeaMonster") and game:GetService("Workspace").SeaMonster:GetChildren() or {}
		children2 = game:GetService("ReplicatedStorage"):FindFirstChild("MOB") and game:GetService("ReplicatedStorage").MOB:GetChildren() or {}
	else
		-- Sea 1
		local mobFolder = game:GetService("ReplicatedStorage"):FindFirstChild("MOB")
		children = mobFolder and mobFolder:GetChildren() or {}
		children2 = children
	end

	local function v175(p36)
		local Humanoid = p36:FindFirstChild("Humanoid")

		if not Humanoid then
			return Humanoid
		end

		Humanoid = p36.Humanoid.Health > 0

		return Humanoid
	end
	local function v177(p37)
		for _, v in pairs(p37) do
			if table.find(p35, v.Name) and v175(v) then
				return true
			end
		end

		return false
	end

	return v177(workspace:FindFirstChild("Monster") and workspace.Monster:FindFirstChild("Mon") and SafeMonsters("Mon") or {}) or (v177(workspace:FindFirstChild("Monster") and workspace.Monster:FindFirstChild("Boss") and SafeMonsters("Boss") or {}) or (v177(children2) or v177(children)) or v177(game:GetService("ReplicatedStorage").MOB:GetChildren()) or (v177(workspace:FindFirstChild("Monster") and workspace.Monster:FindFirstChild("Mon") and SafeMonsters("Mon") or {}) or v177(workspace:FindFirstChild("Monster") and workspace.Monster:FindFirstChild("Boss") and SafeMonsters("Boss") or {})))
end
function t13.attackMon(p38, p39, _)
	local QuestBoard = Client.PlayerGui:FindFirstChild("MainGui") and Client.PlayerGui.MainGui:FindFirstChild("QuestFrame") and Client.PlayerGui.MainGui.QuestFrame:FindFirstChild("QuestBoard")
	local children, children2

	if Sea2 or Sea3 then
		children = game:GetService("Workspace"):FindFirstChild("SeaMonster") and game:GetService("Workspace").SeaMonster:GetChildren() or {}
		local gm = game.Workspace:FindFirstChild("GhostMonster")
		children2 = gm and gm:GetChildren() or {}
	else
		local mobFolder = game:GetService("ReplicatedStorage"):FindFirstChild("MOB")
		children = mobFolder and mobFolder:GetChildren() or {}
		children2 = children
	end

	local function v184()
		return _G.Settings[p39] ~= nil
	end
	local function v185(p40)
		local HumanoidRootPart = p40:FindFirstChild("Humanoid") and p40:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return HumanoidRootPart
		end

		HumanoidRootPart = p40.Humanoid.Health > 0 and (p40.HumanoidRootPart.Position.Y > -100 and p40.HumanoidRootPart.Position.Y < 1500)

		return HumanoidRootPart
	end
	local function v186(p41)
		while true do
			task.wait()

			if v185(p41) then
				tp({
					Target = getTargetPosition(p41, _G.Settings.PositionFarm),
					Mod = _G.Settings.PositionFarm == "Above" and CFrame.Angles(math.rad(-90), 0, 0) or CFrame.new()
				})
				task.spawn(function()
					Attack()
					getgenv().PosMonSkill = p41.HumanoidRootPart
					v73()
				end)
			end

			if not (v184() and (p39 ~= "Auto_Farm_Level1" or QuestBoard.Visible and QuestBoard.TextFrame.QuestCount.Text:find(p41.Name:gsub("%[Lv%.%s*%d+%]", ""))) and (p41.Parent and (p41.Humanoid.Health > 0 and (p41:FindFirstChild("HumanoidRootPart") and (p41.HumanoidRootPart.Position.Y >= -100 and p41.HumanoidRootPart.Position.Y <= 1500))))) then
				return
			end
		end
	end

	(function(p42)
		for _, v in ipairs(p42) do
			for _, v2 in ipairs(v) do
				if table.find(p38, v2.Name) and v184() then
					if v185(v2) then
						v186(v2)
					elseif v == game:GetService("ReplicatedStorage").MOB:GetChildren() then
						Tp(v2.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0))
					end
				end
			end
		end
	end)({
		SafeMonsters("Boss"),
		SafeMonsters("Mon"),
		children2,
		children,
		game:GetService("ReplicatedStorage").MOB:GetChildren()
	})
end
-- DUPLICATE t13.find removed (first definition at t13.find(p35) is kept)

function loadIslandForAllNPCs(p46, p47)
	local v198 = t12[p46]

	if _G.Settings.Auto_Farm_Level1 and not t13.find({ p47 }) then
		if v198 and #v198 > 0 then
			local v199, v200, v201 = pairs(v198)

			while true do
				local v202

				v201, v202 = v199(v200, v201)

				if v201 == nil or (not _G.Settings.Auto_Farm_Level1 or t13.find({ p47 })) then
					break
				end

				local hrp = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
				if hrp then hrp.CFrame = v202 * CFrame.new(0, 50, -math.random(5, 10)) end
				wait(0.5)
			end

			return "Loaded all NPC positions on island: " .. p46
		else
			return "No NPCs found on island: " .. p46
		end
	else
		return "Entity Spawn"
	end
end

local function v203(p48, p49)
	if p48.LevelRequired ~= 3750 then
		if p48.LevelRequired ~= 3775 then
			if p48.LevelRequired ~= 4750 then
				v146(p49)
				loadIslandForAllNPCs(v135(p49), p48.Mob)
			else
				local tp_ = tp
				local t14 = {
					Target = workspace.Island["Forgotten Coliseum"].Vacuus.Base:GetChildren()[179].CFrame * CFrame.new(0, 20, 0)
				}

				tp_(t14)
			end
		else
			local tp_ = tp
			local t15 = {
				Target = workspace.Island["H - Fiore"].Italian.Base.Mountain.Model:GetChildren()[9].CFrame * CFrame.new(0, 20, 0)
			}

			tp_(t15)
		end
	else
		tp({
			Target = workspace.Island["H - Fiore"].Lab.Lab.Base.CFrame * CFrame.new(0, 20, 0)
		})
	end
end

local t16 = {}
local CFrame_ = nil

GetQuestData()


-- Fixed: stubs for settings-style toggles (no continuous farm loop needed)
function t16.Auto_Spawn_Kaido()
	-- This is a flag used by Auto_Kill_Kaido1; no independent loop required
	while _G.Settings.Auto_Spawn_Kaido and task.wait(2) do
		-- flag only
	end
end
function t16.Bring_Nearest_Mobs_Together()
	-- This is a flag used by t13.Bring; no independent loop required
	while _G.Settings.Bring_Nearest_Mobs_Together and task.wait(2) do
		-- flag only
	end
end
function t16.Auto_Farm_Level1()
	local s2 = "Auto_Farm_Level1"

	while _G.Settings[s2] and task.wait(0.3) do
		local ok, result = pcall(function()
			local v213 = GetQuestData()
			if not v213 or not v213.Mob then
				return
			end

			-- Safe NPC CFrame
			local CFrame_2 = CFrame.new()
			if v213.NPC and typeof(v213.NPC) == "table" and v213.NPC.CFrame then
				CFrame_2 = v213.NPC.CFrame
			elseif v213.NPC and typeof(v213.NPC) == "CFrame" then
				CFrame_2 = v213.NPC
			elseif v213.NPC and v213.NPC.CFrame then
				CFrame_2 = v213.NPC.CFrame
			end

			local currentQuest = ""
			pcall(function() currentQuest = tostring(Client.CurrentQuest.Value) end)

			if currentQuest ~= v213.QuestTitle or currentQuest == "" then
				tp({ Target = CFrame_2 })
				pcall(function()
					Repli:WaitForChild("Chest").Remotes.Functions.Quest:InvokeServer("take", v213.QuestTitle)
				end)
				task.wait(0.5)
			else
				-- Special case Dough Master
				if v213.Mob == "Dough Master [Lv. 3275]" and v213.LevelRequired == 3275 then
					tp({ Target = CFrame.new(30279.0625, 69.36441802978516, 93166.2734375) })
				else
					local v215 = Repli:FindFirstChild("MOB") and Repli.MOB:FindFirstChild(v213.Mob)
					if v215 then
						local cf = v215.GetModelCFrame and v215:GetModelCFrame() or (v215:FindFirstChild("HumanoidRootPart") and v215.HumanoidRootPart.CFrame)
						if cf then
							tp({ Target = cf * CFrame.new(0, 20, 0) })
						end
					elseif v213.LevelRequired < 3265 or CFrame_ ~= nil then
						tp({ Target = CFrame_ or CFrame_2 })
					else
						if v203 then
							v203(v213, CFrame_2)
						else
							tp({ Target = CFrame_2 })
						end
					end
				end

				if not t13.find({ v213.Mob }) then
					return
				end

				task.delay(0.5, function()
					CFrame_ = nil
				end)
				t13.attack({ v213.Mob }, s2)
				task.delay(0.5, function()
					pcall(function()
						CFrame_ = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart") and Client.Character.HumanoidRootPart.CFrame
					end)
				end)
			end
		end)

		if not ok then
			warn(tostring(result), ": " .. s2)
		end
	end
end

local t18 = {}

function t16.Auto_Sea21()
	local s3 = "Auto_Sea21"

	while _G.Settings[s3] and task.wait(0.5) do
		local ok, result = pcall(function()
			-- Only runs in Sea 1 at the right level range
			if not Sea1 then
				return
			end
			local lvl = Client.PlayerStats.lvl.Value
			if lvl < 2250 or lvl >= 4000 then
				return
			end

			-- Disable level farm while progressing to Sea 2
			if _G.Settings.Auto_Farm_Level1 then
				_G.Settings.Auto_Farm_Level1 = false
			end

			local progression = ""
			pcall(function()
				progression = tostring(Client.PlayerStats.SecondSeaProgression.Value)
			end)

			if progression ~= "Yes" then
				-- Need Map material or kill Seasoned Fishman
				if getPlayerMaterial("Map") <= 0 then
					local questVisible = false
					pcall(function()
						local qf = Client.PlayerGui:FindFirstChild("MainGui")
						qf = qf and qf:FindFirstChild("QuestFrame")
						qf = qf and qf:FindFirstChild("QuestBoard")
						questVisible = qf and qf.Visible
					end)

					if questVisible then
						local mob = Repli:FindFirstChild("MOB") and Repli.MOB:FindFirstChild("Seasoned Fishman [Lv. 2200]")
						if mob then
							local pivot = mob.GetPivot and mob:GetPivot() or (mob:FindFirstChild("HumanoidRootPart") and mob.HumanoidRootPart.CFrame)
							if pivot then
								tp({ Target = pivot })
							end
						else
							tp({
								Target = CFrame.new(-1865.43481, 45.2696266, 6722.8501)
							})
						end

						if t13.find({ "Seasoned Fishman [Lv. 2200]" }) then
							t13.attack({ "Seasoned Fishman [Lv. 2200]" }, s3)
						end
					else
						-- Take quest from Traveler
						SafeToQuest("Traveler")
						task.wait(0.5)
						local trav = SafeNPC("Traveler")
						if trav then
							tp({ Target = trav.CFrame * CFrame.new(0, 0, -10) })
						end
					end
				else
					-- Have Map, talk to Traveler to progress
					SafeToQuest("Traveler")
					task.wait(0.5)
					local trav = SafeNPC("Traveler")
					if trav then
						tp({ Target = trav.CFrame * CFrame.new(0, 0, -10) })
					end
				end
			else
				-- Already unlocked Sea 2, teleport
				local npc = SafeNPC("Traveler") or SafeNPC("Elite Pirate")
				if npc then
					toQuest(npc.CFrame, 2)
				else
					warn("Auto_Sea21: Traveler/Elite Pirate not found")
				end
			end
		end)

		if not ok then
			warn(result, ": " .. s3)
		end
	end
end
function t16.Auto_Sea31()
	local s4 = "Auto_Sea31"

	while _G.Settings[s4] and task.wait(1) do
		local ok, result = pcall(function()
			-- Note: original state machine with n3 was incomplete / dead code heavy.
			-- Keeping structure but preventing tight infinite loop.
			-- Fixed: initialize materials/NPC tables and choose sensible start state
			v307 = v307 or {Log=50, ["Pile of Bones"]=10, ["Fresh Fish"]=50, ["Angellic's Feather"]=14, ["Sea King's Blood"]=1}
			v308 = v308 or {
				Sea1 = SafeNPCCFrame("Elite Pirate"),
				Sea2 = SafeNPCCFrame("Traveler") or SafeNPCCFrame("Elite Pirate")
			}
			v316 = v316 or nil

			-- Progress-aware starting state
			local n3 = 17  -- default: check materials / crafting path
			if getPlayerMaterial("Kraken's Cache") > 0 then
				return  -- already has cache, nothing to do this cycle
			end
			if t13.find({ "Tentacle" }) then
				n3 = 13  -- attack tentacle
			elseif getPlayerMaterial("Heart of Sea") > 0 then
				n3 = 16  -- craft path
			elseif getPlayerMaterial("Log") < (v307.Log or 50) then
				n3 = 27  -- farm logs
			else
				n3 = 28  -- has logs, check other mats
			end

			local safety = 0
			while true do
				safety = safety + 1
				if safety > 50 then
					warn("Auto_Sea31: safety break")
					break
				end
				if n3 < 27 then
					if n3 < 13 then
						if n3 < 10 then
							if n3 == 3 then
								return
							else
								break
							end
						elseif n3 < 11 then
							if n3 == 10 then
								SafeToQuest("The Squid")
								wait(0.5)
								tp({
									Target = SafeNPCCFrame("The Squid") * CFrame.new(0, 10, -10)
								})
								break
							else
								break
							end
						elseif n3 == 11 then
							if t13.find({ "Tentacle" }) then
								n3 = 13
							else
								n3 = 14
							end
						else
							break
						end
					elseif n3 < 16 then
						if n3 < 14 then
							if n3 == 13 then
								t13.attackMon({ "Tentacle" }, s4, 10)

								break
							else
								break
							end
						elseif n3 == 14 then
							if getPlayerMaterial("Heart of Sea") <= 0 then
								n3 = 17
							else
								n3 = 16
							end
						else
							break
						end
					elseif n3 < 17 then
						if n3 == 16 then
							if Client.PlayerGui:FindFirstChild("CraftingMaterialUI") then
								Client.PlayerGui:FindFirstChild("CraftingMaterialUI"):Destroy()
								Client.Character.Humanoid:ChangeState(15)
							else
								SafeToQuest("Summon Tentacle")
							end

							break
						else
							break
						end
					elseif n3 == 17 then
						if not (getPlayerMaterial("Kraken\'s Cache") <= 0) then
							return
						end

						if t13.find({ "Tentacle" }) then
							return
						end

						local t20 = {
							Log = 50,
							["Pile of Bones"] = 10,
							["Fresh Fish"] = 50,
							["Angellic\'s Feather"] = 14,
							["Sea King\'s Blood"] = 1
						}
						local t21 = {
							Sea1 = (workspace.AllNPC:FindFirstChild("Elite Pirate") or workspace.AllNPC:FindFirstChild("The Squid") or {CFrame=CFrame.new()}).CFrame,
							Sea2 = (workspace.AllNPC:FindFirstChild("Elite Pirate") or workspace.AllNPC:FindFirstChild("Traveler") or {CFrame=CFrame.new()}).CFrame
						}
						v307 = t20
						v308 = t21

						if getPlayerMaterial("Log") >= t20.Log then
							n3 = 28
						else
							n3 = 27
						end
					else
						break
					end
				elseif n3 < 40 then
					local v229

					if n3 < 32 then
						if n3 < 28 then
							if n3 == 27 then
								if not Sea2 then
									toQuest(v308 and v308.Sea2 or CFrame.new())

									return
								end

								local v230, v231

								v310, v311, v229 = pairs(game:GetService("Workspace"):GetDescendants())
								n3 = 32
							else
								break
							end
						elseif n3 == 28 then
							if getPlayerMaterial("Pile of Bones") >= (v307 and v307["Pile of Bones"] or 10) then
								if getPlayerMaterial("Fresh Fish") >= (v307 and v307["Fresh Fish"] or 50) then
									if getPlayerMaterial("Angellic\'s Feather") >= (v307 and v307["Angellic's Feather"] or 14) then
										if getPlayerMaterial("Sea King\'s Blood") >= (v307 and v307["Sea King's Blood"] or 1) then
											if Sea2 then
												SafeToQuest("Jack Stones")

												for _, child in pairs(Client.PlayerGui:GetChildren()) do
													if child.Name == "CraftingMaterialUI" then
														if child:FindFirstChild("Frame") and child.Frame.OrbName.Text ~= "Heart of Sea" then
															child.Frame.Materials.AnchorPoint = Vector2.new(0, 0)
															child.Frame.Materials.Position = UDim2.new(0, 0, 0, 0)
															child.Frame.Materials.Visible = true

															if child.Frame.Materials:FindFirstChild("ScrollingFrame") then
																child.Frame.Materials:FindFirstChild("ScrollingFrame").ClipsDescendants = false

																if child.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("UIGridLayout") then
																	child.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("UIGridLayout").CellSize = UDim2.new(1001, 0, 1001, 0)
																end

																if child.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("Diamond Key") then
																	child.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("Diamond Key").Visible = false
																end

																game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
																game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
															end
														elseif child.Frame.OrbName.Text == "Heart of Sea" then
															child.Frame.CraftButton.Size = UDim2.new(1001, 0, 1001, 0)
															game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
															game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
														end
													end
												end
											else
												toQuest(v308 and v308.Sea2 or CFrame.new())
											end
										elseif Sea2 then
											warn("Sea King\'s Blood Not Have")

											if t13.find({ "SeaKing", "HydraSeaKing" }) then
												t13.attack({ "SeaKing", "HydraSeaKing" }, s4)
											else
												seaChest()
											end
										else
											toQuest(v308 and v308.Sea2 or CFrame.new())
										end
									elseif Sea1 then
										if t13.find({ "Sky Soldier [Lv. 800]", "Ball Man [Lv. 850]" }) then
											t13.attack({ "Sky Soldier [Lv. 800]", "Ball Man [Lv. 850]" }, s4)
										else
											tp({
												Target = workspace.Island["H - Skyland"].Sky.Base:GetChildren()[4].CFrame
											})
										end
									else
										toQuest(v308 and v308.Sea1 or CFrame.new())
									end
								elseif Sea1 then
									if t13.find({ "Karate Fishman [Lv. 200]", "Fighter Fishman [Lv. 180]", "Shark Man [Lv. 230]" }) then
										t13.attack({ "Karate Fishman [Lv. 200]", "Fighter Fishman [Lv. 180]", "Shark Man [Lv. 230]" }, s4)
									else
										tp({
											Target = workspace.Island["D - Shark Island"].D.Base:GetChildren()[57].CFrame
										})
									end
								else
									toQuest(v308 and v308.Sea1 or CFrame.new())
								end
							elseif Sea2 then
								if t13.find({ "Skull Pirate [Lv. 3050]" }) then
									t13.attack({ "Skull Pirate [Lv. 3050]" }, s4)
								else
									tp({
										Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)
									})
								end
							else
								toQuest(v308 and v308.Sea2 or CFrame.new())
							end

							break
						else
							break
						end
					elseif n3 < 36 then
						if n3 == 32 then
							local v234

							v229, v234 = v310(v311, v229)

							if v229 == nil then
								return
							end

							if string.find(v234.Name, "Tree") and (v234:FindFirstChild("Part") and v234.Part.Transparency == 0) then
								v316 = v234
								n3 = 40
							else
								n3 = 36
							end
						else
							break
						end
					elseif n3 == 36 then
						if not (_G.Settings[s4] and (getPlayerMaterial("Log") < (v307 and v307.Log or 50) and (not t13.find({ "Tentacle" }) and getPlayerMaterial("Kraken\'s Cache") <= 0))) then
							return
						end

						break
					else
						break
					end
				elseif n3 < 49 then
					if n3 < 43 then
						if n3 == 40 then
							task.wait(1.5)

							if _G.Settings[s4] or (getPlayerMaterial("Log") <= (v307 and (v307 and v307.Log or 50) or 50) or not t13.find({ "Tentacle" })) then
								-- empty original body (dead code)
							end

							n3 = 43
						else
							break
						end
					elseif n3 == 43 then
						wait()

						local t22 = {
							Target = (v316 and v316.GetModelCFrame and v316:GetModelCFrame()) or (Client.Character and Client.Character:FindFirstChild("HumanoidRootPart") and Client.Character.HumanoidRootPart.CFrame) or CFrame.new()
						}

						tp(t22)

						if not (Client.Backpack:FindFirstChild("Bisento") or Client.Character:FindFirstChild("Bisento")) then
							game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer(unpack({ "Bisento" }))
						end

						n3 = 49
					else
						break
					end
				elseif n3 < 134 then
					if n3 == 49 then
						EquipTools("Bisento")

						if not (t2.CheckOnCooldown("Z") and t2.CheckOnCooldown("X")) then
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
						end

						if _G.Settings[s4] and (not t2.CheckOnCooldown("Z") and (not t2.CheckOnCooldown("X") and (not t13.find({ "Tentacle" }) and getPlayerMaterial("Kraken\'s Cache") <= 0))) then
						end

						break
					else
						break
					end
				elseif n3 == 134 then
					if Client.PlayerStats.lvl.Value < 4000 or Sea3 then
						return
					end

					if _G.Settings.Auto_Farm_Level1 then
						_G.Settings.Auto_Farm_Level1 = false
					end

					if getPlayerMaterial("Kraken\'s Cache") <= 0 then
					end

					break
				else
					break
				end
			end
		end)

		if not ok then
			warn(result, ": " .. s4)
		end
	end
end

local t23 = {}

function t16.Auto_Kill_Minion1()
	local s5 = "Auto_Kill_Minion1"

	while _G.Settings[s5] and task.wait() do
		local ok, result = pcall(function()
			local children = workspace.EventSpawns:GetChildren()
			local v241 = false

			for _, child in pairs(children) do
				if child.Name == "Spawn" and child:FindFirstChild("Chest") then
					local CFrame_2 = child.Chest.RootPart.CFrame

					if not t23[CFrame_2] then
						t23[CFrame_2] = true
						tp({
							Target = CFrame_2
						})

						for i = 1, 7 do
							local v246 = "Chest" .. i
							local v247 = game:GetService("Workspace"):FindFirstChild(v246)

							if v247 then
								pcall(function()
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v247.RootPart.CFrame
								end)
							end
						end
					end
				end

				if t13.find({ "Minion", "Boss" }) then
					t13.attack({ "Minion", "Boss" }, s5)
					v241 = true

					break
				end
			end

			if v241 then
				return
			end

			for _, child in pairs(children) do
				if child.Name == "Spawn" then
					pcall(function()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = child.CFrame
					end)
					task.wait(1)

					if t13.find({ "Minion", "Boss" }) then
						t13.attack({ "Minion", "Boss" }, s5)

						break
					end
				end
			end
		end)

		if not ok then
			warn(result, ": " .. s5)
		end
	end
end
function t16.Auto_Farm_Nearest_Mob()
	local s6 = "Auto_Farm_Nearest_Mob"

	while _G.Settings[s6] and task.wait() do
		local ok, result = pcall(function()
			for _, child in pairs(game:GetService("Workspace").Monster.Mon:GetChildren()) do
				local Humanoid = child:FindFirstChild("Humanoid")
				local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if Humanoid and (HumanoidRootPart and (Humanoid.Health > 0 and ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 1000 and t13.find({ child.Name })))) then
					t13.attack({ child.Name }, s6)
				end
			end
		end)

		if not ok then
			warn(result, ": " .. s6)
		end
	end
end
function t16.Auto_Kill_Sea_King1()
	local s7 = "Auto_Kill_Sea_King1"

	while _G.Settings[s7] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "SeaKing" }) then
				t13.attack({ "SeaKing" }, s7)
			else
				seaChest()
			end
		end)

		if not ok then
			warn(result, ": " .. s7)
		end
	end
end
function t16.Auto_Kill_GhostMonster1()
	local s8 = "Auto_Kill_GhostMonster1"

	while _G.Settings[s8] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "Ghost Ship" }) then
				n2 = Client.PlayerStats.beli.Value
				t13.attack({ "Ghost Ship" }, s8)
			else
				for _, child in pairs(game.Workspace:GetChildren()) do
					if child.Name:match("Chest") and (child.PrimaryPart and (cheatKey[child.PrimaryPart.CFrame] == false or cheatKey[child.PrimaryPart.CFrame] == nil)) then
						Tp(child.PrimaryPart.CFrame)
						cheatKey[child.PrimaryPart.CFrame] = true
						task.wait(0.3)
					else
						-- cheatKey persists across iterations
					end
				end
			end
		end)

		if not ok then
			print("Error in Auto_Kill_GhostMonster1:", result)
		end

		task.wait()
	end
end
function t16.Abyssal_Tyrant()
	local s9 = "Abyssal_Tyrant"

	while _G.Settings[s9] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "SeaDragon" }) then
				return
			end

			t13.attack({ "SeaDragon" }, s9)
		end)

		if not ok then
			warn(result, ": " .. s9)
		end
	end
end
function t16.Chaos_Kraken()
	local s10 = "Chaos_Kraken"

	while _G.Settings[s10] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "FuryTentacle" }) then
				return
			end

			t13.attack({ "FuryTentacle" }, s10)
		end)

		if not ok then
			warn(result, ": " .. s10)
		end
	end
end
function t16.Deepsea_Crusher()
	local s11 = "Deepsea_Crusher"

	while _G.Settings[s11] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "ThirdSeaEldritch Crab" }) then
				return
			end

			t13.attack({ "ThirdSeaEldritch Crab" }, s11)
		end)

		if not ok then
			warn(result, ": " .. s11)
		end
	end
end
function t16.auto_draken()
	local s12 = "auto_draken"

	while _G.Settings[s12] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "ThirdSeaDragon" }) then
				return
			end

			t13.attack({ "ThirdSeaDragon" }, s12)
		end)

		if not ok then
			warn(result, ": " .. s12)
		end
	end
end
function t16.Auto_Kill_Hydar_Sea_King1()
	local s13 = "Auto_Kill_Hydar_Sea_King1"

	while _G.Settings[s13] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "HydraSeaKing" }) then
				t13.attack({ "HydraSeaKing" }, s13)
			else
				seaChest()
			end
		end)

		if not ok then
			warn(result, ": " .. s13)
		end
	end
end
function t16.Auto_Kill_Kaido1()
	local s14 = "Auto_Kill_Kaido1"

	while _G.Settings[s14] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "Dragon [Lv. 5000]" }) then
				t13.attack({ "Dragon [Lv. 5000]" }, s14)
			elseif getPlayerMaterial("Dragon\'s Orb") <= 0 or not _G.Settings.Auto_Spawn_Kaido then
				if t13.find({ "Elite Skeleton [Lv. 3100]" }) then
					t13.attack({ "Elite Skeleton [Lv. 3100]" }, s14)
				else
					tp({
						Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)
					})
				end
			else
				SafeToQuest("SummonDragon", "SummonDragon")
			end
		end)

		if not ok then
			warn(result, ": " .. s14)
		end
	end
end
function t16.Auto_Expert_Swordman1()
	local s15 = "Auto_Expert_Swordman1"

	while _G.Settings[s15] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "Expert Swordman [Lv. 3000]" }) then
				return
			end

			t13.attack({ "Expert Swordman [Lv. 3000]" }, s15)
		end)

		if not ok then
			warn(result, ": " .. s15)
		end
	end
end
function t16.auto_bushido()
	local s16 = "auto_bushido"

	while _G.Settings[s16] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "Bushido Ape [Lv. 5000]" }) then
				return
			end

			t13.attack({ "Bushido Ape [Lv. 5000]" }, s16)
		end)

		if not ok then
			warn(result, ": " .. s16)
		end
	end
end
function t16.auto_lordsaber()
	local s17 = "auto_lordsaber"

	while _G.Settings[s17] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "Lord of Saber [Lv. 8500]" }) then
				return
			end

			t13.attack({ "Lord of Saber [Lv. 8500]" }, s17)
		end)

		if not ok then
			warn(result, ": " .. s17)
		end
	end
end
function t16.auto_jacko()
	local s18 = "auto_jacko"

	while _G.Settings[s18] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "Jack o lantern [Lv. 10000]" }) then
				t13.attack({ "Jack o lantern [Lv. 10000]" }, s18)
			else
				local SummonJackolantern = (getPlayerMaterial("Candy") > 50 and _G.Settings.auto_jacko and true or false) and workspace.AllNPC:FindFirstChild("SummonJackolantern")

				if not SummonJackolantern then
					return
				end

				toQuest(SummonJackolantern.CFrame, "SummonJackolantern")
			end
		end)

		if not ok then
			warn(result, ": " .. s18)
		end
	end
end
function t16.auto_skull()
	local s19 = "auto_skull"

	while _G.Settings[s19] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "Skull King" }) then
				return
			end

			t13.attack({ "Skull King" }, s19)
		end)

		if not ok then
			warn(result, ": " .. s19)
		end
	end
end
function t16.auto_farm_candy()
	local s20 = "auto_farm_candy"

	while _G.Settings[s20] and task.wait() do
		local ok, result = pcall(function()
			if Sea1 then
				if not t13.find({ "Zombie [Lv. 1500]" }) then
					return
				end

				t13.attack({ "Zombie [Lv. 1500]" }, s20)
			elseif Sea2 then
				if t13.find({ "Elite Skeleton [Lv. 3100]" }) then
					t13.attack({ "Elite Skeleton [Lv. 3100]" }, s20)
				elseif t13.find({ "Skull Pirate [Lv. 3050]" }) then
					t13.attack({ "Skull Pirate [Lv. 3050]" }, s20)
				else
					tp({
						Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)
					})
				end
			else
				if not (Sea3 and t13.find({ "Wilderness Gorilla [Lv. 4325]" })) then
					return
				end

				t13.attack({ "Wilderness Gorilla [Lv. 4325]" }, s20)
			end
		end)

		if not ok then
			warn(result, ": " .. s20)
		end
	end
end
function t16.auto_third_event()
	local funcx = "auto_third_event"
	_G.Settings[funcx] = _G.Settings[funcx] or false

	local t24 = {
		{
			name = "SeaDragon"
		},
		{
			name = "ThirdSeaEldritch Crab"
		},
		{
			name = "ThirdSeaDragon"
		},
		{
			name = "FuryTentacle"
		}
	}

	while _G.Settings["auto_third_event"] and task.wait(1) do
		for _, v in ipairs(t24) do
			if _G.Settings[v.name] then
				local ok, result = pcall(function()
					t13.attack({ v.name }, funcx)
				end)

				if not ok then
					warn("Error in " .. funcx .. ": " .. result)
				end
			end
		end
	end
end
function t16.goriila()
	local s21 = "goriila"

	while _G.Settings[s21] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "Jungle Gorilla [Lv. 4300]" }) then
				return
			end

			t13.attack({ "Jungle Gorilla [Lv. 4300]" }, s21)
		end)

		if not ok then
			warn(result, ": " .. s21)
		end
	end
end
function t16.Auto_Kill_BigMom()
	local s22 = "Auto_Kill_BigMom"

	while _G.Settings[s22] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "Ms. Mother [Lv. 7500]" }) then
				t13.attack({ "Ms. Mother [Lv. 7500]" }, s22)
			else
				tp(CFrame.new(-343, 177, 9087))
			end
		end)

		if not ok then
			warn(result, ": " .. s22)
		end
	end
end
function t16.King_Samurai()
	local s23 = "King_Samurai"

	while _G.Settings[s23] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "King Samurai [Lv. 3500]" }) then
				return
			end

			t13.attack({ "King Samurai [Lv. 3500]" }, s23)
		end)

		if not ok then
			warn(result, ": " .. s23)
		end
	end
end
function t16.auto_quake()
	local s24 = "auto_quake"

	while _G.Settings[s24] and task.wait() do
		local ok, result = pcall(function()
			if not t13.find({ "Quake Woman [Lv. 1925]" }) then
				return
			end

			t13.attack({ "Quake Woman [Lv. 1925]" }, s24)
		end)

		if not ok then
			warn(result, ": " .. s24)
		end
	end
end
function t16.AUTOOBSERVE2()
	local s25 = "AUTOOBSERVE2"

	while _G.Settings[s25] and task.wait() do
		local ok, result = pcall(function()
			SafeToQuest("Stranger Uncle", "Stranger Uncle")

			if t13.find({ "LeePung [Lv. 5000]" }) then
				t13.attack({ "LeePung [Lv. 5000]" }, s25)
			else
				SafeToQuest("Stranger Uncle", "Stranger Uncle")
			end

			SafeToQuest("Stranger Uncle", "Stranger Uncle")
		end)

		if not ok then
			warn(result, ": " .. s25)
		end
	end
end

local t25 = {
	["Jack o lantern [Lv. 10000]"] = "Jack o lantern",
	["King Samurai [Lv. 3500]"] = "King Samurai",
	["Dragon [Lv. 5000]"] = "Dragon",
	["Ms. Mother [Lv. 7500]"] = "Ms. Mother",
	["Lord of Saber [Lv. 8500]"] = "Lord of Saber",
	["Bushido Ape [Lv. 5000]"] = "Bushido Ape"
}

local function v323(p50)
	return t25[p50] or p50
end

function t16.auto_hop_boss()
	local s26 = "auto_hop_boss"

	while _G.Settings[s26] do
		local ok, result = pcall(function()
			local selectbosss_ = _G.Settings.selectbosss or {}
			local v328 = false

			for _, v in pairs(selectbosss_) do
				if t13.find({ v }) then
					local v331 = v323(v)

					print("Entity found: " .. v331 .. ". Stopping auto-hop.")
					_G.Settings[s26] = false
					v328 = true

					break
				end
			end

			if v328 then
				return
			end

			print("No selected entities found. Waiting " .. _G.Settings.HopDelay .. " seconds before hopping...")
			task.wait(_G.Settings.HopDelay or _G.HopDelay or 5)
			HopServer()
		end)

		if not ok then
			warn(result, ": " .. s26)
		end

		if not _G.Settings[s26] then
			return
		end
	end

	print("Auto-hop disabled. Stopping the function.")
end

local t26 = {
	FuryTentacle = "Chaos Kraken",
	["ThirdSeaEldritch Crab"] = "Deepsea Crusher",
	ThirdSeaDragon = "Drakenfyr the Inferno King",
	SeaDragon = "Abyssal Tyrant",
	["Skull King"] = "Skull King",
	["Ghost Ship"] = "Ghost Ship",
	HydraSeaKing = "Hydra Sea King",
	SeaKing = "Sea King"
}

local function v333(p51)
	return t26[p51] or p51
end

function t16.auto_hop()
	local s27 = "auto_hop"

	while wait() do
		if not _G.Settings[s27] then
			print("Auto-hop disabled. Stopping the function.")

			break
		end

		local ok, result = pcall(function()
			local SelectedEntities = _G.Settings.SelectedEntities or {}
			local v338 = false

			for _, SelectedEntity in pairs(SelectedEntities) do
				if t13.find({ SelectedEntity }) then
					local v341 = v333(SelectedEntity)

					print("Entity found: " .. v341 .. ". Stopping auto-hop.")
					_G.Settings[s27] = false
					v338 = true

					break
				end
			end

			if v338 then
				return
			end

			HopServer()
		end)

		if not ok then
			warn(result, ": " .. s27)
		end

		if not _G.Settings[s27] then
			return
		end
	end
end
function t16.auto_hakiv2()
	local s28 = "auto_hakiv2"

	while _G.Settings[s28] and task.wait() do
		local ok, result = pcall(function()
			if t13.find({ "Dark Beard [Lv. 3475]" }) then
				t13.attack({ "Dark Beard [Lv. 3475]" }, s28)
			elseif getPlayerMaterial("Dark Beard\'s Totem") <= 0 then
				if t13.find({ "Sally [Lv. 3450]" }) then
					t13.attack({ "Sally [Lv. 3450]" }, s28)
				else
					SafeToQuest("Lee", "Lee")
					wait(5)
					SafeToQuest("Pung", "Pung")
					wait(5)

					if getPlayerMaterial("Dark Beard\'s Totem") <= 0 and t13.find({ "Sally [Lv. 3450]" }) then
						t13.attack({ "Sally [Lv. 3450]" }, s28)
					end

					if getPlayerMaterial("Dark Beard\'s Totem") <= 0 then
						return
					end

					game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack({
						"QuestSpawnBoss",
						{
							SuccessQuest = "Quest Accepted.",
							BossName = "Dark Beard [Lv. 3475]",
							LevelNeed = 3475,
							QuestName = "Kill 1 Dark Beard",
							MaterialNeed = "Dark Beard's Totem",
							AI_Name = "Dark Beard",
							LevelLow = "You must be Level 3,475 to accept this quest."
						}
					}))
				end
			else
				game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack({
					"QuestSpawnBoss",
					{
						SuccessQuest = "Quest Accepted.",
						BossName = "Dark Beard [Lv. 3475]",
						LevelNeed = 3475,
						QuestName = "Kill 1 Dark Beard",
						MaterialNeed = "Dark Beard\'s Totem",
						AI_Name = "Dark Beard",
						LevelLow = "You must be Level 3,475 to accept this quest."
					}
				}))
			end
		end)

		if not ok then
			warn(result, ": " .. s28)
		end
	end
end
function MaterialMon()
	if SelectMaterial ~= "Rusted Scrap" then
		if SelectMaterial ~= "Iron Ingot" then
			if SelectMaterial ~= "Leather" then
				if SelectMaterial ~= "Angellic\'s Feather" then
					if SelectMaterial ~= "Carrot" then
						if SelectMaterial ~= "Gun Powder" then
							if SelectMaterial ~= "Fresh Fish" then
								if SelectMaterial ~= "Undead Ooze" then
									if SelectMaterial ~= "Shark Canine" then
										if SelectMaterial ~= "Bread Crumps" then
											if SelectMaterial ~= "Pile of Bones" then
												if SelectMaterial ~= "Thief\'s Rag" then
													if SelectMaterial ~= "Dragon Orb" then
														if SelectMaterial ~= "Lucidu\'s Totem" then
															if SelectMaterial ~= "Dark Beard Totem" then
																if SelectMaterial ~= "Magma Crystal" then
																	if SelectMaterial ~= "Ice Crystals" then
																		if SelectMaterial ~= "Samurai Bandage" then
																			if SelectMaterial ~= "Lost Ruby" then
																				if SelectMaterial ~= "Essence of Fire" then
																					if SelectMaterial ~= "Twilight Orb" then
																						if SelectMaterial ~= "Vital Fluid" then
																							if SelectMaterial ~= "Coral and Pearl" then
																								if SelectMaterial ~= "Shark Fin" then
																									if SelectMaterial ~= "Diverse Sphere" then
																										return
																									end

																									MMon = "Gazelle Man [Lv. 2350]"
																								else
																									MMon = "Fishman Guardian [Lv. 4150]"
																								end
																							else
																								MMon = "Fugitive [Lv. 4050]"
																							end
																						else
																							MMon = "Shadow Master [Lv. 1650]"
																						end
																					else
																						MMon = "Shadow Master [Lv. 1600]"
																					end
																				else
																					MMon = "Flame User [Lv. 3200]"
																				end
																			else
																				MMon = "Anubis [Lv. 3150]"
																			end
																		else
																			MMon = "Kitsune Samurai [Lv. 2650]"
																		end
																	else
																		MMon = "Azlan [Lv. 3300]"
																	end
																else
																	MMon = "The Volcano [Lv. 3325]"
																end
															else
																MMon = "Dark Beard Servant [Lv. 3400]"
															end
														else
															MMon = "Vice Admiral [Lv. 3500]"
														end
													else
														MMon = "Elite Skeleton [Lv. 3100]"
													end
												else
													MMon = "Desert Thief [Lv. 3125]"
												end
											else
												MMon = "Skull Pirate [Lv. 3050]"
											end
										else
											MMon = "Chess Soldier [Lv. 3200]"
										end
									else
										MMon = "Seasoned Fishman [Lv. 2200]"
									end
								elseif Sea1 then
									MMon = "Zombie [Lv. 1500]"
								else
									if not Sea2 then
										return
									end

									MMon = "Sally [Lv. 3450]"
								end
							else
								MMon = "Karate Fishman [Lv. 200]"
							end
						elseif Sea1 then
							MMon = "Ball Man [Lv. 850]"
						else
							if not Sea2 then
								return
							end

							MMon = "Lomeo [Lv. 3675]"
						end
					else
						MMon = "Beast Swordman [Lv. 2300]"
					end
				else
					MMon = "Sky Soldier [Lv. 800]"
				end
			elseif Sea1 then
				MMon = "Commander [Lv. 100]"
			else
				if not Sea2 then
					return
				end

				MMon = "Duke [Lv. 2550]"
			end
		else
			MMon = "Beast Pirate [Lv. 2250]"
		end
	elseif Sea1 then
		MMon = "Elite Soldier [Lv. 1000]"
	else
		if not Sea2 then
			return
		end

		MMon = "Beast Swordman [Lv. 2300]"
	end
end

if Sea1 then
	MonsterList = {
		"Soldier [Lv. 1]",
		"Clown Pirate [Lv. 10]",
		"Smoky [Lv. 20]",
		"Tashi [Lv. 30]",
		"Clown Swordman [Lv. 50]",
		"The Clown [Lv. 75]",
		"Commander [Lv. 100]",
		"Captain [Lv. 120]",
		"The Barbaric [Lv. 145]",
		"Fighter Fishman [Lv. 180]",
		"Karate Fishman [Lv. 200]",
		"Shark Man [Lv. 230]",
		"Trainer Chef [Lv. 250]",
		"Dark Leg [Lv. 300]",
		"Dory [Lv. 350]",
		"Snow Soldier [Lv. 400]",
		"King Snow [Lv. 450]",
		"Little Dear [Lv. 500]",
		"Candle Man [Lv. 525]",
		"Bomb Man [Lv. 625]",
		"King of Sand [Lv. 725]",
		"Sky Soldier [Lv. 800]",
		"Ball Man [Lv. 850]",
		"Rumble Man [Lv. 900]",
		"Elite Soldier [Lv. 1000]",
		"Leader [Lv. 1100]",
		"Pasta [Lv. 1150]",
		"Wolf [Lv. 1250]",
		"Giraffe [Lv. 1325]",
		"Leo [Lv. 1400]",
		"Zombie [Lv. 1500]",
		"Shadow Master [Lv. 1600]",
		"New World Pirate [Lv. 1700]",
		"Rear Admiral [Lv. 1800]",
		"True Karate Fishman [Lv. 1850]",
		"Quake Woman [Lv. 1925]",
		"Fishman [Lv. 2000]",
		"Combat Fishman [Lv. 2050]",
		"Sword Fishman [Lv. 2100]",
		"Soldier Fishman [Lv. 2150]",
		"Seasoned Fishman [Lv. 2200]"
	}
elseif Sea2 then
	MonsterList = {
		"Beast Pirate [Lv. 2250]",
		"Beast Swordman [Lv. 2300]",
		"Gazelle Man [Lv. 2350]",
		"Bandit Beast Pirate [Lv. 2400]",
		"Powerful Beast Pirate [Lv. 2450]",
		"Violet Samurai [Lv. 2500]",
		"Duke [Lv. 2550]",
		"Magician [Lv. 2600]",
		"Kitsune Samurai [Lv. 2650]",
		"Elite Beast Pirate [Lv. 2700]",
		"Bear Man [Lv. 2750]",
		"Bean [Lv. 2800]",
		"Meji [Lv. 2850]",
		"Pachy Woman [Lv. 2950]",
		"Kappa [Lv. 2950]",
		"Joey [Lv. 3000]",
		"Skull Pirate [Lv. 3050]",
		"Elite Skeleton [Lv. 3100]",
		"Desert Thief [Lv. 3125]",
		"Anubis [Lv. 3150]",
		"Pharaoh [Lv. 3175]",
		"Flame User [Lv. 3200]",
		"Chess Soldier [Lv. 3200]",
		"Sunken Vessel [Lv. 3225]",
		"Biscuit Man [Lv. 3250]",
		"Azlan [Lv. 3300]",
		"The Volcano [Lv. 3325]",
		"Dark Beard Servant [Lv. 3400]",
		"Supreme Swordman [Lv. 3425]",
		"Sally [Lv. 3450]",
		"Vice Admiral [Lv. 3500]",
		"Pondere [Lv. 3525]",
		"Hefty [Lv. 3550]",
		"Lucidus [Lv. 3575]",
		"Fiore Gladiator [Lv. 3600]",
		"Fiore Fighter [Lv. 3625]",
		"Fiore Pirate [Lv. 3650]",
		"Lomeo [Lv. 3675]",
		"Prince Aria [Lv. 3700]",
		"Devastate [Lv. 3725]",
		"Physicus [Lv. 3750]",
		"Floffy [Lv. 3775]",
		"Dead Troupe [Lv. 3800]",
		"Dead Troupe Captain [Lv. 3850]",
		"Ryu [Lv. 3975]"
	}
elseif Sea3 then
	MonsterList = { "Fugitive [Lv. 4050]", "Fishman Guardian [Lv. 4150]" }
end

local v345 = Sea1 and {
	"Rusted Scrap",
	"Leather",
	"Angellic\'s Feather",
	"Gun Powder",
	"Fresh Fish",
	"Undead Ooze",
	"Shark Canine"
} or (Sea2 and {
	"Rusted Scrap",
	"Leather",
	"Iron Ingot",
	"Carrot",
	"Mystic Droplet",
	"Gun Powder",
	"Bread Crumps",
	"Undead Ooze",
	"Pile of Bones",
	"Thief\'s Rag",
	"Dragon Orb",
	"Lucidu\'s Totem",
	"Dark Beard Totem",
	"Ice Crystals",
	"Magma Crystal",
	"Samurai Bandage",
	"Lost Ruby",
	"Essence of Fire",
	"Twilight Orb",
	"Vital Fluid",
	"Phoenix Tear",
	"Diverse Sphere"
} or (Sea3 and { "Coral and Pearl", "Shark Fin" } or nil))

v59 = {
	"Gazelle Man [Lv. 2350]",
	"Violet Samurai [Lv. 2500]",
	"Duke [Lv. 2550]",
	"Magician [Lv. 2600]",
	"Kitsune Samurai [Lv. 2650]",
	"Bear Man [Lv. 2750]",
	"Bean [Lv. 2800]",
	"Meji [Lv. 2850]",
	"Petra [Lv. 2900]",
	"Kappa [Lv. 2950]",
	"Joey [Lv. 3000]",
	"Elite Skeleton [Lv. 3100]",
	"Desert Thief [Lv. 3125]",
	"Anubis [Lv. 3150]",
	"Pharaoh [Lv. 3175]",
	"Flame User [Lv. 3200]",
	"Sunken Vessel [Lv. 3225]",
	"Biscuit Man [Lv. 3250]",
	"Dough Master [Lv. 3275]",
	"Supreme Swordman [Lv. 3425]",
	"Sally [Lv. 3450]",
	"Pondere [Lv. 3525]",
	"Hefty [Lv. 3550]",
	"Lomeo [Lv. 3675]",
	"Prince Aria [Lv. 3700]",
	"Devastate [Lv. 3725]",
	"Physicus [Lv. 3750]",
	"Floffy [Lv. 3775]",
	"Ryu [Lv. 3975]"
}
v58 = {
	"Fugitive [Lv. 4050]",
	"The deep one [Lv. 4200]",
	"Fishman King\'s Guard [Lv. 4250]",
	"Cyborg Gorilla [Lv. 4375]",
	"Ripcurrent Raider [Lv. 4400]",
	"Tidal Warrior [Lv. 4450]",
	"Ocean Gladiator [Lv. 4500]",
	"Electro Abyss Warrior [Lv. 4600]",
	"Inferno Diver [Lv. 4650]",
	"Tempest Tidebreaker [Lv. 4700]",
	"Abyssal Swordman [Lv. 4750]"
}
-- Fixed: do not nil the Players service
local bossList = nil

if Sea1 then
	v58 = {
		"Smoky [Lv. 20]",
		"Tashi [Lv. 30]",
		"The Clown [Lv. 75]",
		"Captain [Lv. 120]",
		"The Barbaric [Lv. 145]",
		"Karate Fishman [Lv. 200]",
		"Shark Man [Lv. 230]",
		"Dark Leg [Lv. 300]",
		"Dory [Lv. 350]",
		"King Snow [Lv. 450]",
		"Little Dear [Lv. 500]",
		"Candle Man [Lv. 525]",
		"Bomb Man [Lv. 625]",
		"King of Sand [Lv. 725]",
		"Ball Man [Lv. 850]",
		"Rumble Man [Lv. 950]",
		"Leader [Lv. 1100]",
		"Pasta [Lv. 1150]",
		"Wolf [Lv. 1250]",
		"Giraffe [Lv. 1300]",
		"Leo [Lv. 1450]",
		"Shadow Master [Lv. 1650]",
		"True Karate Fishman [Lv. 1850]",
		"Quake Woman [Lv. 1925]",
		"Combat Fishman [Lv. 2050]",
		"Sword Fishman [Lv. 2100]",
		"Seasoned Fishman [Lv. 2200]"
	}
elseif Sea2 then
	v58 = v59
elseif not Sea3 then
	v58 = v58 or {}
end

local v346

local areasIter, areasState, v346 = pairs(game:GetService("Workspace").Areas:GetChildren())

local v347 = v333
local v348 = v323
local v349 = t8
local v350 = t13
local t27 = {}

while true do
	v346, v471 = areasIter(areasState, v346)

	if v346 == nil then
		break
	end

	if v471.Name ~= "Sea of dust" then
		table.insert(t27, v471.Name)
	end
end

function t16.autofarmbosses()
	local s29 = "autofarmbosses"

	while _G.Settings[s29] and task.wait() do
		if v350.find({ selectedBoss }) then
			v350.attack({ selectedBoss }, s29)
		end
	end
end
function t16.AutoFarmMaterial()
	local s30 = "AutoFarmMaterial"

	while _G.Settings[s30] and task.wait() do
		MaterialMon()

		if MMon and v350.find({ MMon }) then
			v350.attack({ MMon }, s30)
		end
	end
end
function getSpawn()
	task.spawn(function()
		while task.wait(1) do
			local ok, result = pcall(function()
				local Backpack = game.Players.LocalPlayer.Backpack

				if _G.Settings.Select_Weapon == "Melee" or (_G.Settings.Select_Weapon == "Sword" or _G.Settings.Select_Weapon == "Fruit Power") then
					local v357 = _G.Settings.Select_Weapon == "Melee" and "Combat" or (_G.Settings.Select_Weapon == "Sword" and "Sword" or "Fruit Power")

					for _, child in pairs(Backpack:GetChildren()) do
						if child.ClassName == "Tool" and child.ToolTip == v357 then
							_G.Weapon = tostring(child.Name)
						end
					end
				elseif _G.Settings.Select_Weapon ~= "all In One" then
					_G.Settings.Select_Weapon = "Melee"
				else
					for _, child in pairs(Backpack:GetChildren()) do
						if child.ClassName == "Tool" then
							if child.ToolTip ~= "Sword" then
								if child.ToolTip ~= "Combat" then
									if child.ToolTip == "Fruit Power" then
										myWeapon["Fruit Power"] = tostring(child.Name)
									end
								else
									myWeapon.Melee = tostring(child.Name)
								end
							else
								myWeapon.Sword = tostring(child.Name)
							end
						end
					end
				end

				for _, child in pairs(Backpack:GetChildren()) do
					if child.ClassName == "Tool" and child.ToolTip == "Fruit Power" then
						myWeapon.Fruit = tostring(child.Name)
					end
				end
			end)

			if not ok then
				print("Error in getSpawn: ", result)
			end
		end
	end)
end

local PlaceId = game.PlaceId

if PlaceId ~= 4520749081 then
	if PlaceId ~= 6381829480 then
		if PlaceId == 5931540094 then
			Colossuem = true
		end
	else
		Sea2 = true
	end
else
	Sea1 = true
end

local LocalPlayer = game:GetService("Players").LocalPlayer

game:GetService("TextService")
game:GetService("TweenService")
game:GetService("UserInputService")
game:GetService("HttpService")
game:GetService("CoreGui")

local LocalPlayer2 = game:GetService("Players").LocalPlayer

game:GetService("UserInputService")
game:GetService("TweenService")
game:GetService("RunService")
LocalPlayer = LocalPlayer2
LocalPlayer2.GetMouse(LocalPlayer)
game:GetService("VirtualInputManager")
game:GetService("VirtualUser")
game:GetService("HttpService")
game:GetService("Lighting")
game:GetService("ReplicatedStorage")
game:GetService("TeleportService")

local _ = game:GetService("StarterGui")

local function _()
	return LocalPlayer2.Character or LocalPlayer2.CharacterAdded:Wait()
end

local pairs_ = pairs
local ipairs_ = ipairs

LocalPlayer = game:GetService("Players").LocalPlayer

local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

game:GetService("UserInputService")
game:GetService("HttpService")
game:GetService("CoreGui")

local LocalPlayer3 = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")

game:GetService("TweenService")
game:GetService("RunService")
LocalPlayer = LocalPlayer3
LocalPlayer3.GetMouse(LocalPlayer)
game:GetService("VirtualInputManager")
game:GetService("VirtualUser")
game:GetService("HttpService")
game:GetService("Lighting")
game:GetService("ReplicatedStorage")
game:GetService("TeleportService")

local _ = game:GetService("StarterGui")

local function _()
	return LocalPlayer3.Character or LocalPlayer3.CharacterAdded:Wait()
end

local t28 = {
	Bind = Enum.KeyCode.RightControl
}
local UserInputService2 = game:GetService("UserInputService")
local t29 = {
	Config = {
		MainColor = Color3.fromRGB(138, 43, 226), -- BlueViolet purple
		DropColor = Color3.fromRGB(20, 0, 30), -- near black purple
		["UI Size"] = UDim2.new(0.1, 400, 0.1, 250)
	},
	CoreGui = game:FindFirstChild("CoreGui") or game.Players.LocalPlayer.PlayerGui,
	Windows = {}
}
local protectgui_ = protectgui or (syn and syn.protect_gui or function() end)

local function createTextButton(p52)
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.BackgroundTransparency = 1
	TextButton.TextTransparency = 1
	TextButton.Text = ""
	TextButton.Parent = p52
	TextButton.ZIndex = 5000

	return TextButton
end

function t29.GetTextSize(_, p53)
	return TextService:GetTextSize(p53.Text, p53.TextSize, p53.Font, Vector2.new(math.huge, math.huge))
end

local function v383(p54)
	task.spawn(function()
		local n4 = 1
		local UIListLayout = p54:WaitForChild("UIListLayout", 9999999)

		p54.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + n4)

		local v386 = UIListLayout

		UIListLayout.GetPropertyChangedSignal(v386, "AbsoluteContentSize"):Connect(function()
			p54.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + n4)
		end)
	end)
end
local function v387(p55)
	task.spawn(function()
		local n5 = 1
		local UIListLayout = p55:WaitForChild("UIListLayout", 9999999)

		p55.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + n5, 0, 0)

		local v390 = UIListLayout

		UIListLayout.GetPropertyChangedSignal(v390, "AbsoluteContentSize"):Connect(function()
			p55.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + n5, 0, 0)
		end)
	end)
end

function t29.NewWindow(_, _, p56, p57)
	local image = p57 or "0"
	local t30 = {
		Toggle = Enum.KeyCode.LeftControl,
		Tabs = {},
		TabSelect = 1
	}
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ImageLabel = Instance.new("ImageLabel")
	local Frame2 = Instance.new("Frame")
	local ImageLabel2 = Instance.new("ImageLabel")
	local UICorner2 = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")
	local TextLabel2 = Instance.new("TextLabel")
	local UIGradient = Instance.new("UIGradient")

	Instance.new("UIGradient")

	local Frame3 = Instance.new("Frame")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Frame4 = Instance.new("Frame")
	local ImageLabel3 = Instance.new("ImageLabel")
	local UICorner3 = Instance.new("UICorner")
	local UICorner4 = Instance.new("UICorner")
	local Frame5 = Instance.new("Frame")
	local UICorner5 = Instance.new("UICorner")

	ScreenGui.Name = "Main"
	ScreenGui.Parent = t29.CoreGui
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	protectgui_(ScreenGui)
	Frame.Parent = ScreenGui
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
	Frame.BackgroundTransparency = 0
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = UDim2.fromScale(0, 0)
	Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Frame.ClipsDescendants = true
	TweenService:Create(Frame, TweenInfo.new(1.5), {
		Size = t29.Config["UI Size"]
	}):Play()
	UICorner.Parent = Frame
	ImageLabel.Name = "DropShadow"
	ImageLabel.Parent = Frame
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(1, 47, 1, 47)
	ImageLabel.ZIndex = 0
	ImageLabel.Image = "rbxassetid://6015897843"
	ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.ImageTransparency = 0.5
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(49, 49, 450, 450)
	ImageLabel.Rotation = 0.01
	Frame2.Name = "Topbar"
	Frame2.Parent = Frame
	Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame2.BackgroundTransparency = 1
	Frame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame2.BorderSizePixel = 0
	Frame2.Size = UDim2.new(1, 0, 0.09, 0)
	Frame2.ZIndex = 2
	Frame5.Parent = Frame
	Frame5.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame5.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
	Frame5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame5.BorderSizePixel = 0
	Frame5.BackgroundTransparency = 0.5
	Frame5.Position = UDim2.new(0.5, 0, 0.1, 0)
	Frame5.Size = UDim2.new(0.95, 0, 0.005, 0)
	Frame5.ZIndex = 5

	local UIGradient2 = Instance.new("UIGradient")

	UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(221, 160, 221)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) })
	UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.6, 0), NumberSequenceKeypoint.new(1, 0.5) })
	UIGradient2.Parent = Frame5
	UICorner5.CornerRadius = UDim.new(0, 3)
	UICorner5.Parent = Frame5
	ImageLabel2.Name = "HubLogo"
	ImageLabel2.Parent = Frame2
	ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel2.BackgroundTransparency = 1
	ImageLabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel2.BorderSizePixel = 0
	ImageLabel2.Position = UDim2.new(0.0450000018, 0, 0.6, 0)
	ImageLabel2.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
	ImageLabel2.SizeConstraint = Enum.SizeConstraint.RelativeYY
	ImageLabel2.ZIndex = 3
	ImageLabel2.Image = image
	UICorner2.Parent = ImageLabel2
	TextLabel.Name = "TextTitle"
	TextLabel.Parent = Frame2
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.103366353, 0, 0.2099998972, 0)
	TextLabel.Size = UDim2.new(0.896555603, 0, 0.433997005, 0)
	TextLabel.ZIndex = 3
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "Akuma <font color=\'rgb(160,32,240)\'>HUB</font>"
	TextLabel.RichText = true
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14
	TextLabel.TextWrapped = true
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Name = "TextDescription"
	TextLabel2.Parent = Frame2
	TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel2.BorderSizePixel = 0
	TextLabel2.Position = UDim2.new(0.103366353, 0, 0.65399694, 0)
	TextLabel2.Size = UDim2.new(0, 80, 0.300000012, 0)
	TextLabel2.ZIndex = 3
	TextLabel2.Font = Enum.Font.GothamBold
	TextLabel2.Text = p56 or "..."
	TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel2.TextScaled = false
	TextLabel2.TextSize = 10
	TextLabel2.TextWrapped = true
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	game:GetService("TweenService")

	local ImageButton = Instance.new("ImageButton")

	ImageButton.Name = "Exit"
	ImageButton.Parent = Frame2
	ImageButton.AnchorPoint = Vector2.new(1, 0)
	ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageButton.BackgroundTransparency = 1
	ImageButton.BorderSizePixel = 0
	ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageButton.Position = UDim2.new(1, -8, 0, 10)
	ImageButton.Size = UDim2.new(0, 20, 0, 20)
	ImageButton.Image = "rbxassetid://10747384394"

	local ImageButton2 = Instance.new("ImageButton")

	ImageButton2.Name = "Minimize"
	ImageButton2.Parent = Frame2
	ImageButton2.AnchorPoint = Vector2.new(1, 0)
	ImageButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageButton2.BackgroundTransparency = 1
	ImageButton2.BorderSizePixel = 0
	ImageButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageButton2.Position = UDim2.new(1, -33, 0, 10)
	ImageButton2.Size = UDim2.new(0, 20, 0, 20)
	ImageButton2.Image = "rbxassetid://10734896206"
	ImageButton2.MouseButton1Click:Connect(function()
		Frame.Visible = not Frame.Visible
	end)
	ImageButton.MouseButton1Click:Connect(function()
		pcall(function() ScreenGui:Destroy() end)
		pcall(function() Frame:Destroy() end)
		-- Fixed: removed references to non-existent Frames / Toggle
	end);
	(function()
		local textSize = t29:GetTextSize(TextLabel2)

		TweenService:Create(TextLabel2, TweenInfo.new(0.5), {
			Size = UDim2.new(0, textSize.X, 0.3, 0)
		}):Play()
	end)()
	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t29.Config.MainColor), ColorSequenceKeypoint.new(1, t29.Config.DropColor) })
	UIGradient.Parent = TextLabel2
	Frame3.Name = "MenuFrames"
	Frame3.Parent = Frame
	Frame3.AnchorPoint = Vector2.new(0.5, 0)
	Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame3.BackgroundTransparency = 1
	Frame3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame3.BorderSizePixel = 0
	Frame3.Position = UDim2.new(0.5, 0, 0.075000003, 0)
	Frame3.Size = UDim2.new(0.949999988, 0, 0.0799999982, 0)
	Frame3.ZIndex = 2
	ScrollingFrame.Name = "MenuScroll"
	ScrollingFrame.Parent = Frame3
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.ZIndex = 3
	ScrollingFrame.CanvasSize = UDim2.new(2, 0, 0, 0)
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.TopImage = ""
	v387(ScrollingFrame)
	UIListLayout.Parent = ScrollingFrame
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 8)
	Frame4.Name = "CloseUI"
	Frame4.Parent = Frame
	Frame4.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame4.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
	Frame4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame4.BorderSizePixel = 0
	Frame4.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame4.Visible = false
	Frame4.ZIndex = 45
	Frame4.Size = UDim2.fromScale(1, 1)
	TweenService:Create(Frame4, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
		Size = UDim2.fromScale(0, 0)
	}):Play()
	ImageLabel3.Name = "HubLogo"
	ImageLabel3.Parent = Frame4
	ImageLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel3.BackgroundTransparency = 1
	ImageLabel3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel3.BorderSizePixel = 0
	ImageLabel3.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel3.Size = UDim2.new(0.25, 0, 0.25, 0)
	ImageLabel3.SizeConstraint = Enum.SizeConstraint.RelativeYY
	ImageLabel3.ZIndex = 55
	ImageLabel3.Image = image
	UICorner3.Parent = ImageLabel3
	UICorner4.Parent = Frame4

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(37, 37, 37)
	UIStroke.Parent = Frame4

	local u417 = nil
	local n6 = 0.1
	local Position = nil
	local Position2 = nil
	local u421 = true
	local v422 = Frame

	Frame.GetPropertyChangedSignal(v422, "Size"):Connect(function()
		if Frame.Size.X.Scale > 0 then
			Frame.Visible = true
		else
			Frame.Visible = false
		end
	end)

	local v423 = Frame4

	Frame4.GetPropertyChangedSignal(v423, "Size"):Connect(function()
		if Frame4.Size.X.Scale > 0 then
			Frame4.Visible = true
		else
			Frame4.Visible = false
		end
	end)

	local function v424(p58)
		if p58 then
			TweenService:Create(Frame, TweenInfo.new(0.5), {
				Size = t29.Config["UI Size"]
			}):Play()
			TweenService:Create(Frame4, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
				Size = UDim2.fromScale(0, 0)
			}):Play()
		else
			TweenService:Create(Frame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
				Size = UDim2.fromScale(0, 0)
			}):Play()
			TweenService:Create(Frame4, TweenInfo.new(0.5), {
				Size = UDim2.fromScale(1, 1)
			}):Play()
		end
	end

	task.spawn(function()
		local ScreenGui2 = Instance.new("ScreenGui")
		local Frame6 = Instance.new("Frame")
		local UICorner6 = Instance.new("UICorner")
		local UIStroke2 = Instance.new("UIStroke")
		local ImageLabel4 = Instance.new("ImageLabel")
		local ImageLabel5 = Instance.new("ImageLabel")

		ScreenGui2.Name = "Toggle"
		ScreenGui2.Parent = t29.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
		ScreenGui2.ZIndexBehavior = Enum.ZIndexBehavior.Global
		Frame6.Name = "c4"
		Frame6.Parent = ScreenGui2
		Frame6.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame6.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame6.BorderSizePixel = 0
		Frame6.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
		Frame6.Size = UDim2.new(0, 65, 0, 65)
		Frame6.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Frame6.ZIndex = 67
		UICorner6.Parent = Frame6
		UIStroke2.Color = Color3.fromRGB(138, 43, 226)
		UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke2.Parent = Frame6
		ImageLabel4.Name = "logo"
		ImageLabel4.Parent = Frame6
		ImageLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel4.BackgroundTransparency = 1.01
		ImageLabel4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel4.BorderSizePixel = 0
		ImageLabel4.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel4.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
		ImageLabel4.ZIndex = 68
		ImageLabel4.Image = image
		ImageLabel5.Name = "DropShadow"
		ImageLabel5.Parent = Frame6
		ImageLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel5.BackgroundTransparency = 1
		ImageLabel5.BorderSizePixel = 0
		ImageLabel5.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel5.Size = UDim2.new(1, 47, 1, 47)
		ImageLabel5.ZIndex = 66
		ImageLabel5.Image = "rbxassetid://6015897843"
		ImageLabel5.ImageColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel5.ImageTransparency = 0.5
		ImageLabel5.ScaleType = Enum.ScaleType.Slice
		ImageLabel5.SliceCenter = Rect.new(49, 49, 450, 450)

		local u431 = false
		local Position3 = nil
		local Position4 = nil
		local Position5 = Frame6.Position

		local function v435(p59)
			local v436 = p59.Position - Position3
			local uDim2 = UDim2.new(Position4.X.Scale, Position4.X.Offset + v436.X, Position4.Y.Scale, Position4.Y.Offset + v436.Y)

			game:GetService("TweenService"):Create(Frame6, TweenInfo.new(n6), {
				Position = uDim2
			}):Play()
		end

		local v438 = createTextButton(Frame6)

		v438.ZIndex = 68
		v438.MouseButton1Click:Connect(function()
			if Position5 ~= Frame6.Position then
				return
			end

			u421 = not u421
			v424(u421)
		end)
		v438.InputBegan:Connect(function(input)
			if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				return
			end

			u431 = true
			Position3 = input.Position
			Position4 = Frame6.Position
			Position5 = Frame6.Position
			input.Changed:Connect(function()
				if input.UserInputState ~= Enum.UserInputState.End then
					return
				end

				u431 = false
			end)
		end)
		UserInputService2.InputChanged:Connect(function(input)
			if not ((input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and u431) then
				return
			end

			v435(input)
		end)
	end)
	UserInputService.InputBegan:Connect(function(input, _)
		if input.KeyCode ~= t28.Bind then
			return
		end

		if uitoggled ~= false then
			Frame:TweenSize(UDim2.new(0.100000001, 410, 0.100000001, 240), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 1, true)
			ScreenGui.Enabled = true
			uitoggled = false
		else
			Frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 1, true)
			uitoggled = true
			task.wait(0.5)
			ScreenGui.Enabled = false
		end
	end)

	local function v439(p60)
		local v440 = p60.Position - Position
		local uDim2 = UDim2.new(Position2.X.Scale, Position2.X.Offset + v440.X, Position2.Y.Scale, Position2.Y.Offset + v440.Y)

		game:GetService("TweenService"):Create(Frame, TweenInfo.new(n6), {
			Position = uDim2
		}):Play()
	end

	Frame2.InputBegan:Connect(function(input)
		if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			return
		end

		u417 = true
		Position = input.Position
		Position2 = Frame.Position
		input.Changed:Connect(function()
			if input.UserInputState ~= Enum.UserInputState.End then
				return
			end

			u417 = false
		end)
	end)
	UserInputService2.InputChanged:Connect(function(input)
		if not ((input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and u417) then
			return
		end

		v439(input)
	end)
	UserInputService2.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		if input.KeyCode ~= t30.Toggle then
			return
		end

		u421 = not u421
		v424(u421)
	end)

	function t30.AddMenu(_, p61, p62, p63, p64)
		local v442 = p64 or "tab"
		local t31 = {
			Checker = {}
		}
		local Frame6 = Instance.new("Frame")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		local UICorner6 = Instance.new("UICorner")
		local ImageLabel4 = Instance.new("ImageLabel")
		local TextLabel3 = Instance.new("TextLabel")
		local TextLabel4 = Instance.new("TextLabel")
		local TextButton = Instance.new("TextButton")

		Frame6.Name = "MenuButton"
		Frame6.Parent = ScrollingFrame
		Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame6.BackgroundTransparency = 1
		Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame6.BorderSizePixel = 0
		Frame6.ClipsDescendants = false
		Frame6.Size = UDim2.new(0.5, 0, 0.75, 0)
		Frame6.ZIndex = 4
		UIAspectRatioConstraint.Parent = Frame6
		UIAspectRatioConstraint.AspectRatio = 0.1
		UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
		UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
		TweenService:Create(UIAspectRatioConstraint, TweenInfo.new(0.3 + #t30.Tabs / 10, Enum.EasingStyle.Back), {
			AspectRatio = 4
		}):Play()
		UICorner6.CornerRadius = UDim.new(0, 3)
		UICorner6.Parent = Frame6
		ImageLabel4.Name = "MenuLogo"
		ImageLabel4.Parent = Frame6
		ImageLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel4.BackgroundTransparency = 1
		ImageLabel4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel4.BorderSizePixel = 0
		ImageLabel4.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel4.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ImageLabel4.ZIndex = 5
		ImageLabel4.Image = p63
		TextLabel3.Name = "MenuText"
		TextLabel3.Parent = Frame6
		TextLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel3.BorderSizePixel = 0
		TextLabel3.Position = UDim2.new(0.010877919, 0, 0.5, 0)
		TextLabel3.Size = UDim2.new(2.10955262, 0, 0.5, 0)
		TextLabel3.ZIndex = 5
		TextLabel3.Font = Enum.Font.GothamBold
		TextLabel3.Text = p61 or "Menu"
		TextLabel3.TextColor3 = Color3.fromRGB(100, 100, 15)
		TextLabel3.TextTransparency = 0.8
		TextLabel3.TextScaled = true
		TextLabel3.TextSize = 14
		TextLabel3.TextWrapped = true
		TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel4.Name = "MenuDesc"
		TextLabel4.Parent = Frame6
		TextLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel4.BackgroundTransparency = 1
		TextLabel4.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel4.BorderSizePixel = 0
		TextLabel4.Position = UDim2.new(0.11100589, 0, 0.600000083, 0)
		TextLabel4.Size = UDim2.new(2.10955262, 0, 0.349999547, 0)
		TextLabel4.ZIndex = 5
		TextLabel4.Font = Enum.Font.GothamBold
		TextLabel4.Text = p62 or "Description"
		TextLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel4.TextScaled = true
		TextLabel4.TextSize = 14
		TextLabel4.TextTransparency = 0.8
		TextLabel4.TextWrapped = true
		TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
		TextButton.Name = "Button"
		TextButton.Parent = Frame6
		TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.BackgroundTransparency = 1
		TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.BorderSizePixel = 0
		TextButton.Size = UDim2.new(1, 0, 1, 0)
		TextButton.ZIndex = 25
		TextButton.Font = Enum.Font.SourceSans
		TextButton.Text = ""
		TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.TextSize = 14
		TextButton.TextTransparency = 1

		local Frame7 = nil

		if v442:find("tab") then
			Frame7 = Instance.new("Frame")

			local Frame8 = Instance.new("Frame")
			local Frame9 = Instance.new("Frame")
			local UICorner7 = Instance.new("UICorner")
			local UIStroke2 = Instance.new("UIStroke")
			local TextLabel5 = Instance.new("TextLabel")
			local ImageLabel5 = Instance.new("ImageLabel")
			local UICorner8 = Instance.new("UICorner")
			local TextBox = Instance.new("TextBox")
			local Frame10 = Instance.new("Frame")
			local Frame11 = Instance.new("Frame")
			local ScrollingFrame2 = Instance.new("ScrollingFrame")
			local UIListLayout2 = Instance.new("UIListLayout")
			local Frame12 = Instance.new("Frame")

			Frame7.Name = "PageFrames"
			Frame7.Parent = Frame
			Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame7.BackgroundTransparency = 1
			Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame7.BorderSizePixel = 0
			Frame7.ClipsDescendants = true
			Frame7.Position = UDim2.new(0, 0, 0.163185388, 0)
			Frame7.Size = UDim2.new(1, 0, 0.836814642, 0)
			Frame7.ZIndex = 4
			Frame8.Name = "Search"
			Frame8.Parent = Frame7
			Frame8.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame8.BackgroundTransparency = 1
			Frame8.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame8.BorderSizePixel = 0
			Frame8.ClipsDescendants = true
			Frame8.Position = UDim2.new(0.187006071, 0, 0.5, 0)
			Frame8.Size = UDim2.new(0.354012221, 0, 0.980000138, 0)
			Frame8.ZIndex = 4
			Frame9.Name = "SearchEngine"
			Frame9.Parent = Frame8
			Frame9.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Frame9.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame9.BorderSizePixel = 0
			Frame9.ClipsDescendants = true
			Frame9.Size = UDim2.new(1, 0, 0.0680000037, 0)
			Frame9.ZIndex = 6
			UICorner7.CornerRadius = UDim.new(0, 2)
			UICorner7.Parent = Frame9
			UIStroke2.Thickness = 0.5
			UIStroke2.Color = Color3.fromRGB(39, 39, 39)
			UIStroke2.Parent = Frame9
			TextLabel5.Name = "LabelText"
			TextLabel5.Parent = Frame9
			TextLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel5.BackgroundTransparency = 1
			TextLabel5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel5.BorderSizePixel = 0
			TextLabel5.Position = UDim2.new(0.612374663, 0, 0.499999851, 0)
			TextLabel5.Size = UDim2.new(0.871346772, 0, 0.50000006, 0)
			TextLabel5.ZIndex = 6
			TextLabel5.Font = Enum.Font.GothamBold
			TextLabel5.Text = "Search"
			TextLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel5.TextScaled = true
			TextLabel5.TextSize = 14
			TextLabel5.TextTransparency = 0.75
			TextLabel5.TextWrapped = true
			TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
			ImageLabel5.Name = "SearchIcon"
			ImageLabel5.Parent = Frame9
			ImageLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel5.BackgroundTransparency = 1
			ImageLabel5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel5.BorderSizePixel = 0
			ImageLabel5.Position = UDim2.new(0.075000003, 0, 0.5, 0)
			ImageLabel5.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			ImageLabel5.SizeConstraint = Enum.SizeConstraint.RelativeYY
			ImageLabel5.ZIndex = 6
			ImageLabel5.Image = "rbxassetid://7734052925"
			ImageLabel5.ImageTransparency = 0.75
			UICorner8.CornerRadius = UDim.new(0, 6)
			UICorner8.Parent = ImageLabel5
			TextBox.Name = "searchbox"
			TextBox.Parent = Frame9
			TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1
			TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.BorderSizePixel = 0
			TextBox.Position = UDim2.new(1.46321285, 0, 0.499999851, 0)
			TextBox.Size = UDim2.new(2.66615963, 0, 0.50000006, 0)
			TextBox.ZIndex = 7
			TextBox.ClearTextOnFocus = false
			TextBox.Font = Enum.Font.GothamBold
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextScaled = true
			TextBox.TextSize = 14
			TextBox.TextWrapped = true
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			Frame10.Parent = Frame8
			Frame10.Active = true
			Frame10.AnchorPoint = Vector2.new(0, 0.5)
			Frame10.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			Frame10.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame10.BorderSizePixel = 0
			Frame10.Position = UDim2.new(1.01999998, 0, 0.5, 0)
			Frame10.Rotation = 0
			Frame10.Size = UDim2.new(0.00499999989, 0, 1, 0)
			Frame10.ZIndex = 3
			Frame11.Parent = Frame10
			Frame11.Active = true
			Frame11.AnchorPoint = Vector2.new(0, 0.5)
			Frame11.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame11.BorderSizePixel = 0
			Frame11.Position = UDim2.new(1.00999999, 0, 0.5, 0)
			Frame11.Size = UDim2.new(1, 0, 1, 0)
			Frame11.ZIndex = 3
			ScrollingFrame2.Name = "TabFrames"
			ScrollingFrame2.Parent = Frame8
			ScrollingFrame2.Active = true
			ScrollingFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
			ScrollingFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScrollingFrame2.BackgroundTransparency = 1
			ScrollingFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ScrollingFrame2.BorderSizePixel = 0
			ScrollingFrame2.ClipsDescendants = false
			ScrollingFrame2.Position = UDim2.new(0.500000119, 0, 0.549316823, 0)
			ScrollingFrame2.Size = UDim2.new(0.949999988, 0, 0.901000023, 0)
			ScrollingFrame2.ZIndex = 6
			ScrollingFrame2.ScrollBarThickness = 0
			v383(ScrollingFrame2)
			UIListLayout2.Parent = ScrollingFrame2
			UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout2.Padding = UDim.new(0, 4)
			Frame12.Name = "Main"
			Frame12.Parent = Frame7
			Frame12.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame12.BackgroundTransparency = 1
			Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame12.BorderSizePixel = 0
			Frame12.ClipsDescendants = true
			Frame12.Position = UDim2.new(0.685165405, 0, 0.5, 0)
			Frame12.Size = UDim2.new(0.609669089, 0, 0.980000019, 0)
			Frame12.ZIndex = 4
			TextBox.Focused:Connect(function()
				TweenService:Create(TextLabel5, TweenInfo.new(0.1), {
					TextTransparency = 1
				}):Play()
				TweenService:Create(ImageLabel5, TweenInfo.new(0.1), {
					ImageTransparency = 1
				}):Play()
			end)
			TextBox.FocusLost:Connect(function()
				if #TextBox.Text <= 0 then
					TweenService:Create(TextLabel5, TweenInfo.new(0.1), {
						TextTransparency = 0.75
					}):Play()
					TweenService:Create(ImageLabel5, TweenInfo.new(0.1), {
						ImageTransparency = 0.75
					}):Play()

					for _, child in ipairs_(ScrollingFrame2:GetChildren()) do
						if child:IsA("Frame") then
							child.Visible = true
						end
					end
				else
					for _, child in ipairs_(ScrollingFrame2:GetChildren()) do
						if child:IsA("Frame") then
							if child.Name:lower():find(TextBox.Text:lower()) then
								child.Visible = true
							else
								child.Visible = false
							end
						end
					end
				end
			end)

			local v469 = TextBox

			TextBox.GetPropertyChangedSignal(v469, "Text"):Connect(function()
				if #TextBox.Text <= 0 then
					TweenService:Create(TextLabel5, TweenInfo.new(0.1), {
						TextTransparency = 0.75
					}):Play()
					TweenService:Create(ImageLabel5, TweenInfo.new(0.1), {
						ImageTransparency = 0.75
					}):Play()

					for _, child in ipairs_(ScrollingFrame2:GetChildren()) do
						if child:IsA("Frame") then
							child.Visible = true
						end
					end
				else
					TweenService:Create(TextLabel5, TweenInfo.new(0.1), {
						TextTransparency = 1
					}):Play()
					TweenService:Create(ImageLabel5, TweenInfo.new(0.1), {
						ImageTransparency = 1
					}):Play()

					for _, child in ipairs_(ScrollingFrame2:GetChildren()) do
						if child:IsA("Frame") then
							if child.Name:lower():find(TextBox.Text:lower()) then
								child.Visible = true
							else
								child.Visible = false
							end
						end
					end
				end
			end)
		elseif v442:find("change") then
			Frame7 = Instance.new("Frame")

			local Frame8 = Instance.new("Frame")
			local ScrollingFrame2 = Instance.new("ScrollingFrame")
			local UIListLayout2 = Instance.new("UIListLayout")
			local Frame9 = Instance.new("Frame")
			local UICorner7 = Instance.new("UICorner")

			v383(ScrollingFrame2)
			Frame7.Name = "ChangeLog"
			Frame7.Parent = Frame
			Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame7.BackgroundTransparency = 1
			Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame7.BorderSizePixel = 0
			Frame7.Position = UDim2.new(0, 0, 0.163185388, 0)
			Frame7.Size = UDim2.new(1, 0, 0.836814642, 0)
			Frame7.Visible = true
			Frame7.ZIndex = 4
			Frame8.Name = "Main"
			Frame8.Parent = Frame7
			Frame8.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame8.BackgroundTransparency = 1
			Frame8.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame8.BorderSizePixel = 0
			Frame8.ClipsDescendants = true
			Frame8.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame8.Size = UDim2.new(0.949999988, 0, 0.949999988, 0)
			Frame8.ZIndex = 4
			ScrollingFrame2.Name = "MainScrolling"
			ScrollingFrame2.Parent = Frame8
			ScrollingFrame2.Active = true
			ScrollingFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
			ScrollingFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScrollingFrame2.BackgroundTransparency = 1
			ScrollingFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ScrollingFrame2.BorderSizePixel = 0
			ScrollingFrame2.ClipsDescendants = false
			ScrollingFrame2.Position = UDim2.new(0.5, 0, 0.5, 0)
			ScrollingFrame2.Size = UDim2.new(0.99000001, 0, 1, 0)
			ScrollingFrame2.ZIndex = 2
			ScrollingFrame2.ScrollBarThickness = 0
			UIListLayout2.Parent = ScrollingFrame2
			UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout2.Padding = UDim.new(0, 5)
			Frame9.Parent = Frame7
			Frame9.AnchorPoint = Vector2.new(0.5, 1)
			Frame9.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Frame9.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame9.BorderSizePixel = 0
			Frame9.Position = UDim2.new(0.5, 0, 0, 0)
			Frame9.Size = UDim2.new(0.949999988, 0, 0.00499999989, 0)
			UICorner7.CornerRadius = UDim.new(0.5, 0)
			UICorner7.Parent = Frame9
		end

		local tabSelect = #t30.Tabs + 1

		local function v480(p65)
			if p65 then
				TweenService:Create(Frame7, TweenInfo.new(0.3), {
					Position = UDim2.fromScale(0, 0.163)
				}):Play()
				TweenService:Create(TextLabel3, TweenInfo.new(0.1 + tabSelect / 10), {
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextTransparency = 0.8
				}):Play()
			else
				if tabSelect >= t30.TabSelect then
					TweenService:Create(Frame7, TweenInfo.new(0.3), {
						Position = UDim2.fromScale(1, 0.163)
					}):Play()
				else
					TweenService:Create(Frame7, TweenInfo.new(0.3), {
						Position = UDim2.fromScale(-1, 0.163)
					}):Play()
				end

				TweenService:Create(TextLabel3, TweenInfo.new(0.1), {
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextTransparency = 0.25
				}):Play()
			end
		end

		if t30.Tabs[1] then
			v480(false)
		else
			v480(true)
		end

		table.insert(t30.Tabs, { Frame6, v480 })
		tabSelect = #t30.Tabs
		TextButton.MouseButton1Click:Connect(function()
			t30.TabSelect = tabSelect

			for k, tab in ipairs_(t30.Tabs) do
				if tab[1] ~= Frame6 then
					tab[2](false)
				else
					t30.TabSelect = k
					tab[2](true)
				end
			end
		end)

		function t31.AddTab(_, p66, p67, p68)
			local t32 = {}
			local ScrollingFrame2 = nil

			if v442:find("tab") then
				ScrollingFrame2 = Instance.new("ScrollingFrame")

				local UIListLayout2 = Instance.new("UIListLayout")

				v383(ScrollingFrame2)
				ScrollingFrame2.Name = tostring(p66 or "Main")
				ScrollingFrame2.Name = "MainScrolling"
				ScrollingFrame2.Parent = Frame7:WaitForChild("Main")
				ScrollingFrame2.Active = true
				ScrollingFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
				ScrollingFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame2.BackgroundTransparency = 1
				ScrollingFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame2.BorderSizePixel = 0
				ScrollingFrame2.ClipsDescendants = false
				ScrollingFrame2.Position = UDim2.new(0.1, 0, 0.1, 0)
				ScrollingFrame2.Size = UDim2.new(0.99500001, 0, 1, 0)
				ScrollingFrame2.ZIndex = 2
				ScrollingFrame2.ScrollBarThickness = 0
				UIListLayout2.Parent = ScrollingFrame2
				UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout2.Padding = UDim.new(0, 1.5)

				local Frame8 = Instance.new("Frame")
				local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
				local UICorner7 = Instance.new("UICorner")
				local UIStroke2 = Instance.new("UIStroke")
				local UIGradient3 = Instance.new("UIGradient")
				local ImageLabel5 = Instance.new("ImageLabel")
				local TextLabel5 = Instance.new("TextLabel")
				local TextLabel6 = Instance.new("TextLabel")
				local TextButton2 = Instance.new("TextButton")

				Frame8.Name = tostring(p66 or "Main")
				Frame8.Parent = Frame7:WaitForChild("Search"):WaitForChild("TabFrames")
				Frame8.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
				Frame8.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frame8.BorderSizePixel = 0
				Frame8.Size = UDim2.new(1, 0, 1, 0)
				Frame8.ZIndex = 5
				UIAspectRatioConstraint2.Parent = Frame8
				UIAspectRatioConstraint2.AspectRatio = 4.25
				UIAspectRatioConstraint2.AspectType = Enum.AspectType.ScaleWithParentSize
				UICorner7.CornerRadius = UDim.new(0, 3)
				UICorner7.Parent = Frame8
				UIStroke2.Transparency = 0.25
				UIStroke2.Color = Color3.fromRGB(128, 0, 128)
				UIStroke2.Parent = Frame8
				UIGradient3.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.5),
					NumberSequenceKeypoint.new(0.2, 0),
					NumberSequenceKeypoint.new(0.8, 0),
					NumberSequenceKeypoint.new(1, 0.5)
				})
				UIGradient3.Parent = UIStroke2
				ImageLabel5.Name = "TabIcon"
				ImageLabel5.Parent = Frame8
				ImageLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel5.BackgroundTransparency = 1
				ImageLabel5.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel5.BorderSizePixel = 0
				ImageLabel5.Position = UDim2.new(0.135000005, 0, 0.5, 0)
				ImageLabel5.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
				ImageLabel5.SizeConstraint = Enum.SizeConstraint.RelativeYY
				ImageLabel5.ZIndex = 6
				ImageLabel5.Image = "rbxassetid://" .. p67
				TextLabel5.Name = "Text"
				TextLabel5.Parent = Frame8
				TextLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel5.BackgroundTransparency = 1
				TextLabel5.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel5.BorderSizePixel = 0
				TextLabel5.Position = UDim2.new(0.246999651, 0, 0.200000003, 0)
				TextLabel5.Size = UDim2.new(0.753000021, 0, 0.400000006, 0)
				TextLabel5.ZIndex = 7
				TextLabel5.Font = Enum.Font.GothamBold
				TextLabel5.Text = p66 or "Main"
				TextLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel5.TextScaled = true
				TextLabel5.TextSize = 14
				TextLabel5.TextWrapped = true
				TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel6.Name = "Description"
				TextLabel6.Parent = Frame8
				TextLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel6.BackgroundTransparency = 1
				TextLabel6.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel6.BorderSizePixel = 0
				TextLabel6.Position = UDim2.new(0.246999651, 0, 0.600000024, 0)
				TextLabel6.Size = UDim2.new(0.753000081, 0, 0.25, 0)
				TextLabel6.ZIndex = 7
				TextLabel6.Font = Enum.Font.GothamBold
				TextLabel6.Text = p68 or "loadstring()()"
				TextLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel6.TextScaled = true
				TextLabel6.TextSize = 14
				TextLabel6.TextTransparency = 0.5
				TextLabel6.TextWrapped = true
				TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
				TextButton2.Name = "Button"
				TextButton2.Parent = Frame8
				TextButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton2.BackgroundTransparency = 1
				TextButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextButton2.BorderSizePixel = 0
				TextButton2.Size = UDim2.new(1, 0, 1, 0)
				TextButton2.ZIndex = 25
				TextButton2.Font = Enum.Font.SourceSans
				TextButton2.Text = ""
				TextButton2.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton2.TextSize = 14
				TextButton2.TextTransparency = 1

				local function v495(p69)
					UDim2.fromScale(0.9, 0.95)

					if p69 then
						TextLabel5.TextColor3 = Color3.fromRGB(128, 0, 128)
						TweenService:Create(ImageLabel5, TweenInfo.new(0.15), {
							ImageTransparency = 0
						}):Play()
						TweenService:Create(TextLabel6, TweenInfo.new(0.15), {
							TextTransparency = 0.5
						}):Play()
						TweenService:Create(TextLabel5, TweenInfo.new(0.15), {
							TextTransparency = 0
						}):Play()
						TweenService:Create(UIStroke2, TweenInfo.new(0.15), {
							Transparency = 0.25
						}):Play()
						TweenService:Create(ScrollingFrame2, TweenInfo.new(0.4), {
							Position = UDim2.new(0.5, 0, 0.5, 0)
						}):Play()
					else
						TextLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
						TweenService:Create(ImageLabel5, TweenInfo.new(0.15), {
							ImageTransparency = 0.55
						}):Play()
						TweenService:Create(TextLabel6, TweenInfo.new(0.15), {
							TextTransparency = 0.85
						}):Play()
						TweenService:Create(TextLabel5, TweenInfo.new(0.15), {
							TextTransparency = 0.55
						}):Play()
						TweenService:Create(UIStroke2, TweenInfo.new(0.15), {
							Transparency = 0.65
						}):Play()
						TweenService:Create(ScrollingFrame2, TweenInfo.new(0.4), {
							Position = UDim2.fromScale(1.55, 0.5)
						}):Play()
					end
				end

				if t31[1] then
					v495(false)
				else
					v495(true)
				end

				table.insert(t31, { v495, ImageLabel5 })
				TextButton2.MouseButton1Click:Connect(function()
					for _, v in ipairs_(t31) do
						if v[2] ~= ImageLabel5 then
							v[1](false)
						else
							v[1](true)
						end
					end
				end)
			elseif v442:find("change") then
				ScrollingFrame2 = Frame7:FindFirstChild("Main"):FindFirstChild("MainScrolling")
			end

			function t32.AddLabel(_, p70, p71)
				local TextLabel5 = Instance.new("TextLabel")
				local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")

				TextLabel5.Name = "SectionTitle"
				TextLabel5.Parent = ScrollingFrame2
				TextLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel5.BackgroundTransparency = 1
				TextLabel5.BorderSizePixel = 0
				TextLabel5.Size = UDim2.new(0.980000019, 0, 0.5, 0)
				TextLabel5.ZIndex = 4
				TextLabel5.Font = Enum.Font.GothamBold
				TextLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel5.TextScaled = true
				TextLabel5.TextSize = 14
				TextLabel5.TextWrapped = true
				TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel5.Text = p70 .. ": " .. (p71 == "positive" and "✅" or "❌")
				UIAspectRatioConstraint2.Parent = TextLabel5
				UIAspectRatioConstraint2.AspectRatio = 23
				UIAspectRatioConstraint2.AspectType = Enum.AspectType.ScaleWithParentSize

				return {
					SetStatus = function(_, p72)
						TextLabel5.Text = p70 .. ": " .. (p72 == "positive" and "✅" or "❌")
					end,
					Delete = function(_)
						TextLabel5:Destroy()
					end
				}
			end
			function t32.AddSection(_, p73, p74, p75, _)
				local TextLabel5 = Instance.new("TextLabel")
				local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
				local t33 = {}

				TextLabel5.Name = "SectionTitle"
				TextLabel5.Parent = ScrollingFrame2
				TextLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel5.BackgroundTransparency = 1
				TextLabel5.Size = UDim2.new(0.98, 0, 0.5, 0)
				TextLabel5.ZIndex = 4
				TextLabel5.Font = Enum.Font.GothamBold
				TextLabel5.Text = p73 or "SECTION"
				TextLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel5.TextScaled = true
				TextLabel5.TextWrapped = true
				TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
				UIAspectRatioConstraint2.Parent = TextLabel5
				UIAspectRatioConstraint2.AspectRatio = 23
				UIAspectRatioConstraint2.AspectType = Enum.AspectType.ScaleWithParentSize

				local Frame8 = Instance.new("Frame")
				local UICorner7 = Instance.new("UICorner")
				local UIStroke2 = Instance.new("UIStroke")
				local UIListLayout2 = Instance.new("UIListLayout")
				local Frame9 = Instance.new("Frame")
				local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")
				local ImageLabel5 = Instance.new("ImageLabel")
				local ImageLabel6 = Instance.new("ImageLabel")
				local TextLabel6 = Instance.new("TextLabel")
				local TextLabel7 = Instance.new("TextLabel")
				local Frame10 = Instance.new("Frame")
				local UICorner8 = Instance.new("UICorner")

				local function v515()
					local Y = UIListLayout2.AbsoluteContentSize.Y

					Frame8.Size = UDim2.new(1, 0, 0, Y + 10)
					UIStroke2.Thickness = 1
				end

				local v517 = UIListLayout2

				UIListLayout2.GetPropertyChangedSignal(v517, "AbsoluteContentSize"):Connect(v515)
				Frame8.ChildAdded:Connect(v515)
				Frame8.ChildRemoved:Connect(v515)
				Frame8.Name = "SectionFrame"
				Frame8.Parent = ScrollingFrame2
				Frame8.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
				Frame8.BackgroundTransparency = 0.6
				Frame8.Size = UDim2.new(1, -10, 0, 65)
				Frame8.ZIndex = 4
				Frame8.ClipsDescendants = true
				v515()
				UICorner7.Parent = Frame8
				UIStroke2.Color = Color3.fromRGB(128, 0, 128)
				UIStroke2.Transparency = 0.9
				UIStroke2.Parent = Frame8
				UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIListLayout2.Parent = Frame8
				UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout2.Padding = UDim.new(0, 5)
				Frame9.Name = "Header"
				Frame9.Parent = Frame8
				Frame9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Frame9.BackgroundTransparency = 1
				Frame9.Size = UDim2.new(0.95, 0, 0.5, 0)
				Frame9.ZIndex = 5
				UIAspectRatioConstraint3.Parent = Frame9
				UIAspectRatioConstraint3.AspectRatio = 4
				UIAspectRatioConstraint3.AspectType = Enum.AspectType.ScaleWithParentSize
				ImageLabel5.Name = "SectionIcon"
				ImageLabel5.Parent = Frame9
				ImageLabel5.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel5.BackgroundTransparency = 1
				ImageLabel5.Position = UDim2.new(0.05, 0, 0.4, 0)
				ImageLabel5.Size = UDim2.new(0.5, 0, 0.5, 0)
				ImageLabel5.SizeConstraint = Enum.SizeConstraint.RelativeYY
				ImageLabel5.ZIndex = 6
				ImageLabel5.Image = "rbxassetid://119522694447910"
				ImageLabel6.Name = "SectionIcon"
				ImageLabel6.Parent = Frame9
				ImageLabel6.AnchorPoint = Vector2.new(0.5, 0.7)
				ImageLabel6.BackgroundTransparency = 1
				ImageLabel6.Position = UDim2.new(0.95, 0, 0.6, 0)
				ImageLabel6.Size = UDim2.new(0.5, 0, 0.5, 0)
				ImageLabel6.SizeConstraint = Enum.SizeConstraint.RelativeYY
				ImageLabel6.ZIndex = 6
				ImageLabel6.Image = "rbxassetid://"
				TextLabel6.Name = "SectionHeadTest"
				TextLabel6.Parent = Frame9
				TextLabel6.BackgroundTransparency = 1
				TextLabel6.Position = UDim2.new(0.22, 0, 0.095, 0)
				TextLabel6.Size = UDim2.new(0.7, 0, 0.195, 0)
				TextLabel6.ZIndex = 5
				TextLabel6.Font = Enum.Font.GothamBold
				TextLabel6.Text = p74 or "Data Settings"
				TextLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel6.TextScaled = true
				TextLabel6.TextWrapped = true
				TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
				TextLabel7.Name = "SectionDescription"
				TextLabel7.Parent = Frame9
				TextLabel7.BackgroundTransparency = 1
				TextLabel7.Position = UDim2.new(0.22, 0, 0.255, 0)
				TextLabel7.Size = UDim2.new(0.7, 0, 0.495, 0)
				TextLabel7.ZIndex = 5
				TextLabel7.Font = Enum.Font.GothamBold
				TextLabel7.Text = p75 or "Save The Setting"
				TextLabel7.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel7.TextSize = 11
				TextLabel7.TextTransparency = 0.5
				TextLabel7.TextWrapped = true
				TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
				Frame10.Parent = Frame9
				Frame10.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame10.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
				Frame10.BackgroundTransparency = 0.6
				Frame10.Position = UDim2.new(0.5, 0, 0.9, 0)
				Frame10.Size = UDim2.new(0.95, 0, 0.02, 0)
				Frame10.ZIndex = 5
				UICorner8.CornerRadius = UDim.new(0.5, 0)
				UICorner8.Parent = Frame10

				function t33.Update(_)
					v515()
				end
				function t33.AddLabel(_, p76)
					local TextLabel8 = Instance.new("TextLabel")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
					local t34 = {}

					TextLabel8.Name = "SectionTitle"
					TextLabel8.Parent = Frame8
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Size = UDim2.new(0.92, 0, 0.5, 0)
					TextLabel8.ZIndex = 4
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p76 or "SECTION"
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextTransparency = 0.5
					TextLabel8.TextScaled = false
					TextLabel8.TextSize = 12
					TextLabel8.TextWrapped = true
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					UIAspectRatioConstraint4.Parent = TextLabel8
					UIAspectRatioConstraint4.AspectRatio = 23
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize

					function t34.Set(_, p77)
						TextLabel8.Text = tostring(p77)
					end
					function t34.Delete(_)
						TextLabel8:Destroy()
						v515()
					end

					t33:Update()

					return t34
				end
				function t33.AddSeperator(_, p78)
					local Frame11 = Instance.new("Frame")
					local Frame12 = Instance.new("Frame")
					local TextLabel8 = Instance.new("TextLabel")
					local Frame13 = Instance.new("Frame")
					local TextLabel9 = Instance.new("TextLabel")
					local TextLabel10 = Instance.new("TextLabel")
					local UIStroke3 = Instance.new("UIStroke")
					local UICorner9 = Instance.new("UICorner")

					Frame11.Name = "Seperator"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					Frame11.BorderSizePixel = 0
					Frame11.BackgroundTransparency = 1
					Frame11.ZIndex = 4
					Frame11.Size = UDim2.new(0.9, 0, 0, 30)
					UICorner9.CornerRadius = UDim.new(0.4, 0)
					UICorner9.Parent = Frame11
					UIStroke3.Color = Color3.fromRGB(128, 0, 128)
					UIStroke3.Transparency = 0.5
					UIStroke3.Parent = Frame11
					UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					Frame12.Name = "Sep1"
					Frame12.Parent = Frame11
					Frame12.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
					Frame12.BackgroundTransparency = 0
					Frame12.ZIndex = 10
					Frame12.BorderSizePixel = 0
					Frame12.ZIndex = 6
					Frame12.Position = UDim2.new(0, 10, 0, 10)
					Frame12.Size = UDim2.new(0, 90, 0, 2)
					Frame12.Visible = false
					TextLabel8.Name = "Sep2"
					TextLabel8.Parent = Frame11
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel8.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextLabel8.Size = UDim2.new(0.95, 0, 0, 30)
					TextLabel8.Font = Enum.Font.SourceSansBold
					TextLabel8.Text = p78
					TextLabel8.RichText = true
					TextLabel8.ZIndex = 6
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextTransparency = 0.5
					TextLabel8.TextSize = 18
					TextLabel9.Name = "Sep2"
					TextLabel9.Parent = Frame11
					TextLabel9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel9.BackgroundTransparency = 1
					TextLabel9.Position = UDim2.new(0, 0, 0, 0)
					TextLabel9.Size = UDim2.new(0.3385, 0, 0, 30)
					TextLabel9.Font = Enum.Font.SourceSansBold
					TextLabel9.Text = "<<"
					TextLabel9.RichText = true
					TextLabel9.ZIndex = 6
					TextLabel9.TextColor3 = Color3.fromRGB(128, 0, 128)
					TextLabel9.TextSize = 20
					TextLabel10.Name = "Sep2"
					TextLabel10.Parent = Frame11
					TextLabel10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel10.BackgroundTransparency = 1
					TextLabel10.Position = UDim2.new(0, 0, 0, 0)
					TextLabel10.AnchorPoint = Vector2.new(1, 0.5)
					TextLabel10.Position = UDim2.new(0.8, 0, 0.5, 0)
					TextLabel10.Font = Enum.Font.SourceSansBold
					TextLabel10.Text = ">>"
					TextLabel10.RichText = true
					TextLabel10.ZIndex = 6
					TextLabel10.TextColor3 = Color3.fromRGB(128, 0, 128)
					TextLabel10.TextSize = 20
					Frame13.Name = "Sep3"
					Frame13.Parent = Frame11
					Frame13.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
					Frame13.BackgroundTransparency = 0.1
					Frame13.BorderSizePixel = 0
					Frame13.ZIndex = 6
					Frame13.Visible = false
					Frame13.Position = UDim2.new(0, 280, 0, 10)
					Frame13.Size = UDim2.new(0, 90, 0, 2)
				end
				function t33.addLabel(_, p79)
					local TextLabel8 = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")
					local t35 = {}

					TextLabel8.Name = "Label"
					TextLabel8.Parent = Frame8
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.Size = UDim2.new(0, 270, 0, 20)
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.TextColor3 = Color3.fromRGB(225, 225, 225)
					TextLabel8.TextTransparency = 0.5
					TextLabel8.TextSize = 10
					TextLabel8.Text = p79
					TextLabel8.ZIndex = 5
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					UIPadding.PaddingLeft = UDim.new(0, 10)
					UIPadding.Parent = TextLabel8
					UIPadding.Name = "PaddingLabel"

					function t35.Set(_, p80)
						TextLabel8.Text = p80
					end

					return t35
				end
				function t33.Textbox(_, p81, p82, p83)
					local Frame11 = Instance.new("Frame")

					Frame11.Name = "Input"
					Frame11.Parent = Frame8
					Frame11.BorderSizePixel = 0
					Frame11.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					Frame11.Size = UDim2.new(0.94, 0, 0, 30)
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.ZIndex = 6

					local UIStroke3 = Instance.new("UIStroke")

					UIStroke3.Color = Color3.fromRGB(255, 255, 255)
					UIStroke3.Thickness = 1
					UIStroke3.Transparency = 0.95
					UIStroke3.Name = "UiToggle_UiStroke1"
					UIStroke3.Parent = Frame11

					local UICorner9 = Instance.new("UICorner")

					UICorner9.Parent = Frame11
					UICorner9.CornerRadius = UDim.new(0, 2)

					local TextLabel8 = Instance.new("TextLabel")

					TextLabel8.Name = "Title"
					TextLabel8.Parent = Frame11
					TextLabel8.BorderSizePixel = 0
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel8.TextTransparency = 0.2
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextSize = 12
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.Size = UDim2.new(2, 0, 1, 0)
					TextLabel8.Position = UDim2.new(0.02, 0, 0, 0)
					TextLabel8.Text = p81
					TextLabel8.ZIndex = 6

					local TextBox = Instance.new("TextBox")

					TextBox.Name = "TextBox"
					TextBox.Parent = Frame11
					TextBox.CursorPosition = -1
					TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.BorderSizePixel = 0
					TextBox.TextTransparency = 0.2
					TextBox.TextSize = 10
					TextBox.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
					TextBox.Font = Enum.Font.GothamBold
					TextBox.ClipsDescendants = true
					TextBox.AnchorPoint = Vector2.new(1, 0)
					TextBox.PlaceholderText = p82 .. "....."
					TextBox.Size = UDim2.new(0, 150, 0, 25)
					TextBox.Position = UDim2.new(1, -8, 0, 2)
					TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextBox.Text = ""
					TextBox.ZIndex = 6

					local UICorner10 = Instance.new("UICorner")

					UICorner10.Parent = TextBox
					UICorner10.CornerRadius = UDim.new(0, 8)
					TextBox.FocusLost:Connect(function(enterPressed)
						if not enterPressed then
							return
						end

						p83(TextBox.Text)
					end)
				end
				function t33.Toggle1(_, p84, p85, p86)
					local Frame11 = Instance.new("Frame")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
					local Frame12 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local TextLabel8 = Instance.new("TextLabel")
					local Frame13 = Instance.new("Frame")
					local UICorner10 = Instance.new("UICorner")
					local ImageLabel7 = Instance.new("ImageLabel")
					local Frame14 = Instance.new("Frame")
					local UIGradient3 = Instance.new("UIGradient")
					local UICorner11 = Instance.new("UICorner")

					Frame11.Name = "Toggle"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame11.BackgroundTransparency = 1
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.BorderSizePixel = 0
					Frame11.Size = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame11.ZIndex = 5
					UIAspectRatioConstraint4.Parent = Frame11
					UIAspectRatioConstraint4.AspectRatio = 11.5
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize
					Frame12.Name = "MainFrame"
					Frame12.Parent = Frame11
					Frame12.AnchorPoint = Vector2.new(0.5, 0)
					Frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame12.BackgroundTransparency = 1
					Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame12.BorderSizePixel = 0
					Frame12.Position = UDim2.new(0.5, 0, 0, 0)
					Frame12.Size = UDim2.new(0.949999988, 0, 1, 0)
					Frame12.ZIndex = 6
					UICorner9.CornerRadius = UDim.new(0, 3)
					UICorner9.Parent = Frame12
					TextLabel8.Name = "Text"
					TextLabel8.Parent = Frame12
					TextLabel8.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Position = UDim2.new(0.531999981, 0, 0.5, 0)
					TextLabel8.Size = UDim2.new(1.12300003, 0, 0.524999976, 0)
					TextLabel8.ZIndex = 6
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p84 or "Auto Fuck"
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextScaled = true
					TextLabel8.TextSize = 14
					TextLabel8.TextWrapped = true
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					Frame13.Name = "System"
					Frame13.Parent = Frame12
					Frame13.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame13.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					Frame13.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame13.BorderSizePixel = 0
					Frame13.BackgroundTransparency = 1
					Frame13.Position = UDim2.new(10.0419999994, 0, 0.5, 0)
					Frame13.Size = UDim2.new(0.824999988, 0, 0.824999988, 0)
					Frame13.SizeConstraint = Enum.SizeConstraint.RelativeYY
					Frame13.ZIndex = 6
					UICorner10.CornerRadius = UDim.new(0, 3)
					UICorner10.Parent = Frame13
					ImageLabel7.Name = "TurnOn"
					ImageLabel7.Parent = Frame13
					ImageLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel7.BorderSizePixel = 0
					ImageLabel7.Position = UDim2.new(0.5, 0, 0.5, 0)
					ImageLabel7.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
					ImageLabel7.ZIndex = 7
					ImageLabel7.Image = "rbxassetid://3944680095"
					ImageLabel7.ImageColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel7.ImageTransparency = 1
					Frame14.Name = "Box"
					Frame14.Parent = Frame13
					Frame14.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame14.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame14.BorderSizePixel = 0
					Frame14.Position = UDim2.new(0.5, 0, 0.5, 0)
					Frame14.ZIndex = 6
					UIGradient3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t29.Config.MainColor), ColorSequenceKeypoint.new(1, t29.Config.DropColor) })
					UIGradient3.Rotation = 45
					UIGradient3.Parent = Frame14
					UICorner11.CornerRadius = UDim.new(0, 4)
					UICorner11.Parent = Frame14

					local function v549(p87)
						if p87 then
							TweenService:Create(ImageLabel7, TweenInfo.new(0.4), {
								ImageTransparency = 0
							}):Play()
							TweenService:Create(Frame14, TweenInfo.new(0.3), {
								Size = UDim2.fromScale(1, 1)
							}):Play()
							TweenService:Create(ImageLabel7, TweenInfo.new(0.55), {
								ImageColor3 = t29.Config.MainColor
							}):Play()
						else
							TweenService:Create(ImageLabel7, TweenInfo.new(0.4), {
								ImageTransparency = 1
							}):Play()
							TweenService:Create(Frame14, TweenInfo.new(0.3), {
								Size = UDim2.fromScale(0, 0)
							}):Play()
							TweenService:Create(ImageLabel7, TweenInfo.new(0.555), {
								ImageColor3 = Color3.fromRGB(0, 0, 0)
							}):Play()
						end
					end

					v549(p85)
					createTextButton(Frame12).MouseButton1Click:Connect(function()
						p85 = not p85
						v549(p85)

						if not p86 then
							return
						end

						p86(p85)
					end)
					t33:Update()

					return {
						Text = function(_, ...)
							TextLabel8.Text = tostring(...)
						end,
						Value = function(_, p88)
							p85 = p88
							v549(p88)

							if not p86 then
								return
							end

							p86(p85)
						end,
						Delete = function(_)
							Frame11:Destroy()
							v515()
						end
					}
				end
				function t33.AddToggle1(_, p89, p90, p91)
					local Frame11 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local TextButton2 = Instance.new("TextButton")
					local TextLabel8 = Instance.new("TextLabel")
					local Frame12 = Instance.new("Frame")
					local UICorner10 = Instance.new("UICorner")
					local ImageLabel7 = Instance.new("ImageLabel")
					local UICorner11 = Instance.new("UICorner")
					local UIGradient3 = Instance.new("UIGradient")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")

					Frame11.Name = "Toggle"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					Frame11.BackgroundTransparency = 1
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.BorderSizePixel = 0
					Frame11.Size = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame11.ZIndex = 5
					UIAspectRatioConstraint4.Parent = Frame11
					UIAspectRatioConstraint4.AspectRatio = 11.5
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize
					UICorner9.CornerRadius = UDim.new(0, 3)
					UICorner9.Name = "UICorner_Toggle"
					UICorner9.Parent = Frame11
					TextButton2.Name = "Toggle_Click"
					TextButton2.Parent = Frame11
					TextButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextButton2.BackgroundTransparency = 1
					TextButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextButton2.BorderSizePixel = 0
					TextButton2.Size = UDim2.new(1, 0, 1, 0)
					TextButton2.Font = Enum.Font.SourceSans
					TextButton2.Text = ""
					TextButton2.TextColor3 = Color3.fromRGB(0, 0, 0)
					TextButton2.TextSize = 1
					TextButton2.ZIndex = 6
					TextLabel8.Name = "Toggle_Text"
					TextLabel8.Parent = Frame11
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Position = UDim2.new(0.14399981, 0, 0.32, 0)
					TextLabel8.Size = UDim2.new(1.13500003, 0, 0.424999976, 0)
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p89
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextSize = 14
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel8.ZIndex = 6
					TextLabel8.TextScaled = true
					Frame12.Name = "Toggle_Icon"
					Frame12.Parent = Frame11
					Frame12.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
					Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame12.BorderSizePixel = 0
					Frame12.Position = UDim2.new(0.035, 0, 0.181818187, 0)
					Frame12.Size = UDim2.new(0, 25, 0, 23)
					Frame12.ZIndex = 6
					UICorner10.CornerRadius = UDim.new(0, 3)
					UICorner10.Name = "UICorner_Toggle2"
					UICorner10.Parent = Frame12
					ImageLabel7.Parent = Frame12
					ImageLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel7.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel7.BorderSizePixel = 0
					ImageLabel7.Position = UDim2.new(0.519999981, 0, 0.550000012, 0)
					ImageLabel7.Size = UDim2.new(0, 30, 0, 30)
					ImageLabel7.Image = "http://www.roblox.com/asset/?id=6031068421"
					ImageLabel7.ImageColor3 = Color3.fromRGB(128, 0, 128)
					ImageLabel7.Visible = false
					ImageLabel7.ZIndex = 6
					UICorner11.CornerRadius = UDim.new(0, 3)
					UICorner11.Name = "UICorner_Toggle2"
					UICorner11.Parent = ImageLabel7
					UIGradient3.Parent = ImageLabel7

					if p90 == true then
						p90 = true
						ImageLabel7.Visible = true
						pcall(p91, p90)
					end

					TextButton2.MouseButton1Click:Connect(function()
						if p90 then
							p90 = false
							ImageLabel7.Visible = false
						else
							p90 = true
							ImageLabel7.Visible = true
						end

						pcall(p91, p90)
					end)
				end
				function t33.AddToggle(_, p92, p93, p94)
					local Frame11 = Instance.new("Frame")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
					local Frame12 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local TextLabel8 = Instance.new("TextLabel")
					local Frame13 = Instance.new("Frame")
					local UICorner10 = Instance.new("UICorner")
					local ImageLabel7 = Instance.new("ImageLabel")
					local Frame14 = Instance.new("Frame")
					local UIGradient3 = Instance.new("UIGradient")
					local UICorner11 = Instance.new("UICorner")

					Frame11.Name = "Toggle"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame11.BackgroundTransparency = 1
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.BorderSizePixel = 0
					Frame11.Size = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame11.ZIndex = 4
					UIAspectRatioConstraint4.Parent = Frame11
					UIAspectRatioConstraint4.AspectRatio = 11.5
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize
					Frame12.Name = "MainFrame"
					Frame12.Parent = Frame11
					Frame12.AnchorPoint = Vector2.new(0.5, 0)
					Frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame12.BackgroundTransparency = 1
					Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame12.BorderSizePixel = 0
					Frame12.Position = UDim2.new(0.5, 0, 0, 0)
					Frame12.Size = UDim2.new(0.949999988, 0, 1, 0)
					Frame12.ZIndex = 5
					UICorner9.CornerRadius = UDim.new(0, 3)
					UICorner9.Parent = Frame12
					TextLabel8.Name = "Text"
					TextLabel8.Parent = Frame12
					TextLabel8.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Position = UDim2.new(0.681999981, 0, 0.5, 0)
					TextLabel8.Size = UDim2.new(1.12300003, 0, 0.524999976, 0)
					TextLabel8.ZIndex = 5
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p92 or "Auto Fuck"
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextScaled = true
					TextLabel8.TextSize = 14
					TextLabel8.TextWrapped = true
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					Frame13.Name = "System"
					Frame13.Parent = Frame12
					Frame13.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame13.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					Frame13.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame13.BorderSizePixel = 0
					Frame13.Position = UDim2.new(0.0419999994, 0, 0.5, 0)
					Frame13.Size = UDim2.new(0.824999988, 0, 0.824999988, 0)
					Frame13.SizeConstraint = Enum.SizeConstraint.RelativeYY
					Frame13.ZIndex = 5
					UICorner10.CornerRadius = UDim.new(0, 3)
					UICorner10.Parent = Frame13
					ImageLabel7.Name = "TurnOn"
					ImageLabel7.Parent = Frame13
					ImageLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel7.BorderSizePixel = 0
					ImageLabel7.Position = UDim2.new(0.5, 0, 0.5, 0)
					ImageLabel7.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
					ImageLabel7.ZIndex = 6
					ImageLabel7.Image = "rbxassetid://3944680095"
					ImageLabel7.ImageColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel7.ImageTransparency = 1
					Frame14.Name = "Box"
					Frame14.Parent = Frame13
					Frame14.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame14.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame14.BorderSizePixel = 0
					Frame14.Position = UDim2.new(0.5, 0, 0.5, 0)
					Frame14.ZIndex = 5
					UIGradient3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t29.Config.MainColor), ColorSequenceKeypoint.new(1, t29.Config.DropColor) })
					UIGradient3.Rotation = 45
					UIGradient3.Parent = Frame14
					UICorner11.CornerRadius = UDim.new(0, 4)
					UICorner11.Parent = Frame14

					local function v571(p95)
						if p95 then
							TweenService:Create(ImageLabel7, TweenInfo.new(0.4), {
								ImageTransparency = 0
							}):Play()
							TweenService:Create(Frame14, TweenInfo.new(0.3), {
								Size = UDim2.fromScale(1, 1)
							}):Play()
							TweenService:Create(ImageLabel7, TweenInfo.new(0.55), {
								ImageColor3 = t29.Config.MainColor
							}):Play()
						else
							TweenService:Create(ImageLabel7, TweenInfo.new(0.4), {
								ImageTransparency = 1
							}):Play()
							TweenService:Create(Frame14, TweenInfo.new(0.3), {
								Size = UDim2.fromScale(0, 0)
							}):Play()
							TweenService:Create(ImageLabel7, TweenInfo.new(0.555), {
								ImageColor3 = Color3.fromRGB(0, 0, 0)
							}):Play()
						end
					end

					v571(p93)
					createTextButton(Frame12).MouseButton1Click:Connect(function()
						p93 = not p93
						v571(p93)

						if not p94 then
							return
						end

						p94(p93)
					end)

					if p93 == true then
						p93 = true
						v571(p93)
						pcall(p94, p93)
					end

					t33:Update()

					return {
						Text = function(_, ...)
							TextLabel8.Text = tostring(...)
						end,
						Value = function(_, p96)
							p93 = p96
							v571(p96)

							if not p94 then
								return
							end

							p94(p93)
						end,
						Delete = function(_)
							Frame11:Destroy()
							v515()
						end
					}
				end
				function t33.MultiDropdown(_, p97, p98, p99, p100)
					local v572 = p99 or {}
					local u573 = false
					local Frame11 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local TextLabel8 = Instance.new("TextLabel")
					local TextLabel9 = Instance.new("TextLabel")
					local ScrollingFrame3 = Instance.new("ScrollingFrame")
					local UIListLayout3 = Instance.new("UIListLayout")
					local UIPadding = Instance.new("UIPadding")
					local TextButton2 = Instance.new("TextButton")
					local ImageLabel7 = Instance.new("ImageLabel")

					Frame11.Name = "Dropdown"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					Frame11.ClipsDescendants = true
					Frame11.Size = UDim2.new(0.94, 0, 0, 30)
					Frame11.ZIndex = 6
					UICorner9.CornerRadius = UDim.new(0, 3)
					UICorner9.Parent = Frame11
					TextLabel9.Name = "DropTitle1"
					TextLabel9.Parent = Frame11
					TextLabel9.BackgroundTransparency = 1
					TextLabel9.Size = UDim2.new(0.9, 0, 0, 20)
					TextLabel9.Font = Enum.Font.GothamBold
					TextLabel9.Text = "  " .. p97
					TextLabel9.TextColor3 = Color3.fromRGB(225, 225, 225)
					TextLabel9.TextSize = 12
					TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel9.ZIndex = 6
					TextLabel8.Name = "DropTitle"
					TextLabel8.Parent = Frame11
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.Size = UDim2.new(0.9, 0, 0, 38)
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.TextColor3 = Color3.fromRGB(190, 190, 190)
					TextLabel8.TextSize = 9
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel8.ZIndex = 6
					TextLabel8.TextScaled = false
					ScrollingFrame3.Name = "DropScroll"
					ScrollingFrame3.Parent = TextLabel8
					ScrollingFrame3.Active = true
					ScrollingFrame3.BackgroundTransparency = 1
					ScrollingFrame3.Position = UDim2.new(0, 0, 0, 31)
					ScrollingFrame3.Size = UDim2.new(0.99, 0, 0, 150)
					ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, 0)
					ScrollingFrame3.ScrollBarThickness = 20
					ScrollingFrame3.ZIndex = 6
					UIListLayout3.Parent = ScrollingFrame3
					UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout3.Padding = UDim.new(0, 5)
					UIPadding.Parent = ScrollingFrame3
					UIPadding.PaddingLeft = UDim.new(0, 5)
					UIPadding.PaddingTop = UDim.new(0, 5)
					ImageLabel7.Name = "DropImage"
					ImageLabel7.Parent = Frame11
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.Position = UDim2.new(0.9, 0, 0, 6)
					ImageLabel7.Rotation = 180
					ImageLabel7.Size = UDim2.new(0, 20, 0, 20)
					ImageLabel7.Image = "rbxassetid://10734963191"
					ImageLabel7.ZIndex = 6
					TextButton2.Name = "DropButton"
					TextButton2.Parent = Frame11
					TextButton2.BackgroundTransparency = 1
					TextButton2.Size = UDim2.new(0.95, 0, 0, 31)
					TextButton2.Font = Enum.Font.GothamBold
					TextButton2.Text = ""
					TextButton2.ZIndex = 6

					local function v583()
						if #v572 <= 0 then
							return (not p99 or #p99 <= 0) and "   Select Multiple: " or "   " .. "Select Multiple: " .. table.concat(p99, ", ")
						else
							return "   " .. "Select Multiple: " .. table.concat(v572, ", ")
						end
					end

					local u584

					if p99 then
						v572 = p99
						u584 = v572
					else
						v572 = {}
						u584 = v572
					end

					TextLabel8.Text = v583()

					for _, v in ipairs_(p98) do
						local TextButton3 = Instance.new("TextButton")
						local UICorner10 = Instance.new("UICorner")

						TextButton3.Name = "Item"
						TextButton3.Parent = ScrollingFrame3
						TextButton3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
						TextButton3.Size = UDim2.new(0.99, 0, 0, 20)
						TextButton3.Font = Enum.Font.GothamBold
						TextButton3.Text = tostring(v)
						TextButton3.TextColor3 = Color3.fromRGB(225, 225, 225)
						TextButton3.TextSize = 13
						TextButton3.ZIndex = 6
						UICorner10.CornerRadius = UDim.new(0, 4)
						UICorner10.Parent = TextButton3

						if table.find(u584, v) then
							TextButton3.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
						end

						TextButton3.MouseButton1Click:Connect(function()
							if table.find(u584, v) then
								table.remove(u584, table.find(u584, v))
								TextButton3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
							else
								table.insert(u584, v)
								TextButton3.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
							end

							TextLabel8.Text = v583()
							p100(u584)
						end)
					end

					ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, UIListLayout3.AbsoluteContentSize.Y + 5)
					TextButton2.MouseButton1Click:Connect(function()
						if u573 then
							u573 = false
							Frame11:TweenSize(UDim2.new(0.94, 0, 0, 30), "Out", "Quad", 0.3, true)
							ImageLabel7.Rotation = 180
						else
							u573 = true
							Frame11:TweenSize(UDim2.new(0.94, 0, 0, 181), "Out", "Quad", 0.3, true)
							ImageLabel7.Rotation = 0
						end
					end)

					return {
						Add = function(_, p101)
							local TextButton3 = Instance.new("TextButton")
							local UICorner10 = Instance.new("UICorner")

							TextButton3.Name = "Item"
							TextButton3.Parent = ScrollingFrame3
							TextButton3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
							TextButton3.Size = UDim2.new(0.99, 0, 0, 20)
							TextButton3.Font = Enum.Font.GothamBold
							TextButton3.Text = tostring(p101)
							TextButton3.TextColor3 = Color3.fromRGB(225, 225, 225)
							TextButton3.TextSize = 13
							TextButton3.ZIndex = 6
							UICorner10.CornerRadius = UDim.new(0, 4)
							UICorner10.Parent = TextButton3
							TextButton3.MouseButton1Click:Connect(function()
								if table.find(u584, p101) then
									table.remove(u584, table.find(u584, p101))
									TextButton3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
								else
									table.insert(u584, p101)
									TextButton3.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
								end

								TextLabel8.Text = v583()
								p100(u584)
							end)
						end,
						Clear = function()
							u584 = {}
							TextLabel8.Text = "   Select Multiple : "

							for _, child in ipairs_(ScrollingFrame3:GetChildren()) do
								if child:IsA("TextButton") then
									child.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
								end
							end

							p100(u584)
						end
					}
				end
				function t33.AddDropdown(_, p102, p103, p104, p105)
					local Frame11 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local UICorner10 = Instance.new("UICorner")
					local TextLabel8 = Instance.new("TextLabel")
					local ScrollingFrame3 = Instance.new("ScrollingFrame")
					local UIListLayout3 = Instance.new("UIListLayout")
					local UIPadding = Instance.new("UIPadding")
					local TextButton2 = Instance.new("TextButton")
					local ImageLabel7 = Instance.new("ImageLabel")

					Instance.new("UIStroke")
					Instance.new("TextBox")
					Frame11.Name = "Dropdown"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					Frame11.BackgroundTransparency = 0
					Frame11.ClipsDescendants = true
					Frame11.Size = UDim2.new(0.94, 0, 0, 30)
					Frame11.ZIndex = 6

					local UIStroke3 = Instance.new("UIStroke")

					UIStroke3.Color = Color3.fromRGB(255, 255, 255)
					UIStroke3.Thickness = 1
					UIStroke3.Transparency = 0.95
					UIStroke3.Name = "UiToggle_UiStroke1"
					UIStroke3.Parent = Frame11
					UICorner9.CornerRadius = UDim.new(0, 3)
					UICorner9.Parent = Frame11

					function getpro()
						if p104 then
							if table.find(p103, p104) then
								p105(p104)

								return "   " .. p102 .. " : " .. p104
							else
								return "   " .. p102 .. " : "
							end
						else
							return "   " .. p102 .. " : "
						end
					end

					TextLabel8.Name = "DropTitle"
					TextLabel8.Parent = Frame11
					TextLabel8.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.Size = UDim2.new(0.9, 0, 0, 31)
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = getpro()
					TextLabel8.TextColor3 = Color3.fromRGB(225, 225, 225)
					TextLabel8.TextSize = 12
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel8.ZIndex = 6
					ScrollingFrame3.Name = "DropScroll"
					ScrollingFrame3.Parent = TextLabel8
					ScrollingFrame3.Active = true
					ScrollingFrame3.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
					ScrollingFrame3.BackgroundTransparency = 1
					ScrollingFrame3.BorderSizePixel = 0
					ScrollingFrame3.Position = UDim2.new(0, 0, 0, 31)
					ScrollingFrame3.Size = UDim2.new(0.99, 0, 0, 150)
					ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, 0)
					ScrollingFrame3.ScrollBarThickness = 20
					ScrollingFrame3.ZIndex = 6
					UIListLayout3.Parent = ScrollingFrame3
					UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout3.Padding = UDim.new(0, 5)
					UIPadding.Parent = ScrollingFrame3
					UIPadding.PaddingLeft = UDim.new(0, 5)
					UIPadding.PaddingTop = UDim.new(0, 5)
					ImageLabel7.Name = "DropImage"
					ImageLabel7.Parent = Frame11
					ImageLabel7.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.Position = UDim2.new(0.9, 0, 0, 6)
					ImageLabel7.Rotation = 180
					ImageLabel7.Size = UDim2.new(0, 20, 0, 20)
					ImageLabel7.Image = "rbxassetid://10734963191"
					ImageLabel7.ZIndex = 6
					TextButton2.Name = "DropButton"
					TextButton2.Parent = Frame11
					TextButton2.BackgroundColor3 = Color3.fromRGB(224, 224, 224)
					TextButton2.BackgroundTransparency = 1
					TextButton2.Size = UDim2.new(0.95, 0, 0, 31)
					TextButton2.Font = Enum.Font.GothamBold
					TextButton2.Text = ""
					TextButton2.TextColor3 = Color3.fromRGB(0, 0, 0)
					TextButton2.TextSize = 14
					TextButton2.ZIndex = 6

					local next_ = next
					local key = nil
					local u605 = false

					while true do
						local v606

						key, v606 = next_(p103, key)

						if key == nil then
							break
						end

						local TextButton3 = Instance.new("TextButton")

						TextButton3.Name = "Item"
						TextButton3.Parent = ScrollingFrame3
						TextButton3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
						TextButton3.BackgroundTransparency = 0
						TextButton3.Size = UDim2.new(0.99, 0, 0, 20)
						TextButton3.BorderSizePixel = 0
						TextButton3.Font = Enum.Font.GothamBold
						TextButton3.Text = tostring(v606)
						TextButton3.TextColor3 = Color3.fromRGB(225, 225, 225)
						TextButton3.TextSize = 13
						TextButton3.TextTransparency = 0
						TextButton3.ZIndex = 6
						UICorner10.CornerRadius = UDim.new(0, 4)
						UICorner10.Parent = TextButton3
						TextButton3.MouseEnter:Connect(function()
							TweenService:Create(TextButton3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								TextTransparency = 0
							}):Play()
						end)
						TextButton3.MouseLeave:Connect(function()
							TweenService:Create(TextButton3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								TextTransparency = 0.5
							}):Play()
						end)
						TextButton3.MouseButton1Click:Connect(function()
							u605 = false
							Frame11:TweenSize(UDim2.new(0.94, 0, 0, 30), "Out", "Quad", 0.3, true)
							TweenService:Create(ImageLabel7, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Rotation = 180
							}):Play()
							p105(TextButton3.Text)
							TextLabel8.Text = "   " .. p102 .. " : " .. TextButton3.Text
						end)
					end

					ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, UIListLayout3.AbsoluteContentSize.Y + 500)
					TextButton2.MouseButton1Click:Connect(function()
						if u605 ~= false then
							u605 = false
							Frame11:TweenSize(UDim2.new(0.94, 0, 0, 30), "Out", "Quad", 0.3, true)
							TweenService:Create(ImageLabel7, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Rotation = 180
							}):Play()
						else
							u605 = true
							Frame11:TweenSize(UDim2.new(0.94, 0, 0, 131), "Out", "Quad", 0.3, true)
							TweenService:Create(ImageLabel7, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Rotation = 0
							}):Play()
						end
					end)

					return {
						Add = function(_, p106)
							local TextButton3 = Instance.new("TextButton")

							TextButton3.Name = "Item"
							TextButton3.Parent = ScrollingFrame3
							TextButton3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
							TextButton3.BackgroundTransparency = 0
							TextButton3.Size = UDim2.new(0.99, 0, 0, 18)
							TextButton3.BorderSizePixel = 0
							TextButton3.Font = Enum.Font.GothamBold
							TextButton3.Text = tostring(p106)
							TextButton3.TextColor3 = Color3.fromRGB(225, 225, 225)
							TextButton3.TextSize = 13
							TextButton3.TextTransparency = 0
							TextButton3.ZIndex = 6

							local UICorner11 = Instance.new("UICorner")

							UICorner11.CornerRadius = UDim.new(0, 4)
							UICorner11.Parent = TextButton3
							TextButton3.MouseEnter:Connect(function()
								TweenService:Create(TextButton3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									TextTransparency = 0
								}):Play()
							end)
							TextButton3.MouseLeave:Connect(function()
								TweenService:Create(TextButton3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									TextTransparency = 0.5
								}):Play()
							end)
							TextButton3.MouseButton1Click:Connect(function()
								u605 = false
								Frame11:TweenSize(UDim2.new(0.94, 0, 0, 31), "Out", "Quad", 0.3, true)
								TweenService:Create(ImageLabel7, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Rotation = 180
								}):Play()
								p105(TextButton3.Text)
								TextLabel8.Text = "   " .. p102 .. " : " .. TextButton3.Text
							end)
						end,
						Clear = function(_)
							TextLabel8.Text = "   Refresh Successfully"
							TextLabel8.TextColor3 = Color3.fromRGB(0, 225, 0)
							wait(0.5)
							TextLabel8.Text = tostring("   " .. p102) .. " : "
							TextLabel8.TextColor3 = Color3.fromRGB(225, 225, 255)
							u605 = false
							Frame11:TweenSize(UDim2.new(0.94, 0, 0, 31), "Out", "Quad", 0.3, true)
							TweenService:Create(ImageLabel7, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Rotation = 180
							}):Play()

							local next_2 = next
							local children, key2 = ScrollingFrame3:GetChildren()

							while true do
								local v613

								key2, v613 = next_2(children, key2)

								if key2 == nil then
									break
								end

								if v613:IsA("TextButton") then
									v613:Destroy()
								end
							end
						end
					}
				end
				function t33.Slider(_, p107, p108, p109, p110, p111)
					local Frame11 = Instance.new("Frame")
					local TextLabel8 = Instance.new("TextLabel")
					local Frame12 = Instance.new("Frame")
					local TextBox = Instance.new("TextBox")
					local UICorner9 = Instance.new("UICorner")
					local Frame13 = Instance.new("Frame")
					local UICorner10 = Instance.new("UICorner")
					local Frame14 = Instance.new("Frame")
					local UICorner11 = Instance.new("UICorner")
					local Frame15 = Instance.new("Frame")
					local UICorner12 = Instance.new("UICorner")
					local t36 = {}

					Frame11.Name = "SliderFrame"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					Frame11.Position = UDim2.new(0.109489053, 0, 0.708609283, 0)
					Frame11.Size = UDim2.new(0.94, 0, 0, 40)
					Frame11.BackgroundTransparency = 0
					Frame11.ZIndex = 16

					local UIStroke3 = Instance.new("UIStroke")

					UIStroke3.Color = Color3.fromRGB(255, 255, 255)
					UIStroke3.Thickness = 1
					UIStroke3.Transparency = 0.95
					UIStroke3.Name = "UiToggle_UiStroke1"
					UIStroke3.Parent = Frame11

					local UICorner13 = Instance.new("UICorner")

					UICorner13.CornerRadius = UDim.new(0, 4)
					UICorner13.Parent = Frame11
					TextLabel8.Name = "LabelNameSlider"
					TextLabel8.Parent = Frame11
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.Position = UDim2.new(0.0229926974, 0, 0.0396823473, 0)
					TextLabel8.Size = UDim2.new(0, 182, 0, 25)
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = tostring(p107)
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextSize = 14
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					TextLabel8.ZIndex = 16
					Frame12.Name = "ShowValueFrame"
					Frame12.Parent = Frame11
					Frame12.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
					Frame12.BackgroundTransparency = 1
					Frame12.Position = UDim2.new(0.733576655, 0, 0.0656082779, 0)
					Frame12.Size = UDim2.new(0, 58, 0, 21)
					Frame12.ZIndex = 16
					TextBox.Name = "CustomValue"
					TextBox.Parent = Frame12
					TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
					TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					TextBox.Position = UDim2.new(0.7, 0, 0.5, 0)
					TextBox.Size = UDim2.new(0, 55, 0, 21)
					TextBox.Font = Enum.Font.GothamBold
					TextBox.Text = "50"
					TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextBox.TextSize = 11
					TextBox.ZIndex = 16
					UICorner9.CornerRadius = UDim.new(0, 4)
					UICorner9.Name = "ShowValueFrameUICorner"
					UICorner9.Parent = TextBox
					Frame13.Name = "ValueFrame"
					Frame13.Parent = Frame11
					Frame13.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame13.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					Frame13.Position = UDim2.new(0.5, 0, 0.8, 0)
					Frame13.Size = UDim2.new(0.85, 0, 0, 5)
					Frame13.ZIndex = 16
					UICorner10.CornerRadius = UDim.new(0, 30)
					UICorner10.Name = "ValueFrameUICorner"
					UICorner10.Parent = Frame13
					Frame14.Name = "PartValue"
					Frame14.Parent = Frame13
					Frame14.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame14.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
					Frame14.BackgroundTransparency = 1
					Frame14.Position = UDim2.new(0.5, 0, 0.8, 0)
					Frame14.Size = UDim2.new(0.85, 0, 0, 5)
					Frame14.ZIndex = 16
					UICorner11.CornerRadius = UDim.new(0, 30)
					UICorner11.Name = "PartValueUICorner"
					UICorner11.Parent = Frame14
					Frame15.Name = "MainValue"
					Frame15.Parent = Frame13
					Frame15.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
					Frame15.Size = UDim2.new((p110 or 0) / p109, 0, 0, 5)
					Frame15.BorderSizePixel = 0
					Frame15.ZIndex = 16
					UICorner12.CornerRadius = UDim.new(0, 30)
					UICorner12.Name = "MainValueUICorner"
					UICorner12.Parent = Frame15

					local Frame16 = Instance.new("Frame")

					Frame16.Name = "ConneValue"
					Frame16.Parent = Frame14
					Frame16.AnchorPoint = Vector2.new(0.7, 0.7)
					Frame16.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
					Frame16.Position = UDim2.new((p110 or 0) / p109, 0.5, 0.5, 0, 0)
					Frame16.Size = UDim2.new(0, 10, 0, 10)
					Frame16.BorderSizePixel = 0
					Frame16.ZIndex = 16

					local UICorner14 = Instance.new("UICorner")

					UICorner14.CornerRadius = UDim.new(0, 10)
					UICorner14.Parent = Frame16
					floor = true

					if floor ~= true then
						TextBox.Text = tostring(p110 and (math.floor(p110 / p109 * (p109 - p108) + p108) or 0) or 0)
					else
						TextBox.Text = tostring(p110 and (string.format(p110 / p109 * (p109 - p108) + p108) or 0) or 0)
					end

					local function v630(p112)
						local uDim2 = UDim2.new(math.clamp((p112.Position.X - Frame13.AbsolutePosition.X) / Frame13.AbsoluteSize.X, 0, 1), 0, 0.5, 0)

						Frame15:TweenSize(UDim2.new(math.clamp((p112.Position.X - Frame13.AbsolutePosition.X) / Frame13.AbsoluteSize.X, 0, 1), 0, 0, 5), "Out", "Sine", 0.2, true)
						Frame16:TweenPosition(uDim2, "Out", "Sine", 0.2, true)

						if floor ~= true then
							local v632 = math.floor(uDim2.X.Scale * p109 / p109 * (p109 - p108) + p108)

							TextBox.Text = tostring(v632)
							p111(v632)
						else
							local v633 = string.format("%.0f", uDim2.X.Scale * p109 / p109 * (p109 - p108) + p108)

							TextBox.Text = tostring(v633)
							p111(v633)
						end
					end

					local u634 = false

					Frame16.InputBegan:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end

						u634 = true
					end)
					Frame16.InputEnded:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end

						u634 = false
					end)
					Frame11.InputBegan:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end

						u634 = true
					end)
					Frame11.InputEnded:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end

						u634 = false
					end)
					Frame13.InputBegan:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end

						u634 = true
					end)
					Frame13.InputEnded:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
							return
						end

						u634 = false
					end)
					game:GetService("UserInputService").InputChanged:Connect(function(input)
						if not (u634 and input.UserInputType == Enum.UserInputType.MouseMovement) then
							return
						end

						v630(input)
					end)
					TextBox.FocusLost:Connect(function()
						if TextBox.Text == "" then
							TextBox.Text = p110
						end

						local v635, tostring_, Text, v638, tostring_2, Text2

						if p109 >= tonumber(TextBox.Text) then
							Frame15:TweenSize(UDim2.new((TextBox.Text or 0) / p109, 0, 0, 5), "Out", "Sine", 0.2, true)
							Frame16:TweenPosition(UDim2.new((TextBox.Text or 0) / p109, 0, 0.6, 0), "Out", "Sine", 0.2, true)

							if floor ~= true then
								v635 = TextBox
								tostring_ = tostring
								Text = TextBox.Text

								if Text then
									Text = math.floor(TextBox.Text / p109 * (p109 - p108) + p108)
								end

								v635.Text = tostring_(Text)
							else
								v638 = TextBox
								tostring_2 = tostring
								Text2 = TextBox.Text

								if Text2 then
									Text2 = string.format("%.0f", TextBox.Text / p109 * (p109 - p108) + p108)
								end

								v638.Text = tostring_2(Text2)
							end

							pcall(p111, TextBox.Text)

							return
						end

						TextBox.Text = p109
						Frame15:TweenSize(UDim2.new((TextBox.Text or 0) / p109, 0, 0, 5), "Out", "Sine", 0.2, true)
						Frame16:TweenPosition(UDim2.new((TextBox.Text or 0) / p109, 0, 0.6, 0), "Out", "Sine", 0.2, true)

						if floor ~= true then
							v635 = TextBox
							tostring_ = tostring
							Text = TextBox.Text

							if Text then
								Text = math.floor(TextBox.Text / p109 * (p109 - p108) + p108)
							end

							v635.Text = tostring_(Text)
						else
							v638 = TextBox
							tostring_2 = tostring
							Text2 = TextBox.Text

							if Text2 then
								Text2 = string.format("%.0f", TextBox.Text / p109 * (p109 - p108) + p108)
							end

							v638.Text = tostring_2(Text2)
						end

						pcall(p111, TextBox.Text)
					end)

					function t36.Update(_, p113)
						Frame15:TweenSize(UDim2.new((p113 or 0) / p109, 0, 0, 5), "Out", "Sine", 0.2, true)
						Frame16:TweenPosition(UDim2.new((p113 or 0) / p109, 0.5, 0.5, 0, 0), "Out", "Sine", 0.2, true)
						TextBox.Text = p113
						pcall(function()
							p111(p113)
						end)
					end

					return t36
				end

				local TweenService2 = game:GetService("TweenService")

				function t33.dROPDS(_, p114, p115, p116, p117)
					local t37 = {}
					local Frame11 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local Frame12 = Instance.new("Frame")
					local UICorner10 = Instance.new("UICorner")
					local TextLabel8 = Instance.new("TextLabel")
					local ImageButton3 = Instance.new("ImageButton")
					local ScrollingFrame3 = Instance.new("ScrollingFrame")
					local UIListLayout3 = Instance.new("UIListLayout")
					local UIPadding = Instance.new("UIPadding")
					local TextBox = Instance.new("TextBox")

					Frame11.Name = "MainDropDown"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					Frame11.BackgroundTransparency = 0.7
					Frame11.BorderSizePixel = 0
					Frame11.ClipsDescendants = true
					Frame11.Size = UDim2.new(0.94, 0, 0, 30)
					Frame11.ZIndex = 16

					local UIStroke3 = Instance.new("UIStroke")

					UIStroke3.Color = Color3.fromRGB(255, 255, 255)
					UIStroke3.Thickness = 1
					UIStroke3.Transparency = 0.95
					UIStroke3.Name = "UiToggle_UiStroke1"
					UIStroke3.Parent = Frame11
					UICorner9.CornerRadius = UDim.new(0, 4)
					UICorner9.Parent = Frame11
					Frame12.Name = "MainDropDown_2"
					Frame12.Parent = Frame11
					Frame12.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					Frame12.BackgroundTransparency = 0.7
					Frame12.BorderSizePixel = 0
					Frame12.ClipsDescendants = true
					Frame12.Size = UDim2.new(1, 0, 0, 30)
					Frame12.ZIndex = 16
					UICorner10.CornerRadius = UDim.new(0, 4)
					UICorner10.Parent = Frame12

					function getpro()
						if p116 then
							if table.find(p115, p116) then
								p117(p116)

								return p114 .. " : " .. p116
							else
								return p114 .. " : "
							end
						else
							return p114 .. " : "
						end
					end

					TextLabel8.Name = "Text"
					TextLabel8.Parent = Frame12
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.Position = UDim2.new(0, 10, 0, 10)
					TextLabel8.Size = UDim2.new(0, 62, 0, 12)
					TextLabel8.ZIndex = 16
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = getpro()
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextSize = 12
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					ImageButton3.Parent = Frame12
					ImageButton3.AnchorPoint = Vector2.new(0, 0.5)
					ImageButton3.BackgroundTransparency = 1
					ImageButton3.Position = UDim2.new(1, -25, 0.5, 0)
					ImageButton3.Size = UDim2.new(0, 12, 0, 12)
					ImageButton3.ZIndex = 16
					ImageButton3.Image = "http://www.roblox.com/asset/?id=10734963191"
					TextBox.Parent = Frame11
					TextBox.Size = UDim2.new(1, -20, 0, 30)
					TextBox.PlaceholderText = "  Search..."
					TextBox.TextColor3 = Color3.new(1, 1, 1)
					TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
					TextBox.BorderSizePixel = 1
					TextBox.Position = UDim2.new(0, 0.5, 0, 35)
					TextBox.ZIndex = 20
					TextBox.Visible = false
					TextBox.Text = ""
					TextBox.BorderSizePixel = 0
					TextBox.ClearTextOnFocus = false
					TextBox.Font = Enum.Font.GothamBold
					TextBox.TextWrapped = true
					TextBox.TextXAlignment = Enum.TextXAlignment.Left
					TextBox.TextSize = 10

					local UICorner11 = Instance.new("UICorner")

					UICorner11.CornerRadius = UDim.new(0, 4)
					UICorner11.Parent = TextBox

					local UIStroke4 = Instance.new("UIStroke")

					UIStroke4.Color = Color3.fromRGB(255, 255, 255)
					UIStroke4.Thickness = 1
					UIStroke4.Transparency = 0.95
					UIStroke4.Name = "UiToggle_UiStroke1"
					UIStroke4.Parent = TextBox
					ScrollingFrame3.Name = "Scroll_Items"
					ScrollingFrame3.Parent = Frame11
					ScrollingFrame3.Active = true
					ScrollingFrame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ScrollingFrame3.BackgroundTransparency = 1
					ScrollingFrame3.BorderSizePixel = 0
					ScrollingFrame3.ZIndex = 20
					ScrollingFrame3.Position = UDim2.new(0, 0, 0, 70)
					ScrollingFrame3.Size = UDim2.new(1, 0, 1, 500)
					ScrollingFrame3.ScrollBarThickness = 20
					UIListLayout3.Parent = ScrollingFrame3
					UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout3.Padding = UDim.new(0, 5)
					UIPadding.Parent = ScrollingFrame3
					UIPadding.PaddingLeft = UDim.new(0, 10)
					UIPadding.PaddingTop = UDim.new(0, 10)

					local u656 = false

					function t37.TogglePanel(_, p118)
						TweenService2:Create(Frame11, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = p118 and UDim2.new(0.92, 0, 0, 300) or UDim2.new(0.92, 0, 0, 30)
						}):Play()
						TweenService2:Create(ImageButton3, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Rotation = p118 and 180 or 0
						}):Play()
						TextBox.Visible = p118
					end

					ImageButton3.MouseButton1Click:Connect(function()
						u656 = not u656
						t37:TogglePanel(u656)
					end)

					function t37.Add(_, p119)
						local TextButton2 = Instance.new("TextButton")
						local UICorner12 = Instance.new("UICorner")

						TextButton2.Name = p119
						TextButton2.Parent = ScrollingFrame3
						TextButton2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
						TextButton2.BorderSizePixel = 0
						TextButton2.ClipsDescendants = true
						TextButton2.Size = UDim2.new(1, -10, 0, 25)
						TextButton2.ZIndex = 17
						TextButton2.AutoButtonColor = false
						TextButton2.Font = Enum.Font.GothamBold
						TextButton2.Text = p119
						TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextButton2.TextSize = 12
						UICorner12.CornerRadius = UDim.new(0, 4)
						UICorner12.Parent = TextButton2

						function t37.Clear(_)
							for _, child in pairs_(ScrollingFrame3:GetChildren()) do
								if child:IsA("TextButton") then
									child:Destroy()
									TextLabel8.TextColor3 = Color3.fromRGB(0, 255, 0)
									TextLabel8.Text = p114 .. " : Refresh Succesfully"
									wait(0.2)
									TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel8.Text = p114 .. " : ..."
								end
							end
						end

						TextButton2.MouseButton1Click:Connect(function()
							u656 = false
							t37:TogglePanel(false)
							p117(p119)
							TextLabel8.Text = p114 .. " : " .. p119
						end)
						ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, UIListLayout3.AbsoluteContentSize.Y + 20)
					end

					local v661 = UIListLayout3

					UIListLayout3.GetPropertyChangedSignal(v661, "AbsoluteContentSize"):Connect(function()
						ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, UIListLayout3.AbsoluteContentSize.Y + 20)
					end)

					local v662, v663, v664 = ipairs_(p115)
					local v665 = ScrollingFrame3
					local v666 = TextBox
					local v667 = t37

					while true do
						local v668

						v664, v668 = v662(v663, v664)

						if v664 == nil then
							break
						end

						v667:Add(v668)
					end

					v666:GetPropertyChangedSignal("Text"):Connect(function()
						local v669 = string.lower(v666.Text)

						for _, child in pairs_(v665:GetChildren()) do
							if child:IsA("TextButton") then
								child.Visible = string.find(string.lower(child.Name), v669) ~= nil
							end
						end
					end)

					return v667
				end
				function t33.Button(_, p120, p121)
					local v672 = p121 or function() end
					local Frame11 = Instance.new("Frame")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
					local Frame12 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local UIGradient3 = Instance.new("UIGradient")
					local TextLabel8 = Instance.new("TextLabel")

					Frame11.Name = "Button"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame11.BackgroundTransparency = 1
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.BorderSizePixel = 0
					Frame11.Size = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame11.ZIndex = 5
					UIAspectRatioConstraint4.Parent = Frame11
					UIAspectRatioConstraint4.AspectRatio = 11.5
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize
					Frame12.Name = "ButtonMainFrame"
					Frame12.Parent = Frame11
					Frame12.AnchorPoint = Vector2.new(0.5, 0)
					Frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame12.BorderSizePixel = 0
					Frame12.Position = UDim2.new(0.5, 0, 0, 0)
					Frame12.Size = UDim2.new(0.949999988, 0, 1, 0)
					Frame12.ZIndex = 6
					UICorner9.CornerRadius = UDim.new(0, 3)
					UICorner9.Parent = Frame12
					UIGradient3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t29.Config.MainColor), ColorSequenceKeypoint.new(1, t29.Config.DropColor) })
					UIGradient3.Rotation = 90
					UIGradient3.Parent = Frame12
					TextLabel8.Name = "Text"
					TextLabel8.Parent = Frame12
					TextLabel8.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextLabel8.Size = UDim2.new(1, 0, 0.600000024, 0)
					TextLabel8.ZIndex = 6
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p120 or "Sea Event"
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextScaled = false
					TextLabel8.TextSize = 14
					TextLabel8.TextWrapped = true

					local v679 = createTextButton(Frame12)

					v679.MouseButton1Down:Connect(function()
						TweenService2:Create(UIGradient3, TweenInfo.new(0.1), {
							Offset = Vector2.new(0, 1)
						}):Play()
					end)
					v679.MouseButton1Up:Connect(function()
						TweenService2:Create(UIGradient3, TweenInfo.new(0.1), {
							Offset = Vector2.new(0, 0)
						}):Play()
					end)
					v679.MouseButton1Click:Connect(v672)

					return {
						Text = function(_, ...)
							TextLabel8.Text = tostring(...)
						end,
						Fire = function(_, ...)
							v672(...)
						end,
						Delete = function(_)
							Frame11:Destroy()
							v515()
						end
					}
				end
				function t33.Slider1(_, p122, p123, p124, p125, p126)
					local t38 = {
						Min = p123 or 0,
						Max = p124 or 100
					}

					t38.Default = p125 or t38.Min

					local v681 = p126 or function() end
					local Frame11 = Instance.new("Frame")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
					local Frame12 = Instance.new("Frame")
					local TextLabel8 = Instance.new("TextLabel")
					local Frame13 = Instance.new("Frame")
					local UICorner9 = Instance.new("UICorner")
					local Frame14 = Instance.new("Frame")
					local UICorner10 = Instance.new("UICorner")
					local Frame15 = Instance.new("Frame")
					local UICorner11 = Instance.new("UICorner")
					local TextLabel9 = Instance.new("TextLabel")

					Frame11.Name = "Slider"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame11.BackgroundTransparency = 1
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.BorderSizePixel = 0
					Frame11.Size = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame11.ZIndex = 5
					UIAspectRatioConstraint4.Parent = Frame11
					UIAspectRatioConstraint4.AspectRatio = 12
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize
					Frame12.Name = "MainFrame"
					Frame12.Parent = Frame11
					Frame12.AnchorPoint = Vector2.new(0.5, 0)
					Frame12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame12.BackgroundTransparency = 1
					Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame12.BorderSizePixel = 0
					Frame12.Position = UDim2.new(0.5, 0, 0, 0)
					Frame12.Size = UDim2.new(0.949999988, 0, 1, 0)
					Frame12.ZIndex = 6
					TextLabel8.Name = "Text"
					TextLabel8.Parent = Frame12
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Position = UDim2.new(0.00999999978, 0, 0, 0)
					TextLabel8.Size = UDim2.new(0.959999979, 0, 0.5, 0)
					TextLabel8.ZIndex = 6
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p122 or "Slider"
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextScaled = true
					TextLabel8.TextSize = 14
					TextLabel8.TextWrapped = true
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					Frame13.Name = "System"
					Frame13.Parent = Frame12
					Frame13.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame13.BackgroundColor3 = Color3.fromRGB(76, 81, 82)
					Frame13.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame13.BorderSizePixel = 0
					Frame13.Position = UDim2.new(0.5, 0, 0.699999988, 0)
					Frame13.Size = UDim2.new(0.970000029, 0, 0.194999993, 0)
					Frame13.ZIndex = 6
					UICorner9.CornerRadius = UDim.new(1, 0)
					UICorner9.Parent = Frame13
					Frame14.Name = "Slide"
					Frame14.Parent = Frame13
					Frame14.BackgroundColor3 = t29.Config.MainColor
					Frame14.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame14.BorderSizePixel = 0
					Frame14.Size = UDim2.new(0.100000001, 0, 1, 0)
					Frame14.ZIndex = 8
					UICorner10.CornerRadius = UDim.new(1, 0)
					UICorner10.Parent = Frame14
					Frame15.Name = "Control"
					Frame15.Parent = Frame14
					Frame15.AnchorPoint = Vector2.new(0.5, 0.5)
					Frame15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame15.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame15.BorderSizePixel = 0
					Frame15.Position = UDim2.new(1, 0, 0.5, 0)
					Frame15.Size = UDim2.new(1.64999998, 0, 2.6500001, 0)
					Frame15.SizeConstraint = Enum.SizeConstraint.RelativeYY
					Frame15.ZIndex = 8
					UICorner11.CornerRadius = UDim.new(0.5, 0)
					UICorner11.Parent = Frame15
					TextLabel9.Name = "ValueText"
					TextLabel9.Parent = Frame12
					TextLabel9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel9.BackgroundTransparency = 1
					TextLabel9.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel9.BorderSizePixel = 0
					TextLabel9.Position = UDim2.new(0.6910429, 0, 0, 0)
					TextLabel9.Size = UDim2.new(0.27895698, 0, 0, 0)
					TextLabel9.ZIndex = 6
					TextLabel9.Font = Enum.Font.GothamBold
					TextLabel9.Text = tostring(t38.Default) .. tostring(t38.VALUE)
					TextLabel9.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel9.TextScaled = true
					TextLabel9.TextSize = 14
					TextLabel9.TextWrapped = true
					TextLabel9.TextXAlignment = Enum.TextXAlignment.Right
					TextLabel9.TextTransparency = 1
					TweenService2:Create(Frame14, TweenInfo.new(0.1), {
						Size = UDim2.fromScale(t38.Default / t38.Max, 1)
					}):Play()

					local u693 = false

					local function v694(p127)
						local v695 = math.clamp((p127.Position.X - Frame13.AbsolutePosition.X) / Frame13.AbsoluteSize.X, 0, 1)
						local v696 = math.floor((t38.Max - t38.Min) * v695 + t38.Min)
						local uDim2 = UDim2.fromScale(v695, 1)

						TextLabel9.Text = tostring(v696) .. tostring(t38.VALUE)
						TweenService2:Create(Frame14, TweenInfo.new(0.1), {
							Size = uDim2
						}):Play()
						v681(v696)
					end

					Frame12.InputBegan:Connect(function(input)
						if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
							return
						end

						u693 = true
						TweenService2:Create(TextLabel9, TweenInfo.new(0.1), {
							Size = UDim2.new(0.27895698, 0, 0.5, 0),
							TextTransparency = 0.1
						}):Play()
						v694(input)
					end)
					Frame12.InputEnded:Connect(function(input)
						if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
							return
						end

						u693 = false
					end)
					UserInputService2.InputChanged:Connect(function(input)
						if not (u693 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)) then
							return
						end

						v694(input)
					end)

					return {
						Text = function(_, ...)
							TextLabel8.Text = tostring(...)
						end,
						Value = function(_, p128)
							TextLabel9.Text = tostring(p128) .. tostring(t38.VALUE)
							v681(p128)
						end,
						Fire = function(_, ...)
							v681(...)
						end,
						Delete = function(_)
							TextButton:Destroy()
							v515()
						end
					}
				end
				function t33.Dropdown1(_, p129, _, p130, p131)
					local Frame11 = Instance.new("Frame")
					local UIAspectRatioConstraint4 = Instance.new("UIAspectRatioConstraint")
					local TextLabel8 = Instance.new("TextLabel")
					local UIAspectRatioConstraint5 = Instance.new("UIAspectRatioConstraint")
					local UIListLayout3 = Instance.new("UIListLayout")
					local Frame12 = Instance.new("Frame")
					local UIStroke3 = Instance.new("UIStroke")
					local UIGradient3 = Instance.new("UIGradient")
					local UICorner9 = Instance.new("UICorner")
					local Frame13 = Instance.new("Frame")
					local UIAspectRatioConstraint6 = Instance.new("UIAspectRatioConstraint")
					local ImageLabel7 = Instance.new("ImageLabel")
					local TextLabel9 = Instance.new("TextLabel")
					local UIGradient4 = Instance.new("UIGradient")
					local UIListLayout4 = Instance.new("UIListLayout")
					local ScrollingFrame3 = Instance.new("ScrollingFrame")
					local UIAspectRatioConstraint7 = Instance.new("UIAspectRatioConstraint")
					local UIListLayout5 = Instance.new("UIListLayout")
					local v716 = p131 or function() end

					v383(ScrollingFrame3)

					local function v717(p132)
						if typeof(p132) == "table" then
							local s31 = ""

							for _, v in ipairs_(p132) do
								s31 = s31 .. " " .. tostring(v) .. " ,"
							end

							return s31:sub(0, #s31 - 1)
						else
							return tostring(Default or "None")
						end
					end

					Frame11.Name = "Dropdown"
					Frame11.Parent = Frame8
					Frame11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame11.BackgroundTransparency = 1
					Frame11.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame11.BorderSizePixel = 0
					Frame11.Size = UDim2.new(0.980000019, 0, 0.5, 0)
					Frame11.ZIndex = 5
					UIAspectRatioConstraint4.Parent = Frame11
					UIAspectRatioConstraint4.AspectRatio = 6.5
					UIAspectRatioConstraint4.AspectType = Enum.AspectType.ScaleWithParentSize
					TextLabel8.Name = "Text"
					TextLabel8.Parent = Frame11
					TextLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.BackgroundTransparency = 1
					TextLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel8.BorderSizePixel = 0
					TextLabel8.Size = UDim2.new(0.959999979, 0, 0.5, 0)
					TextLabel8.ZIndex = 6
					TextLabel8.Font = Enum.Font.GothamBold
					TextLabel8.Text = p129 or "Select Gays"
					TextLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel8.TextScaled = true
					TextLabel8.TextSize = 14
					TextLabel8.TextWrapped = true
					TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
					UIAspectRatioConstraint5.Parent = TextLabel8
					UIAspectRatioConstraint5.AspectRatio = 22
					UIAspectRatioConstraint5.AspectType = Enum.AspectType.ScaleWithParentSize
					UIListLayout3.Parent = Frame11
					UIListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Center
					UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout3.Padding = UDim.new(0, 3)
					Frame12.Name = "DropFrame"
					Frame12.Parent = Frame11
					Frame12.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
					Frame12.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame12.BorderSizePixel = 0
					Frame12.ClipsDescendants = true
					Frame12.Position = UDim2.new(0.0200000405, 0, 0.373297691, 0)
					Frame12.Size = UDim2.new(0.959999979, 0, 0.550000012, 0)
					Frame12.ZIndex = 6
					UIStroke3.Color = Color3.fromRGB(37, 37, 37)
					UIStroke3.Parent = Frame12
					UIGradient3.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.68),
						NumberSequenceKeypoint.new(0.2, 0),
						NumberSequenceKeypoint.new(0.8, 0),
						NumberSequenceKeypoint.new(1, 0.67)
					})
					UIGradient3.Parent = UIStroke3
					UICorner9.CornerRadius = UDim.new(0, 2)
					UICorner9.Parent = Frame12
					Frame13.Name = "Header"
					Frame13.Parent = Frame12
					Frame13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Frame13.BackgroundTransparency = 1
					Frame13.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Frame13.BorderSizePixel = 0
					Frame13.Size = UDim2.new(0.925000012, 0, 1, 0)
					Frame13.ZIndex = 7
					UIAspectRatioConstraint6.Parent = Frame13
					UIAspectRatioConstraint6.AspectRatio = 12
					UIAspectRatioConstraint6.AspectType = Enum.AspectType.ScaleWithParentSize
					ImageLabel7.Name = "Icon"
					ImageLabel7.Parent = Frame13
					ImageLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ImageLabel7.BorderSizePixel = 0
					ImageLabel7.Position = UDim2.new(0.939999998, 0, 0.5, 0)
					ImageLabel7.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
					ImageLabel7.SizeConstraint = Enum.SizeConstraint.RelativeYY
					ImageLabel7.ZIndex = 7
					ImageLabel7.Image = "rbxassetid://7733717447"
					TextLabel9.Name = "SelectText"
					TextLabel9.Parent = Frame13
					TextLabel9.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel9.BackgroundTransparency = 1
					TextLabel9.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TextLabel9.BorderSizePixel = 0
					TextLabel9.Position = UDim2.new(0.437301666, 0, 0.499999493, 0)
					TextLabel9.Size = UDim2.new(0.864019156, 0, 0.550000012, 0)
					TextLabel9.ZIndex = 8
					TextLabel9.Font = Enum.Font.GothamBold
					TextLabel9.Text = v717(Default or "None")
					TextLabel9.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel9.TextScaled = true
					TextLabel9.TextSize = 14
					TextLabel9.TextTransparency = 0.5
					TextLabel9.TextWrapped = true
					TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
					UIGradient4.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.9, 0), NumberSequenceKeypoint.new(1, 1) })
					UIGradient4.Parent = TextLabel9
					UIListLayout4.Parent = Frame12
					UIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Center
					UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout4.Padding = UDim.new(0, 3)
					ScrollingFrame3.Parent = Frame12
					ScrollingFrame3.Active = true
					ScrollingFrame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ScrollingFrame3.BackgroundTransparency = 1
					ScrollingFrame3.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ScrollingFrame3.BorderSizePixel = 0
					ScrollingFrame3.Size = UDim2.new(1, 0, 5.6500001, 0)
					ScrollingFrame3.ZIndex = 6
					ScrollingFrame3.ScrollBarThickness = 0
					UIAspectRatioConstraint7.Parent = ScrollingFrame3
					UIAspectRatioConstraint7.AspectRatio = 1.95
					UIAspectRatioConstraint7.AspectType = Enum.AspectType.ScaleWithParentSize
					UIListLayout5.Parent = ScrollingFrame3
					UIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Center
					UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout5.Padding = UDim.new(0, 3)
					UIAspectRatioConstraint4:GetPropertyChangedSignal("AspectRatio"):Connect(v515)
					Frame12:GetPropertyChangedSignal("Size"):Connect(function()
						if Frame12.Size.Y.Scale < 0.85 then
							ScrollingFrame3.Visible = false
						else
							ScrollingFrame3.Visible = true
						end
					end)

					local function v721(p133)
						if p133 then
							TweenService2:Create(UIAspectRatioConstraint4, TweenInfo.new(0.3), {
								AspectRatio = 1.5
							}):Play()
							TweenService2:Create(Frame12, TweenInfo.new(0.3), {
								Size = UDim2.fromScale(0.96, 0.9)
							}):Play()
							TweenService2:Create(ImageLabel7, TweenInfo.new(0.3), {
								ImageColor3 = t29.Config.MainColor,
								Size = UDim2.new(0.959999976, 0, 0.959999976, 0)
							}):Play()
						else
							TweenService2:Create(UIAspectRatioConstraint4, TweenInfo.new(0.3), {
								AspectRatio = 6.5
							}):Play()
							TweenService2:Create(Frame12, TweenInfo.new(0.3), {
								Size = UDim2.fromScale(0.96, 0.55)
							}):Play()
							TweenService2:Create(ImageLabel7, TweenInfo.new(0.3), {
								ImageColor3 = Color3.fromRGB(255, 255, 255),
								Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
							}):Play()
						end
					end

					v721(false)

					local t39 = {}
					local u723 = false
					local v724 = typeof(t39) ~= "table" and { t39 } or t39

					local function v725(p134)
						local Frame14 = Instance.new("Frame")
						local UIAspectRatioConstraint8 = Instance.new("UIAspectRatioConstraint")
						local Frame15 = Instance.new("Frame")
						local UICorner10 = Instance.new("UICorner")
						local TextLabel10 = Instance.new("TextLabel")
						local Frame16 = Instance.new("Frame")
						local UICorner11 = Instance.new("UICorner")
						local ImageLabel8 = Instance.new("ImageLabel")
						local Frame17 = Instance.new("Frame")
						local UIGradient5 = Instance.new("UIGradient")
						local UICorner12 = Instance.new("UICorner")

						Frame14.Name = "DropdownObject"
						Frame14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Frame14.BackgroundTransparency = 1
						Frame14.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Frame14.BorderSizePixel = 0
						Frame14.Size = UDim2.new(0.980000019, 0, 0.5, 0)
						Frame14.ZIndex = 5
						UIAspectRatioConstraint8.Parent = Frame14
						UIAspectRatioConstraint8.AspectRatio = 11.5
						UIAspectRatioConstraint8.AspectType = Enum.AspectType.ScaleWithParentSize
						Frame15.Name = "MainFrame"
						Frame15.Parent = Frame14
						Frame15.AnchorPoint = Vector2.new(0.5, 0)
						Frame15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Frame15.BackgroundTransparency = 1
						Frame15.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Frame15.BorderSizePixel = 0
						Frame15.Position = UDim2.new(0.409999996, 0, 0, 0)
						Frame15.Size = UDim2.new(0.800000012, 0, 1, 0)
						Frame15.ZIndex = 6
						UICorner10.CornerRadius = UDim.new(0, 3)
						UICorner10.Parent = Frame15
						TextLabel10.Name = "Text"
						TextLabel10.Parent = Frame15
						TextLabel10.AnchorPoint = Vector2.new(0.5, 0.5)
						TextLabel10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						TextLabel10.BackgroundTransparency = 1
						TextLabel10.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextLabel10.BorderSizePixel = 0
						TextLabel10.Position = UDim2.new(0.75, 0, 0.5, 0)
						TextLabel10.Size = UDim2.new(1.12300003, 0, 0.524999976, 0)
						TextLabel10.ZIndex = 6
						TextLabel10.Font = Enum.Font.GothamBold
						TextLabel10.Text = tostring(p134)
						TextLabel10.TextColor3 = Color3.fromRGB(255, 255, 255)
						TextLabel10.TextScaled = true
						TextLabel10.TextSize = 14
						TextLabel10.TextWrapped = true
						TextLabel10.TextXAlignment = Enum.TextXAlignment.Left
						Frame16.Name = "System"
						Frame16.Parent = Frame15
						Frame16.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame16.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
						Frame16.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Frame16.BorderSizePixel = 0
						Frame16.Position = UDim2.new(0.109999999, 0, 0.5, 0)
						Frame16.Size = UDim2.new(0.824999988, 0, 0.824999988, 0)
						Frame16.SizeConstraint = Enum.SizeConstraint.RelativeYY
						Frame16.ZIndex = 6
						UICorner11.CornerRadius = UDim.new(0, 3)
						UICorner11.Parent = Frame16
						ImageLabel8.Name = "TurnOn"
						ImageLabel8.Parent = Frame16
						ImageLabel8.AnchorPoint = Vector2.new(0.5, 0.5)
						ImageLabel8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						ImageLabel8.BackgroundTransparency = 1
						ImageLabel8.BorderColor3 = Color3.fromRGB(0, 0, 0)
						ImageLabel8.BorderSizePixel = 0
						ImageLabel8.Position = UDim2.new(0.5, 0, 0.5, 0)
						ImageLabel8.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
						ImageLabel8.ZIndex = 7
						ImageLabel8.Image = "rbxassetid://3944680095"
						ImageLabel8.ImageColor3 = Color3.fromRGB(0, 0, 0)
						ImageLabel8.ImageTransparency = 1
						Frame17.Name = "Box"
						Frame17.Parent = Frame16
						Frame17.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Frame17.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Frame17.BorderSizePixel = 0
						Frame17.Position = UDim2.new(0.5, 0, 0.5, 0)
						Frame17.ZIndex = 6
						UIGradient5.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, t29.Config.MainColor), ColorSequenceKeypoint.new(1, t29.Config.DropColor) })
						UIGradient5.Rotation = 45
						UIGradient5.Parent = Frame17
						UICorner12.CornerRadius = UDim.new(0, 4)
						UICorner12.Parent = Frame17

						return Frame14, function(p135)
							if p135 then
								TweenService2:Create(ImageLabel8, TweenInfo.new(0.4), {
									ImageTransparency = 0
								}):Play()
								TweenService2:Create(Frame17, TweenInfo.new(0.3), {
									Size = UDim2.fromScale(1, 1)
								}):Play()
								TweenService2:Create(ImageLabel8, TweenInfo.new(0.55), {
									ImageColor3 = t29.Config.MainColor
								}):Play()
							else
								TweenService2:Create(ImageLabel8, TweenInfo.new(0.4), {
									ImageTransparency = 1
								}):Play()
								TweenService2:Create(Frame17, TweenInfo.new(0.3), {
									Size = UDim2.fromScale(0, 0)
								}):Play()
								TweenService2:Create(ImageLabel8, TweenInfo.new(0.555), {
									ImageColor3 = Color3.fromRGB(0, 0, 0)
								}):Play()
							end
						end
					end
					local function v737()
						for _, child in ipairs_(ScrollingFrame3:GetChildren()) do
							if child:IsA("Frame") then
								child:Destroy()
							end
						end

						ScrollingFrame3:SetAttribute("Key", tostring(math.random(1, 1000)))

						for k, v in pairs_(DropdownInfo) do
							local v742, v743 = v725(tostring(v))
							local u744 = false
							local n7 = 0

							v742.Parent = ScrollingFrame3

							if k == Default or v == Default then
								v743(true)
								table.insert(v724, v)
								u744 = true
							else
								v743(false)
							end

							createTextButton(v742).MouseButton1Click:Connect(function()
								u744 = not u744

								if u744 then
									if not (p130 >= #v724 + 1) then
										u744 = not u744

										return
									end

									if table.find(v724, v) then
										v743(u744)
										TextLabel9.Text = v717(v724)
										v716(v724, v)

										return
									end

									table.insert(v724, v)
									n7 = #v724
								else
									for k2, v2 in ipairs_(v724) do
										if v2 == v then
											table.remove(v724, k2)
										end
									end
								end

								v743(u744)
								TextLabel9.Text = v717(v724)
								v716(v724, v)
							end)
						end
					end

					v737()
					createTextButton(Frame13).MouseButton1Click:Connect(function()
						u723 = not u723
						v721(u723)
					end)

					return {
						Text = function(_, ...)
							TextLabel8.Text = tostring(...)
						end,
						Refresh = function(_, p136)
							DropdownInfo = p136
							v737()
						end,
						Fire = function(_, ...)
							v716(...)
						end,
						Delete = function(_)
							TextButton:Destroy()
							v515()
						end
					}
				end

				return t33
			end

			return t32
		end

		return t31
	end

	return t30
end

local executorName = "Unknown"
pcall(function()
	executorName = identifyexecutor and identifyexecutor() or "Unknown"
end)
if executorName == "Solara" then
	executorName = "Solara - Some functions may not work like fast attack etc.."
end
local name = "King Legacy"
pcall(function()
	name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)
-- loadstring remote disabled for safety
_G.Title = name
-- Fixed: do not overwrite LocalPlayer player reference; use Window var
local Window = t29:NewWindow("", "Executor : " .. tostring(executorName), "rbxassetid://115426623977608"):AddMenu("", "Game : " .. name .. "   Version : Akuma", "ticket", "tab")
LocalPlayer = Window  -- UI library returns window object; original reused the name
t27 = LocalPlayer:AddTab("Configs Farm", 10734950020, "distance,bringmob")
v346 = LocalPlayer:AddTab("Main Farm", 6035153656, "farm,bossess,etc.")
v59 = LocalPlayer:AddTab("Halloween Event", 6034467796, "farm,bossess,etc.")
Players = LocalPlayer:AddTab("World Bosses", 15557776256, "farm,bossess,etc.")

local v748 = LocalPlayer:AddTab("Sea Event", 6034754442, "farm,bossess,etc.")
local v749 = LocalPlayer:AddTab("Local Player", 14477563495, "auto stats melee,sword,fruit")
local v750 = LocalPlayer:AddTab("Travel Seas", 14477598542, "teleport sea,hop")
local Shops = LocalPlayer:AddTab("Shops", 14477621526, "auto buy sword,fruit")
local Dungeon = LocalPlayer:AddTab("Dungeon", 14477517268, "auto raid,autoskill")

LocalPlayer = LocalPlayer:AddTab("Misc", 14477663692, "other,config")

local v753 = v749:AddSection("", "Auto Stats", "auto add melee,fruit,sword stats", "rbxassetid://14477563495")

v749 = v749:AddSection("", "Player Combat", "auto kill player,spectate etc..", "rbxassetid://14477563495")

local v754 = v750:AddSection("", "World", "travel first, second, third sea", "rbxassetid://14477598542")

v750 = v750:AddSection("", "Seas", "travel island and npc in any sea", "rbxassetid://14477598542")

local v755 = Shops:AddSection("", "Fruit Shop", "auto buy key, auto open,", "rbxassetid://14477621526")

Shops = Shops:AddSection("", "Others", "auto teleport to abilities shops", "rbxassetid://14477621526")
Dungeon = Dungeon:AddSection("", "Auto Raid", "auto farm raid, auto kill mob", "rbxassetid://14477517268")

local v756 = LocalPlayer:AddSection("", "Misc", "Bost fps,hide ui,destroy", "rbxassetid://14477663692")

LocalPlayer = LocalPlayer:AddSection("", "Esp", "esp player, islands, ghostship,etc..", "rbxassetid://14477663692")

local Players2 = game:GetService("Players")
local LocalPlayer4 = Players2.LocalPlayer
local Parent = script.Parent

Parent = select(2, Players2:GetUserThumbnailAsync(LocalPlayer4.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420))

local thread = nil

function Toggle(p137, p138, ...)
	local v761, v762 = ...
	local v764

	if v762 or type(v761) ~= "function" then
		v764 = v761
		v761 = v762
	else
		v764 = nil
	end

	if not v764 then
		v764, v761 = ...
	end

	return p138:AddToggle(p137, _G.Settings[v764] or false, v761 or function(p139)
		_G.Settings[v764] = p139
		SaveSettings()
		if p139 then
			if t16[v764] then
				thread = task.spawn(t16[v764])
			else
				warn("Toggle: no function t16." .. tostring(v764))
			end
		else
			if thread then
				pcall(task.cancel, thread)
				thread = nil
			end
			NeedNoClip = false
		end
	end)
end
function Dropdown(p140, p141, p142, ...)
	local v765, v766 = ...

	if not v766 and type(v765) == "function" then
		v765 = nil
	end

	if not v765 then
		local v768

		v765, v768 = ...
	end

	return p142:AddDropdown(p140, p141, _G.Settings[v765], function(p143)
		_G.Settings[v765] = p143
		SaveSettings()
	end)
end
function AddMultiDropdown(p144, p145, p146, ...)
	local v769, v770 = ...

	if not v770 and type(v769) == "function" then
		v769 = nil
	end

	if not v769 then
		local v772

		v769, v772 = ...
	end

	return p146:MultiDropdown(p144, _G.Settings[v769], p145, function(p147)
		_G.Settings[v769] = p147
		SaveSettings()
	end)
end
function Label(p148, p149, p150)
	if p150 then
		return p149:AddLabel(p148)
	else
		return p149:AddLabel(Name)
	end
end

LoadSettings()

-- Fixed: keep myWeapon and _G.Weapon updated
task.spawn(function()
	while task.wait(2) do
		pcall(function()
			if not Client or not Client.Character then return end
			for _, child in pairs(Client.Character:GetChildren()) do
				if child:IsA("Tool") then
					local tip = child.ToolTip
					if tip == "Combat" or tip == "Melee" then
						myWeapon.Melee = child.Name
						if _G.Settings.Select_Weapon == "Melee" then _G.Weapon = child.Name end
					elseif tip == "Sword" then
						myWeapon.Sword = child.Name
						if _G.Settings.Select_Weapon == "Sword" then _G.Weapon = child.Name end
					elseif tip == "Fruit Power" then
						myWeapon.Fruit = child.Name
						myWeapon["Fruit Power"] = child.Name
						if _G.Settings.Select_Weapon == "Fruit" then _G.Weapon = child.Name end
					end
				end
			end
			for _, child in pairs(Client.Backpack:GetChildren()) do
				if child:IsA("Tool") then
					local tip = child.ToolTip
					if tip == "Combat" or tip == "Melee" then
						myWeapon.Melee = child.Name
					elseif tip == "Sword" then
						myWeapon.Sword = child.Name
					elseif tip == "Fruit Power" then
						myWeapon.Fruit = child.Name
						myWeapon["Fruit Power"] = child.Name
					end
				end
			end
		end)
	end
end)

Parent = v346:AddSection("", "Main Farming", "auto farm leve, materials, auto 1/2 sea", "rbxassetid://10734975692")

local v773 = Parent:AddLabel("Auto Farming: Inactive")
local v774 = Parent:AddLabel("Quest: N/A")
local v775 = Parent:AddLabel("Health: N/A")

local function v776()
	if v773 then
		v773:Set(_G.LabelAutoFarm or "Auto Farming: Inactive")
	end

	if v774 then
		v774:Set(_G.Questname)
	end

	if not v775 then
		return
	end

	v775:Set(_G.LabelHealth or "Health: N/A")
end

task.spawn(function()
	while task.wait(0.5) do
		v776()
	end
end)

local function v777(p151)
	local LocalPlayer5 = game.Players.LocalPlayer

	if LocalPlayer5 and (LocalPlayer5.Backpack and LocalPlayer5.Character) and LocalPlayer5.Character:FindFirstChild("Humanoid") then
		local v779 = LocalPlayer5.Backpack:FindFirstChild(p151)

		if v779 then
			LocalPlayer5.Character.Humanoid:EquipTool(v779)
		else
			warn("Tool not found in Backpack: " .. p151)
		end
	else
		warn("Player, Character, or Humanoid not available.")
	end
end

Toggle("Auto Farm Level", Parent, "Auto_Farm_Level1")
Toggle("Auto Farm Near", Parent, "Auto_Farm_Nearest_Mob")

if Sea1 then
	Toggle("Auto Second Sea [Lv. 2250]", Parent, "Auto_Sea21")
elseif Sea2 then
	Toggle("Auto Third World [Lv. 4000]", Parent, "Auto_Sea31")
	Toggle("Auto Haki V2", Parent, "auto_hakiv2")
	Toggle("Auto Observation V2", Parent, "AUTOOBSERVE2")
end

Parent:AddSeperator("Boss Farm")
Parent:AddDropdown("Select Boss", v58, "", function(p152)
	selectedBoss = p152
end)
Toggle("Auto Farm Boss", Parent, "autofarmbosses")
Parent:AddSeperator("Material Farm")
Parent:AddDropdown("Select Material", v345, "", function(p153)
	SelectMaterial = p153
	MaterialMon()
end)
Toggle("Auto Farm Materials", Parent, "AutoFarmMaterial")
Parent:AddSeperator("Accessories")
LocalPlayer4, v346, v345 = ipairs_(game:GetService("Players").LocalPlayer:WaitForChild("Accessories"):GetChildren())
v58 = {}

while true do
	v345, v1038 = LocalPlayer4(v346, v345)

	if v345 == nil then
		break
	end

	table.insert(v58, v1038.Name)
end

Parent:AddDropdown("Select Accessory", v58, "", function(p154)
	_G.selectedAccessory = p154
end)
Parent:AddToggle("Auto Equip Selected Accessory", _G.autoEquipAccessory, function(p155)
	_G.autoEquipAccessory = p155

	if not p155 then
		return
	end

	spawn(function()
		while _G.autoEquipAccessory do
			if _G.selectedAccessory then
				local t40 = { _G.selectedAccessory }

				game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("AccessoryEq"):InvokeServer(unpack(t40))
			end

			wait(1)
		end
	end)
end)
Parent:AddSeperator("Passive Tree")

local v781 = Parent:AddLabel("Status : " .. _G.redcircle)

task.spawn(function()
	while true do
		task.wait(1)

		local NPC = game:GetService("ReplicatedStorage"):FindFirstChild("NPC")

		if NPC then
			NPC = game:GetService("ReplicatedStorage").NPC:FindFirstChild("PassiveTree")
		end

		if NPC then
			v781:Set("Check PassiveTree: " .. _G.greencircle)
		else
			v781:Set("Check PassiveTree: " .. _G.redcircle)
		end
	end
end)
Parent:AddToggle("Teleport Passive", false, function(p156)
	_G.autopassive = p156
end)
spawn(function()
	while true do
		local PassiveTree = _G.autopassive and workspace:WaitForChild("AllNPC"):WaitForChild("PassiveTree")

		if PassiveTree then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = PassiveTree.CFrame
		end

		wait(1)
	end
end)
Parent:AddToggle("Auto Hop", false, function(_)
	Serverhop()
end)
Parent:AddSeperator("Codes")

local function v784(p157)
	game:GetService("ReplicatedStorage").Chest.Remotes.Functions.redeemcode:InvokeServer(unpack({ p157 }))
end

Parent:AddDropdown("Select Code", {
	"IslandQuestRepeat",
	"X100KSuccess",
	"FruitAwakeningTime",
	"Halloween2024",
	"Update7.1",
	"DragonColorRefund",
	"PlayKingLegacyFor5Gems",
	"RainbowDragon",
	"<3LEEPUNGG",
	"Update7.0.4",
	"SKGames",
	"PassiveMaster",
	"InfernoKingAwaits",
	"Update7Release",
	"TelekinesisFruitPower",
	"EpicAdventure",
	"WELCOMETOKINGLEGACY",
	"FREESTATSRESET",
	"DinoxLive",
	"2MFAV",
	"Peodiz"
}, "IslandQuestRepeat", function(p158)
	_G.SelectedCode = p158
	print("Selected Code:", _G.SelectedCode)
end)
Parent:AddToggle("Use Selected Code", false, function(p159)
	_G.Settings.UseCode = p159
	print("Use Selected Code:", _G.Settings.UseCode)

	if not (_G.Settings.UseCode and _G.SelectedCode) then
		return
	end

	v784(_G.SelectedCode)
end)

local Settings = v59:AddSection("", "Halloween Event", "auto farm cady any sea auto spawn bosses", "rbxassetid://6034684949")
local v786 = Settings:AddLabel("Total Candy : ")

spawn(function()
	while task.wait(0.1) do
		local Value = Client:FindFirstChild("PlayerStats") and (Client.PlayerStats:FindFirstChild("Material") and (Client.PlayerStats.Material:FindFirstChild("Candy") and Client.PlayerStats.Material.Candy.Value)) or getPlayerMaterial("Candy")

		if Value then
			v786:Set("Total Candy : " .. tostring(Value))
		else
			v786:Set("Total Candy : N/A")
		end
	end
end)

local v788 = Settings:AddLabel("Status : " .. _G.redcircle)

task.spawn(function()
	while task.wait(1) do
		v788:Set(v350.find({ "Skull King" }) and "Check Skull King Mon: " .. _G.greencircle or "Check Skull King Mon: " .. _G.redcircle)
	end
end)

local v789 = Settings:AddLabel("Status : " .. _G.redcircle)

task.spawn(function()
	while task.wait(1) do
		v789:Set(v350.find({ "Jack o lantern [Lv. 10000]" }) and "Check Jack O Lantern Mon: " .. _G.greencircle or "Check Jack O Lantern Mon: " .. _G.redcircle)
	end
end)
Toggle("Auto Farm Candy", Settings, "auto_farm_candy")
Toggle("Auto Kill Jack O Lantern", Settings, "auto_jacko")
Toggle("Auto Third Event Bosses", Settings, "auto_third_event")
Toggle("Auto Summon Jack O Lantern [50 Candy]", Settings, "auto_jacko")
Toggle("Auto Kill Skull King", Settings, "auto_skull")
Settings = Players:AddSection("", "Main Bosses", "auto farm cady any sea auto spawn bosses", "rbxassetid://6034684949")
Settings:AddSeperator("Server Hop")
Settings:MultiDropdown("Select World Boss to Hop", {
	v348("Jack o lantern [Lv. 10000]"),
	v348("King Samurai [Lv. 3500]"),
	v348("Dragon [Lv. 5000]"),
	v348("Ms. Mother [Lv. 7500]"),
	v348("Lord of Saber [Lv. 8500]"),
	v348("Bushido Ape [Lv. 5000]")
}, _G.Settings.selectbosss or {}, function(p160)
	_G.Settings.selectbosss = p160
	print("Selected entities: ", table.concat(_G.Settings.selectbosss or {}, ", "))
	SaveSettings()
end)
Toggle("Auto Hop Until Found World Boss", Settings, "auto_hop_boss")
Settings:Slider("Hop Delay (seconds)", 0, 60, _G.Settings.HopDelay or 15, function(p161)
	_G.Settings.HopDelay = p161
	SaveSettings()
end)
Settings:AddSeperator("Minion")

local v790 = Settings:AddLabel("Status : " .. _G.redcircle)

task.spawn(function()
	while task.wait(1) do
		v790:Set(v350.find({ "Minion", "Boss" }) and "Check Minion Mon: " .. _G.greencircle or "Check Minion Mon: " .. _G.redcircle)
	end
end)
Toggle("Auto Kill Minion", Settings, "Auto_Kill_Minion1")
Settings:AddToggle("Auto Hop Minion", false, function(_)
	HopServer()
end)

if Sea1 then
	Settings:AddSeperator("Saber")

	local v791 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v791:Set(v350.find({ "Expert Swordman [Lv. 3000]" }) and "Check Expert Swordman Mon: " .. _G.greencircle or "Check Expert Swordman Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Expert Swordman", Settings, "Auto_Expert_Swordman1")
end

if Sea2 then
	Settings:AddSeperator("Kaido Boss")

	local v792 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v792:Set(v350.find({ "Dragon [Lv. 5000]" }) and "Check Dragon Mon: " .. _G.greencircle or "Check Dragon Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Fully Kaido", Settings, "Auto_Kill_Kaido1")
	Toggle("Auto Summon Kaido", Settings, "Auto_Spawn_Kaido")
	Settings:AddToggle("Auto Hop Kaido", false, function(_)
		Serverhop()
	end)
	Settings:AddSeperator("Big Mom")

	local v793 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v793:Set(v350.find({ "Ms. Mother [Lv. 7500]" }) and "Check BigMom Mon: " .. _G.greencircle or "Check BigMom Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill BigMom", Settings, "Auto_Kill_BigMom")
	Settings:AddToggle("Auto Big Mom Hop", false, function(_)
		Serverhop()
	end)
	Settings:AddSeperator("King Samurai")

	local v794 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v794:Set(v350.find({ "King Samurai [Lv. 3500]" }) and "Check King Samurai Mon: " .. _G.greencircle or "Check King Samurai Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill King Samurai", Settings, "King_Samurai")
	Settings:AddToggle("Auto King Samurai Hop", false, function(_)
		Serverhop()
	end)
end

if Sea3 then
	Settings:AddSeperator("Lord Of Saber")

	local v795 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v795:Set(v350.find({ "Lord of Saber [Lv. 8500]" }) and "Check Lord Of Saber Mon: " .. _G.greencircle or "Check Lord Of Saber Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Lord of Saber", Settings, "auto_lordsaber")
	Settings:AddToggle("Auto Hop Lord of Saber", false, function(_)
		Serverhop()
	end)
	Settings:AddSeperator("Bushido Ape")

	local v796 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v796:Set(v350.find({ "Bushido Ape [Lv. 5000]" }) and "Check Bushido Ape Mon: " .. _G.greencircle or "Check Bushido Ape Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Bushido Ape", Settings, "auto_bushido")
	Settings:AddToggle("Auto Hop Bushido Ape", false, function(_)
		Serverhop()
	end)
end

if Sea1 then
	_G.sesas = "First Sea"
elseif Sea2 then
	_G.sesas = "Second Sea"
elseif Sea3 then
	_G.sesas = "Third Sea"
end

Settings = v748:AddSection("", _G.sesas .. " Event", "auto kill sea event bosses in any sea!", "http://www.roblox.com/asset/?id=6035078898")

if Sea1 then
	Settings:AddLabel("No Sea Event on First Sea!!")
end

Settings:AddSeperator("Server Hop")
Settings:MultiDropdown("Select Sea Monster to Hop", {
	v347("SeaDragon"),
	v347("FuryTentacle"),
	v347("ThirdSeaEldritch Crab"),
	v347("ThirdSeaDragon"),
	v347("Skull King"),
	v347("SeaKing"),
	v347("HydraSeaKing"),
	v347("Ghost Ship")
}, _G.Settings.SelectedEntities or {}, function(p162)
	_G.Settings.SelectedEntities = p162
	print("Selected entities: ", table.concat(p162, ", "))
	SaveSettings()
end)
Toggle("Auto Hop Until Found Sea Monster", Settings, "auto_hop")
Settings:Slider("Hop Delay (seconds)", 0, 60, _G.Settings.HopDelay or 15, function(p163)
	_G.Settings.HopDelay = p163
	SaveSettings()
end)

if Sea2 then
	local function v797(p164, p165, p166)
		return string.format("%02dh %02dm %02ds", tonumber(p164), tonumber(p165), tonumber(p166))
	end
	local function v798()
		local SeaKing = game:GetService("Workspace").SeaMonster:FindFirstChild("SeaKing")

		if SeaKing and SeaKing:FindFirstChild("Humanoid") then
			local Humanoid = SeaKing.Humanoid
			local v801 = Humanoid.Health / Humanoid.MaxHealth * 100

			return string.format("✅ %d / %d HP (%.0f%%)", math.floor(Humanoid.Health), math.floor(Humanoid.MaxHealth), v801)
		else
			return "❌ 0 / 0 HP (0%)"
		end
	end
	local function v802()
		local GhostMonster = game.Workspace:FindFirstChild("GhostMonster")
		local s32 = "❌ 0 / 0 HP (0%)"

		if not GhostMonster then
			return s32
		end

		for _, child in pairs_(GhostMonster:GetChildren()) do
			if child:IsA("Model") and child:FindFirstChild("Humanoid") then
				local Humanoid = child.Humanoid
				local v808 = Humanoid.Health / Humanoid.MaxHealth * 100

				s32 = string.format("✅ %d / %d HP (%.0f%%)", math.floor(Humanoid.Health), math.floor(Humanoid.MaxHealth), v808)
			end
		end

		return s32
	end

	Settings:AddSeperator("Sea King")

	local v809 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v809:Set(v350.find({ "SeaKing" }) and "Check Sea king Mon: " .. _G.greencircle or "Check Sea King Mon: " .. _G.redcircle)
		end
	end)

	local v810 = Settings:AddLabel("HP : N/A")
	local v811 = Settings:AddLabel("Next Spawn : N/A")

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				v810:Set("HP : " .. v798())

				local attribute = game:GetService("ReplicatedStorage"):GetAttribute("SeaMonsterSpawnText")

				if attribute and attribute:match("^(%d+):(%d+):(%d+)$") then
					local match, v814, v815 = attribute:match("(%d+):(%d+):(%d+)")

					v811:Set("Next Spawn : " .. v797(match, v814, v815))
				else
					v811:Set("Next Spawn : " .. Formatted_SeaKingTime)
				end
			end)
		end
	end)
	Toggle("Auto Kill Sea King", Settings, "Auto_Kill_Sea_King1")
	Settings:AddSeperator("Hydra Boss")

	local v816 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v816:Set(v350.find({ "HydraSeaKing" }) and "Check Hydra Sea King Mon: " .. _G.greencircle or "Check Hydra Sea King Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Hydra Boss", Settings, "Auto_Kill_Hydar_Sea_King1")
	Settings:AddSeperator("Ghost Ship")

	local v817 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v817:Set(v350.find({ "Ghost Ship" }) and "Check Ghost Ship Mon: " .. _G.greencircle or "Check Ghost Ship Mon: " .. _G.redcircle)
		end
	end)

	local v818 = Settings:AddLabel("HP : N/A")
	local v819 = Settings:AddLabel("Next Spawn : N/A")

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				v818:Set("HP : " .. v802())

				local attribute = game:GetService("ReplicatedStorage"):GetAttribute("GhostShipSpawnText")

				if attribute and attribute:match("^(%d+):(%d+):(%d+)$") then
					local match, v822, v823 = attribute:match("(%d+):(%d+):(%d+)")

					v819:Set("Next Spawn : " .. v797(match, v822, v823))
				else
					v819:Set("Next Spawn : N/A")
				end
			end)
		end
	end)
	Toggle("Auto Attack Ghost Ship", Settings, "Auto_Kill_GhostMonster1")
end

if Sea3 then
	local v824 = Settings:AddLabel("🌑 Blood Moon Status: ")
	local n8 = 3
	local n9 = 6

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				local match, v828, v829 = game:GetService("Lighting").TimeOfDay:match("^(%d+):(%d+):(%d+)$")
				local v830 = tonumber(match)
				local v831 = tonumber(v828)
				local v832 = tonumber(v829)
				local attribute = game:GetService("Lighting"):GetAttribute("Day") or 1

				if attribute == n8 and n9 <= v830 then
					local v834 = v830 - n9

					v824:Set(string.format("🌑 Blood Moon Starting In: %02dH:%02dM:%02dS", v834, v831, v832))
				else
					local v835 = n8 - attribute

					if v835 < 0 then
						v835 = v835 + 7
					end

					local v836 = v835 * 24 + (n9 - v830 - 1)

					if v836 < 0 then
						v836 = v836 + 24
					end

					local v837 = 59 - v831

					if 59 - v832 == 59 then
						v837 = v837 + 1
					end

					v824:Set(string.format("🌑 Blood Moon Active: %02dH:%02dM:%02dS", math.floor(v836 / 24), v836 % 24, v837))
				end
			end)
		end
	end)

	local v838 = Settings:AddLabel("Next Spawn: N/A")

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				local attribute = game:GetService("ReplicatedStorage"):GetAttribute("ThirdSeaMonsterSpawnText")

				if attribute then
					if attribute:match("^(%d+):(%d+):(%d+)$") then
						local match, v841, v842 = attribute:match("(%d+):(%d+):(%d+)")

						v838:Set(string.format("🌊 SeaEventTime Spawn in: %02dH:%02dM:%02dS", tonumber(match), tonumber(v841), tonumber(v842)))
					else
						v838:Set("🌊 SeaEventTime Next Spawn: " .. attribute)
					end
				else
					v838:Set("🌊 SeaEventTime Next Spawn: " .. attribute)
				end
			end)
		end
	end)
	Settings:AddSeperator("Abyssal Tyrant")

	local v843 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v843:Set(v350.find({ "SeaDragon" }) and "Check Abyssal TyrantMon: " .. _G.greencircle or "Check Abyssal TyrantMon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Abyssal Tyrant", Settings, "Abyssal_Tyrant")
	Settings:AddSeperator("Chaos Kraken Boss")

	local v844 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v844:Set(v350.find({ "FuryTentacle" }) and "Check Chaos Kraken Mon: " .. _G.greencircle or "Check Chaos Kraken Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Chaos Kraken Boss", Settings, "Chaos_Kraken")
	Settings:AddSeperator("Deepsea Crusher")

	local v845 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v845:Set(v350.find({ "ThirdSeaEldritch Crab" }) and "Check Deepsea Crusher Mon: " .. _G.greencircle or "Check Deepsea Crusher Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Deepsea Crusher Boss", Settings, "Deepsea_Crusher")
	Settings:AddSeperator("Drakenfyr")

	local v846 = Settings:AddLabel("Status : " .. _G.redcircle)

	task.spawn(function()
		while task.wait(1) do
			v846:Set(v350.find({ "ThirdSeaDragon" }) and "Check Drakenfyr Mon: " .. _G.greencircle or "Check Drakenfyr Mon: " .. _G.redcircle)
		end
	end)
	Toggle("Auto Kill Drakenfyr the Inferno King", Settings, "auto_draken")
end

Settings = t27:AddSection("Settings", "Script Made By jay#0050", "Join Tsuo Hub Discord For Updates! \nuse at your own risk.", "http://www.roblox.com/asset/?id=6031233840")
Dropdown("Select Weapon ", {
	"Melee",
	"Sword",
	"Fruit Power",
	"all In One"
}, Settings, "Select_Weapon")
Settings:AddDropdown("Position Farm", { "Above", "Beside", "Lower" }, _G.Settings.PositionFarm, function(p167)
	_G.Settings.PositionFarm = p167
	SaveSettings()
end)
Settings:Slider("DisFarm", 0, 100, _G.Disfarm or 7.5, function(p168)
	_G.Disfarm = p168
end)
Toggle("Bring Mob (Work 80%)", Settings, "Bring_Nearest_Mobs_Together")

function EnableBuso()
	local Client_ = Client

	if Client_ then
		Client_ = Client.Character
	end

	repeat
		wait()
	until Client_ or not Client_ and tick() - RecentlySpawn > RespawnTime

	if not (Client_:WaitForChild("Services"):FindFirstChild("Haki") and Client_:WaitForChild("Services"):FindFirstChild("Haki").Value == 0) then
		return
	end

	-- Client-side set does nothing; use proper remote if available
	-- Client.PlayerStats.BusoShopValue.Value = "BusoHaki"
	game:GetService("ReplicatedStorage").Chest.Remotes.Events.Armament:FireServer()

	repeat
		wait(1)
	until Client_:WaitForChild("Services"):FindFirstChild("Haki").Value == 1
end

Settings:AddToggle("Enable Buso", true, function(p169)
	_G.Settings.EnableBuso = p169
	print("Toggle Enable Buso is:", _G.Settings.EnableBuso)
	spawn(function()
		while _G.Settings.EnableBuso do
			EnableBuso()
			wait(0.4)
		end
	end)
	SaveSettings()
end)
Settings:AddToggle("Auto Active Observation Haki", _G.Settings.ObservationHak, function(p170)
	_G.Settings.ObservationHak = p170
	SaveSettings()
end)
Toggle("White screen ", Settings, function(p171)
	game:GetService("RunService"):Set3dRenderingEnabled(not p171)
end)
Settings:AddToggle("Auto Hide Level Up Text", _G.AutoHideLevelText, function(p172)
	_G.AutoHideLevelText = p172
end)
spawn(function()
	while true do
		if _G.AutoHideLevelText then
			local LevelUp = game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Gui"):WaitForChild("LevelUp")

			if LevelUp then
				LevelUp.Visible = false
			end

			local ItemDrop = game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Gui"):WaitForChild("ItemDrop")

			if ItemDrop then
				ItemDrop.Visible = false
			end
		end

		wait(1)
	end
end)
_G.autohidehealth = _G.autohidehealth or false

local t41 = { workspace.Monster.Boss, workspace.Monster.Mon, game:GetService("ReplicatedStorage").MOB }

local function v851(p173)
	for _, v in ipairs_(t41) do
		for _, child in ipairs_(v:GetChildren()) do
			local BillboardGui = child:FindFirstChild("BillboardGui")

			if BillboardGui then
				BillboardGui.Enabled = not p173
			end

			local Humanoid = child:FindFirstChild("Humanoid")

			if Humanoid then
				Humanoid.DisplayDistanceType = p173 and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
			end
		end
	end
end
local function v858()
	spawn(function()
		while _G.autohidehealth do
			v851(true)
			task.wait(1)
		end

		v851(false)
	end)
end

Settings:AddToggle("Auto Hide Mob Health", _G.autohidehealth, function(p174)
	_G.autohidehealth = p174

	if _G.autohidehealth then
		v858()
	else
		v851(false)
	end

	SaveSettings()
end)
Settings:AddToggle("Delete Damage Text", _G.DeleteDamage, function(p175)
	_G.Delete = p175
end)
Settings:AddToggle("Delete Heavy Effect", _G.DeleteEffext, function(p176)
	_G.DeleteEffext = p176
end)
spawn(function()
	while wait() do
		if _G.DeleteDamage then
			pcall(function()
				if not game:GetService("Workspace"):FindFirstChild("DamageShow") then
					return
				end

				game:GetService("Workspace"):FindFirstChild("DamageShow").Parent = game:GetService("Workspace").Camera
			end)
		else
			pcall(function()
				if not game:GetService("Workspace").Camera:FindFirstChild("DamageShow") then
					return
				end

				game:GetService("Workspace").Camera:FindFirstChild("DamageShow").Parent = game:GetService("Workspace")
			end)
		end
	end
end)
spawn(function()
	while wait() do
		if _G.DeleteEffext then
			pcall(function()
				if not game:GetService("Workspace"):FindFirstChild("Effects") then
					return
				end

				game:GetService("Workspace"):FindFirstChild("Effects").Parent = game:GetService("Workspace").Camera
			end)
		else
			pcall(function()
				if not game:GetService("Workspace").Camera:FindFirstChild("Effects") then
					return
				end

				game:GetService("Workspace").Camera:FindFirstChild("Effects").Parent = game:GetService("Workspace")
			end)
		end
	end
end)

function KenHaki()
	local char = game.Players.LocalPlayer.Character
	if not char then return end
	-- Fixed: no longer hardcodes another player's name
	pcall(function()
		local vim = game:GetService("VirtualInputManager")
		vim:SendKeyEvent(true, "Y", false, game)
		task.wait(0.1)
		vim:SendKeyEvent(false, "Y", false, game)
	end)
end

spawn(function()
	while task.wait() do
		if _G.Settings.ObservationHak then
			pcall(function()
				KenHaki()
			end)
		end
	end
end)
Settings:AddSeperator("Auto Use Skill")
Settings:AddToggle("Use Skill Z", _G.Settings.SkillZ, function(p177)
	_G.Settings.SkillZ = p177
	SaveSettings()
end)
Settings:AddToggle("Use Skill X", _G.Settings.SkillX, function(p178)
	_G.Settings.SkillX = p178
	SaveSettings()
end)
Settings:AddToggle("Use Skill C", _G.Settings.SkillC, function(p179)
	_G.Settings.SkillC = p179
	SaveSettings()
end)
Settings:AddToggle("Use Skill V", _G.Settings.SkillV, function(p180)
	_G.Settings.SkillV = p180
	SaveSettings()
end)
Settings:AddToggle("Use Skill B", _G.Settings.SkillB, function(p181)
	_G.Settings.SkillB = p181
	SaveSettings()
end)
Settings:AddToggle("Use Skill E", _G.Settings.SkillE, function(p182)
	_G.Settings.SkillE = p182
	SaveSettings()
end)
Settings:AddSeperator("Hold Skill")
Settings:Slider("Hold Z", 0, 100, v349.Z, function(p183)
	v349.Z = p183
	SaveSettings()
end)
Settings:Slider("Hold X", 0, 100, v349.X, function(p184)
	v349.X = p184
	SaveSettings()
end)
Settings:Slider("Hold C", 0, 100, v349.C, function(p185)
	v349.C = p185
	SaveSettings()
end)
Settings:Slider("Hold V", 0, 100, v349.V, function(p186)
	v349.V = p186
	SaveSettings()
end)
Settings:Slider("Hold B", 0, 100, v349.B, function(p187)
	v349.B = p187
	SaveSettings()
end)
Settings:Slider("Hold E", 0, 100, v349.E, function(p188)
	v349.E = p188
	SaveSettings()
end)

local n10 = 1
local u861 = false
local u862 = false
local u863 = false
local u864 = false
local v865 = true
local v866 = v753:AddLabel("")

spawn(function()
	while task.wait() do
		v866:Set("Your Points: " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.Points.Value))
	end
end)
spawn(function()
	while task.wait() do
		if v865 then
			for _, v in ipairs_({
				"Melee",
				"Defense",
				"Sword",
				"Fruit"
			}) do
				if v == "Melee" and u861 or (v == "Defense" and u862 or (v == "Sword" and u863 or v == "Fruit" and u864)) then
					local t42 = { v, n10 }

					pcall(function()
						local sf = Client.PlayerGui:FindFirstChild("MainGui")
						sf = sf and sf:FindFirstChild("StarterFrame")
						sf = sf and sf:FindFirstChild("StatsFrame")
						if sf and sf:FindFirstChild("RemoteEvent") then
							sf.RemoteEvent:FireServer(unpack(t42))
						end
					end)
				end
			end
		end
	end
end)

local v870 = v753:AddLabel("")
local v871 = v753:AddLabel("")
local v872 = v753:AddLabel("")
local v873 = v753:AddLabel("")
local v874 = v753:AddLabel("")

spawn(function()
	while task.wait(0.1) do
		v870:Set("Level : " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.lvl.Value))
		v871:Set("Melee : " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.Melee.Value))
		v872:Set("Defense : " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.Defense.Value))
		v873:Set("Sword : " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.sword.Value))
		v874:Set("Devil Fruit : " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.DF.Value))
	end
end)
v753:AddToggle("Melee", u861, function(p189)
	u861 = p189
end)
v753:AddToggle("Defense", u862, function(p190)
	u862 = p190
end)
v753:AddToggle("Sword", u863, function(p191)
	u863 = p191
end)
v753:AddToggle("Devil Fruit", u864, function(p192)
	u864 = p192
end)
PlayerName = {}
local pIter, pState, pKey = pairs_(game.Players:GetChildren())
Settings, Parent, LocalPlayer4 = pIter, pState, pKey  -- keep names for loop compat

while true do
	LocalPlayer4, v753 = Settings(Parent, LocalPlayer4)

	if LocalPlayer4 == nil then
		break
	end

	if v753.Name ~= game.Players.LocalPlayer.Name then
		table.insert(PlayerName, v753.Name)
	end
end

local v875 = v749:AddDropdown("Select Players", PlayerName, "", function(p193)
	_G.SelectPly = p193
end)

v749:Button("Refresh Player", function()
	newPlayerName = {}

	for _, child in pairs_(game.Players:GetChildren()) do
		if child.Name ~= game.Players.LocalPlayer.Name then
			table.insert(newPlayerName, child.Name)
		end
	end

	v875:Refresh(newPlayerName)
end)
v749:AddToggle("Spectate Player", Spectate, function(p194)
	Spectate = p194

	local Humanoid = game.Players.LocalPlayer.Character.Humanoid
	local _GSelectPly = game.Players:FindFirstChild(_G.SelectPly)

	repeat
		task.wait()
		game.Workspace.Camera.CameraSubject = _GSelectPly.Character.Humanoid
	until Spectate == false

	game.Workspace.Camera.CameraSubject = Humanoid
end)
v749:Button("Teleport", function()
	Tp(game.Players[_G.SelectPly].Character.HumanoidRootPart.CFrame)
end)
v749:AddToggle("Auto Kill Player", _G.AutoKillply, function(p195)
	_G.AutoKillply = p195
	CancelTween(_G.AutoKillply)
end)
spawn(function()
	while wait() do
		pcall(function()
			if not (_G.AutoKillply and (game.Players:FindFirstChild(_G.SelectPly) and game.Players:FindFirstChild(_G.SelectPly).Character.Humanoid.Health > 0)) then
				return
			end

			repeat
				task.wait()
				Attack()
				Tp(game.Players:FindFirstChild(_G.SelectPly).Character.HumanoidRootPart.CFrame * Farm_Mode)
			until game.Players:FindFirstChild(_G.SelectPly).Character.Humanoid.Health <= 0 or not _G.AutoKillply or not game.Players:FindFirstChild(_G.SelectPly)
		end)
	end
end)
v754:AddSeperator("Server")
v754:Button("Rejoin Server", function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
v754:Button("Server Hop", function()
	Hop()
end)

function Hop()
	local PlaceId2 = game.PlaceId
	local t43 = {}
	local s33 = ""
	local hour = os.date("!*t").hour

	function TPReturner()
		local data

		if s33 ~= "" then
			local okH, raw = pcall(game.HttpGet, game, "https://games.roblox.com/v1/games/" .. PlaceId2 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. s33)
data = okH and game.HttpService:JSONDecode(raw) or {data={}, nextPageCursor=nil}
		else
			local okH, raw = pcall(game.HttpGet, game, "https://games.roblox.com/v1/games/" .. PlaceId2 .. "/servers/Public?sortOrder=Asc&limit=100")
data = okH and game.HttpService:JSONDecode(raw) or {data={}, nextPageCursor=nil}
		end

		if data.nextPageCursor and (data.nextPageCursor ~= "null" and data.nextPageCursor ~= nil) then
			s33 = data.nextPageCursor
		end

		local n11 = 0

		for _, v in pairs_(data.data) do
			local v888 = true
			local v889 = tostring(v.id)

			if tonumber(v.maxPlayers) > tonumber(v.playing) then
				for _, v2 in pairs_(t43) do
					if n11 == 0 then
						if tonumber(hour) ~= tonumber(v2) then
							pcall(function()
								t43 = {}
								table.insert(t43, hour)
							end)
						end
					elseif v889 == tostring(v2) then
						v888 = false
					end

					n11 = n11 + 1
				end

				if v888 == true then
					table.insert(t43, v889)
					wait(0.1)
					pcall(function()
						wait()
						game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId2, v889, game.Players.LocalPlayer)
					end)
					wait(0.1)
				end
			end
		end
	end
	function Teleport()
		while wait(0.1) do
			pcall(function()
				TPReturner()

				if s33 == "" then
					return
				end

				TPReturner()
			end)
		end
	end

	Teleport()
end

v754:Button("Teleport To Lower Server", function()
	local huge = math.huge
	local u893 = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
	local id = nil
	local data = nil

	if not _G.FailedServerID then
		_G.FailedServerID = {}
	end

	local function v896()
		data = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(u893))

		for _, v in pairs_(data.data) do
			pcall(function()
				if type(v) ~= "table" or (not v.id or (not v.playing or (tonumber(huge) <= tonumber(v.playing) or table.find(_G.FailedServerID, v.id)))) then
					return
				end

				huge = v.playing
				id = v.id
			end)
		end
	end

	function getservers()
		pcall(v896)

		for k, v in pairs_(data) do
			if k == "nextPageCursor" then
				if u893:find("&cursor=") then
					u893 = u893:gsub(u893:sub((u893:find("&cursor="))), "")
				end

				u893 = u893 .. "&cursor=" .. v
				pcall(getservers)
			end
		end
	end

	pcall(getservers)
	wait(0.1)

	if id ~= game.JobId then
		local _ = huge ~= #game:GetService("Players"):GetChildren() - 1
	end

	table.insert(_G.FailedServerID, id)
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, id)

	while wait(0.1) do
		pcall(function()
			if not game:IsLoaded() then
				game.Loaded:Wait()
			end

			game.CoreGui.RobloxPromptGui.promptOverlay.DescendantAdded:Connect(function()
				local ErrorPrompt = game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt")

				if not (ErrorPrompt and ErrorPrompt.TitleFrame.ErrorTitle.Text == "Disconnected") then
					return
				end

				if #game.Players:GetPlayers() > 1 then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
				else
					game.Players.LocalPlayer:Kick("\nRejoining...")
					wait(0.1)
					game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
				end
			end)
		end)
	end
end)
v754:Textbox("Join Server(Join Discord!)", "Enter Job ID", function(p196)
	-- Fixed: accept raw JobId or optional ZenHub_ prefix
	local jobId = p196
	if type(p196) == "string" and #p196 >= 7 and p196:sub(1, 7) == "ZenHub_" then
		jobId = p196:sub(8)
	end
	if jobId and jobId ~= "" then
		local ok, result = pcall(function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
		end)
		if ok then
			print("Successfully teleported to", jobId)
		else
			warn("Teleport failed:", result)
		end
	else
		warn("Invalid Job ID.")
	end
end)
end)
v754:AddToggle("Teleport First Sea", false, function()
	local npc = workspace.AllNPC:FindFirstChild("Elite Pirate")
	if npc then toQuest(npc.CFrame, "Elite Pirate") else warn("Elite Pirate not found") end
end)
v754:AddToggle("Teleport Second Sea", false, function()
	local npc = workspace.AllNPC:FindFirstChild("Elite Pirate") or workspace.AllNPC:FindFirstChild("Traveler")
	if npc then toQuest(npc.CFrame, "Elite Pirate") else warn("Sea2 NPC not found") end
end)
v754:AddToggle("Teleport Third Sea", false, function()
	local npc = workspace.AllNPC:FindFirstChild("The Squid")
	if npc then toQuest(npc.CFrame, "The Squid") else warn("The Squid not found") end
end)
v754:AddSeperator("Teleport Island")
Settings, Parent, LocalPlayer4 = pairs_(game:GetService("Workspace").Areas:GetChildren())
v753 = {}

while true do
	LocalPlayer4, v749 = Settings(Parent, LocalPlayer4)

	if LocalPlayer4 == nil then
		break
	end

	if v749.Name ~= "Sea of dust" then
		table.insert(v753, v749.Name)
	end
end

local s34 = "None"

v754:AddDropdown("Island Select", v753, "", function(p197)
	s34 = p197
end)
v754:Button("Teleport To Island", function()
	if s34 == "None" then
		warn("Please select an island.")
	else
		for _, child in pairs_(game:GetService("Workspace").Areas:GetChildren()) do
			if child.Name == s34 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = child.CFrame * CFrame.new(0, 300, 0)

				break
			end
		end
	end
end)
v750:AddLabel("Npc Teleport")
Settings, Parent, LocalPlayer4 = pairs_(game:GetService("Workspace").AllNPC:GetChildren())
v754 = {}

while true do
	LocalPlayer4, v753 = Settings(Parent, LocalPlayer4)

	if LocalPlayer4 == nil then
		break
	end

	table.insert(v754, v753.Name)
end

local v909 = v750:AddDropdown("Select NPC", Colossuem and { "" } or v754, "", function(p198)
	SelectedNpc = p198
end)

v750:Button("Teleport To NPC", function()
	for _, child in pairs_(game:GetService("Workspace").AllNPC:GetChildren()) do
		if SelectedNpc == child.Name then
			tp1(child.CFrame)
		end
	end
end)
v750:Button("Refresh Npc", function()
	local v912, v913, v914 = pairs_(game:GetService("Workspace").AllNPC:GetChildren())
	local t44 = {}

	while true do
		local v916

		v914, v916 = v912(v913, v914)

		if v914 == nil then
			break
		end

		table.insert(t44, v916.Name)
	end

	v909:Add(t44)
end)
v755:AddSeperator("Keys")
_G.selectedBuyKey = _G.selectedBuyKey or "Copper Key"
_G.buyAmount = 1
_G.buykey = _G.buykey or false
v755:AddDropdown("Select key to buy", { "Iron Key", "Copper Key", "Gold Key" }, _G.selectedBuyKey, function(p199)
	_G.selectedBuyKey = p199
end)
v755:AddToggle("Auto-buy selected key", _G.buykey, function(p200)
	_G.buykey = p200

	if not _G.buykey then
		return
	end

	spawn(function()
		while _G.buykey do
			BuyKey(_G.selectedBuyKey, _G.buyAmount)
			wait(1)
		end
	end)
end)

function BuyKey(p201, p202)
	local t45 = { p201, p202 }
	local ok, result = pcall(function()
		return game:GetService("ReplicatedStorage").Chest.Remotes.Functions.BuyKey:InvokeServer(unpack(t45))
	end)

	if ok and result then
		return
	end

	warn("Failed to purchase key:", p201, "Amount:", p202, "Error:", result)
end

v755:AddToggle("Auto open Key", _G.openkey, function(p203)
	_G.openkey = p203

	if _G.openkey then
		if _G.autoOpening then
			return
		end

		_G.autoOpening = true
		task.spawn(function()
			local t46 = { "Iron Key", "Copper Key", "Gold Key" }

			while _G.openkey do
				for _, v in ipairs_(t46) do
					OpenKey(v)
				end
			end

			_G.autoOpening = false
		end)
	else
		_G.autoOpening = false
	end
end)

function OpenKey(p204)
	if not p204 then
		warn("No key selected")

		return
	end

	local t47 = { p204, "Open1" }
	local ok, result = pcall(function()
		return game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("UseKey"):InvokeServer(unpack(t47))
	end)

	if ok and result then
		return
	end

	warn("Failed to open key:", p204, "Error:", result)
end

local t48 = {
	"SpinFruit",
	"BombFruit",
	"BarrierFruit",
	"HumanFruit",
	"SmokeFruit",
	"SpikeFruit",
	"PawFruit",
	"ShadowFruit",
	"LoveFruit",
	"StringFruit",
	"IceFruit",
	"SandFruit",
	"PhoenixFruit",
	"GumFruit",
	"MagmaFruit",
	"LightFruit",
	"FlameFruit",
	"QuakeFruit",
	"RumbleFruit",
	"GravityFruit",
	"SnowFruit",
	"DoughFruit",
	"ToyFruit",
	"DragonFruit",
	"SpinoFruit",
	"LeopardFruit",
	"BuddhaFruit",
	"OpFruit"
}

_G.autocollectfruit = false
task.spawn(function()
	while true do
		if _G.autocollectfruit then
			pcall(function()
				for _, v in pairs_(t48) do
					local LocalPlayer5 = game.Players.LocalPlayer
					local Character = LocalPlayer5.Character
					local PlayerGui = LocalPlayer5.PlayerGui

					if Character:FindFirstChild(v) and not PlayerGui:FindFirstChild("EatFruitBecky") then
						print(v .. " is equipped but no EatFruitBecky UI found.")
					elseif PlayerGui:FindFirstChild("EatFruitBecky") then
						v77(PlayerGui:FindFirstChild("EatFruitBecky").Dialogue.Collect)
						wait(1)
					elseif LocalPlayer5.Backpack:FindFirstChild(v) then
						v777(v)
						wait(1)
						Click()
						click()
					else
						warn("Fruit not found: " .. v)
					end
				end
			end)
		end

		task.wait(1)
	end
end)
v755:AddToggle("Auto Store Fruit", _G.autocollectfruit, function(p205)
	_G.autocollectfruit = p205

	if _G.autocollectfruit then
		print("Auto Collect Fruit: Enabled")
	else
		print("Auto Collect Fruit: Disabled")
	end
end)
v755:AddSeperator("Gacha Fruit")
DevilFruitList = {
	"SpinFruit",
	"BombFruit",
	"BarrierFruit",
	"HumanFruit",
	"SmokeFruit",
	"SpikeFruit",
	"PawFruit",
	"ShadowFruit",
	"LoveFruit",
	"StringFruit",
	"IceFruit",
	"SandFruit",
	"PhoenixFruit",
	"GumFruit",
	"MagmaFruit",
	"LightFruit",
	"FlameFruit",
	"QuakeFruit",
	"RumbleFruit",
	"GravityFruit",
	"SnowFruit",
	"DoughFruit",
	"ToyFruit",
	"DragonFruit",
	"SpinoFruit",
	"LeopardFruit",
	"BuddhaFruit",
	"OpFruit"
}
v755:AddDropdown("Select Devil Fruit", DevilFruitList, "", function(p206)
	DevilFruitSelected = p206
end)
v755:AddToggle("Auto Buy Devil Fruit", BuyDevilFruit, function(p207)
	BuyDevilFruit = p207
end)
task.spawn(function()
	while task.wait() do
		if BuyDevilFruit then
			pcall(function()
				if not (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(DevilFruitSelected) and game:GetService("Players").LocalPlayer.Character:FindFirstChild(DevilFruitSelected) == nil) then
					return
				end

				local t49 = { DevilFruitSelected, true }

				game:GetService("ReplicatedStorage").Chest.Remotes.Functions.BuyFruitStock:InvokeServer(unpack(t49))
			end)
		end
	end
end)
v755:AddToggle("Bring All Devil Fruit", BringDevilFruit, function(p208)
	BringDevilFruit = p208
end)
spawn(function()
	while task.wait() do
		if BringDevilFruit then
			pcall(function()
				local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart

				for _, child in pairs_(game.Workspace:GetChildren()) do
					if string.find(child.Name, "Fruit") and child:IsA("Tool") then
						child.Handle.CanCollide = false
						child.Handle.CFrame = HumanoidRootPart.CFrame
						wait(0.2)
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, child.Handle, 0)
					end
				end
			end)
		end
	end
end)
v755:Button("Teleport To Random Devil Fruit Shop", function()
	SafeToQuest("DFruitShop")
end)
v755:Button("Teleport To Devil Fruit Shop", function()
	SafeToQuest("DFruitShop")
end)

if Sea1 then
	Shops:Button("Soru Shop", function()
		tp1(CFrame.new(-2519, 75, -2649))
	end)
	Shops:Button("Buso Shop", function()
		tp1(CFrame.new(1953, 44, 914))
	end)
	Shops:Button("Ken Shop", function()
		tp1(CFrame.new(-4960, 462, 1175))
	end)
	Shops:Button("Katana", function()
		tp1(CFrame.new(-2064, 49, -4258))
	end)
	Shops:Button("Pipe Sword", function()
		tp1(CFrame.new(1519, 18, 1008))
	end)
	Shops:Button("Mini Race", function()
		tp1(CFrame.new(2505, 282, -1609))
	end)
elseif Sea2 then
	Shops:Button("Water Style Shop", function()
		tp1(CFrame.new(-4831.19971, 57.822052, 153.415283, -0.414802402, -5.48522792e-8, -0.909911513, -5.58345725e-8, 1, -3.48297213e-8, 0.909911513, 3.63570685e-8, -0.414802402))
	end)
	Shops:Button("Dragon Claw Shop", function()
		tp1(CFrame.new(-4603.89355, 337.312164, 599.383667, -0.962977529, -4.1851969e-8, -0.269581646, -5.81633124e-8, 1, 5.25183914e-8, 0.269581646, 6.625379e-8, -0.962977529))
	end)
end

Shops:Button("Sky Jump", function()
	if Sea1 then
		tp1(CFrame.new(-2192.19214, 48.7368965, -4475.83301, -0.543718636, -7.02707084e-8, -0.839267552, -9.75050725e-8, 1, -2.05600514e-8, 0.839267552, 7.06539609e-8, -0.543718636))
	else
		if not Sea2 then
			return
		end

		tp1(CFrame.new(-3730.19189, 57.8862038, 204.094666, 0.984767377, -1.1842487e-8, 0.173876956, 7.55866214e-9, 1, 2.5299288e-8, -0.173876956, -2.3599636e-8, 0.984767377))
	end
end)
Shops:Button("Reroll Race", function()
	if Sea1 then
		tp1(CFrame.new(-2074.55688, 76.3055191, -4497.41357, 0.6812042, -1.16788412e-9, -0.732093453, 3.87939153e-10, 1, -1.23429367e-9, 0.732093453, 5.5679833e-10, 0.6812042))
	else
		if not Sea2 then
			return
		end

		tp1(CFrame.new(-4949.18311, 57.822052, 191.524734, -0.833928227, 3.89729315e-8, 0.551872909, -1.38614071e-8, 1, -9.15651981e-8, -0.551872909, -8.40085335e-8, -0.833928227))
	end
end)
Shops:Button("Teleport Reset Stat NPC", function()
	if Sea1 then
		tp1(CFrame.new(-2072.95557, 48.7796097, -4405.29053, 0.461064994, -2.14056026e-8, 0.887366354, -5.51042501e-9, 1, 2.69857718e-8, -0.887366354, -1.73319599e-8, 0.461064994))
	else
		if not Sea2 then
			return
		end

		tp1(CFrame.new(-4843.9707, 58.0297661, 70.0297165, 0.288221925, 5.95155969e-9, 0.957563639, 9.68969527e-9, 1, -9.13186593e-9, -0.957563639, 1.19105037e-8, 0.288221925))
	end
end)
Shops:Button("Black Leg Shop", function()
	if Sea1 then
		tp1(CFrame.new(-4206.44971, 109.067413, -2932.71362, 0.979351342, 6.7444752e-9, -0.202165633, -1.24095703e-8, 1, -2.67545666e-8, 0.202165633, 2.87109092e-8, 0.979351342))
	else
		if not Sea2 then
			return
		end

		tp1(CFrame.new(-4918.97363, 60.340538, 55.1117287, 0.950969398, 1.60718479e-8, 0.309284925, -1.49673909e-8, 1, -5.9437637e-9, -0.309284925, 1.02314912e-9, 0.950969398))
	end
end)
Shops:Button("Cybrog Shop", function()
	if Sea1 then
		tp1(CFrame.new(-264.232269, 124.836227, -1400.2168, -0.385267437, 7.39628803e-9, -0.922804952, 1.14298544e-8, 1, 3.24308713e-9, 0.922804952, -9.29807076e-9, -0.385267437))
	else
		if not Sea2 then
			return
		end

		tp1(CFrame.new(-4969.50391, 57.772007, 165.519562, 0.456807017, 2.94110976e-8, 0.889565825, -7.4581024e-8, 1, 5.23630428e-9, -0.889565825, -6.87367105e-8, 0.456807017))
	end
end)

if not Colossuem then
	Dungeon:AddLabel("In Dungeon Only!")
end

function UseSkill(p209)
	Tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
	game:GetService("VirtualInputManager"):SendKeyEvent(true, p209, false, game)
	task.wait()
	game:GetService("VirtualInputManager"):SendKeyEvent(false, p209, false, game)
end

Dungeon:Button("Teleport To Raid Entrance", function()
	tp1(CFrame.new(-4567, 223, -80))
end)

if Colossuem then
	Dungeon:AddToggle("Auto Farm Dungeon", _G.AutoFarmDungeon, function(p210)
		_G.AutoFarmDungeon = p210
	end)
	Dungeon:Slider("Safe Raid Health", 1, 100, 50, function(p211)
		_G.SaveAt = p211
	end)
	Dungeon:Slider("Distance", 1, 100, 30, function(p212)
		DistanceDungeon = p212
	end)
	spawn(function()
		while wait() do
			if _G.AutoFarmDungeon and not _G.NotEquip then
				pcall(function()
					for _, child in ipairs_(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
						if child:IsA("Tool") then
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(child)
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while wait() do
			pcall(function()
				if not _G.AutoFarmDungeon then
					return
				end

				if game.Players.LocalPlayer.Character.Humanoid.Health <= game.Players.LocalPlayer.Character.Humanoid.MaxHealth / 100 * _G.SaveAt then
					AutoFarmMobDungeon = false
					AutoSaveModeDungeon = true
				else
					AutoFarmMobDungeon = true
					AutoSaveModeDungeon = false
				end
			end)
		end
	end)
	spawn(function()
		while wait() do
			if _G.AutoFarmDungeon and AutoFarmMobDungeon then
				pcall(function()
					if game.Players.LocalPlayer.Character.Humanoid.Health <= game.Players.LocalPlayer.Character.Humanoid.MaxHealth / 100 * _G.SaveAt then
						return
					end

					for _, child in pairs_(game:GetService("Workspace").Monster.Mon:GetChildren()) do
						if child:FindFirstChild("HumanoidRootPart") then
							repeat
								task.wait()
								_G.NotEquip = false
								tp1(child.HumanoidRootPart.CFrame * CFrame.new(0, 15, DistanceDungeon))
								wait(0.5)
								UseSkill("B")
								wait(0.5)
								UseSkill("Z")
								wait(0.5)
								UseSkill("X")
								wait(0.5)
								UseSkill("C")
								wait(0.5)
								UseSkill("V")
								wait(0.5)
							until child.Humanoid.Health <= 0 or (not _G.AutoFarmDungeon or (not AutoFarmMobDungeon or game.Players.LocalPlayer.Character.Humanoid.Health <= game.Players.LocalPlayer.Character.Humanoid.MaxHealth / 100 * _G.SaveAt))
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while wait() do
			if _G.AutoFarmDungeon and AutoSaveModeDungeon then
				pcall(function()
					if game.Players.LocalPlayer.Character.Humanoid.Health > game.Players.LocalPlayer.Character.Humanoid.MaxHealth / 100 * _G.SaveAt then
						return
					end

					while true do
						if true then
							task.wait()
							_G.NotEquip = true

							if game:GetService("Workspace").Island:FindFirstChild("Arena1") then
								tp1(CFrame.new(-9.393295288085938, 201.8232879638672, 16.94792366027832))
							else
								tp1(CFrame.new(-19.639192581176758, 182.88330078125, 6.57674503326416))
							end
						end

						for _, child in pairs_(game.Players.LocalPlayer.Backpack:GetChildren()) do
							if child:IsA("Tool") and child.ToolTip == "Fruit Power" then
								EquipWeapon(child.Name)
							end
						end

						for _, child in pairs_(game.Players.LocalPlayer.Character:GetChildren()) do
							if child:IsA("Tool") and child.ToolTip == "Fruit Power" then
								EquipWeapon(child.Name)
							end
						end

						game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game.Players.LocalPlayer.Character.HumanoidRootPart)

						if game.Players.LocalPlayer.Character.Humanoid.Health == game.Players.LocalPlayer.Character.Humanoid.MaxHealth or not (AutoSaveModeDungeon and _G.AutoFarmDungeon) then
							_G.NotEquip = false
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game.Players.LocalPlayer.Character.HumanoidRootPart)

							return
						end
					end
				end)
			end
		end
	end)
end

v756:AddToggle("Inf Geppo", InfGeppo, function(p213)
	InfGeppo = p213
end)
v756:AddToggle("Fly", Flys, function(p214)
	Flys = p214
end)
spawn(function()
	while wait() do
		pcall(function()
			if not Flys then
				return
			end

			fly()
		end)
	end
end)

function fly()
	local mouse = game.Players.LocalPlayer:GetMouse("")

	localplayer = game.Players.LocalPlayer
	game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

	local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
	local n12 = 25
	local t50 = {
		a = false,
		d = false,
		w = false,
		s = false
	}
	local v948 = nil
	local v949 = nil

	local function v950()
		local BodyPosition = Instance.new("BodyPosition", HumanoidRootPart)
		local BodyGyro = Instance.new("BodyGyro", HumanoidRootPart)

		BodyPosition.Name = "EPIXPOS"
		BodyPosition.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		BodyPosition.position = HumanoidRootPart.Position
		BodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
		BodyGyro.CFrame = HumanoidRootPart.CFrame

		while true do
			wait()
			localplayer.Character.Humanoid.PlatformStand = true

			local v953 = BodyGyro.CFrame - BodyGyro.CFrame.p + BodyPosition.position

			if not (t50.w or (t50.s or (t50.a or t50.d))) then
				speed = 1
			end

			if t50.w then
				v953 = v953 + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
				speed = speed + n12
			end

			if t50.s then
				v953 = v953 - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
				speed = speed + n12
			end

			if t50.d then
				v953 = v953 * CFrame.new(speed, 0, 0)
				speed = speed + n12
			end

			if t50.a then
				v953 = v953 * CFrame.new(-speed, 0, 0)
				speed = speed + n12
			end

			if n12 < speed then
				speed = n12
			end

			BodyPosition.position = v953.p

			if t50.w then
				BodyGyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(speed * 15), 0, 0)
			elseif t50.s then
				BodyGyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad(speed * 15), 0, 0)
			else
				BodyGyro.CFrame = workspace.CurrentCamera.CoordinateFrame
			end

			if not Fly then
				if BodyGyro then
					BodyGyro:Destroy()
				end

				if not BodyPosition then
					flying = false
					localplayer.Character.Humanoid.PlatformStand = false
					speed = 0

					return
				end

				BodyPosition:Destroy()
				flying = false
				localplayer.Character.Humanoid.PlatformStand = false
				speed = 0

				return
			end
		end
	end

	v948 = mouse.KeyDown:connect(function(p215)
		if HumanoidRootPart and HumanoidRootPart.Parent then
			if p215 == "w" then
				t50.w = true
			elseif p215 == "s" then
				t50.s = true
			elseif p215 == "a" then
				t50.a = true
			else
				if p215 ~= "d" then
					return
				end

				t50.d = true
			end
		else
			flying = false
			v948:disconnect()
			v949:disconnect()
		end
	end)
	v949 = mouse.KeyUp:connect(function(p216)
		if p216 == "w" then
			t50.w = false
		elseif p216 == "s" then
			t50.s = false
		elseif p216 == "a" then
			t50.a = false
		else
			if p216 ~= "d" then
				return
			end

			t50.d = false
		end
	end)
	v950()
end

v756:AddToggle("No Clip", _G.NoClip, function(p217)
	_G.NoClip = p217
end)
LocalPlayer:AddToggle("Esp Player", PlayerESP, function(p218)
	PlayerESP = p218

	while PlayerESP do
		wait()
		FindPlayer()
	end
end)
LocalPlayer:AddToggle("Esp Devil Fruit", DevilFruitESP, function(p219)
	DevilFruitESP = p219

	while DevilFruitESP do
		wait()
		FindDevilFruit()
	end
end)
LocalPlayer:AddToggle("Esp Legacy Island", LegacyIslandESP, function(p220)
	LegacyIslandESP = p220

	while LegacyIslandESP do
		wait()
		FindLegacyIsland()
	end
end)
LocalPlayer:AddToggle("Esp Hydra Island", HydraIslandESP, function(p221)
	HydraIslandESP = p221

	while HydraIslandESP do
		wait()
		FindHydraIsland()
	end
end)
LocalPlayer:AddToggle("Esp Ghost Ship", GhostShipESP, function(p222)
	GhostShipESP = p222

	while GhostShipESP do
		wait()
		FindGhostShip()
	end
end)
Number = math.random(1, 1000000)

function FindPlayer()
	for _, child in pairs_(game:GetService("Players"):GetChildren()) do
		pcall(function()
			if not child.Character then
				return
			end

			if PlayerESP then
				if child.Character.Head and not child.Character.Head:FindFirstChild("PlayerESP" .. Number) then
					local BillboardGui = Instance.new("BillboardGui", child.Character.Head)

					BillboardGui.Name = "PlayerESP" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child.Character.Head
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "GothamBold"
					TextLabel.FontSize = "Size14"
					TextLabel.Text = child.Name .. "\n" .. math.round((child.Character.Head.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5

					if child.Team ~= game:GetService("Players").LocalPlayer.Team then
						TextLabel.TextColor3 = Color3.new(255, 0, 0)
					else
						TextLabel.TextColor3 = Color3.new(0, 255, 0)
					end
				else
					child.Character.Head["PlayerESP" .. Number].TextLabel.Text = child.Name .. "\n" .. math.round((child.Character.Head.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
				end
			else
				if not child.Character.Head:FindFirstChild("PlayerESP" .. Number) then
					return
				end

				child.Character.Head:FindFirstChild("PlayerESP" .. Number):Destroy()
			end
		end)
	end
end
function FindDevilFruit()
	for _, child in pairs_(game:GetService("Workspace"):GetChildren()) do
		pcall(function()
			if not string.find(child.Name, "Fruit") then
				return
			end

			if DevilFruitESP then
				if not string.find(child.Name, "Fruit") then
					return
				end

				if child.Handle:FindFirstChild("DevilESP" .. Number) then
					child.Handle["DevilESP" .. Number].TextLabel.Text = child.Name .. "\n" .. math.round((child.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
				else
					local BillboardGui = Instance.new("BillboardGui", child.Handle)

					BillboardGui.Name = "DevilESP" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child.Handle
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "GothamBold"
					TextLabel.FontSize = "Size14"
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.Text = child.Name .. "\n" .. math.round((child.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
					TextLabel.TextColor3 = Color3.new(255, 255, 0)
				end
			else
				if not child.Handle:FindFirstChild("DevilESP" .. Number) then
					return
				end

				child.Handle:FindFirstChild("DevilESP" .. Number):Destroy()
			end
		end)
	end
end
function FindGhostShip()
	for _, child in pairs_(game:GetService("Workspace").GhostMonster:GetChildren()) do
		pcall(function()
			if child.Name ~= "Ghost Ship" then
				return
			end

			if GhostShipESP then
				if child.Name ~= "Ghost Ship" then
					return
				end

				if child.HumanoidRootPart:FindFirstChild("GhostESP" .. Number) then
					child.HumanoidRootPart["GhostESP" .. Number].TextLabel.Text = "Ghost Ship" .. "\n" .. math.round((child.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
				else
					local BillboardGui = Instance.new("BillboardGui", child.HumanoidRootPart)

					BillboardGui.Name = "GhostESP" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child.HumanoidRootPart
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "GothamBold"
					TextLabel.FontSize = "Size14"
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.Text = "Ghost Ship" .. "\n" .. math.round((child.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
					TextLabel.TextColor3 = Color3.new(204, 159, 40)
				end
			else
				if not child.HumanoidRootPart:FindFirstChild("GhostESP" .. Number) then
					return
				end

				child.HumanoidRootPart:FindFirstChild("GhostESP" .. Number):Destroy()
			end
		end)
	end
end
function FindLegacyIsland()
	for _, child in pairs_(game:GetService("Workspace").Island:GetChildren()) do
		pcall(function()
			if not string.find(child.Name, "Legacy Island") then
				return
			end

			if LegacyIslandESP then
				if not string.find(child.Name, "Legacy Island") then
					return
				end

				if child.Main:FindFirstChild("GayESP" .. Number) then
					child.Main["GhostESP" .. Number].TextLabel.Text = "Legacy Island" .. "\n" .. math.round((child.Main.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
				else
					local BillboardGui = Instance.new("BillboardGui", child.Main)

					BillboardGui.Name = "GayESP" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child.Main
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "GothamBold"
					TextLabel.FontSize = "Size14"
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.Text = "Legacy Island" .. "\n" .. math.round((child.Main.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
					TextLabel.TextColor3 = Color3.new(255, 255, 255)
				end
			else
				if not child.Main:FindFirstChild("GayESP" .. Number) then
					return
				end

				child.Main:FindFirstChild("GayESP" .. Number):Destroy()
			end
		end)
	end
end
function FindHydraIsland()
	for _, child in pairs_(game:GetService("Workspace").Island:GetChildren()) do
		pcall(function()
			if not string.find(child.Name, "Sea King") then
				return
			end

			if HydraIslandESP then
				if not string.find(child.Name, "Sea King") then
					return
				end

				if child.Main:FindFirstChild("HydraESP" .. Number) then
					child.Main["GhostESP" .. Number].TextLabel.Text = "Hydra Island" .. "\n" .. math.round((child.Main.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
				else
					local BillboardGui = Instance.new("BillboardGui", child.Main)

					BillboardGui.Name = "HydraESP" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child.Main
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "GothamBold"
					TextLabel.FontSize = "Size14"
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.Text = "Hydra Island" .. "\n" .. math.round((child.Main.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3) .. " m."
					TextLabel.TextColor3 = Color3.new(0, 255, 255)
				end
			else
				if not child.Main:FindFirstChild("HydraESP" .. Number) then
					return
				end

				child.Main:FindFirstChild("HydraESP" .. Number):Destroy()
			end
		end)
	end
end

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/ZenHubbScript/Main/refs/heads/main/log"))() -- disabled for safety
getSpawn()
-- Fixed: protect metatable hook
local okMeta, Settings = pcall(getrawmetatable, game)
if not okMeta or not Settings then
	warn("getrawmetatable not available")
	Settings = {}
end
local __namecall = Settings.__namecall or function() end
pcall(setreadonly, Settings, false)

function Settings.__namecall(...)
	local t51 = { ... }

	if getnamecallmethod() ~= "InvokeServer" or (tostring(t51[1]) ~= "SkillAction" or not getgenv().PosMonSkill) then
		return __namecall(...)
	elseif t51[3] then
		if t51[3].Type == "Up" or t51[3].Type == "Down" then
			t51[3].MouseHit = getgenv().PosMonSkill

			return __namecall(unpack(t51))
		else
			return __namecall(...)
		end
	else
		return __namecall(...)
	end
end
