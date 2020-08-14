vRPlojaderoupa = {}
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

Tunnel.bindInterface("vrp_lojaderoupa", vRPlojaderoupa)

vRPserver = Tunnel.getInterface("vRP")
Proxy.addInterface("vrp_lojaderoupa", vRPlojaderoupa)
tvRP = Proxy.getInterface("vRP")

local lojaderoupa = {
    { name = "Loja de Roupas", id = 277, x = 428.93206787109, y = -800.06951904297, z = 28.501140365601 },
    { name = "Loja de Roupas", id = 277, x = -1083.8194580078, y = -2729.783203125, z = 13.606415748596 },
    { name = "Loja de Roupas", id = 277, x = -1107.7806396484, y = 2708.408203125, z = 19.107864379883 },
    { name = "Loja de Roupas", id = 277, x = -3171.5932617188, y = 1043.6356201172, z = 20.863214492798 },
    { name = "Loja de Roupas", id = 277, x = 1190.3948974609, y = 2713.0549316406, z = 38.222633361816 },
    { name = "Loja de Roupas", id = 277, x = 614.95764160156, y = 2763.2229003906, z = 42.088096618652 },
    { name = "Loja de Roupas", id = 277, x = 124.43270874023, y = -223.98475646973, z = 54.557830810547 },
    { name = "Loja de Roupas", id = 277, x = 1695.6501464844, y = 4829.3608398438, z = 42.063110351563 },
    { name = "Loja de Roupas", id = 277, x = 11.32901096344, y = 6514.4165039063, z = 31.877853393555 },
    { name = "Loja de Roupas", id = 277, x = -1447.8765869141, y = -242.02229309082, z = 48.820152282715 },

    { name = "Loja de Roupas", id = 277, x = -1191.7509765625, y = -768.24780273438, z = 17.32049369812 },
    { name = "Loja de Roupas", id = 277, x = -829.35980224609, y = -1073.7856445313, z = 11.328107833862 },
    { name = "Loja de Roupas", id = 277, x = -167.59172058105, y = -299.13482666016, z = 39.733280181885 },
    { name = "Loja de Roupas", id = 277, x = -704.85522460938, y = -151.95098876953, z = 37.415130615234 },
    { name = "Loja de Roupas", id = 277, x = 72.997901916504, y = -1399.2281494141, z = 29.37614440918 },
}

local parts = {
    rosto = 0,
    mascara = 1,
    cabelo = 2,
    mao = 3,
    calca = 4,
    sapato = 6,
    gravata = 7,
    mochila = 5,
    camisa = 8,
    colete = 9,
    jaqueta = 11,
    bone = "p0",
    oculos = "p1",
    brinco = "p2",
    relogio = "p6",
    relogio2 = "p7"
}

local drawables = {}
local textures = {}
local old_custom = {}

local lojaderoupaOpen = false
local atLoja = false

function openGuiLojaRoupa()
    lojaderoupaOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({ openLojaRoupa = true })
end

function closeGuiLojaRoupa()
    SetNuiFocus(false)
    SendNUIMessage({ openLojaRoupa = false })
    lojaderoupaOpen = false
    drawables = {}
    textures = {}
    old_custom = {}
end

function DrawTxt(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.45)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)

    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.400, 0.855)
end

function IsNearLojaRoupa()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(lojaderoupa) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if (distance <= 3) then
            return true
        end
    end
end

function vRPlojaderoupa.Main()
    lojaderoupaOpen = true
    old_custom = tvRP.getCustomization()
    old_custom.modelhash = nil

    for k, v in pairs(parts) do
        drawables[k] = { 0, 0 }
        textures[k] = { 0, 0 }

        local old_part = old_custom[v]

        if old_part then
            drawables[k][1] = old_part[1]
            textures[k][1] = old_part[2]
        end

        async(function()
            drawables[k][2] = tvRP.getDrawables(v)
            textures[k][2] = tvRP.getDrawableTextures(v, drawables[k][1])
        end)
    end
end

function vRPlojaderoupa.Drawing(mod, choice, drawables, textures)
    local isprop, index = parse_part(parts[choice])
    local drawable = drawables[choice]
    drawable[1] = drawable[1] + mod

    if isprop then
        if drawable[1] >= drawable[2] then
            drawable[1] = -1 -- circular selection (-1 for prop parts)
        elseif drawable[1] < -1 then
            drawable[1] = drawable[2] - 1
        end
    else
        if drawable[1] >= drawable[2] then
            drawable[1] = 0 -- circular selection
        elseif drawable[1] < 0 then
            drawable[1] = drawable[2]
        end
    end

    local custom = {}
    custom[parts[choice]] = { drawable[1], textures[choice][1] }
    tvRP.setCustomization(custom)

    local n = tvRP.getDrawableTextures(parts[choice], drawable[1])
    textures[choice][2] = n
    if textures[choice][1] >= n then
        textures[choice][1] = 0
    end

end

function vRPlojaderoupa.Texture(choice)
    local texture = textures[choice]
    texture[1] = texture[1] + 1
    if texture[1] >= texture[2] then
        texture[1] = 0
    end -- circular selection

    -- apply changedrawables
    local custom = {}
    custom[parts[choice]] = { drawables[choice][1], texture[1] }

    tvRP.setCustomization(custom)
end

function vRPlojaderoupa.finish(isok)
    if isok then
        lojaderoupaOpen = false
        closeGuiLojaRoupa()
    else
        lojaderoupaOpen = false
        tvRP.setCustomization(old_custom)
        closeGuiLojaRoupa()
    end
end

function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

RegisterNUICallback("next_custom", function(data, cb)
    local choice = 1
    local mod = data.type
    vRPlojaderoupa.Drawing(choice, mod, drawables, textures)

    cb("ok")
end)

RegisterNUICallback("anterior_custom", function(data, cb)
    local choice = -1
    local mod = data.type
    vRPlojaderoupa.Drawing(choice, mod, drawables, textures)
    cb("ok")
end)

RegisterNUICallback("cor", function(data, cb)
    local choice = -1
    local mod = data.type
    vRPlojaderoupa.Texture(mod)
    cb("ok")
end)

RegisterNUICallback("comprar", function(data, cb)
    local price = data.preco
    TriggerServerEvent("vrplojaroupa:compra", price)
end)

RegisterNUICallback("close", function(data, cb)
    tvRP.setCustomization(old_custom)
    closeGuiLojaRoupa()
    cb('ok')
end)

Citizen.CreateThread(function()
    if displayJobBlips then
        for k, v in ipairs(lojaderoupa) do
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, v.id)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING");
            AddTextComponentString(tostring(v.name))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(lojaderoupa) do
            DrawMarker(27, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, 0, 0, 0, 0, 0, 0, 3.501, 3.5001, 0.5001, 255, 0, 0, 100, 0, 0, 0, 1)
        end
    end
end)

Citizen.CreateThread(function()
    SetNuiFocus(false)
    while true do
        Citizen.Wait(0)
        if (IsNearLojaRoupa()) then
            Citizen.CreateThread(function()
                DrawTxt("PRESSIONE [E] PARA ABRIR A LOJA")
                if IsControlJustPressed(1, 51) then
                    if lojaderoupaOpen then
                        closeGuiLojaRoupa()
                        tvRP.setCustomization(old_custom)
                    else
                        openGuiLojaRoupa()
                        vRPlojaderoupa.Main()
                    end
                end
            end)

        end
    end
end)
