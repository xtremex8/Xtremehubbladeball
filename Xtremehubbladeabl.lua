local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = Player:WaitForChild("PlayerGui")
local Balls = workspace:WaitForChild("Balls", 9e9)

local AutoParryActive = false
local spamOn = false
local AutoSpamParryActive = false

local function Parry()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

local function IsTarget()
    return Player.Character and Player.Character:FindFirstChild("Highlight")
end

local function VerifyBall(Ball)
    return typeof(Ball) == "Instance" and Ball:IsA("BasePart") and Ball:IsDescendantOf(Balls) and Ball:GetAttribute("realBall") == true
end

local function TweenButton(button)
    local originalSize = button.Size
    local originalPos = button.Position
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = originalColor}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.05), {Size = originalSize - UDim2.new(0, 5, 0, 5)}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = originalSize}):Play()
    end)
end

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "XtremeHubModern"
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 250, 0, 300)
mainFrame.Position = UDim2.new(1, -260, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 8)

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Name = "TopCorner"

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "XTREME HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local content = Instance.new("Frame", mainFrame)
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1

local functionSection = Instance.new("TextLabel", content)
functionSection.Size = UDim2.new(1, 0, 0, 30)
functionSection.BackgroundTransparency = 1
functionSection.Text = "FUNÇÕES"
functionSection.TextColor3 = Color3.fromRGB(200, 200, 200)
functionSection.Font = Enum.Font.Gotham
functionSection.TextSize = 14
functionSection.TextXAlignment = Enum.TextXAlignment.Left

local btnSpam = Instance.new("TextButton", content)
btnSpam.Size = UDim2.new(1, 0, 0, 40)
btnSpam.Position = UDim2.new(0, 0, 0, 30)
btnSpam.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
btnSpam.Text = "SPAM CLICK: OFF"
btnSpam.TextColor3 = Color3.fromRGB(255, 255, 255)
btnSpam.Font = Enum.Font.Gotham
btnSpam.TextSize = 14
Instance.new("UICorner", btnSpam).CornerRadius = UDim.new(0, 6)

TweenButton(btnSpam)

btnSpam.MouseButton1Click:Connect(function()
    spamOn = not spamOn
    btnSpam.Text = "SPAM CLICK: " .. (spamOn and "ON" or "OFF")
    btnSpam.BackgroundColor3 = spamOn and Color3.fromRGB(80, 150, 80) or Color3.fromRGB(45, 45, 55)
    
    task.spawn(function()
        while spamOn do
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.001)
        end
    end)
end)

local btnParry = Instance.new("TextButton", content)
btnParry.Size = UDim2.new(1, 0, 0, 40)
btnParry.Position = UDim2.new(0, 0, 0, 80)
btnParry.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
btnParry.Text = "AUTO PARRY: OFF"
btnParry.TextColor3 = Color3.fromRGB(255, 255, 255)
btnParry.Font = Enum.Font.Gotham
btnParry.TextSize = 14
Instance.new("UICorner", btnParry).CornerRadius = UDim.new(0, 6)

TweenButton(btnParry)

btnParry.MouseButton1Click:Connect(function()
    AutoParryActive = not AutoParryActive
    btnParry.Text = "AUTO PARRY: " .. (AutoParryActive and "ON" or "OFF")
    btnParry.BackgroundColor3 = AutoParryActive and Color3.fromRGB(80, 150, 80) or Color3.fromRGB(45, 45, 55)
end)

local btnAutoSpamParry = Instance.new("TextButton", content)
btnAutoSpamParry.Size = UDim2.new(1, 0, 0, 40)
btnAutoSpamParry.Position = UDim2.new(0, 0, 0, 130)
btnAutoSpamParry.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
btnAutoSpamParry.Text = "SPAM PARRY: OFF"
btnAutoSpamParry.TextColor3 = Color3.fromRGB(255, 255, 255)
btnAutoSpamParry.Font = Enum.Font.Gotham
btnAutoSpamParry.TextSize = 14
Instance.new("UICorner", btnAutoSpamParry).CornerRadius = UDim.new(0, 6)

TweenButton(btnAutoSpamParry)

btnAutoSpamParry.MouseButton1Click:Connect(function()
    AutoSpamParryActive = not AutoSpamParryActive
    btnAutoSpamParry.Text = "SPAM PARRY: " .. (AutoSpamParryActive and "ON" or "OFF")
    btnAutoSpamParry.BackgroundColor3 = AutoSpamParryActive and Color3.fromRGB(80, 150, 80) or Color3.fromRGB(45, 45, 55)
end)

local discordSection = Instance.new("TextLabel", content)
discordSection.Size = UDim2.new(1, 0, 0, 30)
discordSection.Position = UDim2.new(0, 0, 0, 180)
discordSection.BackgroundTransparency = 1
discordSection.Text = "COMUNIDADE"
discordSection.TextColor3 = Color3.fromRGB(200, 200, 200)
discordSection.Font = Enum.Font.Gotham
discordSection.TextSize = 14
discordSection.TextXAlignment = Enum.TextXAlignment.Left

local btnDiscord = Instance.new("TextButton", content)
btnDiscord.Size = UDim2.new(1, 0, 0, 40)
btnDiscord.Position = UDim2.new(0, 0, 0, 210)
btnDiscord.BackgroundColor3 = Color3.fromRGB(88, 101, 242) 
btnDiscord.Text = "COPIAR LINK DO DISCORD"
btnDiscord.TextColor3 = Color3.fromRGB(255, 255, 255)
btnDiscord.Font = Enum.Font.Gotham
btnDiscord.TextSize = 14
Instance.new("UICorner", btnDiscord).CornerRadius = UDim.new(0, 6)

TweenButton(btnDiscord)

btnDiscord.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/RBrrWsTdZn")
    
    local originalText = btnDiscord.Text
    btnDiscord.Text = "LINK COPIADO!"
    btnDiscord.BackgroundColor3 = Color3.fromRGB(80, 150, 80)
    
    wait(1.5)
    
    btnDiscord.Text = originalText
    btnDiscord.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

Balls.ChildAdded:Connect(function(Ball)
    if not VerifyBall(Ball) then return end

    local OldPosition = Ball.Position
    local OldTick = tick()

    Ball:GetPropertyChangedSignal("Position"):Connect(function()
        if not AutoParryActive and not AutoSpamParryActive then return end

        if IsTarget() then
            local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude
            local Velocity = (OldPosition - Ball.Position).Magnitude

            if (Distance / Velocity) <= 10 then
                Parry()
                
                if AutoSpamParryActive then
                    for i = 1, 0,01 do
                        task.wait(0.0001)
                        Parry()
                    end
                end
            end
        end

        if (tick() - OldTick >= 1/60) then
            OldTick = tick()
            OldPosition = Ball.Position
        end
    end)
end)

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
