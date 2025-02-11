local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- UI Elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Navbar = Instance.new("Frame")
local TeleportTab = Instance.new("TextButton")
local SelfHackTab = Instance.new("TextButton")
local TeleportFrame = Instance.new("Frame")
local SelfHackFrame = Instance.new("Frame")

local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")

-- Fly Elements
local FlyButton = Instance.new("TextButton")
-- Speed Elements
local SpeedHandle = Instance.new("Frame")
local SpeedSlider = Instance.new("Frame")
local SpeedBar = Instance.new("Frame")
-- Jump Elements
local JumpSlider = Instance.new("Frame")
local JumpBar = Instance.new("Frame")
local JumpHandle = Instance.new("Frame")

local ToggleButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main UI
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 400, 0, 350)
Frame.Position = UDim2.new(0.5, -200, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 60)
Frame.BackgroundTransparency = 0.5 
Frame.Visible = false
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true

-- Navbar
Navbar.Parent = Frame
Navbar.Size = UDim2.new(1, 0, 0.15, 0)
Navbar.BackgroundColor3 = Color3.fromRGB(30, 30, 90)

TeleportTab.Parent = Navbar
TeleportTab.Size = UDim2.new(0.5, 0, 1, 0)
TeleportTab.Text = "Teleport"
TeleportTab.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
TeleportTab.TextColor3 = Color3.new(1, 1, 1)

SelfHackTab.Parent = Navbar
SelfHackTab.Size = UDim2.new(0.5, 0, 1, 0)
SelfHackTab.Position = UDim2.new(0.5, 0, 0, 0)
SelfHackTab.Text = "Self Hack"
SelfHackTab.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
SelfHackTab.TextColor3 = Color3.new(1, 1, 1)

-- Teleport Tab
TeleportFrame.Parent = Frame
TeleportFrame.Size = UDim2.new(1, 0, 0.85, 0)
TeleportFrame.Position = UDim2.new(0, 0, 0.15, 0)

TextBox.Parent = TeleportFrame
TextBox.Size = UDim2.new(0.8, 0, 0.15, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.1, 0)
TextBox.PlaceholderText = "Enter username"
TextBox.Text = ""
TextBox.TextScaled = true
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
TextBox.TextColor3 = Color3.new(1, 1, 1)

Button.Parent = TeleportFrame
Button.Size = UDim2.new(0.8, 0, 0.15, 0)
Button.Position = UDim2.new(0.1, 0, 0.3, 0)
Button.Text = "Teleport"
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
Button.TextColor3 = Color3.new(1, 1, 1)

-- Teleport Function
Button.MouseButton1Click:Connect(function()
    local targetName = TextBox.Text
    local player = Players.LocalPlayer
    local targetPlayer = Players:FindFirstChild(targetName)
    if targetPlayer and targetPlayer.Character then
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot and myRoot then
            myRoot.CFrame = targetRoot.CFrame
        end
    end
end)

-- Self Hack Tab
SelfHackFrame.Parent = Frame
SelfHackFrame.Size = UDim2.new(1, 0, 0.85, 0)
SelfHackFrame.Position = UDim2.new(0, 0, 0.15, 0)
SelfHackFrame.Visible = false

-- Fly Toggle
FlyButton.Parent = SelfHackFrame
FlyButton.Size = UDim2.new(0.8, 0, 0.15, 0)
FlyButton.Position = UDim2.new(0.1, 0, 0.1, 0)
FlyButton.Text = "Toggle Fly"
FlyButton.TextScaled = true
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
FlyButton.TextColor3 = Color3.new(1, 1, 1)

local flying = false
local flyConnection
local function toggleFly()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        flying = not flying
        if flying then
            flyConnection = RunService.RenderStepped:Connect(function()
                humanoidRootPart.Velocity = Vector3.new(0, 50, 0)
            end)
        else
            if flyConnection then flyConnection:Disconnect() end
            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

FlyButton.MouseButton1Click:Connect(toggleFly)

-- Speed Slider UI
SpeedSlider.Parent = SelfHackFrame
SpeedSlider.Size = UDim2.new(0.8, 0, 0.1, 0)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 80)

SpeedBar.Parent = SpeedSlider
SpeedBar.Size = UDim2.new(0, 0, 1, 0)
SpeedBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

SpeedHandle.Parent = SpeedSlider
SpeedHandle.Size = UDim2.new(0, 20, 1, 0)
SpeedHandle.Position = UDim2.new(0, 0, 0, 0)
SpeedHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SelfHackFrame
SpeedLabel.Size = UDim2.new(0.25, 0, 0.08, 0)
SpeedLabel.Position = UDim2.new(0.1, 0, 0.37, 0)
SpeedLabel.Text = "Speed: 16"
SpeedLabel.TextScaled = true
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)

