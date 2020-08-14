local cfg = {}
local resourceName = ""..GetCurrentResourceName()..""

cfg.anticheat = {
    steam_require = true,
    name = "[HG_AntiCheat]",
    author = "HackerGeo",
    perm = "anticheat.settings",
    no_perm = "~r~Nu ai acces la setarile ~g~AntiCheat-ului!",
    protect = "~y~Server protejat de ~g~".. resourceName .."!",
    database = "Baza de date verificata",
    reason = "reason",
    steam = "Trebuie sa ai STEAM-ul pornit"
}

cfg.jump = {
    reason = "SUPER JUMP",
    desc = "A PRIMIT KICK",
    kick = "AI FOST DETECTAT CU HACK",
}

cfg.cars = {
    reason = "CARS BLACKLISTED",
    desc = "A PRIMIT BAN",
    kick = "AI FOST DETECTAT CU HACK",
}

cfg.version = {
    version = "1.7.7",
    new = "New AntiCheat Version",
    current = "Your AntiCheat Version",
    updated = "is up to date",
    outdated = "is Outdated",
    download = "Download the latest version",
    from = "From the HackerGeo.com",
}


function getConfig()
	return cfg
end
