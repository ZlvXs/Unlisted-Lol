--Made By Zlv, Enjoy <3
    
local CoreGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

getgenv().HitboxSize = 4
getgenv().HitboxTransparency = 0.5

getgenv().TeamCheck = false
getgenv().FriendCheck = false

--// UI

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/UI-Library/main/Source/MyUILib(Unamed).lua"))();
local Window = Library:Create("Hitbox Expander")

local HomeTab = Window:Tab("Home","rbxassetid://12296135476")

HomeTab:Section("Made By Zlv, Enjoy! <3")
HomeTab:Section("Hitbox")

HomeTab:Slider("Hitbox Size (Slider)", 0,300, function(value)
	getgenv().HitboxSize = value
end)

HomeTab:TextBox("Hitbox Size (TextBox)", function(value)
	getgenv().HitboxSize = value
end)

HomeTab:TextBox("Hitbox Transparency", function(number)
	getgenv().HitboxTransparency = number
end)

HomeTab:Section("Features")

HomeTab:Button("Hitlock", function()
    plr:GetMouse().KeyDown:Connect(function(key)
        if key == 'r' then
            tar = nil
            for _,v in next,workspace:GetDescendants() do
                if v.Name == 'SelectedPlayer' then
                    v:Destroy()
                end
            end
            local n_plr, dist
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= plr and plr.Character and plr.Character:FindFirstChild'HumanoidRootPart' then
                    local distance = v:DistanceFromCharacter(plr.Character.HumanoidRootPart.Position)
                    if v.Character and (not dist or distance <= dist) and v.Character:FindFirstChildOfClass'Humanoid' and v.Character:FindFirstChildOfClass'Humanoid'.Health>0 and v.Character:FindFirstChild'HumanoidRootPart' then
                        dist = distance
                        n_plr = v
                    end
                end
            end
            local sp = Instance.new('SelectionBox',n_plr.Character.Torso)
            sp.Name = 'SelectedPlayer'
            sp.Adornee = n_plr.Character.HumanoidRootPart
            sp.Color3 = Color3.new(255,255,255)
            sp.Transparency = 0.25
            tar = n_plr
        elseif key == 'q' and tar and plr.Character then
            for _,v in next,plr.Character:GetDescendants() do
                if v:IsA'Tool' and v.Name ~= 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'DamageRemote' and v:FindFirstChild'Cooldown' and tar and tar.Character and tar.Character:FindFirstChildOfClass'Humanoid' then
                    AddCd(v,v.Cooldown.Value)
                    if v:FindFirstChild'Attack' and plr.Character:FindFirstChildOfClass'Humanoid' then
                        plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Attack):Play()
                    end
                    if v:FindFirstChild'Blade' then
                        for _,x in next,v.Blade:GetChildren() do
                            if x:IsA'Sound' then
                                x:Play()
                            end
                        end
                    end
                    v.DamageRemote:FireServer(tar.Character:FindFirstChildOfClass'Humanoid')
                elseif v:IsA'Tool' and v.Name == 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'ReplicateRemote' and v:FindFirstChild'Barrel' and v.Barrel:FindFirstChild'Attachment' and tar and tar.Character and tar.Character:FindFirstChild'Torso' then
                    v.Parent = plr.Character
                    AddCd(v,1)
                    rs.Stepped:wait()
                    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Fire):Play()
                    Shoot(v.Barrel.Attachment.WorldPosition,tar.Character:FindFirstChild("Torso").Position,v)
                    v.ReplicateRemote:FireServer(tar.Character:FindFirstChild("Torso").Position)            
                end
            end
        end
end)
end)

HomeTab:Button("Sword", function()
	if game.Players.LocalPlayer.Character:FindFirstChild("Loaded") then
		game.Players.LocalPlayer.Character.Loaded:Destroy()
	end
	game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").RemoteEvent:FireServer("Emerald Greatsword")
	game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").Enabled = false
end)

HomeTab:Section("Setting")

HomeTab:Toggle("Status: ", function(state)
	getgenv().HitboxStatus = state
	game:GetService('RunService').RenderStepped:connect(function()
		if HitboxStatus == true and TeamCheck == false and FriendCheck == false then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						v.Character.HumanoidRootPart.Transparency = HitboxTransparency
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		elseif HitboxStatus == true and TeamCheck == false and FriendCheck == true then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				for i2,v2 in pairs(game:GetService('Players'):GetChildren()) do
					if v.Name ~= game:GetService('Players').LocalPlayer.Name and not v2:IsFriendsWith(game:GetService('Players').LocalPlayer.UserId) then
						pcall(function()
							v.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
							v.Character.HumanoidRootPart.Transparency = HitboxTransparency
							v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
							v.Character.HumanoidRootPart.Material = "Neon"
							v.Character.HumanoidRootPart.CanCollide = false
						end)
					end
				end
			end
		elseif HitboxStatus == true and TeamCheck == true and FriendCheck == false then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if game:GetService('Players').LocalPlayer.Team ~= v.Team then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						v.Character.HumanoidRootPart.Transparency = HitboxTransparency
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		elseif HitboxStatus == true and TeamCheck == true and FriendCheck == true then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if game:GetService('Players').LocalPlayer.Team ~= v.Team and not game:GetService('Players'):IsFriendsWith(UserId) then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						v.Character.HumanoidRootPart.Transparency = HitboxTransparency
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		else
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
						v.Character.HumanoidRootPart.Transparency = 1
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
						v.Character.HumanoidRootPart.Material = "Plastic"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		end
	end)
end)

HomeTab:Keybind("Toggle UI", Enum.KeyCode.F1, function()
	Library:ToggleUI()
end)
