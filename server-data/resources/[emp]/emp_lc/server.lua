local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
emP = {}
Tunnel.bindInterface('emp_lc', emP)

-------------------------------------------------------
--------------------  CONFIG  -------------------------
local lc_permissao = ''
local lc_policia = 'policia.permissao'
local lc_policiais = 3 -- Quantidade minima de policias para iniciar o roubo
local lc_cooldown = 60 * 5 -- em segundos
local lc_scramble = 60 * 30 -- em segundos ( a cada x segundos os lugares dos veiculos vao mudar )
local vehicles = {
    [1] = {model = 'zentorno', name = 'Zentorno', reward = 10000},
    [2] = {model = 'italigto', name = 'Itali GTO', reward = 8000},
    [3] = {model = 'jester', name = 'Jester', reward = 8000},
    [4] = {model = 'carbonizzare', name = 'Carbonizzare', reward = 7000},
    [5] = {model = 'elegy', name = 'Elegy', reward = 7500},
    [6] = {model = 'khamelion', name = 'Khamelion', reward = 6000},
    [7] = {model = 'locust', name = 'Locust', reward = 6000}
}
-------------------------------------------------------

local happening = false
local cooldown = false
local seconds = 0
local secondstoscramble = 0

function scramble()
    secondstoscramble = lc_scramble
    local old_vehicles = vehicles
    vehicles = {}

    for i = 1, #old_vehicles do 
        local rndindex = math.random(#old_vehicles)

        while vehicles[rndindex] ~= nil do
            rndindex = math.random(#old_vehicles)
        end

        vehicles[rndindex] = old_vehicles[rndindex]
    end
    
    TriggerClientEvent('lc_client:updatevehicles', -1, vehicles)
end

function emP.hasPermission()

    local user_id = vRP.getUserId(source)

    if lc_policia ~= '' and vRP.hasPermission(user_id, lc_policia) then
        TriggerClientEvent('LCNotify', source, '~r~Você é um policial e provavelmente não deveria estar aqui.')
        return false
    end

    if #vRP.getUsersByPermission(lc_policia) < lc_policiais then
        TriggerClientEvent('LCNotify', source, '~r~Número insuficiente de policiais.')
        return false
    end

    if lc_permissao == ''or vRP.hasPermission(user_id, lc_permissao) then
        return true
    end

    TriggerClientEvent('LCNotify', source, '~r~Você não tem permissão.')
    return false
end

function emP.hasCooldown()
    return cooldown == true
end

function emP.isHappening()
    return happening == true
end

function emP.setHappening(value)
    happening = value

    if value == false and cooldown == false then
        cooldown = true
        seconds = lc_cooldown
        TriggerClientEvent('lc_client:updatevehicles', -1, {})
    end
end

function emP.networkVehicle(netid)
    local owner_id = vRP.getUserId(source)

    if lc_policia ~= '' then
        for _, t_id in pairs(vRP.getUsersByPermission(lc_policia)) do
		    local t_source = vRP.getUserSource(t_id)
            TriggerClientEvent('LCNotify', t_source, '~o~ALERTA ~w~Roubo de veiculo em andamento! Acompanhe-o pelo rastreador.')
            TriggerEvent('eblips:add',{ name = "Corredor", src = source, color = 83 })
        end
    end

    TriggerClientEvent('lc_client:addblipforvehicle', -1, owner_id, netid)
end

function emP.unNetworkVehicle()
    local owner_id = vRP.getUserId(source)
    TriggerClientEvent('lc_client:removeblipforvehicle', -1, owner_id)
end

function emP.collectReward(index)
    local user_id = vRP.getUserId(source)
    vRP.giveInventoryItem(user_id, 'dinheirosujo', vehicles[index].reward)
    TriggerClientEvent('LCNotify', source, '<FONT color="#40f549">+ ~s~R$' .. vRP.format(vehicles[index].reward) .. ' em dinheiro sujo')
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            if seconds > 0 then
                seconds = seconds - 1
            end

            if seconds <= 0 then
                if cooldown == true then
                    cooldown = false
                    scramble()
                end
            end

            if secondstoscramble > 0 then
                secondstoscramble = secondstoscramble - 1
            end

            if secondstoscramble <= 0 then
                if happening == false and cooldown == false then
                    scramble()
                end
            end
        end
    end
)

function _addBlipForEntity(entity)
	local blip = AddBlipForEntity(entity)
	SetBlipSprite(blip, 161)
	SetBlipColour(blip, 6)
	SetBlipScale(blip, 1.4)
	SetBlipAsShortRange(blip, false)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Corredor')
	EndTextCommandSetBlipName(blip)
	return blip
end

RegisterNetEvent('lc_client:removeblipforvehicle')
AddEventHandler(
	'lc_client:removeblipforvehicle',
	function(owner_id)
		if blips[owner_id] then
			RemoveBlip(blips[owner_id])
			blips[owner_id] = nil
		end
	end
)

AddEventHandler(
    'vRP:playerSpawn',
    function(user_id, source, first_spawn)
        if first_spawn then
            TriggerClientEvent('lc_client:updatevehicles', source, vehicles)
        end
    end
)
