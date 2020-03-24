local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local player = PlayerPedId()
local inside = false
local hidein = false
local isIn = false
local forcehidein = false
local allowedModels = {-1289722222, -1477580979, -1150599089, 1723137093, 1777363799, 1348744438, -511601230, -1008861746, -1255452397, -1961627517, -391594584, 906642318, -2030171296, 1123216662, 884422927, -1651067813, 1269098716, 850565707, 1337041428, 1221512915, -808831384, 2006918058, -1137532101, -1543762099, -1775728740, -808457413, 2136773105, -789894171, 142944341, 1878062887, 634118882, 1203490606, 1177543287, 486987393, -394074634, -1558399629, -227741703, -2119578145, -1205801634, 349605904, -1685021548, 972671128, 223258115, 1762279763, -1883002148, -2033222435, 523724515, -14495224, 1617472902, -685276541, 464687292, 1531094468, -498054846,-2124201592, 1373123368, 75131841, -1797613329, 2006667053,1830407356, 941800958, 1545842587, -1566741232, -377465520,499169875, -1122289213, -1193103848, 873639469, 1349725314, 970598228, -304802106, 736902334, 767087018, -746882698, -1529242755, 2072687711, 196747873, 1489967196, -1485523546, 330661258, 1581459400, 1069929536, 1645267888, 1475773103, -1479664699, 683047626, 65402552, 1026149675, 1488164764, 943752001, -1743316013, -810318068, -310465116, 525509695, 296357396, -1745203402, -1346687836, 893081117, -907477130, -119658072, 728614474, 1162065741, -1776615689, 237764926, 1595740562, -1168952148}
local x1,y1,z1 = 0,0,0


RegisterNetEvent('hidein:trunk_enter')
AddEventHandler('hidein:trunk_enter', function()
	putintrunk()
end)

RegisterNetEvent('hidein:trunk_forceput')
AddEventHandler('hidein:trunk_forceput', function()
	if isIn then
		putoutoftrunk()
		forcehidein = false
	else
		forceputintrunk()
	end
end)

function checkArray (array, val)
  for name, value in ipairs(array) do
	  if value == val then
		  return true
	  end
  end

  return false
end

function putintrunk()

local animDict = "mp_common_miss"
loadAnimDict(animDict)

