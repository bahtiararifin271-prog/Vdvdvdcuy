-- =========================================================
-- SECTION 1/7 : LOADING + CONFIG + STATE (RED W)
-- =========================================================

Players = game:GetService("Players")
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
VirtualInputManager = game:GetService("VirtualInputManager")
Stats = game:GetService("Stats")
GuiService = game:GetService("GuiService")
SoundService = game:GetService("SoundService")
StarterGui = game:GetService("StarterGui")

LP = Players.LocalPlayer
PG = LP:WaitForChild("PlayerGui")

function getRoot()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

C = {
    BG = Color3.fromRGB(15, 5, 5),
    BG2 = Color3.fromRGB(25, 8, 8),
    PANEL = Color3.fromRGB(40, 12, 12),
    PANEL2 = Color3.fromRGB(55, 18, 18),
    RED = Color3.fromRGB(255, 50, 50),
    RED_LIGHT = Color3.fromRGB(255, 120, 120),
    RED_DARK = Color3.fromRGB(180, 20, 20),
    ORANGE = Color3.fromRGB(255, 100, 60),
    ACC = Color3.fromRGB(255, 50, 50),
    ACC2 = Color3.fromRGB(255, 120, 120),
    ACC3 = Color3.fromRGB(255, 100, 60),
    FIRE_BRIGHT = Color3.fromRGB(255, 200, 200),
    TXT = Color3.fromRGB(255, 240, 240),
    DIM = Color3.fromRGB(180, 80, 80),
    GRN = Color3.fromRGB(80, 255, 150),
    RED_DEEP = Color3.fromRGB(255, 70, 100),
    CYAN = Color3.fromRGB(80, 240, 255),
}

function rnd(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = o
end

function strk(o, col, t, tr)
    local s = Instance.new("UIStroke")
    s.Color = col or C.RED
    s.Thickness = t or 1.5
    s.Transparency = tr or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local ToggleSoundId = "rbxassetid://6073491164"
local _toggleSoundInstance = nil
function playToggleSound()
    task.spawn(function()
        pcall(function()
            if not _toggleSoundInstance or not _toggleSoundInstance.Parent then
                _toggleSoundInstance = Instance.new("Sound")
                _toggleSoundInstance.SoundId = ToggleSoundId
                _toggleSoundInstance.Volume = 0.5
                _toggleSoundInstance.Parent = SoundService
            end
            _toggleSoundInstance:Play()
        end)
    end)
end
_G.Roooor_playSound = playToggleSound

-- =========================================================
-- LOADING RED GALAXY
-- =========================================================
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "RedWLoading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 999999
loadingGui.Parent = PG

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 2, 2)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

local nebula = Instance.new("Frame")
nebula.Size = UDim2.new(1, 0, 1, 0)
nebula.BackgroundColor3 = Color3.fromRGB(35, 5, 5)
nebula.BorderSizePixel = 0
nebula.BackgroundTransparency = 0.3
nebula.Parent = bg

local nebulaGrad = Instance.new("UIGradient")
nebulaGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(180, 20, 20)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(60, 10, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 80, 80)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(80, 15, 15)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(200, 30, 30)),
})
nebulaGrad.Rotation = 45
nebulaGrad.Parent = nebula

task.spawn(function()
    local t = 0
    while nebula.Parent do
        t = t + 0.005
        nebulaGrad.Rotation = (t * 20) % 360
        task.wait(0.08)
    end
end)

local starContainer = Instance.new("Frame")
starContainer.Size = UDim2.new(1, 0, 1, 0)
starContainer.BackgroundTransparency = 1
starContainer.Parent = bg

local stars = {}
for i = 1, 20 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(math.random(220, 255), math.random(80, 150), math.random(80, 150))
    star.BorderSizePixel = 0
    star.BackgroundTransparency = math.random(20, 60) / 100
    star.Parent = starContainer
    rnd(star, 999)
    table.insert(stars, {
        obj = star,
        speed = math.random(10, 40) / 10000,
        twinkle = math.random() * math.pi * 2
    })
end

task.spawn(function()
    while starContainer.Parent do
        for _, s in ipairs(stars) do
            if s.obj and s.obj.Parent then
                local p = s.obj.Position
                local newY = p.Y.Scale + s.speed
                if newY > 1 then
                    newY = 0
                    s.obj.Position = UDim2.new(math.random(), 0, 0, 0)
                else
                    s.obj.Position = UDim2.new(p.X.Scale, 0, newY, 0)
                end
                s.twinkle = s.twinkle + 0.1
                s.obj.BackgroundTransparency = 0.4 + math.sin(s.twinkle) * 0.3
            end
        end
        task.wait(0.12)
    end
end)

local galaxyHolder = Instance.new("Frame")
galaxyHolder.Size = UDim2.new(0, 400, 0, 400)
galaxyHolder.Position = UDim2.new(0.5, -200, 0.5, -200)
galaxyHolder.BackgroundTransparency = 1
galaxyHolder.Parent = bg

local spiral1 = Instance.new("Frame")
spiral1.Size = UDim2.new(0, 300, 0, 300)
spiral1.Position = UDim2.new(0.5, -150, 0.5, -150)
spiral1.BackgroundTransparency = 1
spiral1.Parent = galaxyHolder

local spiral1Stroke = Instance.new("UIStroke")
spiral1Stroke.Thickness = 60
spiral1Stroke.Transparency = 0.85
spiral1Stroke.Color = Color3.fromRGB(255, 50, 50)
spiral1Stroke.Parent = spiral1
rnd(spiral1, 999)

local spiral1Grad = Instance.new("UIGradient")
spiral1Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 100, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 180, 180)),
})
spiral1Grad.Parent = spiral1Stroke

local spiral2 = Instance.new("Frame")
spiral2.Size = UDim2.new(0, 260, 0, 260)
spiral2.Position = UDim2.new(0.5, -130, 0.5, -130)
spiral2.BackgroundTransparency = 1
spiral2.Parent = galaxyHolder

local spiral2Stroke = Instance.new("UIStroke")
spiral2Stroke.Thickness = 40
spiral2Stroke.Transparency = 0.88
spiral2Stroke.Color = Color3.fromRGB(255, 180, 180)
spiral2Stroke.Parent = spiral2
rnd(spiral2, 999)

local spiral2Grad = Instance.new("UIGradient")
spiral2Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 180, 180)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 60)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 50, 50)),
})
spiral2Grad.Rotation = 180
spiral2Grad.Parent = spiral2Stroke

task.spawn(function()
    local t = 0
    while galaxyHolder.Parent do
        t = t + 1
        spiral1.Rotation = t * 0.8
        spiral2.Rotation = -t * 1.1
        spiral1Grad.Rotation = (t * 2) % 360
        spiral2Grad.Rotation = 180 + (t * 1.5) % 360
        task.wait(0.08)
    end
end)

local titleGlow = Instance.new("Frame")
titleGlow.Size = UDim2.new(0, 500, 0, 100)
titleGlow.Position = UDim2.new(0.5, -250, 0.42, -50)
titleGlow.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
titleGlow.BackgroundTransparency = 0.85
titleGlow.BorderSizePixel = 0
titleGlow.Parent = bg
rnd(titleGlow, 999)

local glowGrad = Instance.new("UIGradient")
glowGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 100, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 180, 180)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 50, 50)),
})
glowGrad.Parent = titleGlow

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Size = UDim2.new(1, 0, 0, 90)
welcomeTitle.Position = UDim2.new(0, 0, 0.42, -20)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Text = "RED W"
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 0
welcomeTitle.Font = Enum.Font.GothamBlack
welcomeTitle.TextStrokeTransparency = 0.4
welcomeTitle.TextStrokeColor3 = Color3.fromRGB(255, 50, 50)
welcomeTitle.Parent = bg

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 180, 180)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 60)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 180, 180)),
})
titleGrad.Parent = welcomeTitle

task.spawn(function()
    local t = 0
    while welcomeTitle.Parent do
        t = t + 1
        titleGrad.Rotation = (t * 2) % 360
        task.wait(0.08)
    end
end)

TweenService:Create(welcomeTitle, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    TextSize = 68,
    TextTransparency = 0
}):Play()

task.spawn(function()
    task.wait(1.2)
    while titleGlow.Parent do
        TweenService:Create(titleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.6,
            Size = UDim2.new(0, 560, 0, 120),
            Position = UDim2.new(0.5, -280, 0.42, -60)
        }):Play()
        task.wait(1.3)
        TweenService:Create(titleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.85,
            Size = UDim2.new(0, 500, 0, 100),
            Position = UDim2.new(0.5, -250, 0.42, -50)
        }):Play()
        task.wait(1.3)
    end
end)

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.Position = UDim2.new(0, 0, 0.42, 70)
subtitle.BackgroundTransparency = 1
subtitle.Text = "L O A D I N G"
subtitle.TextColor3 = Color3.fromRGB(255, 200, 200)
subtitle.TextSize = 14
subtitle.Font = Enum.Font.GothamBold
subtitle.TextStrokeTransparency = 0.5
subtitle.TextStrokeColor3 = Color3.fromRGB(120, 20, 20)
subtitle.TextTransparency = 1
subtitle.Parent = bg

TweenService:Create(subtitle, TweenInfo.new(1), {TextTransparency = 0}):Play()

task.spawn(function()
    task.wait(1)
    while subtitle.Parent do
        TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0.4}):Play()
        task.wait(0.9)
        TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
        task.wait(0.9)
    end
end)

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 320, 0, 4)
barBg.Position = UDim2.new(0.5, -160, 0.42, 110)
barBg.BackgroundColor3 = Color3.fromRGB(50, 10, 10)
barBg.BorderSizePixel = 0
barBg.BackgroundTransparency = 0.4
barBg.Parent = bg
rnd(barBg, 999)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
rnd(barFill, 999)

