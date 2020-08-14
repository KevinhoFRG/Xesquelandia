local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_lojaderoupa")

vRPloja = Tunnel.getInterface("vrp_lojaderoupa")


RegisterServerEvent("vrplojaroupa:compra")
AddEventHandler("vrplojaroupa:compra", function(price)
        local user_id = vRP.getUserId(source)
    if price then
        if vRP.tryFullPayment(user_id,price) then
            vRPclient.notify(source, "VOCE COMPROU")
            vRPloja.finish(source,true)
        else
            vRPclient.notify(source, "SEM DINHEIRO")
            vRPloja.finish(source,false)
        end
    end
end)

