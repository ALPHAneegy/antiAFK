local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

-- Anti AFK
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "TheRealDeathAntiAFK"
Gui.ResetOnSpawn = false

pcall(function()
    Gui.Parent = game:GetService("CoreGui")
end)

if not Gui.Parent then
    Gui.Parent = Player:WaitForChild("PlayerGui")
end

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 170, 0, 60)
Frame.Position = UDim2.new(0.5, -85, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,8)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-30,0,20)
Title.Position = UDim2.new(0,7,0,2)
Title.BackgroundTransparency = 1
Title.Text = "ANTI-AFK"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1,-30,0,15)
Credit.Position = UDim2.new(0,7,0,20)
Credit.BackgroundTransparency = 1
Credit.Text = "By TheRealDeath"
Credit.TextColor3 = Color3.fromRGB(160,160,160)
Credit.TextSize = 9
Credit.Font = Enum.Font.Gotham
Credit.TextXAlignment = Enum.TextXAlignment.Left
Credit.Parent = Frame

local Timer = Instance.new("TextLabel")
Timer.Size = UDim2.new(1,-14,0,20)
Timer.Position = UDim2.new(0,7,0,37)
Timer.BackgroundTransparency = 1
Timer.Text = "AFK: 00:00:00"
Timer.TextColor3 = Color3.fromRGB(80,255,100)
Timer.TextSize = 12
Timer.Font = Enum.Font.GothamBold
Timer.TextXAlignment = Enum.TextXAlignment.Left
Timer.Parent = Frame

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,20,0,20)
Close.Position = UDim2.new(1,-23,0,2)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,80,80)
Close.TextSize = 14
Close.Font = Enum.Font.GothamBold
Close.Parent = Frame

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- Contador
local Inicio = os.time()

task.spawn(function()
    while Gui.Parent do
        local Tiempo = os.time() - Inicio

        local Horas = math.floor(Tiempo / 3600)
        local Minutos = math.floor((Tiempo % 3600) / 60)
        local Segundos = Tiempo % 60

        Timer.Text = string.format(
            "AFK: %02d:%02d:%02d",
            Horas,
            Minutos,
            Segundos
        )

        task.wait(1)
    end
end)

-- Mover ventana en móvil/PC
local Moviendo = false
local InicioMouse
local InicioFrame

Frame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Moviendo = true
        InicioMouse = Input.Position
        InicioFrame = Frame.Position
    end
end)

UIS.InputChanged:Connect(function(Input)
    if Moviendo and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - InicioMouse

        Frame.Position = UDim2.new(
            InicioFrame.X.Scale,
            InicioFrame.X.Offset + Delta.X,
            InicioFrame.Y.Scale,
            InicioFrame.Y.Offset + Delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then
        Moviendo = false
    end
end)