local barFillGrad = Instance.new("UIGradient")
barFillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 100, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 180, 180)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 50, 50)),
})
barFillGrad.Parent = barFill

TweenService:Create(barFill, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

local barGlow = Instance.new("Frame")
barGlow.Size = UDim2.new(1, 12, 2, 12)
barGlow.Position = UDim2.new(0, -6, 0, -6)
barGlow.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
barGlow.BackgroundTransparency = 0.7
barGlow.BorderSizePixel = 0
barGlow.ZIndex = -1
barGlow.Parent = barBg
rnd(barGlow, 999)

task.delay(1.6, function()
    if not loadingGui then return end
    if bg and bg.Parent then
        TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    end
    if welcomeTitle and welcomeTitle.Parent then
        TweenService:Create(welcomeTitle, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    end
    if subtitle and subtitle.Parent then
        TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    end
    if nebula and nebula.Parent then
        TweenService:Create(nebula, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    end
    if titleGlow and titleGlow.Parent then
        TweenService:Create(titleGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    if barBg and barBg.Parent then
        TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    if barGlow and barGlow.Parent then
        TweenService:Create(barGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    task.wait(0.8)
    if loadingGui then loadingGui:Destroy() end
end)

-- =========================================================
-- STATE
-- =========================================================
S = _G.RedWS or {
    WalkSpeed = false,
    SpeedHack = false,
    SpeedHackVal = 40,
    NoClip = false,
    NoClipCamera = false,
}
_G.RedWS = S

ESP = _G.RedW_ESP or {
    Survivor = true, Killer = true, Generator = true,
    Distance = 1000,
}
_G.RedW_ESP = ESP

TeamColors = _G.RedW_TeamColors or {
    Killer = Color3.fromRGB(255, 60, 60),
    Survivor = Color3.fromRGB(80, 150, 255),
}
_G.RedW_TeamColors = TeamColors

GeneratorColor = Color3.fromRGB(255, 100, 60)

AutoParry = _G.RedW_AutoParry or {
    Enabled = false, ParryDistance = 20,
    Wiggle = false, WiggleSpam = 5,
}
_G.RedW_AutoParry = AutoParry

-- Soft Cinematic State
GraphicState = _G.RedW_GraphicState or {
    SoftCinematic = false,
    LowGraphics = false,
    FullBright = false,
    NoFog = false,
    NoAnimation = false,
    NoParticle = false,
    NoGrass = false,
    CleanSky = false,
    Time = 18,
    SelectedPreset = "Soft",
}
_G.RedW_GraphicState = GraphicState

_G.ToggleStates = _G.ToggleStates or {}
_G.SliderStates = _G.SliderStates or {}
_G.DropdownStates = _G.DropdownStates or {}

print("✅ [1/7] RED W - Base Loaded")-- =========================================================
-- SECTION 2/7 : AUTO PARRY + ESP LOGIC
-- =========================================================

-- =========================================================
-- KILLER ANIMS (buat deteksi attack)
-- =========================================================
KillerAnims = {}
for _, id in ipairs({
    "105374834496520","113255068724446","118907603246885","129784271201071",
    "117042998468241","122812055447896","78935059863801","74968262036854",
    "78432063483146","132817836308238","133963973694098","111920872708571",
    "80411309607666","98163597193511","82666958311998","110355011987939",
    "139369275981139","135002183282873","121216847022485","130593238885843",
    "117070354890871","106871536134254","138720291317243",
    "127096285501517","112166042383605","123047897844134",
    "126965695851149","135084204086504"
}) do
    KillerAnims["rbxassetid://"..id] = true
end

SkipAnims = {
    ["112166042383605"] = "Break Pallet",
    ["123047897844134"] = "Stun",
    ["126965695851149"] = "WalkCrouch",
    ["135084204086504"] = "WalkCrouch Injured",
    ["127096285501517"] = "Parry Anim",
}

-- =========================================================
-- ESP LOGIC
-- =========================================================
ESPObjects = {}
CachedSCP = {}
Cached = { Generators = {}, Windows = {}, Pallets = {} }

function cacheObject(obj)
    if obj.Name == "Generator" then
        Cached.Generators[obj] = true
    elseif obj.Name == "Window" then
        Cached.Windows[obj] = true
    elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        Cached.Pallets[obj] = true
    end
    local name = string.lower(obj.Name)
    if string.find(name, "scp") then
        CachedSCP[obj] = true
    end
end

function removeCache(obj)
    Cached.Generators[obj] = nil
    Cached.Windows[obj] = nil
    Cached.Pallets[obj] = nil
    CachedSCP[obj] = nil
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do cacheObject(obj) end
workspace.DescendantAdded:Connect(cacheObject)
workspace.DescendantRemoving:Connect(removeCache)

function createESP(obj, color)
    if not obj then return end
    if ESPObjects[obj] then
        if ESPObjects[obj].FillColor ~= color then
            ESPObjects[obj].FillColor = color
            ESPObjects[obj].OutlineColor = color
        end
        return
    end
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj
    ESPObjects[obj] = h
    obj.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if ESPObjects[obj] then
                ESPObjects[obj]:Destroy()
                ESPObjects[obj] = nil
            end
        end
    end)
end

function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

function GetGameValue(obj, name)
    if not obj then return nil end
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
    local child = obj:FindFirstChild(name)
    if child and child:IsA("ValueBase") then
        local ok, val = pcall(function() return child.Value end)
        if ok then return val end
    end
    return nil
end

function GetGeneratorProgress(gen)
    if not gen then return 0 end
    local names = {
        "RepairProgress", "Progress", "Value", "RepairValue",
        "ProgressValue", "GenProgress", "Repaired", "Repair",
        "Percent", "Percentage", "RepairPercent"
    }
    for _, n in ipairs(names) do
        local v = GetGameValue(gen, n)
        if v ~= nil and type(v) == "number" then return v end
    end
    for _, d in ipairs(gen:GetDescendants()) do
        if d:IsA("ValueBase") then
            local ln = string.lower(d.Name)
            if ln:find("progress") or ln:find("repair")
               or ln:find("percent") or ln:find("value") then
                local ok, val = pcall(function() return d.Value end)
                if ok and type(val) == "number" then return val end
            end
        end
    end
    for _, attrName in ipairs(gen:GetAttributes()) do
        local v = gen:GetAttribute(attrName)
        if type(v) == "number" and v >= 0 and v <= 100 then
            local lower = string.lower(attrName)
            if lower:find("progress") or lower:find("repair")
               or lower:find("value") or lower:find("percent") then
                return v
            end
        end
    end
    return 0
end

function ApplyGenHighlight(object, color)
    if not object then return end
    local h = object:FindFirstChild("GenHighlight") or Instance.new("Highlight")
    h.Name = "GenHighlight"
    h.Adornee = object
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = object
end

function UpdateGenerator(generator)
    if not generator or not generator.Parent then return end
    if not ESP.Generator then
        local a = generator:FindFirstChild("GenESP")
        if a then a:Destroy() end
        local b = generator:FindFirstChild("GenESPBar")
        if b then b:Destroy() end
        local h = generator:FindFirstChild("GenHighlight")
        if h then h:Destroy() end
        return
    end
    local percent = GetGeneratorProgress(generator)
    local cp = math.clamp(percent, 0, 100)
    if percent >= 100 then
        local old = generator:FindFirstChild("GenESPBar")
        if old then old:Destroy() end
        local h = generator:FindFirstChild("GenHighlight")
        if h then h:Destroy() end
        return
    end
    local barSize = 64
    local barHeight = 8
    local textSize = 10
    local billboard = generator:FindFirstChild("GenESPBar")
    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "GenESPBar"
        billboard.Size = UDim2.new(0, barSize, 0, barHeight)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 1.5, 0)
        billboard.Adornee = generator
        billboard.Parent = generator
        local barBg = Instance.new("Frame")
        barBg.Name = "BarBg"
        barBg.Size = UDim2.new(1, 0, 1, 0)
        barBg.BackgroundColor3 = Color3.fromRGB(30, 5, 5)
        barBg.BorderSizePixel = 0
        barBg.Parent = billboard
        local bbc = Instance.new("UICorner")
        bbc.CornerRadius = UDim.new(1, 0)
        bbc.Parent = barBg
        local barFill = Instance.new("Frame")
        barFill.Name = "BarFill"
        barFill.Size = UDim2.new(0, 0, 1, 0)
        barFill.BackgroundColor3 = Color3.fromRGB(255, 100, 60)
        barFill.BorderSizePixel = 0
        barFill.Parent = barBg
        local bfc = Instance.new("UICorner")
        bfc.CornerRadius = UDim.new(1, 0)
        bfc.Parent = barFill
        local pctText = Instance.new("TextLabel")
        pctText.Name = "PctText"
        pctText.Size = UDim2.new(1, 0, 1, 0)
        pctText.BackgroundTransparency = 1
        pctText.Text = "0%"
        pctText.TextColor3 = Color3.fromRGB(255, 255, 255)
        pctText.TextSize = textSize
        pctText.Font = Enum.Font.GothamBold
        pctText.TextXAlignment = Enum.TextXAlignment.Center
        pctText.TextYAlignment = Enum.TextYAlignment.Center
        pctText.TextStrokeTransparency = 0.2
        pctText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        pctText.ZIndex = 10
        pctText.Parent = barBg
    end
    local barBg = billboard:FindFirstChild("BarBg")
    if barBg then
        local barFill = barBg:FindFirstChild("BarFill")
        local pctText = barBg:FindFirstChild("PctText")
        if barFill then barFill.Size = UDim2.new(cp / 100, 0, 1, 0) end
        if pctText then pctText.Text = string.format("%.0f%%", percent) end
    end
    local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
    ApplyGenHighlight(generator, color)
end

-- =========================================================
-- AUTO PARRY LOGIC
-- =========================================================
AP_parryCount = 0
AP_hookedKillers = _G.RedW_APHooked or {}
_G.RedW_APHooked = AP_hookedKillers

AP_Config = {
    Debounce = 0.02,
    Radius = 20,
    FaceSensitivity = 0.2,
}

function AP_GetKillerType(char, player)
    local charName = string.lower(char.Name)
    local displayName = string.lower(player and player.DisplayName or "")
    local isHidden = charName:find("hidden") or displayName:find("hidden") or charName:find("617") or displayName:find("617")
    local isAbyss = charName:find("abyss") or displayName:find("abyss") or charName:find("walker") or displayName:find("walker")
    local isMasked = charName:find("masked") or displayName:find("masked") or charName:find("jacket") or displayName:find("jacket")
    return isHidden, isAbyss, isMasked
end

function AP_ShouldParry(char, player, killerRoot, myRoot, dist)
    local isHidden, isAbyss, isMasked = AP_GetKillerType(char, player)
    local velocity = killerRoot.AssemblyLinearVelocity
    local toMe = (myRoot.Position - killerRoot.Position).Unit
    local killerLook = killerRoot.CFrame.LookVector
    local faceDot = killerLook:Dot(toMe)
    if isHidden then
        if velocity.Magnitude > 20 or dist > 10 then return false, "HIDDEN MARK"
        else return true, "HIDDEN BASIC" end
    end
    if isAbyss then
        if velocity.Magnitude < 20 and dist < 12 and faceDot > 0.3 then return true, "ABYSS SLASH" end
        return false, nil
    end
    if isMasked then
        if velocity.Magnitude > 15 and dist < 15 then return true, "MASKED CHAINSAW" end
        return false, nil
    end
    if velocity.Magnitude < 25 and dist < 12 and faceDot > 0.2 then return true, "BASIC ATTACK" end
    return false, nil
end

_AP_lastParry = 0
function AP_TryParry(reason)
    local now = tick()
    local bypass = reason == "BASIC ATTACK" or reason == "ABYSS SLASH" or reason == "MASKED CHAINSAW" or reason == "HIDDEN BASIC" or reason == "PREDICTIVE"
    local debounce = bypass and 0.015 or AP_Config.Debounce
    if now - _AP_lastParry > debounce then
        _AP_lastParry = now
        AP_PressParryButton()
        AP_parryCount = AP_parryCount + 1
        return true
    end
    return false
end

function AP_GetParryButton()
    local current = PG
    for segment in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

function AP_FindParryButton()
    local btn = AP_GetParryButton()
    if btn and btn:IsA("GuiObject") and btn.Visible then return btn end
    for _, obj in pairs(PG:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if n:find("parry") or n:find("block") or n:find("guard") then
                return obj
            end
        end
    end
    return nil
end

function AP_PressRightClick()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
    task.wait(0.001)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
end

function AP_PressParryButton()
    for i = 1, 2 do
        AP_PressRightClick()
        task.wait(0.001)
    end
    if UIS.TouchEnabled then
        local btn = AP_FindParryButton()
        if btn and btn:IsA("GuiObject") then
            local pos = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X / 2 + inset.X
            local y = pos.Y + size.Y / 2 + inset.Y
            for i = 1, 2 do
                VirtualInputManager:SendTouchEvent(8823 + i, 0, x, y)
                task.wait(0.001)
                VirtualInputManager:SendTouchEvent(8823 + i, 2, x, y)
                task.wait(0.001)
            end
        end
    end
end

function AP_HookKiller(char)
    if AP_hookedKillers[char] then return end
    AP_hookedKillers[char] = true
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    animator.AnimationPlayed:Connect(function(track)
        if not AutoParry.Enabled then return end
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if not id then return end
        if SkipAnims and SkipAnims[id] then return end
        if not KillerAnims["rbxassetid://" .. id] then return end
        local myRoot = getRoot()
        local killerRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot or not killerRoot then return end
        local dist = (killerRoot.Position - myRoot.Position).Magnitude
        if dist > AP_Config.Radius then return end
        local player = Players:GetPlayerFromCharacter(char)
        local shouldParry, reason = AP_ShouldParry(char, player, killerRoot, myRoot, dist)
        if shouldParry then AP_TryParry(reason) end
    end)
end

task.spawn(function()
    while task.wait(0.001) do
        if not AutoParry.Enabled then continue end
        local myRoot = getRoot()
        if not myRoot then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local killerRoot = p.Character:FindFirstChild("HumanoidRootPart")
                local killerHum = p.Character:FindFirstChildOfClass("Humanoid")
                if killerRoot and killerHum and killerHum.Health > 0 then
                    local dist = (killerRoot.Position - myRoot.Position).Magnitude
                    if dist <= AP_Config.Radius then
                        local isAttacking = false
                        local skipReason = nil
                        local animator = killerHum:FindFirstChildOfClass("Animator")
                        if animator then
                            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                                local a = track.Animation
                                if a and a.AnimationId then
                                    local id = a.AnimationId:match("%d+")
                                    if SkipAnims and SkipAnims[id] then skipReason = SkipAnims[id] end
                                    if KillerAnims["rbxassetid://" .. id] and (not SkipAnims or not SkipAnims[id]) then isAttacking = true end
                                end
                            end
                        end
                        if skipReason then continue end
                        local velocity = killerRoot.AssemblyLinearVelocity
                        local prevVelocity = p.Character:GetAttribute("LastVelocity") or 0
                        p.Character:SetAttribute("LastVelocity", velocity.Magnitude)
                        local velocitySpike = math.abs(velocity.Magnitude - prevVelocity) > 6
                        if isAttacking or velocitySpike then
                            local shouldParry, reason = AP_ShouldParry(p.Character, p, killerRoot, myRoot, dist)
                            if velocitySpike and not reason then
                                reason = "PREDICTIVE"
                                shouldParry = true
                            end
                            if shouldParry then AP_TryParry(reason) end
                        end
                    end
                end
            end
        end
    end
end)

print("✅ [2/7] RED W - Auto Parry + ESP Logic Loaded")-- =========================================================
-- SECTION 3/7 : SOFT CINEMATIC LOGIC (XYNOZ)
-- =========================================================

Presets = {
    ["Soft"] = { Brightness = 2.00, Exposure = 0.03, ShadowSoftness = 0.075, Ambient = Color3.fromRGB(42,45,52), OutdoorAmbient = Color3.fromRGB(130,138,155), AtmosphereDensity = 0.055, AtmosphereHaze = 0.025, AtmosphereGlare = 0.08, BloomIntensity = 0.12, BloomSize = 20, BloomThreshold = 0.96, Contrast = 0.18, Saturation = 0.08, ColorBrightness = 0.01, SunRaysIntensity = 0.06, SunRaysSpread = 0.75, DOFNear = 0.01, DOFFar = 0.02, DOFFocus = 45, DOFRadius = 40 },
    ["Cinematic"] = { Brightness = 2.10, Exposure = 0.05, ShadowSoftness = 0.055, Ambient = Color3.fromRGB(32,35,42), OutdoorAmbient = Color3.fromRGB(125,132,150), AtmosphereDensity = 0.075, AtmosphereHaze = 0.045, AtmosphereGlare = 0.12, BloomIntensity = 0.18, BloomSize = 24, BloomThreshold = 0.92, Contrast = 0.24, Saturation = 0.10, ColorBrightness = 0.015, SunRaysIntensity = 0.085, SunRaysSpread = 0.72, DOFNear = 0.025, DOFFar = 0.045, DOFFocus = 45, DOFRadius = 35 },
    ["Ultra Cinematic"] = { Brightness = 2.15, Exposure = 0.07, ShadowSoftness = 0.045, Ambient = Color3.fromRGB(30,32,40), OutdoorAmbient = Color3.fromRGB(135,142,160), AtmosphereDensity = 0.065, AtmosphereHaze = 0.035, AtmosphereGlare = 0.14, BloomIntensity = 0.22, BloomSize = 27, BloomThreshold = 0.89, Contrast = 0.27, Saturation = 0.13, ColorBrightness = 0.02, SunRaysIntensity = 0.10, SunRaysSpread = 0.70, DOFNear = 0.02, DOFFar = 0.04, DOFFocus = 44, DOFRadius = 34 },
    ["Golden Hour"] = { Brightness = 2.20, Exposure = 0.08, ShadowSoftness = 0.065, Ambient = Color3.fromRGB(58,48,38), OutdoorAmbient = Color3.fromRGB(155,135,105), AtmosphereDensity = 0.07, AtmosphereHaze = 0.055, AtmosphereGlare = 0.16, BloomIntensity = 0.20, BloomSize = 26, BloomThreshold = 0.91, Contrast = 0.20, Saturation = 0.16, ColorBrightness = 0.025, SunRaysIntensity = 0.12, SunRaysSpread = 0.76, DOFNear = 0.015, DOFFar = 0.035, DOFFocus = 45, DOFRadius = 38 },
    ["Night Cinema"] = { Brightness = 1.65, Exposure = -0.02, ShadowSoftness = 0.035, Ambient = Color3.fromRGB(20,25,38), OutdoorAmbient = Color3.fromRGB(65,78,110), AtmosphereDensity = 0.085, AtmosphereHaze = 0.065, AtmosphereGlare = 0.06, BloomIntensity = 0.15, BloomSize = 24, BloomThreshold = 0.86, Contrast = 0.30, Saturation = 0.08, ColorBrightness = -0.01, SunRaysIntensity = 0.04, SunRaysSpread = 0.70, DOFNear = 0.025, DOFFar = 0.05, DOFFocus = 48, DOFRadius = 32 },
    ["Deep Shadow"] = { Brightness = 1.90, Exposure = 0.00, ShadowSoftness = 0.035, Ambient = Color3.fromRGB(25,28,35), OutdoorAmbient = Color3.fromRGB(105,112,130), AtmosphereDensity = 0.07, AtmosphereHaze = 0.04, AtmosphereGlare = 0.08, BloomIntensity = 0.14, BloomSize = 22, BloomThreshold = 0.94, Contrast = 0.30, Saturation = 0.08, ColorBrightness = 0.005, SunRaysIntensity = 0.07, SunRaysSpread = 0.74, DOFNear = 0.02, DOFFar = 0.035, DOFFocus = 48, DOFRadius = 34 },
    ["Crystal"] = { Brightness = 2.35, Exposure = 0.10, ShadowSoftness = 0.065, Ambient = Color3.fromRGB(48,52,60), OutdoorAmbient = Color3.fromRGB(150,158,175), AtmosphereDensity = 0.035, AtmosphereHaze = 0.018, AtmosphereGlare = 0.10, BloomIntensity = 0.10, BloomSize = 18, BloomThreshold = 1.00, Contrast = 0.15, Saturation = 0.05, ColorBrightness = 0.025, SunRaysIntensity = 0.055, SunRaysSpread = 0.78, DOFNear = 0.01, DOFFar = 0.025, DOFFocus = 46, DOFRadius = 42 },
    ["Dreamy"] = { Brightness = 2.10, Exposure = 0.06, ShadowSoftness = 0.09, Ambient = Color3.fromRGB(50,48,58), OutdoorAmbient = Color3.fromRGB(140,135,155), AtmosphereDensity = 0.10, AtmosphereHaze = 0.08, AtmosphereGlare = 0.13, BloomIntensity = 0.25, BloomSize = 30, BloomThreshold = 0.88, Contrast = 0.12, Saturation = 0.10, ColorBrightness = 0.025, SunRaysIntensity = 0.08, SunRaysSpread = 0.80, DOFNear = 0.03, DOFFar = 0.055, DOFFocus = 44, DOFRadius = 45 },
    ["Vivid Cinema"] = { Brightness = 2.20, Exposure = 0.06, ShadowSoftness = 0.055, Ambient = Color3.fromRGB(35,40,45), OutdoorAmbient = Color3.fromRGB(135,145,160), AtmosphereDensity = 0.055, AtmosphereHaze = 0.025, AtmosphereGlare = 0.10, BloomIntensity = 0.18, BloomSize = 23, BloomThreshold = 0.91, Contrast = 0.28, Saturation = 0.22, ColorBrightness = 0.015, SunRaysIntensity = 0.09, SunRaysSpread = 0.73, DOFNear = 0.015, DOFFar = 0.035, DOFFocus = 45, DOFRadius = 36 },
    ["Dark Cinema"] = { Brightness = 1.80, Exposure = -0.03, ShadowSoftness = 0.04, Ambient = Color3.fromRGB(18,20,26), OutdoorAmbient = Color3.fromRGB(88,92,110), AtmosphereDensity = 0.075, AtmosphereHaze = 0.05, AtmosphereGlare = 0.05, BloomIntensity = 0.12, BloomSize = 21, BloomThreshold = 0.95, Contrast = 0.34, Saturation = 0.04, ColorBrightness = -0.005, SunRaysIntensity = 0.04, SunRaysSpread = 0.70, DOFNear = 0.025, DOFFar = 0.045, DOFFocus = 48, DOFRadius = 30 },
    ["Cloudy Soft"] = { Brightness = 2.00, Exposure = 0.02, ShadowSoftness = 0.10, Ambient = Color3.fromRGB(55,58,65), OutdoorAmbient = Color3.fromRGB(145,148,158), AtmosphereDensity = 0.11, AtmosphereHaze = 0.09, AtmosphereGlare = 0.07, BloomIntensity = 0.10, BloomSize = 20, BloomThreshold = 0.97, Contrast = 0.10, Saturation = 0.03, ColorBrightness = 0.01, SunRaysIntensity = 0.035, SunRaysSpread = 0.82, DOFNear = 0.025, DOFFar = 0.05, DOFFocus = 46, DOFRadius = 43 },
    ["Film Look"] = { Brightness = 2.05, Exposure = 0.03, ShadowSoftness = 0.06, Ambient = Color3.fromRGB(40,40,42), OutdoorAmbient = Color3.fromRGB(125,125,130), AtmosphereDensity = 0.06, AtmosphereHaze = 0.035, AtmosphereGlare = 0.08, BloomIntensity = 0.09, BloomSize = 19, BloomThreshold = 0.98, Contrast = 0.30, Saturation = -0.02, ColorBrightness = 0.005, SunRaysIntensity = 0.065, SunRaysSpread = 0.74, DOFNear = 0.02, DOFFar = 0.04, DOFFocus = 45, DOFRadius = 37 },
    ["Moonlight"] = { Brightness = 1.70, Exposure = -0.01, ShadowSoftness = 0.03, Ambient = Color3.fromRGB(22,28,45), OutdoorAmbient = Color3.fromRGB(70,88,125), AtmosphereDensity = 0.09, AtmosphereHaze = 0.07, AtmosphereGlare = 0.04, BloomIntensity = 0.17, BloomSize = 25, BloomThreshold = 0.85, Contrast = 0.25, Saturation = 0.06, ColorBrightness = 0.00, SunRaysIntensity = 0.03, SunRaysSpread = 0.68, DOFNear = 0.02, DOFFar = 0.045, DOFFocus = 49, DOFRadius = 34 },
    ["Bright Cinema"] = { Brightness = 2.45, Exposure = 0.12, ShadowSoftness = 0.07, Ambient = Color3.fromRGB(52,55,62), OutdoorAmbient = Color3.fromRGB(165,170,185), AtmosphereDensity = 0.045, AtmosphereHaze = 0.025, AtmosphereGlare = 0.14, BloomIntensity = 0.16, BloomSize = 23, BloomThreshold = 0.95, Contrast = 0.18, Saturation = 0.09, ColorBrightness = 0.035, SunRaysIntensity = 0.10, SunRaysSpread = 0.78, DOFNear = 0.01, DOFFar = 0.025, DOFFocus = 45, DOFRadius = 40 },
    ["Ultra Soft"] = { Brightness = 2.05, Exposure = 0.04, ShadowSoftness = 0.12, Ambient = Color3.fromRGB(58,60,68), OutdoorAmbient = Color3.fromRGB(145,148,160), AtmosphereDensity = 0.08, AtmosphereHaze = 0.065, AtmosphereGlare = 0.08, BloomIntensity = 0.08, BloomSize = 18, BloomThreshold = 1.00, Contrast = 0.08, Saturation = 0.04, ColorBrightness = 0.015, SunRaysIntensity = 0.045, SunRaysSpread = 0.82, DOFNear = 0.025, DOFFar = 0.055, DOFFocus = 45, DOFRadius = 46 },
    ["Performance Cinema"] = { Brightness = 2.00, Exposure = 0.03, ShadowSoftness = 0.08, Ambient = Color3.fromRGB(40,43,50), OutdoorAmbient = Color3.fromRGB(125,132,148), AtmosphereDensity = 0.04, AtmosphereHaze = 0.02, AtmosphereGlare = 0.05, BloomIntensity = 0.07, BloomSize = 16, BloomThreshold = 1.00, Contrast = 0.14, Saturation = 0.06, ColorBrightness = 0.01, SunRaysIntensity = 0.035, SunRaysSpread = 0.75, DOFNear = 0, DOFFar = 0, DOFFocus = 45, DOFRadius = 30 },
}

PresetOrder = {
    "Soft","Cinematic","Ultra Cinematic","Golden Hour","Night Cinema",
    "Deep Shadow","Crystal","Dreamy","Vivid Cinema","Dark Cinema",
    "Cloudy Soft","Film Look","Moonlight","Bright Cinema","Ultra Soft",
    "Performance Cinema",
}

OriginalLighting = {
    Brightness = Lighting.Brightness,
    ExposureCompensation = Lighting.ExposureCompensation,
    ShadowSoftness = Lighting.ShadowSoftness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
    ClockTime = Lighting.ClockTime,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
}

PartBackup = {}
ParticleBackup = {}
TextureBackup = {}
AnimationBackup = {}
CloudBackup = {}
CreatedEffects = {}

function CreateEffect(className, name)
    local old = Lighting:FindFirstChild(name)
    if old and old.ClassName == className then
        CreatedEffects[name] = old
        return old
    end
    if old then old:Destroy() end
    local effect = Instance.new(className)
    effect.Name = name
    effect.Parent = Lighting
    CreatedEffects[name] = effect
    return effect
end

function RemoveCreatedEffects()
    for name, effect in pairs(CreatedEffects) do
        if effect and effect.Parent then effect:Destroy() end
        CreatedEffects[name] = nil
    end
end

function ApplyCharacterShadow()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if PartBackup[obj] == nil then
                PartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = true
        end
    end
end

function RestorePartShadows()
    for part, oldValue in pairs(PartBackup) do
        if part and part.Parent then
            part.CastShadow = oldValue
        end
    end
    table.clear(PartBackup)
end

function ApplyAtmosphereState()
    local atmosphere = Lighting:FindFirstChild("RedW_Atmosphere")
    if not atmosphere then return end
    if GraphicState.NoFog then
        atmosphere.Density = 0
        atmosphere.Haze = 0
        atmosphere.Glare = 0
        return
    end
    if GraphicState.CleanSky then
        atmosphere.Density = 0.015
        atmosphere.Haze = 0.005
        atmosphere.Glare = 0
        return
    end
    local cfg = Presets[GraphicState.SelectedPreset]
    atmosphere.Density = cfg.AtmosphereDensity
    atmosphere.Haze = cfg.AtmosphereHaze
    atmosphere.Glare = cfg.AtmosphereGlare
end

function ApplySoftCinematicLighting()
    local cfg = Presets[GraphicState.SelectedPreset]
    if not cfg then return end

    Lighting.Brightness = cfg.Brightness
    Lighting.ExposureCompensation = cfg.Exposure
    Lighting.ShadowSoftness = cfg.ShadowSoftness
    Lighting.Ambient = cfg.Ambient
    Lighting.OutdoorAmbient = cfg.OutdoorAmbient
    Lighting.GlobalShadows = true
    Lighting.EnvironmentDiffuseScale = 0.90
    Lighting.EnvironmentSpecularScale = 1

    local atmosphere = CreateEffect("Atmosphere", "RedW_Atmosphere")
    atmosphere.Color = Color3.fromRGB(205,215,235)
    atmosphere.Decay = Color3.fromRGB(100,110,130)

    local bloom = CreateEffect("BloomEffect", "RedW_Bloom")
    bloom.Intensity = cfg.BloomIntensity
    bloom.Size = cfg.BloomSize
    bloom.Threshold = cfg.BloomThreshold

    local color = CreateEffect("ColorCorrectionEffect", "RedW_ColorCorrection")
    color.Contrast = cfg.Contrast
    color.Saturation = cfg.Saturation
    color.Brightness = cfg.ColorBrightness

    local rays = CreateEffect("SunRaysEffect", "RedW_SunRays")
    rays.Intensity = cfg.SunRaysIntensity
    rays.Spread = cfg.SunRaysSpread

    local dof = CreateEffect("DepthOfFieldEffect", "RedW_DOF")
    dof.NearIntensity = cfg.DOFNear
    dof.FarIntensity = cfg.DOFFar
    dof.FocusDistance = cfg.DOFFocus
    dof.InFocusRadius = cfg.DOFRadius

    ApplyAtmosphereState()
    ApplyCharacterShadow()
end

function EnableSoftCinematic()
    if GraphicState.LowGraphics then
        GraphicState.LowGraphics = false
    end
    GraphicState.SoftCinematic = true
    ApplySoftCinematicLighting()
end

function DisableSoftCinematic()
    GraphicState.SoftCinematic = false
    RemoveCreatedEffects()
    RestorePartShadows()
    Lighting.Brightness = OriginalLighting.Brightness
    Lighting.ExposureCompensation = OriginalLighting.ExposureCompensation
    Lighting.ShadowSoftness = OriginalLighting.ShadowSoftness
    Lighting.Ambient = OriginalLighting.Ambient
    Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
    Lighting.GlobalShadows = OriginalLighting.GlobalShadows
    Lighting.EnvironmentDiffuseScale = OriginalLighting.EnvironmentDiffuseScale
    Lighting.EnvironmentSpecularScale = OriginalLighting.EnvironmentSpecularScale
end

function SelectPreset(name)
    if not Presets[name] then return end
    GraphicState.SelectedPreset = name
    if GraphicState.SoftCinematic then
        ApplySoftCinematicLighting()
    end
end

function EnableLowGraphics()
    if GraphicState.SoftCinematic then
        DisableSoftCinematic()
    end
    GraphicState.LowGraphics = true
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
           or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            if ParticleBackup[obj] == nil then
                ParticleBackup[obj] = obj.Enabled
            end
            obj.Enabled = false
        elseif obj:IsA("Texture") or obj:IsA("Decal") then
            if TextureBackup[obj] == nil then
                TextureBackup[obj] = obj.Transparency
            end
            obj.Transparency = math.max(obj.Transparency, 0.5)
        elseif obj:IsA("BasePart") then
            if PartBackup[obj] == nil then
                PartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = false
        end
    end
    Lighting.GlobalShadows = false
    Lighting.EnvironmentDiffuseScale = 0.35
    Lighting.EnvironmentSpecularScale = 0.15
end

function DisableLowGraphics()
    GraphicState.LowGraphics = false
    for obj, oldValue in pairs(ParticleBackup) do
        if obj and obj.Parent then obj.Enabled = oldValue end
    end
    for obj, oldValue in pairs(TextureBackup) do
        if obj and obj.Parent then obj.Transparency = oldValue end
    end
    table.clear(ParticleBackup)
    table.clear(TextureBackup)
    RestorePartShadows()
    Lighting.GlobalShadows = OriginalLighting.GlobalShadows
    Lighting.EnvironmentDiffuseScale = OriginalLighting.EnvironmentDiffuseScale
    Lighting.EnvironmentSpecularScale = OriginalLighting.EnvironmentSpecularScale
end

function ApplyFullBright()
    if GraphicState.FullBright then
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 0.25
        Lighting.Ambient = Color3.fromRGB(180,180,180)
        Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)
    else
        if GraphicState.SoftCinematic then
            ApplySoftCinematicLighting()
        elseif not GraphicState.LowGraphics then
            Lighting.Brightness = OriginalLighting.Brightness
            Lighting.ExposureCompensation = OriginalLighting.ExposureCompensation
            Lighting.Ambient = OriginalLighting.Ambient
            Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
        end
    end
end

function ApplyNoFog()
    if GraphicState.NoFog then
        Lighting.FogStart = 100000
        Lighting.FogEnd = 100000
    else
        Lighting.FogStart = OriginalLighting.FogStart
        Lighting.FogEnd = OriginalLighting.FogEnd
    end
    if GraphicState.SoftCinematic then
        ApplyAtmosphereState()
    end
end

function ApplyCleanSky()
    if GraphicState.CleanSky then
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("Clouds") then
                if CloudBackup[obj] == nil then
                    CloudBackup[obj] = obj.Enabled
                end
                obj.Enabled = false
            end
        end
    else
        for obj, oldValue in pairs(CloudBackup) do
            if obj and obj.Parent then obj.Enabled = oldValue end
        end
        table.clear(CloudBackup)
    end
    if GraphicState.SoftCinematic then
        ApplyAtmosphereState()
    end
end

function ApplyNoParticle()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
           or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            if GraphicState.NoParticle then
                if ParticleBackup[obj] == nil then
                    ParticleBackup[obj] = obj.Enabled
                end
                obj.Enabled = false
            else
                if ParticleBackup[obj] ~= nil then
                    obj.Enabled = ParticleBackup[obj]
                    ParticleBackup[obj] = nil
                end
            end
        end
    end
end

function ApplyGrass()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Terrain") then
            if GraphicState.NoGrass then
                obj.Decoration = false
            else
                obj.Decoration = true
            end
        end
    end
end

function ApplyAnimation()
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local animator = humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        if GraphicState.NoAnimation then
                            if AnimationBackup[track] == nil then
                                AnimationBackup[track] = true
                            end
                            track:AdjustSpeed(0)
                        else
                            if AnimationBackup[track] then
                                track:AdjustSpeed(1)
                                AnimationBackup[track] = nil
                            end
                        end
                    end
                end
            end
        end
    end
end

function ApplyTime()
    Lighting.ClockTime = GraphicState.Time
end

function ResetGraphics()
    GraphicState.SoftCinematic = false
    GraphicState.LowGraphics = false
    GraphicState.FullBright = false
    GraphicState.NoFog = false
    GraphicState.NoAnimation = false
    GraphicState.NoParticle = false
    GraphicState.NoGrass = false
    GraphicState.CleanSky = false
    RemoveCreatedEffects()
    RestorePartShadows()
    for obj, oldValue in pairs(ParticleBackup) do
        if obj and obj.Parent then obj.Enabled = oldValue end
    end
    for obj, oldValue in pairs(TextureBackup) do
        if obj and obj.Parent then obj.Transparency = oldValue end
    end
    table.clear(ParticleBackup)
    table.clear(TextureBackup)
    for obj, oldValue in pairs(AnimationBackup) do
        if obj and obj.Parent then obj:AdjustSpeed(1) end
    end
    table.clear(AnimationBackup)
    for obj, oldValue in pairs(CloudBackup) do
        if obj and obj.Parent then obj.Enabled = oldValue end
    end
    table.clear(CloudBackup)
    Lighting.Brightness = OriginalLighting.Brightness
    Lighting.ExposureCompensation = OriginalLighting.ExposureCompensation
    Lighting.ShadowSoftness = OriginalLighting.ShadowSoftness
    Lighting.Ambient = OriginalLighting.Ambient
    Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
    Lighting.GlobalShadows = OriginalLighting.GlobalShadows
    Lighting.EnvironmentDiffuseScale = OriginalLighting.EnvironmentDiffuseScale
    Lighting.EnvironmentSpecularScale = OriginalLighting.EnvironmentSpecularScale
    Lighting.FogStart = OriginalLighting.FogStart
    Lighting.FogEnd = OriginalLighting.FogEnd
    GraphicState.Time = 18
    GraphicState.SelectedPreset = "Soft"
    Lighting.ClockTime = GraphicState.Time
    GraphicState.SoftCinematic = true
    ApplySoftCinematicLighting()
end

workspace.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if GraphicState.SoftCinematic and obj:IsA("BasePart") then
            if PartBackup[obj] == nil then
                PartBackup[obj] = obj.CastShadow
            end
            obj.CastShadow = true
        end
        if GraphicState.LowGraphics then
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
               or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                if ParticleBackup[obj] == nil then
                    ParticleBackup[obj] = obj.Enabled
                end
                obj.Enabled = false
            end
        end
    end)
end)

print("✅ [3/7] RED W - Soft Cinematic Logic Loaded")-- =========================================================
-- SECTION 4/7 : GUI MERAH (ONE W STYLE)
-- =========================================================

gui = Instance.new("ScreenGui")
gui.Name = "RedWHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 99999

local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not ok then gui.Parent = PG end

btnContainer = Instance.new("TextButton")
btnContainer.Size = UDim2.fromOffset(52, 52)
btnContainer.Position = UDim2.fromOffset(20, 120)
btnContainer.BackgroundColor3 = C.PANEL
btnContainer.Text = "W"
btnContainer.TextColor3 = C.RED
btnContainer.TextSize = 22
btnContainer.Font = Enum.Font.GothamBlack
btnContainer.BorderSizePixel = 0
btnContainer.AutoButtonColor = false
btnContainer.Active = true
btnContainer.Parent = gui
rnd(btnContainer, 999)

local tStroke = Instance.new("UIStroke")
tStroke.Thickness = 2
tStroke.Color = C.RED
tStroke.Parent = btnContainer

local tGlow = Instance.new("UIStroke")
tGlow.Color = C.RED_LIGHT
tGlow.Thickness = 6
tGlow.Transparency = 0.7
tGlow.Parent = btnContainer

local tGlow2 = Instance.new("UIStroke")
tGlow2.Color = C.ORANGE
tGlow2.Thickness = 10
tGlow2.Transparency = 0.85
tGlow2.Parent = btnContainer

local tGrad = Instance.new("UIGradient")
tGrad.Color = ColorSequence.new(C.RED_DARK, C.RED, C.RED_LIGHT, C.RED, C.RED_DARK)
tGrad.Rotation = 45
tGrad.Parent = btnContainer

task.spawn(function()
    local t = 0
    while btnContainer.Parent do
        t = t + 0.03
        tGrad.Rotation = (t * 40) % 360
        tGlow.Transparency = 0.7 - math.abs(math.sin(t * 2)) * 0.4
        tGlow2.Transparency = 0.85 - math.abs(math.sin(t * 1.5)) * 0.3
        btnContainer.TextColor3 = C.RED:Lerp(C.RED_LIGHT, math.abs(math.sin(t * 2)))
        btnContainer.TextSize = 22 + math.sin(t * 3) * 1.5
        tStroke.Transparency = 0.1 + math.abs(math.sin(t * 2.5)) * 0.3
        task.wait(0.03)
    end
end)

btnContainer.MouseEnter:Connect(function()
    TweenService:Create(btnContainer, TweenInfo.new(0.15), {
        Size = UDim2.fromOffset(58, 58)
    }):Play()
end)

btnContainer.MouseLeave:Connect(function()
    TweenService:Create(btnContainer, TweenInfo.new(0.15), {
        Size = UDim2.fromOffset(52, 52)
    }):Play()
end)

panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(620, 420)
panel.Position = UDim2.new(0.5, -310, 0.5, -210)
panel.BackgroundColor3 = C.BG
panel.BackgroundTransparency = 0.02
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.Visible = false
panel.Parent = gui
rnd(panel, 14)
strk(panel, C.RED, 2, 0.25)

local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new(C.BG, C.BG2, C.BG)
bgGrad.Rotation = 135
bgGrad.Parent = panel

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = C.PANEL
header.BackgroundTransparency = 0.05
header.BorderSizePixel = 0
header.Parent = panel
rnd(header, 14)

local hPatch = Instance.new("Frame")
hPatch.Size = UDim2.new(1, 0, 0, 26)
hPatch.Position = UDim2.new(0, 0, 1, -26)
hPatch.BackgroundColor3 = C.PANEL
hPatch.BackgroundTransparency = 0.05
hPatch.BorderSizePixel = 0
hPatch.Parent = header

local logo = Instance.new("Frame")
logo.Size = UDim2.fromOffset(32, 32)
logo.Position = UDim2.new(0, 12, 0.5, -16)
logo.BackgroundColor3 = C.PANEL2
logo.BorderSizePixel = 0
logo.Parent = header
rnd(logo, 8)
strk(logo, C.RED, 1.5, 0.3)

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "W"
logoText.TextColor3 = C.RED
logoText.TextSize = 18
logoText.Font = Enum.Font.GothamBlack
logoText.Parent = logo

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new(C.RED, C.RED_LIGHT, C.ORANGE)
logoGrad.Parent = logoText

local hTitle = Instance.new("TextLabel")
hTitle.Size = UDim2.new(0, 200, 0, 24)
hTitle.Position = UDim2.new(0, 52, 0, 14)
hTitle.BackgroundTransparency = 1
hTitle.Text = "RED W"
hTitle.TextColor3 = C.TXT
hTitle.TextSize = 16
hTitle.Font = Enum.Font.GothamBlack
hTitle.TextXAlignment = Enum.TextXAlignment.Left
hTitle.Parent = header

local hTitleGrad = Instance.new("UIGradient")
hTitleGrad.Color = ColorSequence.new(C.RED, C.ORANGE)
hTitleGrad.Parent = hTitle

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.fromOffset(26, 26)
minBtn.Position = UDim2.new(1, -62, 0.5, -13)
minBtn.BackgroundColor3 = C.BG
minBtn.BackgroundTransparency = 0.3
minBtn.Text = "—"
minBtn.TextColor3 = C.TXT
minBtn.TextSize = 13
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false
minBtn.Parent = header
rnd(minBtn, 6)
strk(minBtn, C.RED, 1, 0.4)

closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(26, 26)
closeBtn.Position = UDim2.new(1, -32, 0.5, -13)
closeBtn.BackgroundColor3 = C.BG
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✕"
closeBtn.TextColor3 = C.RED_DEEP
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = header
rnd(closeBtn, 6)
strk(closeBtn, C.RED_DEEP, 1, 0.4)

tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 38)
tabBar.Position = UDim2.new(0, 10, 0, 60)
tabBar.BackgroundColor3 = C.PANEL
tabBar.BackgroundTransparency = 0.3
tabBar.BorderSizePixel = 0
tabBar.Parent = panel
rnd(tabBar, 8)
strk(tabBar, C.RED, 1, 0.3)

