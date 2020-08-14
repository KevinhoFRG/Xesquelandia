local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
tex = {}
Tunnel.bindInterface("st-cctv",tex)
vRP = Proxy.getInterface("vRP")
--vRPclient = Tunnel.getInterface("vRP")

function tex.Permissao()
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao")
end
