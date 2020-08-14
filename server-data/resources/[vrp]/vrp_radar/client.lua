local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
funch = Tunnel.getInterface("vrp_radar")

local radares = {
    ["radar01"] = {
        position = { ["x"] = 203.09, ["y"] = -1031.95, ["z"] = 35.29, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 120KM/H", ["maxvel"] = 120 } -- 203.0986328125,-1031.9599609375,35.295879364014
    },
    ["radar02"] = {
        position = { ["x"] = 399.00, ["y"] = -1032.88, ["z"] = 36.85, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 120KM/H", ["maxvel"] = 120 } -- 399.00717163086,-1032.8801269531,36.857120513916
    },
    ["radar03"] = {
        position = { ["x"] = 613.49, ["y"] = -276.26, ["z"] = 51.49, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 200KM/H", ["maxvel"] = 200 } -- 613.49700927734,-276.26690673828,51.496353149414
    },
    ["radar04"] = {
        position = { ["x"] = 256.39, ["y"] = -615.90, ["z"] = 49.38, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 100KM/H", ["maxvel"] = 100 } -- 256.39044189453,-615.90966796875,49.385589599609
    },
    ["radar05"] = {
        position = { ["x"] = 1614.33, ["y"] = 1069.88, ["z"] = 92.49, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 200KM/H", ["maxvel"] = 200 } -- 1614.3312988281,1069.88671875,92.496658325195
    },
    ["radar06"] = {
        position = { ["x"] = -2151.97, ["y"] = 2318.82, ["z"] = 47.20, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 100KM/H", ["maxvel"] = 100 } -- -2151.9736328125,2318.8247070313,47.201671600342
    },
    ["radar07"] = {
        position = { ["x"] = -2651.88, ["y"] = 2738.06, ["z"] = 25.46, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 200KM/H", ["maxvel"] = 200 } -- -2651.8828125,2738.0617675781,25.461395263672
    },
    ["radar08"] = {
        position = { ["x"] = -154.07, ["y"] = -1233.43, ["z"] = 47.45, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 150KM/H", ["maxvel"] = 150 } -- -154.07368469238,-1233.4311523438,47.454586029053
    },
    ["radar09"] = {
        position = { ["x"] = 95.76, ["y"] = -1189.26, ["z"] = 47.65, ["colour"] = 1, ["id"] = 161, ["title"] = "Radar 150KM/H", ["maxvel"] = 150 } -- 95.769142150879,-1189.265625,47.654209136963
    }
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k,v in pairs(radares) do
            local ped = GetPlayerPed(-1)
            local x,y,z = table.unpack(GetEntityCoords(ped))
            local bowz,cdz = GetGroundZFor_3dCoord(v.position.x,v.position.y,v.position.z)
            local distance = GetDistanceBetweenCoords(v.position.x,v.position.y,cdz,x,y,z,true)
            local vel = GetEntitySpeed(ped)*3.18
            DrawMarker(21,v.position.x,v.position.y,v.position.z+4,1,1,0,0,0,0,2.0,2.0,2.0,255,0,0,50,1,1,1,1)
            if distance < 30 and vel > v.position.maxvel then
                if not funch.checkcop("policia.permissao") then
                    if not funch.checkcop("rota.permissao") then
                        if not funch.checkcop("paramedico.permissao") then
                            if not funch.checkcop("prf.permissao") then
                                funch.checkmult(parseInt(vel*2.5),vel)
                                Citizen.Wait(20000)
                            end    
                        end    
                    end        
                end
            end    
        end
    end    
end)

Citizen.CreateThread(function()

    for _, info in pairs(radares) do
      info.blip = AddBlipForCoord(info.position.x, info.position.y, info.position.z)
      SetBlipSprite(info.blip, info.position.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.1)
      SetBlipColour(info.blip, info.position.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.position.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)