tabScroll = Instance.new("ScrollingFrame")
tabScroll.Size = UDim2.new(1, -8, 1, -8)
tabScroll.Position = UDim2.new(0, 4, 0, 4)
tabScroll.BackgroundTransparency = 1
tabScroll.BorderSizePixel = 0
tabScroll.ScrollBarThickness = 0
tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
tabScroll.ScrollingDirection = Enum.ScrollingDirection.X
tabScroll.Parent = tabBar

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Parent = tabScroll

contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -110)
contentFrame.Position = UDim2.new(0, 10, 0, 105)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = panel

leftCol = Instance.new("Frame")
leftCol.Size = UDim2.new(0.5, -5, 1, 0)
leftCol.BackgroundColor3 = C.BG2
leftCol.BackgroundTransparency = 0.3
leftCol.BorderSizePixel = 0
leftCol.Parent = contentFrame
rnd(leftCol, 10)
strk(leftCol, C.RED, 1, 0.3)

rightCol = Instance.new("Frame")
rightCol.Size = UDim2.new(0.5, -5, 1, 0)
rightCol.Position = UDim2.new(0.5, 5, 0, 0)
rightCol.BackgroundColor3 = C.BG2
rightCol.BackgroundTransparency = 0.3
rightCol.BorderSizePixel = 0
rightCol.Parent = contentFrame
rnd(rightCol, 10)
strk(rightCol, C.RED, 1, 0.3)

