-- why u look in MY code big boyyy


-- this is skidded and ai generated







local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local Client = Players.LocalPlayer

RS.RenderStepped:Connect(function()
    for _, Player in pairs(Players:GetPlayers()) do
        if Player == Client then continue end
        local character = Player.Character or Player.CharacterAdded:Wait()[1]
        if character then
            local HRP = character:WaitForChild("HumanoidRootPart")
            local Humanoid = character:WaitForChild("Humanoid")

            -- Store original properties (do this only ONCE per character)
            if not HRP:FindFirstChild("OriginalProperties") then
                local originalProperties = Instance.new("Folder")
                originalProperties.Name = "OriginalProperties"
                originalProperties.Parent = HRP

                local sizeValue = Instance.new("Vector3Value")
                sizeValue.Name = "Size"
                sizeValue.Value = HRP.Size
                sizeValue.Parent = originalProperties

                local shapeValue = Instance.new("EnumValue")
                shapeValue.Name = "Shape"
                shapeValue.Value = HRP.Shape
                shapeValue.Parent = originalProperties

                local materialValue = Instance.new("EnumValue")
                materialValue.Name = "Material"
                materialValue.Value = HRP.Material
                materialValue.Parent = originalProperties

                local colorValue = Instance.new("Color3Value")
                colorValue.Name = "Color"
                colorValue.Value = HRP.Color
                colorValue.Parent = originalProperties

                local transparencyValue = Instance.new("NumberValue")
                transparencyValue.Name = "Transparency"
                transparencyValue.Value = HRP.Transparency
                transparencyValue.Parent = originalProperties

                local hipHeightValue = Instance.new("NumberValue")
                hipHeightValue.Name = "HipHeight"
                hipHeightValue.Value = Humanoid.HipHeight
                hipHeightValue.Parent = originalProperties
            end

            -- Apply changes using the settings table
            HRP.Size = Vector3.new(ZeraHitboxSettings.Size, ZeraHitboxSettings.Size, ZeraHitboxSettings.Size)
            HRP.Shape = Enum.PartType.Ball
            HRP.Material = ZeraHitboxSettings.Material
            HRP.Color = ZeraHitboxSettings.Color
            HRP.Transparency = ZeraHitboxSettings.Transparency
            Humanoid.HipHeight = ZeraHitboxSettings.Size * ZeraHitboxSettings.HipHeightMultiplier
            HRP.CanCollide = false
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = player.Character.HumanoidRootPart
        local originalProperties = HRP:FindFirstChild("OriginalProperties")
        if originalProperties then
            HRP.Size = originalProperties.Size.Value
            HRP.Shape = originalProperties.Shape.Value
            HRP.Material = originalProperties.Material.Value
            HRP.Color = originalProperties.Color.Value
            HRP.Transparency = originalProperties.Transparency.Value
            local Humanoid = player.Character:WaitForChild("Humanoid")
            Humanoid.HipHeight = originalProperties.HipHeight.Value
            HRP.CanCollide = true
            originalProperties:Destroy()
        end
    end
end)
