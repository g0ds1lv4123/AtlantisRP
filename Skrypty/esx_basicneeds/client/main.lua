ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return false
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return false
	end, function(status)
		status.remove(75)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_sandwich_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatFruit')
AddEventHandler('esx_basicneeds:onEatFruit', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'ng_proc_food_ornge1a'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatBurger')
AddEventHandler('esx_basicneeds:onEatBurger', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			local chance1 = math.random(0,10)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, 180.0, 0.0, 0.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				if chance1 <= 3 then
					TriggerServerEvent('3dme:shareDisplayDo', 'Sos skapuje na ubranie robiąc wielką plamę')
				end
				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatHotdog')
AddEventHandler('esx_basicneeds:onEatHotdog', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_hotdog_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			local chance1 = math.random(0,10)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, 180.0, 0.0, 180.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				if chance1 <= 3 then
					TriggerServerEvent('3dme:shareDisplayDo', 'Dodatki spadają z bułki i brudzą buty')
				end
				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatBaton')
AddEventHandler('esx_basicneeds:onEatBaton', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_choc_meto'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, -30.0, -120.0, -60.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				Citizen.Wait(2500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatDonut')
AddEventHandler('esx_basicneeds:onEatDonut', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_donut_02'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			local chance1 = math.random(0,10)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, 190.0, 0.0, -15.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				if chance1 <= 3 then
					TriggerServerEvent('3dme:shareDisplayDo', 'Buzia jest ubrudzona od polewy czekoladowej')
				end
				Citizen.Wait(2500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEatKebab')
AddEventHandler('esx_basicneeds:onEatKebab', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_taco_02' --' 
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			local chance1 = math.random(0,10)
			local chance2 = math.random(1,2)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.135, 0.02, 0.05, 190.0, 0.0, -15.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				if chance1 <= 3 then
					if chance2 == 1 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Sos skapuje na ubranie robiąc wielką plamę')
					elseif chance2 == 2 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Sos jest za ostry, twarz robi się czerwona')
					end
				end
				Citizen.Wait(2500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function( prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, 3.0, -1, 56, 1, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:drinkdo')
AddEventHandler('esx_basicneeds:drinkdo', function()
	local chance1 = math.random(0,10)
		if chance1 <= 3 then
			TriggerServerEvent('3dme:shareDisplayDo', 'Krzywi się, ponieważ sok jest bardzo kwaśny')
		end
end)

RegisterNetEvent('esx_basicneeds:oncoffe')
AddEventHandler('esx_basicneeds:oncoffe', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'p_amb_coffeecup_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 57005)
			local chance1 = math.random(0,10)
			local chance2 = math.random(1,2) 
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.015, -0.03, -80.0, 0.0, -20.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a', function()
				TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 8.0, 3.0, -1, 51, 1, 0, 0, 0)
				if chance1 <= 3 then
					if chance2 == 1 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Dookoła unosi się zapach pysznej kawy')
					elseif chance2 == 2 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Krzywi się, ponieważ kawa była gorzka')
					end
				end
				Citizen.Wait(6500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onEnergy')
AddEventHandler('esx_basicneeds:onEnergy', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_can_01b'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 57005)
			local chance1 = math.random(0,10)
			local chance2 = math.random(1,2) 
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.015, -0.03, -80.0, 0.0, -20.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a', function()
				TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				if chance1 <= 3 then
					if chance2 == 1 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Czuje siarkę w składzie energetyka')
					elseif chance2 == 2 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Głośno beka od nadmiaru bąbelków')
					end
				end
				Citizen.Wait(5500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
				Citizen.Wait(300000)
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onCola')
AddEventHandler('esx_basicneeds:onCola', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'ng_proc_sodacan_01a'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 57005)
			local chance1 = math.random(0,10)
			local chance2 = math.random(1,2) 
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.105, -0.07, -0.045, -80.0, 0.0, -20.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a', function()
				TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 8.0, 3.0, -1, 51, 1, 0, 0, 0)

				if chance1 <= 3 then
					if chance2 == 1 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Głośno beka od nadmiaru bąbelków')
					elseif chance2 == 2 then
						TriggerServerEvent('3dme:shareDisplayDo', 'Puszka była wstrząśnięta i cola tryska dookoła')
					end
				end
				Citizen.Wait(5500)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)