leftScroll = Instance.new("ScrollingFrame")
leftScroll.Size = UDim2.new(1, -12, 1, -12)
leftScroll.Position = UDim2.new(0, 6, 0, 6)
leftScroll.BackgroundTransparency = 1
leftScroll.BorderSizePixel = 0
leftScroll.ScrollBarThickness = 2
leftScroll.ScrollBarImageColor3 = C.RED
leftScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
leftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
leftScroll.Parent = leftCol

local leftLayout = Instance.new("UIListLayout")
leftLayout.Padding = UDim.new(0, 5)
leftLayout.Parent = leftScroll

rightScroll = Instance.new("ScrollingFrame")
rightScroll.Size = UDim2.new(1, -12, 1, -12)
rightScroll.Position = UDim2.new(0, 6, 0, 6)
rightScroll.BackgroundTransparency = 1
rightScroll.BorderSizePixel = 0
rightScroll.ScrollBarThickness = 2
rightScroll.ScrollBarImageColor3 = C.RED
rightScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
rightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
rightScroll.Parent = rightCol

local rightLayout = Instance.new("UIListLayout")
rightLayout.Padding = UDim.new(0, 5)
rightLayout.Parent = rightScroll

cs = leftScroll
_G.RedW_cs = cs

dragging = false
dragStart = nil
startPos = nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

