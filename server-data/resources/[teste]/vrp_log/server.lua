
--configs
local AvatarURL = 'https://cdn.discordapp.com/attachments/661387442984583188/676090231811866634/Ops.png'
local Webhook = 'https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q'

local WebHookChat = 'https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q'

local WebHookEnterExit = 'https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q'

local WebHookAdmin = 'https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q'

local WebHookInventory = 'https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q'

local WebHookRoubos = 'https://discordapp.com/api/webhooks/687862400497614852/cJBdOSctJmt46DxyXzvSWNuIhbsu8EF3YnIVRoAgN6XKmYquXA2pR8NvW4D_GTJCyS5Q'

local valor_ticket = 40000


RegisterServerEvent("log:hoppe")
AddEventHandler("log:hoppe", function(text)
	TriggerEvent('DiscordBot:ToDiscord', Webhook, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:chat")
AddEventHandler("log:hoppe:chat", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookChat, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:admin")
AddEventHandler("log:hoppe:admin", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookAdmin, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:enterexit")
AddEventHandler("log:hoppe:enterexit", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookEnterExit, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:inventory")
AddEventHandler("log:hoppe:inventory", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookInventory, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterServerEvent("log:hoppe:roubos")
AddEventHandler("log:hoppe:roubos", function(text)
	TriggerEvent('DiscordBot:ToDiscord', WebHookRoubos, "Complexo Paulista", text, AvatarURL, false, false)
end)

RegisterCommand("logtest", function(source,args)
	TriggerEvent("log:hoppe",args[1])
end)


RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, External, TTS)
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

AddEventHandler("vRP:playerLeave", function(user_id, group, gtype)
	TriggerEvent("log:hoppe:enterexit","```ID "..user_id.." saiu do servidor Data: "..os.date("%H:%M:%S").."```")
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	TriggerEvent("log:hoppe:enterexit","```ID "..user_id.." entrou no servidor Data: "..os.date("%H:%M:%S").."```")
end)