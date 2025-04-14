local function modifyPrompt(prompt)
    prompt.HoldDuration = 0
end
local function isTargetPrompt(prompt)
    local parent = prompt.Parent
    while parent do
        if parent == workspace then
            return true
        end
        parent = parent.Parent
    end
    return false
end
for _, prompt in ipairs(workspace:GetDescendants()) do
    if prompt:IsA("ProximityPrompt") and isTargetPrompt(prompt) then
        modifyPrompt(prompt)
    end
end
workspace.DescendantAdded:Connect(function(instance)
    if instance:IsA("ProximityPrompt") and isTargetPrompt(instance) then
        modifyPrompt(instance)
    end
end)

local textToDisplay = "蛋皇快速互动"
local fontSize = 30
local colors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 0, 255)
}
local currentColorIndex = 1
local colorChangeInterval = 1
local timer = 0

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Position = UDim2.new(0.5, 0, 0.1, 0) 
textLabel.Size = UDim2.new(0, 0, 0, fontSize)
textLabel.BackgroundTransparency = 1
textLabel.Text = textToDisplay
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = fontSize
textLabel.TextColor3 = colors[currentColorIndex]
textLabel.Parent = screenGui

game:GetService("RunService").Heartbeat:Connect(function(dt)
    timer = timer + dt
    if timer >= colorChangeInterval then
        currentColorIndex = currentColorIndex + 1
        if currentColorIndex > #colors then
            currentColorIndex = 1
        end
        textLabel.TextColor3 = colors[currentColorIndex]
        timer = 0
    end
end)