btnDragging = false
btnDragStart = nil
btnStartPos = nil
btnWasDragged = false

btnContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnWasDragged = false
        btnDragStart = input.Position
        btnStartPos = btnContainer.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
            btnWasDragged = true
        end
        btnContainer.Position = UDim2.new(
            btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X,
            btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = false
    end
end)

isOpen = false

function openPanel()
    if isOpen then return end
    isOpen = true
    panel.Visible = true
    panel.Size = UDim2.fromOffset(80, 80)
    panel.Position = UDim2.new(0.5, -40, 0.5, -40)
    TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(620, 420),
        Position = UDim2.new(0.5, -310, 0.5, -210),
    }):Play()
end

function closePanel()
    if not isOpen then return end
    isOpen = false
    TweenService:Create(panel, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(80, 80),
        Position = UDim2.new(0.5, -40, 0.5, -40),
    }):Play()
    task.wait(0.25)
    panel.Visible = false
end

btnContainer.MouseButton1Click:Connect(function()
    if btnWasDragged then
        btnWasDragged = false
        return
    end
    if isOpen then closePanel() else openPanel() end
    playToggleSound()
end)

closeBtn.MouseButton1Click:Connect(function()
    closePanel()
    playToggleSound()
end)

minBtn.MouseButton1Click:Connect(function()
    closePanel()
    playToggleSound()
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if isOpen then closePanel() else openPanel() end
        playToggleSound()
    end
end)

