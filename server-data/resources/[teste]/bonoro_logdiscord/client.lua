local alreadyDead = false

function getWeaponHashName(hash)
	if hash ~= nil then
		if hash == "2725352035" then return "WEAPON_UNARMED"
		elseif hash == "4194021054" then return "WEAPON_ANIMAL"
		elseif hash == "148160082" then return "WEAPON_COUGAR"
		elseif hash == "1317494643" then return "WEAPON_HAMMER"
		elseif hash == "2508868239" then return "WEAPON_BAT"
		elseif hash == "2227010557" then return "WEAPON_CROWBAR"
		elseif hash == "453432689" then return "WEAPON_PISTOL"
		elseif hash == "2578778090" then return "WEAPON_KNIFE"
		elseif hash == "1593441988" then return "WEAPON_COMBATPISTOL"
		elseif hash == "1737195953" then return "WEAPON_NIGHTSTICK"
		elseif hash == "1141786504" then return "WEAPON_GOLFCLUB"
		elseif hash == "584646201" then return "WEAPON_APPISTOL"
		elseif hash == "2578377531" then return "WEAPON_PISTOL50"
		elseif hash == "324215364" then return "WEAPON_MICROSMG"
		elseif hash == "736523883" then return "WEAPON_SMG"
		elseif hash == "4024951519" then return "WEAPON_ASSAULTSMG"
		elseif hash == "2210333304" then return "WEAPON_CARBINERIFLE"
		elseif hash == "3220176749" then return "WEAPON_ASSAULTRIFLE"
		elseif hash == "2634544996" then return "WEAPON_MG"
		elseif hash == "487013001" then return "WEAPON_PUMPSHOTGUN"
		elseif hash == "2017895192" then return "WEAPON_SAWNOFFSHOTGUN"
		elseif hash == "3800352039" then return "WEAPON_ASSAULTSHOTGUN"
		elseif hash == "2640438543" then return "WEAPON_BULLPUPSHOTGUN"
		elseif hash == "911657153" then return "WEAPON_STUNGUN"
		elseif hash == "100416529" then return "WEAPON_SNIPERRIFLE"
		elseif hash == "205991906" then return "WEAPON_HEAVYSNIPER"
		elseif hash == "856002082" then return "WEAPON_REMOTESNIPER"
		elseif hash == "2726580491" then return "WEAPON_GRENADELAUNCHER"
		elseif hash == "1305664598" then return "WEAPON_GRENADELAUNCHER_SMOKE"
		elseif hash == "2982836145" then return "WEAPON_RPG"
		elseif hash == "375527679" then return "WEAPON_PASSENGER_ROCKET"
		elseif hash == "2937143193" then return "WEAPON_ADVANCEDRIFLE"
		elseif hash == "2144741730" then return "WEAPON_COMBATMG"
		elseif hash == "324506233" then return "WEAPON_AIRSTRIKE_ROCKET"
		elseif hash == "1752584910" then return "WEAPON_STINGER"
		elseif hash == "1119849093" then return "WEAPON_MINIGUN"
		elseif hash == "2481070269" then return "WEAPON_GRENADE"
		elseif hash == "741814745" then return "WEAPON_STICKYBOMB"
		elseif hash == "4256991824" then return "WEAPON_SMOKEGRENADE"
		elseif hash == "2694266206" then return "WEAPON_BZGAS"
		elseif hash == "615608432" then return "WEAPON_MOLOTOV"
		elseif hash == "101631238" then return "WEAPON_FIREEXTINGUISHER"
		elseif hash == "883325847" then return "WEAPON_PETROLCAN"
		elseif hash == "4256881901" then return "WEAPON_DIGISCANNER"
		elseif hash == "2294779575" then return "WEAPON_BRIEFCASE"
		elseif hash == "28811031" then return "WEAPON_BRIEFCASE_02"
		elseif hash == "600439132" then return "WEAPON_BALL"
		elseif hash == "1233104067" then return "WEAPON_FLARE"
		elseif hash == "3204302209" then return "WEAPON_VEHICLE_ROCKET"
		elseif hash == "1223143800" then return "WEAPON_BARBED_WIRE"
		elseif hash == "4284007675" then return "WEAPON_DROWNING"
		elseif hash == "1936677264" then return "WEAPON_DROWNING_IN_VEHICLE"
		elseif hash == "539292904" then return "WEAPON_EXPLOSION"
		elseif hash == "3452007600" then return "WEAPON_FALL"
		elseif hash == "910830060" then return "WEAPON_EXHAUSTION"
		elseif hash == "3425972830" then return "WEAPON_HIT_BY_WATER_CANNON"
		elseif hash == "133987706" then return "WEAPON_RAMMED_BY_CAR"
		elseif hash == "2339582971" then return "WEAPON_BLEEDING"
		elseif hash == "2741846334" then return "WEAPON_RUN_OVER_BY_CAR"
		elseif hash == "341774354" then return "WEAPON_HELI_CRASH"
		elseif hash == "3750660587" then return "WEAPON_FIRE"
		elseif hash == "2461879995" then return "WEAPON_ELECTRIC_FENCE"
		elseif hash == "3218215474" then return "WEAPON_SNSPISTOL"
		elseif hash == "4192643659" then return "WEAPON_BOTTLE"
		elseif hash == "1627465347" then return "WEAPON_GUSENBERG"
		elseif hash == "3231910285" then return "WEAPON_SPECIALCARBINE"
		elseif hash == "3523564046" then return "WEAPON_HEAVYPISTOL"
		elseif hash == "2132975508" then return "WEAPON_BULLPUPRIFLE"
		elseif hash == "2460120199" then return "WEAPON_DAGGER"
		elseif hash == "137902532" then return "WEAPON_VINTAGEPISTOL"
		elseif hash == "2138347493" then return "WEAPON_FIREWORK"
		elseif hash == "2828843422" then return "WEAPON_MUSKET"
		elseif hash == "984333226" then return "WEAPON_HEAVYSHOTGUN"
		elseif hash == "3342088282" then return "WEAPON_MARKSMANRIFLE"
		elseif hash == "1672152130" then return "WEAPON_HOMINGLAUNCHER"
		elseif hash == "2874559379" then return "WEAPON_PROXMINE"
		elseif hash == "126349499" then return "WEAPON_SNOWBALL"
		elseif hash == "1198879012" then return "WEAPON_FLAREGUN"
		elseif hash == "3794977420" then return "WEAPON_GARBAGEBAG"
		elseif hash == "3494679629" then return "WEAPON_HANDCUFFS"
		elseif hash == "171789620" then return "WEAPON_COMBATPDW"
		elseif hash == "3696079510" then return "WEAPON_MARKSMANPISTOL"
		elseif hash == "3638508604" then return "WEAPON_KNUCKLE"
		elseif hash == "4191993645" then return "WEAPON_HATCHET"
		elseif hash == "1834241177" then return "WEAPON_RAILGUN"
		elseif hash == "3713923289" then return "WEAPON_MACHETE"
		elseif hash == "3675956304" then return "WEAPON_MACHINEPISTOL"
		elseif hash == "738733437" then return "WEAPON_AIR_DEFENCE_GUN"
		elseif hash == "3756226112" then return "WEAPON_SWITCHBLADE"
		elseif hash == "3249783761" then return "WEAPON_REVOLVER"
		elseif hash == "4019527611" then return "WEAPON_DBSHOTGUN"
		elseif hash == "1649403952" then return "WEAPON_COMPACTRIFLE"
		elseif hash == "317205821" then return "WEAPON_AUTOSHOTGUN"
		elseif hash == "3441901897" then return "WEAPON_BATTLEAXE"
		elseif hash == "125959754" then return "WEAPON_COMPACTLAUNCHER"
		elseif hash == "3173288789" then return "WEAPON_MINISMG"
		elseif hash == "3125143736" then return "WEAPON_PIPEBOMB"
		elseif hash == "2484171525" then return "WEAPON_POOLCUE"
		elseif hash == "419712736" then return "WEAPON_WRENCH"
		else return "<ARMA DESCONHECIDA - "..hash..">" end
	else
		return "<ARMA DESCONHECIDA - "..hash..">"
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for i=0,255 do
			N_0x31698aa80e0223f8(i)
		end

		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and alreadyDead == false then
			local killer = GetPedKiller(playerPed)
			--local killername = "unknown"
			local killerId = 0
			local _, weaponhash = GetCurrentPedWeapon(killer, true)
			for id = 0, 255 do
				if killer == GetPlayerPed(id) then
					killerId = GetPlayerServerId(id)
					--killername = GetPlayerName(id)
					break
				end
			end
			if killer == playerPed then
				TriggerServerEvent('logplayerDied',nil,nil,nil)
				alreadyDead = true
			elseif killerId and killerId ~= 0 then
				TriggerServerEvent('logplayerDied',tostring(killerId),1,getWeaponHashName(tostring(weaponhash)))
				alreadyDead = true
			else
				TriggerServerEvent('logplayerDied',nil,nil,nil)
				alreadyDead = true
			end
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) and alreadyDead == true then
			alreadyDead = false
		end
	end
end)



--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000)		
		TriggerServerEvent('DMN:moneyLog')
    end
end)]]
