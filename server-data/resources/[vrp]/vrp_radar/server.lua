local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
funch = {}
Tunnel.bindInterface("vrp_radar",funch)

function funch.checkmult(amount,vel)
    local user_id = vRP.getUserId(source)
    --if not funch.checkcop() then
        vRP.tryFullPayment(user_id,amount)
        TriggerClientEvent("Notify",source,"importante","Você foi multado em R$"..amount.." pelo radar equivalente aos "..parseInt(vel).."KM/H")
    --end
end

function funch.checkcop(permission)
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,permission)
end    