-- =========================================================
-- KOMPONEN UI
-- =========================================================

function sec(title, icon, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local deco = Instance.new("Frame")
    deco.Size = UDim2.new(0, 3, 0, 14)
    deco.Position = UDim2.new(0, 2, 0.5, -7)
    deco.BackgroundColor3 = C.RED
    deco.BorderSizePixel = 0
    deco.Parent = f
    rnd(deco, 2)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -12, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = (icon or "•") .. " " .. string.upper(title)
    l.TextColor3 = C.RED
    l.TextSize = 9
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
end

function tog(name, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    local fStrk = strk(f, C.RED, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -55, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local t = Instance.new("Frame")
    t.Size = UDim2.fromOffset(30, 15)
    t.Position = UDim2.new(1, -42, 0.5, -7.5)
    t.BorderSizePixel = 0
    t.Parent = f
    rnd(t, 8)

    local k = Instance.new("Frame")
    k.Size = UDim2.fromOffset(11, 11)
    k.BorderSizePixel = 0
    k.Parent = t
    rnd(k, 6)

    _G.ToggleStates = _G.ToggleStates or {}
    local saved = _G.ToggleStates[name]
    local state
    if saved ~= nil then state = saved else state = def end
    _G.ToggleStates[name] = state

    t.BackgroundColor3 = state and C.RED or C.PANEL2
    k.Position = state and UDim2.new(1, -13, 0.5, -5.5) or UDim2.new(0, 2, 0.5, -5.5)
    k.BackgroundColor3 = state and Color3.fromRGB(40, 10, 10) or C.DIM

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        state = not state
        _G.ToggleStates[name] = state
        TweenService:Create(k, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Position = state and UDim2.new(1, -13, 0.5, -5.5) or UDim2.new(0, 2, 0.5, -5.5),
            BackgroundColor3 = state and Color3.fromRGB(40, 10, 10) or C.DIM
        }):Play()
        TweenService:Create(t, TweenInfo.new(0.2), {
            BackgroundColor3 = state and C.RED or C.PANEL2
        }):Play()
        fStrk.Color = state and C.RED_LIGHT or C.RED
        playToggleSound()
        if cb then pcall(cb, state) end
    end)
end

function sl(name, min, max, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 36)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, C.RED, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -60, 0, 14)
    l.Position = UDim2.new(0, 10, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.SliderStates = _G.SliderStates or {}
    local curVal = _G.SliderStates[name]
    if curVal == nil then curVal = def end
    _G.SliderStates[name] = curVal

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 50, 0, 14)
    v.Position = UDim2.new(1, -56, 0, 4)
    v.BackgroundTransparency = 1
    v.Text = tostring(curVal)
    v.TextColor3 = C.RED
    v.TextSize = 10
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 5)
    bg.Position = UDim2.new(0, 10, 1, -10)
    bg.BackgroundColor3 = C.BG
    bg.BorderSizePixel = 0
    bg.Parent = f
    rnd(bg, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((curVal - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.RED
    fill.BorderSizePixel = 0
    fill.Parent = bg
    rnd(fill, 3)

    local fillGrad = Instance.new("UIGradient")
    fillGrad.Color = ColorSequence.new(C.RED_DARK, C.RED, C.RED_LIGHT)
    fillGrad.Parent = fill

    local kn = Instance.new("Frame")
    kn.Size = UDim2.fromOffset(12, 12)
    kn.Position = UDim2.new((curVal - min) / (max - min), -6, 0.5, -6)
    kn.BackgroundColor3 = C.RED_LIGHT
    kn.BorderSizePixel = 0
    kn.ZIndex = 2
    kn.Parent = bg
    rnd(kn, 6)
    strk(kn, C.RED, 1.5)

    local drag = false
    local function upd(input)
        local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
        local raw = min + (max - min) * pos
        local val
        if (max - min) <= 2 then
            val = math.floor(raw * 100 + 0.5) / 100
        else
            val = math.floor(raw + 0.5)
        end
        _G.SliderStates[name] = val
        fill.Size = UDim2.new(pos, 0, 1, 0)
        kn.Position = UDim2.new(pos, -6, 0.5, -6)
        v.Text = tostring(val)
        if cb then pcall(cb, val) end
    end

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = true
            upd(input)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if drag and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            upd(input)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

function cpk(name, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, C.RED, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -50, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.fromOffset(30, 16)
    cB.Position = UDim2.new(1, -38, 0.5, -8)
    cB.BackgroundColor3 = def
    cB.Text = ""
    cB.BorderSizePixel = 0
    cB.Parent = f
    rnd(cB, 4)
    strk(cB, C.RED, 1.5)

    local presets = {
        Color3.fromRGB(255, 50, 50),
        Color3.fromRGB(255, 120, 120),
        Color3.fromRGB(255, 100, 60),
        Color3.fromRGB(255, 70, 100),
        Color3.fromRGB(80, 255, 150),
        Color3.fromRGB(74, 255, 181),
        Color3.fromRGB(80, 240, 255),
        Color3.fromRGB(255, 80, 200),
        Color3.fromRGB(255, 255, 255),
    }
    local idx = 1

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #presets then idx = 1 end
        cB.BackgroundColor3 = presets[idx]
        if cb then pcall(cb, presets[idx]) end
    end)
end

function btn(name, cb, parent)
    parent = parent or cs
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 28)
    b.BackgroundColor3 = C.PANEL
    b.BackgroundTransparency = 0.4
    b.Text = name
    b.TextColor3 = C.TXT
    b.TextSize = 10
    b.Font = Enum.Font.GothamMedium
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = parent
    rnd(b, 6)
    strk(b, C.RED, 1, 0.4)

    b.MouseButton1Click:Connect(function()
        playToggleSound()
        if cb then pcall(cb) end
    end)
end

function drp(name, options, def, cb, parent)
    parent = parent or cs
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.PANEL
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = parent
    rnd(f, 6)
    strk(f, C.RED, 1, 0.4)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 10
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.DropdownStates = _G.DropdownStates or {}
    local savedIdx = _G.DropdownStates[name]
    local idx = savedIdx or 1
    if not savedIdx then
        for i, o in ipairs(options) do
            if o == def then idx = i end
        end
        _G.DropdownStates[name] = idx
    end
    local cur = options[idx]

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.5, -28, 1, 0)
    v.Position = UDim2.new(0.5, 0, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = tostring(cur) .. " ▾"
    v.TextColor3 = C.RED
    v.TextSize = 9
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        cur = options[idx]
        _G.DropdownStates[name] = idx
        v.Text = tostring(cur) .. " ▾"
        if cb then pcall(cb, cur) end
    end)

    if cb and savedIdx then
        task.defer(function() pcall(cb, cur) end)
    end
end

activeTab = nil

function makeTab(name, icon, order, leftCb, rightCb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(80, 30)
    b.BackgroundColor3 = C.BG
    b.BackgroundTransparency = 1
    b.Text = ""
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    b.AutoButtonColor = false
    b.Parent = tabScroll
    rnd(b, 6)

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 20, 1, 0)
    ico.Position = UDim2.new(0, 8, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextColor3 = C.DIM
    ico.TextSize = 13
    ico.Font = Enum.Font.GothamBold
    ico.TextXAlignment = Enum.TextXAlignment.Left
    ico.Parent = b

    local lblT = Instance.new("TextLabel")
    lblT.Size = UDim2.new(1, -30, 1, 0)
    lblT.Position = UDim2.new(0, 26, 0, 0)
    lblT.BackgroundTransparency = 1
    lblT.Text = string.upper(name)
    lblT.TextColor3 = C.DIM
    lblT.TextSize = 8
    lblT.Font = Enum.Font.GothamBold
    lblT.TextXAlignment = Enum.TextXAlignment.Left
    lblT.Parent = b

    b.MouseButton1Click:Connect(function()
        if activeTab == b then return end
        if activeTab then
            TweenService:Create(activeTab, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            for _, c in pairs(activeTab:GetChildren()) do
                if c:IsA("TextLabel") then
                    TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = C.DIM}):Play()
                end
            end
        end
        activeTab = b
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.5, BackgroundColor3 = C.RED}):Play()
        for _, c in pairs(b:GetChildren()) do
            if c:IsA("TextLabel") then
                TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(40, 10, 10)}):Play()
            end
        end
        for _, c in pairs(leftScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        for _, c in pairs(rightScroll:GetChildren()) do
            if not c:IsA("UIListLayout") then c:Destroy() end
        end
        if leftCb then pcall(leftCb) end
        if rightCb then pcall(rightCb) end
    end)