local dragging = false
Frame.Draggable = true

SpeedHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        Frame.Draggable = false
    end
end)

SpeedHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        Frame.Draggable = true
    end
end)

local dragging = false

SpeedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        local sliderPos = math.clamp((input.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X, 0, 1)

        SpeedBar.Size = UDim2.new(sliderPos, 0, 1, 0)
        SpeedHandle.Position = UDim2.new(sliderPos, -10, 0, 0)

        local speedValue = math.floor(16 + (sliderPos * 200))
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        SpeedLabel.Text = "Speed: " .. speedValue
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
    end
end)

SpeedSlider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderPos = math.clamp((input.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X, 0, 1)
        SpeedBar.Size = UDim2.new(sliderPos, 0, 1, 0)
        SpeedHandle.Position = UDim2.new(sliderPos, -10, 0, 0)
        
        local speedValue = math.floor(16 + (sliderPos * 200))
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        SpeedLabel.Text = "Speed: " .. speedValue
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
    end
end)

-- Jump Power UI
JumpSlider.Parent = SelfHackFrame
JumpSlider.Size = UDim2.new(0.8, 0, 0.1, 0)
JumpSlider.Position = UDim2.new(0.1, 0, 0.7, 0)
JumpSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 80)

JumpBar.Parent = JumpSlider
JumpBar.Size = UDim2.new(0, 0, 1, 0)
JumpBar.BackgroundColor3 = Color3.fromRGB(255, 165, 0)

JumpHandle.Parent = JumpSlider
JumpHandle.Size = UDim2.new(0, 20, 1, 0)
JumpHandle.Position = UDim2.new(0, 0, 0, 0)
JumpHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Parent = SelfHackFrame
JumpLabel.Size = UDim2.new(0.4, 0, 0.1, 0)
JumpLabel.Position = UDim2.new(0.1, 0, 0.60, 0)
JumpLabel.Text = "Jump Power: 50"
JumpLabel.TextScaled = true
JumpLabel.BackgroundTransparency = 1
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Visible = true

local dragging = false
Frame.Draggable = true

JumpHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        Frame.Draggable = false
    end
end)

JumpHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        Frame.Draggable = true
    end
end)

local dragging = false

JumpSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        local sliderPos = math.clamp((input.Position.X - JumpSlider.AbsolutePosition.X) / JumpSlider.AbsoluteSize.X, 0, 1)
        JumpBar.Size = UDim2.new(sliderPos, 0, 1, 0)
        JumpHandle.Position = UDim2.new(sliderPos, -10, 0, 0)
        local jumpValue = math.floor(50 + (sliderPos * 300))
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        JumpLabel.Text = "Jump Power: " .. jumpValue
        if humanoid then
            humanoid.JumpPower = jumpValue
        end
    end
end)

JumpSlider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderPos = math.clamp((input.Position.X - JumpSlider.AbsolutePosition.X) / JumpSlider.AbsoluteSize.X, 0, 1)
        JumpBar.Size = UDim2.new(sliderPos, 0, 1, 0)
        JumpHandle.Position = UDim2.new(sliderPos, -10, 0, 0)
        local jumpValue = math.floor(50 + (sliderPos * 300))
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        JumpLabel.Text = "Jump Power: " .. jumpValue
        if humanoid then
            humanoid.JumpPower = jumpValue
        end
    end
end)

-- Toggle UI Button
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -50, 0.1, 0)
ToggleButton.Text = "Show UI"
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Active = true
ToggleButton.Draggable = true

ToggleButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 320)})
    Frame.Visible = true
    tween:Play()
    ToggleButton.Visible = false
end)

-- Checking for dragging
local isDragging = false
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        isDragging = true
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if not isDragging then
            -- Cuma kebuka kalau nggak di-drag
            local tween = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 320)})
            Frame.Visible = true
            tween:Play()
            ToggleButton.Visible = false
        end
    end
end)


-- Close Button
CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0.2, 0, 0.10, 0)
CloseButton.Position = UDim2.new(0.8, 0, 0.85, 0)
CloseButton.Text = "✖️"
CloseButton.TextScaled = true
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.TextColor3 = Color3.new(1, 1, 1)

CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    ToggleButton.Visible = true
end)

-- Tab Switching
TeleportTab.MouseButton1Click:Connect(function()
    TeleportFrame.Visible = true
    SelfHackFrame.Visible = false
end)

SelfHackTab.MouseButton1Click:Connect(function()
    TeleportFrame.Visible = false
    SelfHackFrame.Visible = true
end)

-- Default tab
TeleportFrame.Visible = true
SelfHackFrame.Visible = false

-- @graysxx
