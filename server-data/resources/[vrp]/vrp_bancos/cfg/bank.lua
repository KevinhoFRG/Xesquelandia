cfg = {}

cfg.blips = true

cfg.seconds = 360 -- TEMPO DO ASSALTO EM SEGUNDOS

cfg.cooldown = 86400 -- TEMPO DO COOLDOWN EM SEGUNDOS

cfg.cops = 6 -- MINIMO DE PM'S ON
cfg.permission = "policia.permissao" -- permission given to cops

cfg.banks = { -- list of banks
	["pacific"] = {
		position = { ['x'] = 265.3271484375, ['y'] = 213.73670959473, ['z'] = 101.68334197998 },
		blipposition = { ['x'] = 265.3271484375, ['y'] = 213.73670959473, ['z'] = 101.68334197998 },
		hackearposition = { ['x'] = 253.18077087402, ['y'] = 228.45509338379, ['z'] = 101.68334197998 },
		reward = 500000 + math.random(0,800000),
		nameofbank = "Banco Central",
		lastrobbed = 0,
		lasthackeado = 0
	}
}