local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Backpack = Player:WaitForChild("Backpack")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = Player:WaitForChild("PlayerGui")
screenGui.Name = "ToxicMustardGasYT_GUI"
screenGui.ResetOnSpawn = false

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 80, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(0, 0, 255)
toggleButton.Text = "Open"
toggleButton.Font = Enum.Font.SciFi
toggleButton.TextSize = 14
toggleButton.TextColor3 = Color3.fromRGB(0, 170, 255)

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 300, 0, 220)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 255)
mainFrame.Visible = false

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.BorderSizePixel = 2
titleLabel.BorderColor3 = Color3.fromRGB(0, 0, 255)
titleLabel.Text = "ToxicMustardGasYT's GUI"
titleLabel.Font = Enum.Font.SciFi
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)

-- Tabs Frame
local tabsFrame = Instance.new("Frame")
tabsFrame.Parent = mainFrame
tabsFrame.Size = UDim2.new(1, 0, 0, 30)
tabsFrame.Position = UDim2.new(0, 0, 0, 30)
tabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabsFrame.BorderSizePixel = 2
tabsFrame.BorderColor3 = Color3.fromRGB(0, 0, 255)

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, 0, 1, -60)
contentFrame.Position = UDim2.new(0, 0, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local tabButtons = {}
local tabContents = {}

-- Function to Create Tab Button
local function createTabButton(name, index)
    local button = Instance.new("TextButton")
    button.Parent = tabsFrame
    button.Size = UDim2.new(0, 70, 1, 0)
    button.Position = UDim2.new(0, (index - 1) * 75, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(0, 0, 255)
    button.Text = name
    button.Font = Enum.Font.SciFi
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(0, 170, 255)
    tabButtons[name] = button
    return button
end

-- Function to Create Tab Content
local function createTabContent(name)
    local content = Instance.new("Frame")
    content.Parent = contentFrame
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.Visible = false
    tabContents[name] = content
    return content
end

-- Function to Show Tabs
local function showTab(name)
    for tabName, content in pairs(tabContents) do
        content.Visible = (tabName == name)
    end
end

-- Add Tabs
local orbitButton = createTabButton("Orbit", 1)
local orbitTab = createTabContent("Orbit")
orbitButton.MouseButton1Click:Connect(function()
    showTab("Orbit")
end)

local dupeToolsButton = createTabButton("Dupe", 2)
local dupeTab = createTabContent("Dupe")
dupeToolsButton.MouseButton1Click:Connect(function()
    showTab("Dupe")
end)

local dropToolsButton = createTabButton("Drop", 3)
local dropTab = createTabContent("Drop")
dropToolsButton.MouseButton1Click:Connect(function()
    showTab("Drop")
end)

local removeMeshButton = createTabButton("Remove", 4)
local removeMeshTab = createTabContent("Remove")
removeMeshButton.MouseButton1Click:Connect(function()
    showTab("Remove")
end)

local creditsButton = createTabButton("Credits", 5)
local creditsTab = createTabContent("Credits")
creditsButton.MouseButton1Click:Connect(function()
    showTab("Credits")
end)

-- Credits Content
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Parent = creditsTab
creditsLabel.Size = UDim2.new(1, 0, 1, 0)
creditsLabel.Text = "GUI Made By Sailors\nDiscord: toxicmustardgasyt\n\nTabs:\n- Orbit: Orbit tools.\n- Remove Mesh: Removes tool meshes.\n- Drop Tools: Drops tools.\n- Dupe Tools: Duplicate tools."
creditsLabel.Font = Enum.Font.SciFi
creditsLabel.TextSize = 14
creditsLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
creditsLabel.BackgroundTransparency = 1
creditsLabel.TextWrapped = true

-- Toggle Button Logic
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    toggleButton.Text = isOpen and "Close" or "Open"
end)
