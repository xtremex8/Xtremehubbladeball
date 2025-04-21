# Xtremehubbladeball
-- Serviços necessários
local v = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")

-- Criação da interface gráfica
local s = Instance.new("ScreenGui")
s.Name = "XtremeHubGUI"
s.Parent = game.CoreGui

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
title.Text = "Xtreme-hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.LuckiestGuy
title.TextSize = 20
title.Parent = s

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 30)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
subtitle.Text = "Blade Ball"
subtitle.TextColor3 = Color3.new(1, 1, 1)
subtitle.Font = Enum.Font.LuckiestGuy
subtitle.TextSize = 16
subtitle.Parent = s

-- Botão MANUAL SPAM
local b = Instance.new("TextButton")
b.Size = UDim2.new(0, 200, 0, 50)
b.Position = UDim2.new(0.5, -100, 0.5, -25)
b.AnchorPoint = Vector2.new(0.5, 0.5)
b.BackgroundColor3 = Color3.new(0, 0, 0)
b.BorderSizePixel = 2
b.BorderColor3 = Color3.new(1, 1, 1)
b.Text = "MANUAL SPAM"
b.TextColor3 = Color3.new(1, 1, 1)
b.TextScaled = true
b.Font = Enum.Font.LuckiestGuy
b.TextXAlignment = Enum.TextXAlignment.Center
b.TextYAlignment = Enum.TextYAlignment.Center
b.Parent = s

-- Variáveis de controle
local t = false
local d = false
local i = nil
local ds = nil
local sp = nil

-- Função para ativar/desativar o botão
b.MouseButton1Click:Connect(function()
    t = not t
    b.Text = t and "ON" or "OFF"
    while t do
        v:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.005) -- Intervalo ajustado para 5 milissegundos para maior rapidez sem abusos
    end
end)

-- Função para arrastar o botão
local function updatePosition(input)
    local delta = input.Position - ds
    b.Position = UDim2.new(
        sp.X.Scale,
        sp.X.Offset + delta.X,
        sp.Y.Scale,
        sp.Y.Offset + delta.Y
    )
end

b.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        d = true
        ds = input.Position
        sp = b.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                d = false
            end
        end)
    end
end)

b.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        i = input
    end
end)

uis.InputChanged:Connect(function(input)
    if d and input == i then
        updatePosition(input)
    end
end)
