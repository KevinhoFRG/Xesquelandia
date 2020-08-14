local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_carsounds")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, true) then
            drawTxt(0.104,0.849,0.42,"SOM:",200,200,200,255)
            drawTxt(0.123,0.849,0.42,som,0,255,0,255)  
        end
    end
end)

function drawTxt(x,y,scale,text,r,g,b,a)
	SetTextFont(4)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

som = "N"
RegisterCommand("motor", function(source,args)
    local ped = GetPlayerPed(-1)
    local carro = GetVehiclePedIsUsing(ped)
    if GetVehicleClass(carro) == 7 or GetVehicleClass(carro) == 6 or GetVehicleClass(carro) == 5 then-- SOMENTE CARROS ESPORTIVOS
        if args[1] == "esporte" then
            ForceVehicleEngineAudio(carro,"TAMPA2")
            som = "E"
        elseif args[1] == "normal" then
            ForceVehicleEngineAudio(carro,GetEntityModel(GetHashKey(carro)))
            som = "N"
        elseif args[1] == "rally" then
            ForceVehicleEngineAudio(carro,"MONSTER")
            som = "R"
        end
    end              
end)