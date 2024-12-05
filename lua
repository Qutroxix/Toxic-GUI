-- Services
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- Configuration
local Config = {
    GUI = {
        BackgroundColor = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(0, 170, 255),
        Font = Enum.Font.SciFi,
    },
    Size = {
        Full = UDim2.new(0, 400, 0, 400),
        Minimized = UDim2.new(0, 400, 0, 50),
    }
}

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ToxicMustardGasYT_GUI"
ScreenGui.Parent = PlayerGui

-- Create Open Button
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 100, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.BackgroundColor3 = Config.GUI.BackgroundColor
OpenButton.TextColor3 = Config.GUI.TextColor
OpenButton.Text = "OPEN"
OpenButton.Font = Config.GUI.Font
OpenButton.TextSize = 20
OpenButton.Parent = ScreenGui

-- Create Main GUI Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = Config.Size.Full
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
MainFrame.BackgroundColor3 = Config.GUI.BackgroundColor
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Dragging Logic for MainFrame
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Add Minimize and Close Buttons
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 50, 0, 30)
CloseButton.Position = UDim2.new(1, -60, 0, 10)
CloseButton.BackgroundColor3 = Config.GUI.BackgroundColor
CloseButton.TextColor3 = Config.GUI.TextColor
CloseButton.Text = "X"
CloseButton.Font = Config.GUI.Font
CloseButton.TextSize = 16
CloseButton.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 50, 0, 30)
MinimizeButton.Position = UDim2.new(1, -120, 0, 10)
MinimizeButton.BackgroundColor3 = Config.GUI.BackgroundColor
MinimizeButton.TextColor3 = Config.GUI.TextColor
MinimizeButton.Text = "-"
MinimizeButton.Font = Config.GUI.Font
MinimizeButton.TextSize = 16
MinimizeButton.Parent = MainFrame

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Name = "TabsContainer"
TabsContainer.Size = UDim2.new(1, 0, 0, 30)
TabsContainer.Position = UDim2.new(0, 0, 0, 50)
TabsContainer.BackgroundColor3 = Config.GUI.BackgroundColor
TabsContainer.BorderSizePixel = 0
TabsContainer.Parent = MainFrame

-- Tabs Logic
local Tabs = {"Orbit", "Gears", "Speed/Jump", "Credits"}
local Buttons = {}
local ActiveTab = nil
local TabContents = {}

local function createTabButton(name)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Tab"
    Button.Text = name
    Button.Size = UDim2.new(0, 100, 1, 0)
    Button.BackgroundColor3 = Config.GUI.BackgroundColor
    Button.TextColor3 = Config.GUI.TextColor
    Button.Font = Config.GUI.Font
    Button.TextSize = 14
    Button.Parent = TabsContainer
    Buttons[name] = Button
    return Button
end

local function switchTab(tabName)
    if ActiveTab then
        TabContents[ActiveTab].Visible = false
    end
    ActiveTab = tabName
    TabContents[tabName].Visible = true
end

for _, tabName in ipairs(Tabs) do
    local Button = createTabButton(tabName)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = tabName .. "Content"
    ContentFrame.Size = UDim2.new(1, 0, 1, -80)
    ContentFrame.Position = UDim2.new(0, 0, 0, 80)
    ContentFrame.BackgroundColor3 = Config.GUI.BackgroundColor
    ContentFrame.Visible = false
    ContentFrame.Parent = MainFrame
    TabContents[tabName] = ContentFrame

    Button.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
end

-- Credits Tab
local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Text = "GUI Made By ToxicMustardGasYT\nDiscord: toxicmustardgasyt"
CreditsLabel.Size = UDim2.new(1, 0, 0, 100)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.TextColor3 = Config.GUI.TextColor
CreditsLabel.Font = Config.GUI.Font
CreditsLabel.TextSize = 16
CreditsLabel.Parent = TabContents["Credits"]

-- Toggle Open/Close
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    OpenButton.Text = MainFrame.Visible and "CLOSE" or "OPEN"
end)

-- Close Button Logic
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Text = "OPEN"
end)

-- Minimize Button Logic
MinimizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == Config.Size.Full then
        MainFrame.Size = Config.Size.Minimized
    else
        MainFrame.Size = Config.Size.Full
    end
end)

-- Default to First Tab
switchTab("Orbit")
