-- NEON GLOKER | Blue Neon Edition
-- Starter LocalScript for Roblox Studio

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local blue = Color3.fromRGB(0, 170, 255)
local dark = Color3.fromRGB(12, 18, 30)
local white = Color3.fromRGB(235, 245, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "NeonGloker"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Floating NG button
local button = Instance.new("TextButton")
button.Name = "FloatingButton"
button.Size = UDim2.fromOffset(62, 62)
button.Position = UDim2.new(0, 24, 0.45, 0)
button.BackgroundColor3 = dark
button.Text = "NG"
button.TextColor3 = white
button.TextSize = 22
button.Font = Enum.Font.GothamBold
button.AutoButtonColor = false
button.Parent = gui

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = button

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = blue
buttonStroke.Thickness = 2.5
buttonStroke.Parent = button

-- Main menu
local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Size = UDim2.fromOffset(260, 300)
menu.Position = UDim2.new(0.5, -130, 0.5, -150)
menu.BackgroundColor3 = dark
menu.Visible = false
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 14)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = blue
menuStroke.Thickness = 2
menuStroke.Parent = menu

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 44)
title.Position = UDim2.fromOffset(12, 4)
title.BackgroundTransparency = 1
title.Text = "NEON GLOKER"
title.TextColor3 = blue
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -38, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
close.Text = "×"
close.TextColor3 = white
close.TextSize = 24
close.Font = Enum.Font.GothamBold
close.Parent = menu

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = close

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -24, 0, 2)
divider.Position = UDim2.fromOffset(12, 48)
divider.BackgroundColor3 = blue
divider.BorderSizePixel = 0
divider.Parent = menu

local features = {
    "Infinite Jump",
    "Speed: 16",
    "Noclip",
    "Aura Kill",
    "Teleport",
    "Fly",
}

local buttons = {}

for i, name in ipairs(features) do
    local row = Instance.new("TextButton")
    row.Name = name:gsub("[^%w]", "") .. "Button"
    row.Size = UDim2.new(1, -24, 0, 34)
    row.Position = UDim2.fromOffset(12, 58 + (i - 1) * 38)
    row.BackgroundColor3 = Color3.fromRGB(20, 35, 52)
    row.Text = name .. "  [OFF]"
    row.TextColor3 = white
    row.TextSize = 14
    row.Font = Enum.Font.GothamMedium
    row.Parent = menu

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = row

    local stroke = Instance.new("UIStroke")
    stroke.Color = blue
    stroke.Thickness = 1
    stroke.Transparency = 0.45
    stroke.Parent = row

    buttons[name] = row

    row.Activated:Connect(function()
        if name == "Speed: 16" then
            row.Text = "Speed: 16  [GUI ONLY]"
        else
            local enabled = row:GetAttribute("Enabled") or false
            enabled = not enabled
            row:SetAttribute("Enabled", enabled)
            row.Text = name .. (enabled and "  [ON]" or "  [OFF]")
            row.BackgroundColor3 = enabled
                and Color3.fromRGB(0, 75, 115)
                or Color3.fromRGB(20, 35, 52)
        end
    end)
end

-- Open and close menu
button.Activated:Connect(function()
    menu.Visible = not menu.Visible
    if menu.Visible then
        menu.Size = UDim2.fromOffset(240, 280)
        TweenService:Create(
            menu,
            TweenInfo.new(0.18, Enum.EasingStyle.Back),
            {Size = UDim2.fromOffset(260, 300)}
        ):Play()
    end
end)

close.Activated:Connect(function()
    menu.Visible = false
end)

-- Gentle neon pulse
task.spawn(function()
    while gui.Parent do
        TweenService:Create(
            buttonStroke,
            TweenInfo.new(0.8),
            {Transparency = 0.55}
        ):Play()
        task.wait(0.8)

        TweenService:Create(
            buttonStroke,
            TweenInfo.new(0.8),
            {Transparency = 0}
        ):Play()
        task.wait(0.8)
    end
end)

print("NEON GLOKER loaded!")