player = PlayerPedId()
local plyCoords = GetEntityCoords(player, false)
local vehicle = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 4.0, 0, 70)
local vehclass = GetVehicleClass(vehicle)
local vehname = GetEntityModel(vehicle)
if checkArray(allowedModels, vehname) then
	japierdoleustawinnekoordy(vehname)
	Wait(100)
	print(x1)
	print(y1)
	print(z1)
	if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
		if GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
			if not inside and x1 ~= 0 and y1 ~= 0 and z1 ~= 0 then
				--Citizen.Wait(500)
				AttachEntityToEntity(player, vehicle, -1, x1, y1, z1, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
				--RaiseConvertibleRoof(vehicle, false)
				if IsEntityAttached(player) then
					ClearPedTasksImmediately(player)
					Citizen.Wait(15)
					TaskPlayAnim(player, 'mp_common_miss', 'dead_ped_idle', 8.0, -1, -1, 1, 0, 0, 0, 0)
				  	inside = true
					SetEnableHandcuffs(player, true)
				  	checkloop()
				end
			end
		end
	else
		TriggerEvent("pNotify:SendNotification", {text = "Najpierw otwórz bagażnik", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
else
	print('chujowe auto byku')
end
end

function forceputintrunk()

local animDict = "mp_common_miss"
loadAnimDict(animDict)

player = PlayerPedId()
local plyCoords = GetEntityCoords(player, false)
local vehicle = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 4.0, 0, 70)
local vehname = GetEntityModel(vehicle)
if checkArray(allowedModels, vehname) then
	japierdoleustawinnekoordy(vehname)
	Wait(100)
	print(x1)
	print(y1)
	print(z1)
	if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
		if GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
			if not inside and x1 ~= 0 and y1 ~= 0 and z1 ~= 0 then
				Citizen.Wait(500)
				AttachEntityToEntity(player, vehicle, -1, x1, y1, z1, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
				--RaiseConvertibleRoof(vehicle, false)
				--Wait(500)
				if IsEntityAttached(player) then
					isIn = true
					ClearPedTasksImmediately(player)
					Citizen.Wait(15)
					TaskPlayAnim(player, 'mp_common_miss', 'dead_ped_idle', 8.0, -1, -1, 1, 0, 0, 0, 0)	
				  	SetEnableHandcuffs(player, true)
				  	checkloopwithlock()
				end
			end
		end
	else
		TriggerEvent("pNotify:SendNotification", {text = "Najpierw otwórz bagażnik", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
else
	print('chujowe auto byku')
end
end

function putoutoftrunk()
player = PlayerPedId()
local plyCoords = GetEntityCoords(player, false)
local vehicle = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 4.0, 0, 70)
	if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.5, 0.0))
		player = PlayerPedId()
		--Citizen.Wait(500)
		DetachEntity(player, true, false)
		SetEnableHandcuffs(player, false)
		SetEntityCoords(PlayerPedId(), x, y, z+5.0, 0, 0, 0, 0)
		Citizen.Wait(15)
		SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, 0, 0)
		SetEntityVisible(player, true, true)
		inside = false
		hidein = false
		isIn = false
		ClearAllHelpMessages()
	else
		TriggerEvent("pNotify:SendNotification", {text = "Najpierw otwórz bagażnik", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
end

function checkloop()
hidein = true
	while hidein do 
	Citizen.Wait(1)

		if inside then

			player = PlayerPedId()
			local plyCoords = GetEntityCoords(player, false)
			local vehicle = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 4.0, 0, 70)

			DrawText3Ds(plyCoords.x, plyCoords.y, plyCoords.z+0.5, '~b~[E] aby opuścić bagażnik.')

			if not IsEntityPlayingAnim(player, 'mp_common_miss', 'dead_ped_idle', 3) then
				local animDict = "mp_common_miss"
				loadAnimDict(animDict)
				TaskPlayAnim(playerPed, 'mp_common_miss', 'dead_ped_idle', 1.0, -1, -1, 49, 0, 0, 0, 0)
			end

			if IsPedBeingStunned(GetPlayerPed(-1)) then
				putoutoftrunk()
			end

    --DisableControlAction(2, 199, true) -- Disable pause screen
    --DisableControlAction(2, 200, true) -- Disable pause screen alternate
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 311, true) -- K
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 21, true) -- SHIFT
    DisableControlAction(0, 22, true) -- SPACE
    DisableControlAction(0, 288, true) -- F1
    DisableControlAction(0, 289, true) -- F2
    DisableControlAction(0, 170, true) -- F3
    DisableControlAction(0, 57, true) -- F10
    DisableControlAction(0, 73, true) -- X
    DisableControlAction(0, 244, true) -- M
    DisableControlAction(0, 246, true) -- Y
    DisableControlAction(0, 74, true) -- H
    DisableControlAction(0, 29, true) -- B
    DisableControlAction(0, 243, true) -- ~
	DisableControlAction(0, 81, true) -- ,
	DisableControlAction(0, 82, true) -- .

			if IsDisabledControlPressed(0, 38) and inside then
				local doorlockout = GetVehicleDoorLockStatus(vehicle)
				if doorlockout == 4 then
					TriggerEvent("pNotify:SendNotification", {text = "Pojazd jest zamknięty", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
				else
					putoutoftrunk()
				end
			end
		end
	end
end

function checkloopwithlock()
forcehidein = true
	while forcehidein do 
	Citizen.Wait(1)

		if inside then
    --DisableControlAction(2, 199, true) -- Disable pause screen
    --DisableControlAction(2, 200, true) -- Disable pause screen alternate
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 311, true) -- K
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 21, true) -- SHIFT
    DisableControlAction(0, 22, true) -- SPACE
    DisableControlAction(0, 288, true) -- F1
    DisableControlAction(0, 289, true) -- F2
    DisableControlAction(0, 170, true) -- F3
    DisableControlAction(0, 57, true) -- F10
    DisableControlAction(0, 73, true) -- X
    DisableControlAction(0, 244, true) -- M
    DisableControlAction(0, 246, true) -- Y
    DisableControlAction(0, 74, true) -- H
    DisableControlAction(0, 29, true) -- B
    DisableControlAction(0, 243, true) -- ~
	DisableControlAction(0, 81, true) -- ,
	DisableControlAction(0, 82, true) -- .


			player = PlayerPedId()

			if not IsEntityPlayingAnim(player, 'mp_common_miss', 'dead_ped_idle', 3) then
				local animDict = "mp_common_miss"
				loadAnimDict(animDict)
				TaskPlayAnim(playerPed, 'mp_common_miss', 'dead_ped_idle', 1.0, -1, -1, 49, 0, 0, 0, 0)
			end
		end
	end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function japierdoleustawinnekoordy(vehmodel)
	local _vehmodel = vehmodel
	if _vehmodel == -1289722222 then
		x1,y1,z1 = -0.1,-1.6,0.05
	elseif _vehmodel == -1477580979 then
		x1,y1,z1 = -0.1,-2.1,0.02
	elseif _vehmodel == -1150599089 then
		x1,y1,z1 = -0.1,-1.9,0.1
	elseif _vehmodel == 1723137093 then
		x1,y1,z1 = -0.1,-1.8,0.2
	elseif _vehmodel == 1777363799 then
		x1,y1,z1 = -0.1,-2.0,0.1
	elseif _vehmodel == 1348744438 then
		x1,y1,z1 = -0.1,-1.95,-0.02
	elseif _vehmodel == -511601230 then
		x1,y1,z1 = -0.1,-2.0,0.45
	end