end

print("✅ [4/7] RED W - GUI Loaded")-- =========================================================
-- SECTION 5/7 : TAB COMBAT + ESP
-- =========================================================

-- =========================================================
-- TAB 1: COMBAT (AUTO PARRY)
-- =========================================================
makeTab("Combat", "🛡️", 1, function()
    sec("Auto Parry", "🛡️")
    tog("Enable Auto Parry", false, function(s)
        AutoParry.Enabled = s
        if s then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    task.spawn(function() AP_HookKiller(p.Character) end)
                end
            end
        end
    end)
    sl("Parry Radius", 5, 40, 20, function(v)
        AutoParry.ParryDistance = v
        AP_Config.Radius = v
    end)
    sl("Debounce", 0.01, 0.5, 0.02, function(v)
        AP_Config.Debounce = v
    end)
    btn("Reset Parry Counter", function()
        AP_parryCount = 0
    end)
end, nil)

-- =========================================================
-- TAB 2: ESP
-- =========================================================
makeTab("ESP", "👁️", 2, function()
    sec("Player ESP", "🟢")
    tog("ESP Survivor", true, function(s) ESP.Survivor = s end)
    cpk("Survivor Color", TeamColors.Survivor, function(c) TeamColors.Survivor = c end)
    tog("ESP Killer", true, function(s) ESP.Killer = s end)
    cpk("Killer Color", TeamColors.Killer, function(c) TeamColors.Killer = c end)

    sec("Object ESP", "⚡")
    tog("ESP Generator", true, function(s) ESP.Generator = s end)
    cpk("Gen Color", GeneratorColor, function(c) GeneratorColor = c end)

    sec("ESP Distance", "📏")
    sl("ESP Radius", 10, 1000, 1000, function(v) ESP.Distance = v end)
end, nil)