end

--[[
hidein = true
	local animDict = "timetable@floyd@cryingonbed@base"
	loadAnimDict(animDict)
		while hidein do
		    Citizen.Wait(5)
				player = PlayerPedId()
				local plyCoords = GetEntityCoords(player, false)
				local vehicle = VehicleInFront()
					if GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
						SetVehicleDoorOpen(vehicle, 5, false, false)
							if not inside then
							    AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
							     RaiseConvertibleRoof(vehicle, false)
							     if IsEntityAttached(player) then
									ClearPedTasksImmediately(player)
									Citizen.Wait(100)
									TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
							        if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
										 TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
							        end
							    	inside = true
							    	hidein = false
							    else
							    	inside = false
							    	hidein = false
							    end
							elseif inside and IsDisabledControlPressed(0, 37) then
							    DetachEntity(player, true, true)
							    SetEntityVisible(player, true, true)
							   	ClearPedTasks(player)
							    inside = false
							    hidein = false
								ClearAllHelpMessages()

							end
					Citizen.Wait(2000)
						SetVehicleDoorShut(vehicle, 5, false)
					end
			--if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not inside and GetVehiclePedIsIn(player, false) == 0 then

			if not DoesEntityExist(vehicle) and inside then
				DetachEntity(player, true, true)
				SetEntityVisible(player, true, true)
				ClearPedTasks(player)
				inside = false
				hidein = false
				ClearAllHelpMessages()
			end
		end
end)
]]


--[[	Citizen.CreateThread(function()
		

	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(100)
	end

	  	while true do
		    Citizen.Wait(5)

		    if IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 44) then
						player = PlayerPedId()
						local plyCoords = GetEntityCoords(player, false)
						local vehicle = VehicleInFront()
								if GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
								 	SetVehicleDoorOpen(vehicle, 5, false, false)
							    	if not inside then
							        	AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
							       		RaiseConvertibleRoof(vehicle, false)
							       		if IsEntityAttached(player) then
											ClearPedTasksImmediately(player)
											Citizen.Wait(100)
											TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
							            	if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
										  		TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
							            end
							    		inside = true
							    		else
							    		inside = false
							    		end
							    	elseif inside and IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 44) then
							    		DetachEntity(player, true, true)
							    		SetEntityVisible(player, true, true)
							   			ClearPedTasks(player)
							    		inside = false
										ClearAllHelpMessages()

							    	end
							    	Citizen.Wait(2000)
							    	SetVehicleDoorShut(vehicle, 5, false)
							    end
			    	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not inside and GetVehiclePedIsIn(player, false) == 0 then

					elseif not DoesEntityExist(vehicle) and inside then
				    		DetachEntity(player, true, true)
				    		SetEntityVisible(player, true, true)
				   			ClearPedTasks(player)
				    		inside = false
				   			ClearAllHelpMessages()
				end
			end
	  	end
	end)

 function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end]]