-- =========================================================
-- MAIN ESP LOOP
-- =========================================================
local lastESPUpdate = 0
RunService.Heartbeat:Connect(function()
    local root = getRoot()
    if not root then return end
    local now = tick()
    if now - lastESPUpdate >= 0.2 then
        lastESPUpdate = now
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distance = (hrp.Position - root.Position).Magnitude
                        if distance <= ESP.Distance then
                            if ESP.Survivor and p.Team and p.Team.Name == "Survivors" then
                                createESP(char, TeamColors.Survivor)
                            elseif ESP.Killer and p.Team and p.Team.Name == "Killer" then
                                createESP(char, TeamColors.Killer)
                            else
                                removeESP(char)
                            end
                        else
                            removeESP(char)
                        end
                    end
                else
                    removeESP(char)
                end
            end
        end
        if ESP.Generator then
            for gen in pairs(Cached.Generators) do
                UpdateGenerator(gen)
            end
        end
    end
end)

print("✅ [5/7] RED W - Tab Combat + ESP Loaded")-- =========================================================
-- SECTION 6/7 : TAB VISUAL (SOFT CINEMATIC)
-- =========================================================

makeTab("Visual", "🎬", 3, function()
    sec("Soft Cinematic", "🎬")
    tog("Soft Cinematic", false, function(s)
        if s then
            EnableSoftCinematic()
        else
            DisableSoftCinematic()
        end
    end)
    tog("Low Graphics", false, function(s)
        if s then
            EnableLowGraphics()
        else
            DisableLowGraphics()
        end
    end)
    tog("Full Bright", false, function(s)
        GraphicState.FullBright = s
        ApplyFullBright()
    end)
    tog("No Fog", false, function(s)
        GraphicState.NoFog = s
        ApplyNoFog()
    end)
    tog("Clean Sky", false, function(s)
        GraphicState.CleanSky = s
        ApplyCleanSky()
    end)
    tog("No Particle", false, function(s)
        GraphicState.NoParticle = s
        ApplyNoParticle()
    end)
    tog("No Grass", false, function(s)
        GraphicState.NoGrass = s
        ApplyGrass()
    end)
    tog("No Animation", false, function(s)
        GraphicState.NoAnimation = s
        ApplyAnimation()
    end)

    sec("Shadow", "🌑")
    btn("Soft Shadow", function()
        Lighting.ShadowSoftness = 0.10
        if GraphicState.SoftCinematic then ApplyCharacterShadow() end
    end)
    btn("Balanced Shadow", function()
        Lighting.ShadowSoftness = 0.055
        if GraphicState.SoftCinematic then ApplyCharacterShadow() end
    end)
    btn("Sharp Shadow", function()
        Lighting.ShadowSoftness = 0.025
        if GraphicState.SoftCinematic then ApplyCharacterShadow() end
    end)
    btn("Refresh Shadow", function()
        if GraphicState.SoftCinematic then ApplyCharacterShadow() end
    end)
end, function()
    sec("Preset (16)", "🎬", rightScroll)
    for _, presetName in ipairs(PresetOrder) do
        local icon = "🎬"
        if presetName == "Soft" then icon = "🌤️"
        elseif presetName == "Ultra Cinematic" then icon = "✨"
        elseif presetName == "Golden Hour" then icon = "🌅"
        elseif presetName == "Night Cinema" then icon = "🌙"
        elseif presetName == "Deep Shadow" then icon = "🌑"
        elseif presetName == "Crystal" then icon = "💎"
        elseif presetName == "Dreamy" then icon = "🌫️"
        elseif presetName == "Vivid Cinema" then icon = "🔥"
        elseif presetName == "Dark Cinema" then icon = "🖤"
        elseif presetName == "Cloudy Soft" then icon = "☁️"
        elseif presetName == "Film Look" then icon = "🎞️"
        elseif presetName == "Moonlight" then icon = "🌌"
        elseif presetName == "Bright Cinema" then icon = "☀️"
        elseif presetName == "Ultra Soft" then icon = "👑"
        elseif presetName == "Performance Cinema" then icon = "⚡"
        end

        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 28)
        btn2.BackgroundColor3 = C.PANEL
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = icon .. "  " .. presetName
        btn2.TextColor3 = C.TXT
        btn2.TextSize = 10
        btn2.Font = Enum.Font.GothamMedium
        btn2.TextXAlignment = Enum.TextXAlignment.Left
        btn2.AutoButtonColor = false
        btn2.Parent = rightScroll
        rnd(btn2, 6)
        strk(btn2, C.RED, 1, 0.4)
        btn2:SetAttribute("IsPreset", true)

        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 10)
        pad.Parent = btn2

        if GraphicState.SelectedPreset == presetName then
            btn2.BackgroundColor3 = C.RED
            btn2.BackgroundTransparency = 0
            btn2.TextColor3 = Color3.fromRGB(40, 10, 10)
        end

        btn2.MouseButton1Click:Connect(function()
            SelectPreset(presetName)
            for _, c in pairs(rightScroll:GetChildren()) do
                if c:IsA("TextButton") and c:GetAttribute("IsPreset") then
                    c.BackgroundColor3 = C.PANEL
                    c.BackgroundTransparency = 0.4
                    c.TextColor3 = C.TXT
                end
            end
            btn2.BackgroundColor3 = C.RED
            btn2.BackgroundTransparency = 0
            btn2.TextColor3 = Color3.fromRGB(40, 10, 10)
            playToggleSound()
        end)
    end

    sec("Time", "🕐", rightScroll)
    btn("🌅 Morning 07:00", function() GraphicState.Time = 7; ApplyTime() end, rightScroll)
    btn("☀️ Day 12:00", function() GraphicState.Time = 12; ApplyTime() end, rightScroll)
    btn("🌇 Sunset 17:30", function() GraphicState.Time = 17.5; ApplyTime() end, rightScroll)
    btn("🌆 Evening 18:00", function() GraphicState.Time = 18; ApplyTime() end, rightScroll)
    btn("🌙 Night 22:00", function() GraphicState.Time = 22; ApplyTime() end, rightScroll)
    btn("🌌 Midnight 00:00", function() GraphicState.Time = 0; ApplyTime() end, rightScroll)

    sec("System", "🔄", rightScroll)
    btn("🔄 Reset Graphics", function()
        ResetGraphics()
        for _, c in pairs(rightScroll:GetChildren()) do
            if c:IsA("TextButton") and c:GetAttribute("IsPreset") then
                if c.Text:find("Soft") and not c.Text:find("Ultra") and not c.Text:find("Cloudy") then
                    c.BackgroundColor3 = C.RED
                    c.BackgroundTransparency = 0
                    c.TextColor3 = Color3.fromRGB(40, 10, 10)
                else
                    c.BackgroundColor3 = C.PANEL
                    c.BackgroundTransparency = 0.4
                    c.TextColor3 = C.TXT
                end
            end
        end
    end, rightScroll)
end)

-- =========================================================
-- AUTO SETUP CHARACTER
-- =========================================================
LP.CharacterAdded:Connect(function(char)
    task.wait(1.5)
    if GraphicState.SoftCinematic then
        pcall(ApplyCharacterShadow)
    end
end)

print("✅ [6/7] RED W - Tab Visual Loaded")-- =========================================================
-- SECTION 7/7 : INIT + FINAL
-- =========================================================

-- Set default preset (Soft) sebagai aktif di UI
GraphicState.SelectedPreset = "Soft"
ApplyTime()

-- Buat karakter siap (kalau udah ada char)
if LP.Character then
    task.spawn(function()
        task.wait(1.5)
        if GraphicState.SoftCinematic then
            pcall(ApplyCharacterShadow)
        end
    end)
end

-- Anti-Ilang Menu
local function ForceResetOnSpawnFalse()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.3) do
        pcall(ForceResetOnSpawnFalse)
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    pcall(ForceResetOnSpawnFalse)
end)

-- Auto Hook Killer buat Auto Parry
task.spawn(function()
    while task.wait(1) do
        if AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    AP_HookKiller(p.Character)
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(1)
        if AutoParry.Enabled and p.Team and p.Team.Name == "Killer" then
            AP_HookKiller(char)
        end
    end)
end)

print("╔══════════════════════════╗")
print("║        RED W             ║")
print("║   SEMUA FITUR LOADED     ║")
print("╠══════════════════════════╣")
print("║   RightShift = Menu      ║")
print("╚══════════════════════════╝")
