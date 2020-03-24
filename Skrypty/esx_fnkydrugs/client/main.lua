ESX                  = nil
local DrugLevel     = 0.0
local DrunkLevel = 0.0
local TargetDrunkLevel = 0.0
local maxDrugLevel  = 4.0
local maxDrunkLevel = 2.5
local globalDrugTime = 400000
local globalDrunkTime = 400000
local TargetDrugLevel = 0.0
local isUsing = false
local isDrunk = false
local isBusy = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


local function drugHigher(TargetDrugLevel)
	while DrugLevel < TargetDrugLevel do
		DrugLevel = DrugLevel + 0.0007
		SetTimecycleModifierStrength(DrugLevel)
		Wait(10)
	end
end

local function drunkHigher(TargetDrunkLevel)
	while DrunkLevel < TargetDrunkLevel do
		DrunkLevel = TargetDrunkLevel
		SetTimecycleModifierStrength(DrunkLevel)
		Wait(1000)
	end
end

local function drugLower()
	local player = PlayerId()
	while (DrugLevel > 0.0 ) do
		DrugLevel = DrugLevel - 0.000005
		SetTimecycleModifierStrength(DrugLevel)
		Wait(10)
		if DrugLevel == 0 then
			SetRunSprintMultiplierForPlayer(player, 1.0)
		end
	end
end

RegisterNetEvent('esx_fnkydrugs:checkpos')
AddEventHandler('esx_fnkydrugs:checkpos', function()
	if isBusy then return end
    local coords    = GetEntityCoords(PlayerPedId())
    local distancecheck  = GetDistanceBetweenCoords(1093.01, -3198.09, -38.99841, coords, true)
	local playerPed = PlayerPedId()
	local dict = 'mini@repair'
    if distancecheck < 5.2 then
		isBusy = true
		--TriggerEvent('2d:ProgressBar', "Przerabiam", 1120)
		TriggerEvent('2d:ProgressBar', "Przerabiam", 25)
		SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
		Citizen.Wait(1)
		loadAnimDict(dict)
		TaskPlayAnim(playerPed, dict, 'fixing_a_ped', 8.0, 3.0, -1, 1, 0, 0, 0, 0)
		--Citizen.Wait(112500)
		Wait(3000)
    	TriggerEvent('esx_fnkydrugs:checkposafter')
    elseif (distancecheck > 5.2 and distancecheck < 12) then
    	TriggerEvent("pNotify:SendNotification", {text = "Podejdź bliżej sprzętu", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	else
		TriggerEvent("pNotify:SendNotification", {text = "Zaczynasz rozcierać liść moździerzem, ale widzisz, że bez specjalistycznego sprzetu, nie uda ci sie uzyskać dobrej jakości produktu", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
    end
end)

RegisterNetEvent('esx_fnkydrugs:checkposafter')
AddEventHandler('esx_fnkydrugs:checkposafter', function()
    local coords    = GetEntityCoords(PlayerPedId())
    local distancecheck  = GetDistanceBetweenCoords(1091.8, -3198.9, -38.99841, coords, true)
	local playerPed = PlayerPedId()
    if distancecheck < 5.2 and IsEntityPlayingAnim(playerPed, "mini@repair", "fixing_a_ped", 3) then
    	TriggerServerEvent('esx_fnkydrugs:mortar')
		ClearPedTasks(playerPed)
		isBusy = false
    else
	local playerPed = PlayerPedId()
		ClearPedTasks(playerPed)
    	TriggerEvent("pNotify:SendNotification", {text = "Patrzysz na zieloną maź, która ci wyszła i zastanawiasz się co poszło nie tak. Spróbuj jeszcze raz", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
		isBusy = false
    end
end)

RegisterNetEvent('esx_fnkydrugs:checkdrugs')
AddEventHandler('esx_fnkydrugs:checkdrugs', function()
 if DrugLevel > 0.0 then
	TriggerEvent("pNotify:SendNotification", {text = "PRZEKRWIONE OCZY, CIĘŻKI ODDECH", type = "atlantisMed",queue = "global",timeout = 5000,layout = "atlantisInfo"})
 end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
--Drugs Effects

--Weed indica
RegisterNetEvent('esx_fnkydrugs:onWeed')
AddEventHandler('esx_fnkydrugs:onWeed', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hipster@a") 
		while not HasAnimSetLoaded("move_m@hipster@a") do
		Citizen.Wait(0)
		end
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
		end
		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.5
		SetTimecycleModifier("drug_drive_blend01")
		drugHigher(TargetDrugLevel)
		ESX.ShowHelpNotification("Czujesz jak Cie siepie.")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/50))
		-- Healing
		SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.8)

		Wait(globalDrugTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

-- Weed hybrid
RegisterNetEvent('esx_fnkydrugs:rhybrid')
AddEventHandler('esx_fnkydrugs:rhybrid', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hipster@a") 
		while not HasAnimSetLoaded("move_m@hipster@a") do
		Citizen.Wait(0)
		end    
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
		end
		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			ClearPedTasksImmediately(playerPed)
		end
		
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.4
		SetTimecycleModifier("drug_drive_blend02")
		drugHigher(TargetDrugLevel)
		ESX.ShowHelpNotification("Czujesz jak Cie siepie.")
		-- Walking cosmetics
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/80))
		-- Healing
		SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.8)

		Wait(globalDrugTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

-- Weed sativa
RegisterNetEvent('esx_fnkydrugs:rsativa')
AddEventHandler('esx_fnkydrugs:rsativa', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hipster@a") 
		while not HasAnimSetLoaded("move_m@hipster@a") do
		Citizen.Wait(0)
		end    
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
		end

		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.2
		SetTimecycleModifier("drug_drive_blend01")
		drugHigher(TargetDrugLevel)
		ESX.ShowHelpNotification("Czujesz jak Cie siepie.")
		-- Walking cosmetics
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/60))
		-- Healing
		SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.8)

		Wait(globalDrugTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

--Bongo
RegisterNetEvent('esx_fnkydrugs:bongo')
AddEventHandler('esx_fnkydrugs:bongo', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hipster@a") 
		while not HasAnimSetLoaded("move_m@hipster@a") do
		Citizen.Wait(0)
		end    
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end

		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.2
		SetTimecycleModifier("drug_drive_blend01")
		drugHigher(TargetDrugLevel)
		ESX.ShowHelpNotification("Czujesz jak Cie siepie.")
		-- Walking cosmetics
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/60))
		-- Healing
		SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.8)

		Wait(globalDrugTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)


--Meth
RegisterNetEvent('esx_fnkydrugs:onMeth')
AddEventHandler('esx_fnkydrugs:onMeth', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hipster@a") 
		while not HasAnimSetLoaded("move_m@hipster@a") do
		Citizen.Wait(0)
		end    
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*wkłada do szklanej fajki mały kryształ*") end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
		end		
		
		-- Set visual fx type
		Citizen.Wait(7000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.7
		SetTimecycleModifier("drug_wobbly")
		drugHigher(TargetDrugLevel)
		ESX.ShowHelpNotification("Metamfetamina wdziera sie do Twojej podświadomości, drylując w myślach niczym młot pneumatyczny.")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		-- set + or - of maxhelath... 100 is 1% of health 1 is 100% of health
		local newHealth = math.min(maxHealth , math.floor(health - maxHealth/70))
		-- Healing
		SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 1.2)

		Wait(globalDrugTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Czujesz, że efekt kryształów już Cię opuszcza.")
				
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

--Opium (Special as morphine for EMS)
RegisterNetEvent('esx_fnkydrugs:onOpium')
AddEventHandler('esx_fnkydrugs:onOpium', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local playerPed = GetPlayerPed(closestPlayer)
	if closestPlayer ~= -1 and closestDistance <= 0.8 then
	
	RequestAnimSet("move_m@drunk@moderatedrunk")
    end
	while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
      Citizen.Wait(0)
    end    
	-- Veri strong
	TargetDrugLevel = DrugLevel + 2.0
	SetTimecycleModifier("drug_wobbly")
	if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*postać wygląda na osłabioną*") end
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    SetPedIsDrunk(playerPed, true)
	drugHigher(TargetDrugLevel)

    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player,0.1)
    SetSwimMultiplierForPlayer(player, 0.1)

    Wait(60000)
	SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
	-- This needs to be here, dunno why does not work as standalone function
	while (DrugLevel > 0.0 ) do
		DrugLevel = DrugLevel - 0.0001
		SetTimecycleModifierStrength(DrugLevel)
		Wait(10)
			if DrugLevel == 0 then
				SetRunSprintMultiplierForPlayer(player, 1.0)
			end
	end

 end)
 
 
--Coke 100%
RegisterNetEvent('esx_fnkydrugs:onCoke100')
AddEventHandler('esx_fnkydrugs:onCoke100', function()
  print('dziala')
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hurry_butch@a") 
		while not HasAnimSetLoaded("move_m@hurry_butch@a") do
			Citizen.Wait(0)
		end     
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*pochyla się nad kreską kokainy*") end
		
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HIKER_STANDING", 0, 1)	
		end
		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.6
		SetTimecycleModifier("mp_battle_int03_tint6")
		drugHigher(TargetDrugLevel)
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
		SetPedIsDrunk(playerPed, true)

		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 1.2)
		SetSwimMultiplierForPlayer(player, 1.2)
		-- Add armor
		SetPedArmour(playerPed, 50)
		-- Take HP
		local newHealth = math.min(maxHealth , math.floor(health - maxHealth/50))
		-- HP mod
		SetEntityHealth(playerPed, newHealth)
		
		Wait(50000)
		TriggerServerEvent('3dme:shareDisplayMe', "*ciężko oddycha*")
		SetRunSprintMultiplierForPlayer(player, 1.0)
		SetSwimMultiplierForPlayer(player, 1.0)
		SetPedArmour(playerPed, 0)
		
		Wait(globalDrugTime-50000) -- -50000 Due to add armor buff.
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)



RegisterNetEvent('esx_fnkydrugs:onCoke90')
AddEventHandler('esx_fnkydrugs:onCoke90', function()
  print('dziala')
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hurry_butch@a") 
		while not HasAnimSetLoaded("move_m@hurry_butch@a") do
			Citizen.Wait(0)
		end     
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*pochyla się nad kreską kokainy*") end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HIKER_STANDING", 0, 1)	
		end
		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.4
		SetTimecycleModifier("mp_battle_int03_tint7")
		drugHigher(TargetDrugLevel)
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
		SetPedIsDrunk(playerPed, true)

		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 1.1)
		SetSwimMultiplierForPlayer(player, 1.1)
		-- Add armor
		SetPedArmour(playerPed, 20)
		-- Take HP
		local newHealth = math.min(maxHealth , math.floor(health - maxHealth/60))
		-- HP mod
		SetEntityHealth(playerPed, newHealth)
		
		Wait(40000)
		TriggerServerEvent('3dme:shareDisplayMe', "*ciężko oddycha*")
		SetRunSprintMultiplierForPlayer(player, 1.0)
		SetSwimMultiplierForPlayer(player, 1.0)
		SetPedArmour(playerPed, 0)
		
		Wait(globalDrugTime-40000) -- -50000 Due to add armor buff.
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

RegisterNetEvent('esx_fnkydrugs:onCoke70')
AddEventHandler('esx_fnkydrugs:onCoke70', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hurry_butch@a") 
		while not HasAnimSetLoaded("move_m@hurry_butch@a") do
			Citizen.Wait(0)
		end     
		-- Trigger *action*
		if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*pochyla się nad kreską kokainy*") end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HIKER_STANDING", 0, 1)
		end
		-- Set visual fx type
		Citizen.Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
			ClearPedTasksImmediately(playerPed)
		end
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.2
		SetTimecycleModifier("mp_battle_int03_tint8")
		drugHigher(TargetDrugLevel)
		-- Walking cosmetics
		SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
		SetPedIsDrunk(playerPed, true)

		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 1.15)
		-- Add armor
		SetPedArmour(playerPed, 10)
		-- Take HP
		local newHealth = math.min(maxHealth , math.floor(health - maxHealth/80))
		-- HP mod
		SetEntityHealth(playerPed, newHealth)
		
		Wait(50000)
		TriggerServerEvent('3dme:shareDisplayMe', "*ciężko oddycha*")
		SetRunSprintMultiplierForPlayer(player, 1.0)
		SetPedArmour(playerPed, 0)
		
		Wait(globalDrugTime-50000) -- -50000 Due to add armor buff.
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

RegisterNetEvent('esx_fnkydrugs:onAcid')
AddEventHandler('esx_fnkydrugs:onAcid', function()
local playerPed = GetPlayerPed(-1)
	if DrugLevel < maxDrugLevel then
		-- Set movement
		RequestAnimSet("move_m@hipster@a") 
		while not HasAnimSetLoaded("move_m@hipster@a") do
		Citizen.Wait(0)
		end    
		-- Trigger *action*
		if IsEntityPlayingAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 3) == false then  TriggerServerEvent('3dme:shareDisplayMe', "*wkłada sobie coś pod język*") end
		ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
		TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(3000)
		end)
		-- Set drug potency
		TargetDrugLevel = DrugLevel + 0.8
		SetTimecycleModifier("DRUG_gas_huffin")
		drugHigher(TargetDrugLevel)
		ESX.ShowHelpNotification("Czujesz jak Cie siepie.")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		local player = PlayerId()  
		local health = GetEntityHealth(playerPed)
		local maxHealth = GetEntityMaxHealth(playerPed)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 1.15)
		-- Add armor
		SetPedArmour(playerPed, 10)
		-- Modify HP
		local rng = math.random(1,2)
			if rng == 1 then
				local newHealth = math.min(maxHealth , math.floor(health - maxHealth/10))
				  print('odejmuje')
				  SetEntityHealth(playerPed, newHealth)
				  
				  if IsEntityPlayingAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 3) == false then
				  ESX.ShowHelpNotification("*postać wygląda na zaniepokojoną*")
				  end
			else
				local newHealth = math.min(maxHealth , math.floor(health + maxHealth/11))
				  print('dodaje')
				  SetEntityHealth(playerPed, newHealth)
					if IsEntityPlayingAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 3) == false then  
					ESX.ShowHelpNotification("*postać wygląda na zadowoloną*")
					end
			end
		if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
			ClearPedTasksImmediately(playerPed)
		end
		ClearPedSecondaryTask(playerPed)
		
		SetRunSprintMultiplierForPlayer(player, 0.9)
		
		Wait(globalDrugTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		while (DrugLevel > 0.0 ) do
			DrugLevel = DrugLevel - 0.0001
			SetTimecycleModifierStrength(DrugLevel)
			Wait(10)
				if DrugLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
		end
		
	else
		ESX.ShowHelpNotification("Czujesz, że faza jest już za mocna...")
	end
end)

--Xanax
RegisterNetEvent('esx_fnkydrugs:onXanax')
AddEventHandler('esx_fnkydrugs:onXanax', function()
	local playerPed = GetPlayerPed(-1)
	local player = PlayerId()
	if IsEntityPlayingAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 3) == false then TriggerServerEvent('3dme:shareDisplayMe', "*wyciąga tabletkę z blistra i ją spożywa*") end
	ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
	TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
	end)
	Citizen.Wait(2000)
	if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then 
		ClearPedTasksImmediately(playerPed)
	end
	ClearPedSecondaryTask(playerPed)
	

	while (DrugLevel > 0.0 ) do
		DrugLevel = DrugLevel - 0.002
		SetTimecycleModifierStrength(DrugLevel)
		Wait(0)
		if DrugLevel <= 0.0 then
			SetRunSprintMultiplierForPlayer(player, 1.0)
			SetTimecycleModifierStrength(0.0)
			SetRunSprintMultiplierForPlayer(player, 1.0)
			SetSwimMultiplierForPlayer(player, 1.0)
			SetPedArmour(PlayerPedId(), 0)
			SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		end
	end
end)

--Alco
--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(0)
--		if DrunkLevel >= 0.3 then
--		isDrunk = true
--		else
--		isDrunk = false
--		end
--	end
--end)



--picie
RegisterNetEvent('esx_fnkydrugs:onBeer')
AddEventHandler('esx_fnkydrugs:onBeer', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_amb_beer_bottle'
		IsAnimated = true
	end
	
  	local playerPed = GetPlayerPed(-1)
  	local maxHealth = GetEntityMaxHealth(playerPed)
  	local beerStr = 0.085
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(playerPed, 18905)

	if DrunkLevel < maxDrunkLevel then
		-- Trigger *action*
		--if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
					AttachEntityToEntity(prop, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, 3.0, -1, 56, 1, 0, 0, 0)
		-- Set visual fx type
		Citizen.Wait(3000)
		IsAnimated = false
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		-- Set drug potency
		TargetDrunkLevel = DrunkLevel + beerStr
		SetTimecycleModifier("Drunk")
		drunkHigher(TargetDrunkLevel)
		ESX.ShowHelpNotification("Wypij piwa kilka kufli... Zaraz twój optymizm wzrośnie")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		--local player = PlayerId()  
		--local health = GetEntityHealth(playerPed)
		--local newHealth = math.min(maxHealth , math.floor(health + maxHealth/50))
		-- Healing
		--SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.9)

		Wait(globalDrunkTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		DrunkLevel = DrunkLevel - beerStr
			SetTimecycleModifierStrength(DrunkLevel)
			Wait(10)
				if DrunkLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end	
			end)
	else
		ESX.ShowHelpNotification("Jesteś tak pijany/a że nie jesteś w stanie trafić do ust i rozlewasz alkohol na siebie...")
	end
end)

RegisterNetEvent('esx_fnkydrugs:onWine')
AddEventHandler('esx_fnkydrugs:onWine', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'p_wine_glass_s'
		IsAnimated = true
	end

  	local playerPed = GetPlayerPed(-1)
  	local maxHealth = GetEntityMaxHealth(playerPed)
  	local beerStr = 0.16
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(playerPed, 18905)

	if DrunkLevel < maxDrunkLevel then
		-- Trigger *action*
		--if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
					AttachEntityToEntity(prop, playerPed, boneIndex, 0.06, -0.045, 0.055, -100.0, 0.0, -50.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, 3.0, -1, 56, 1, 0, 0, 0)
		-- Set visual fx type
		Citizen.Wait(3000)
		IsAnimated = false
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		-- Set drug potency
		TargetDrunkLevel = DrunkLevel + beerStr
		SetTimecycleModifier("Drunk")
		drunkHigher(TargetDrunkLevel)
		ESX.ShowHelpNotification("Otwieram wino ze swoją dziewczyną...")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		--local player = PlayerId()  
		--local health = GetEntityHealth(playerPed)
		--local newHealth = math.min(maxHealth , math.floor(health + maxHealth/50))
		-- Healing
		--SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.9)

		Wait(globalDrunkTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		DrunkLevel = DrunkLevel - beerStr
			SetTimecycleModifierStrength(DrunkLevel)
			Wait(10)
				if DrunkLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end
			end)	
	else
		ESX.ShowHelpNotification("Jesteś tak pijany/a że nie jesteś w stanie trafić do ust i rozlewasz alkohol na siebie...")
	end
end)

RegisterNetEvent('esx_fnkydrugs:onWhisky')
AddEventHandler('esx_fnkydrugs:onWhisky', function(prop_name)
	
	if not IsAnimated then
		prop_name = prop_name or 'prop_whiskey_bottle'
		IsAnimated = true
	end

  	local playerPed = GetPlayerPed(-1)
  	local maxHealth = GetEntityMaxHealth(playerPed)
  	local beerStr = 0.22
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(playerPed, 18905)

	if DrunkLevel < maxDrunkLevel then
		-- Trigger *action*
		--if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
					AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, -0.2, 0.065, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, 3.0, -1, 56, 1, 0, 0, 0)
		-- Set visual fx type
		Citizen.Wait(3000)
		IsAnimated = false
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		-- Set drug potency
		TargetDrunkLevel = DrunkLevel + beerStr
		SetTimecycleModifier("Drunk")
		drunkHigher(TargetDrunkLevel)
		ESX.ShowHelpNotification("Whisky moja żono...")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		
		
		--Game mechanic effect section
		--local player = PlayerId()  
		--local health = GetEntityHealth(playerPed)
		--local newHealth = math.min(maxHealth , math.floor(health + maxHealth/50))
		-- Healing
		--SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.9)

		Wait(globalDrunkTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		DrunkLevel = DrunkLevel - beerStr
			SetTimecycleModifierStrength(DrunkLevel)
			Wait(10)
				if DrunkLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end	
			end)
	else
		ESX.ShowHelpNotification("Jesteś tak pijany/a że nie jesteś w stanie trafić do ust i rozlewasz alkohol na siebie...")
	end
end)

RegisterNetEvent('esx_fnkydrugs:onVodka')
AddEventHandler('esx_fnkydrugs:onVodka', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_shot_glass'
		IsAnimated = true
	end

  	local playerPed = GetPlayerPed(-1)
  	local maxHealth = GetEntityMaxHealth(playerPed)
  	local beerStr = 0.25
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(playerPed, 18905)

	if DrunkLevel < maxDrunkLevel then
		-- Trigger *action*
		--if IsPedActiveInScenario(GetPlayerPed(-1)) == false then TriggerServerEvent('3dme:shareDisplayMe', "*dookoła czuć zapach marihuany*") end
					AttachEntityToEntity(prop, playerPed, boneIndex, 0.11, -0.015, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, 3.0, -1, 56, 1, 0, 0, 0)
		-- Set visual fx type
		Citizen.Wait(3000)
		IsAnimated = false
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		-- Set drug potency
		TargetDrunkLevel = DrunkLevel + beerStr
		SetTimecycleModifier("Drunk")
		drunkHigher(TargetDrunkLevel)
		ESX.ShowHelpNotification("Leże... leże... uwaliłem się jak zwierze... czystą... wódką!")
		-- Walking cosmetics
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)
		

		--Game mechanic effect section
		--local player = PlayerId()  
		--local health = GetEntityHealth(playerPed)
		--local newHealth = math.min(maxHealth , math.floor(health + maxHealth/50))
		-- Healing
		--SetEntityHealth(playerPed, newHealth)
		-- Sprint modifier
		SetRunSprintMultiplierForPlayer(player, 0.9)

		Wait(globalDrunkTime)
		
		SetRunSprintMultiplierForPlayer(player, 1.0)		
		ESX.ShowHelpNotification("Powoli trzeźwiejesz... czujesz się trochę lepiej.")
				
		-- This needs to be here, dunno why does not work as standalone function
		DrunkLevel = DrunkLevel - beerStr
			SetTimecycleModifierStrength(DrunkLevel)
			Wait(10)
				if DrunkLevel == 0 then
					SetRunSprintMultiplierForPlayer(player, 1.0)
				end	
			end)
	else
		ESX.ShowHelpNotification("Jesteś tak pijany/a że nie jesteś w stanie trafić do ust i rozlewasz alkohol na siebie...")
	end
end)

--kontrola chodzenia xD
Citizen.CreateThread(function()
	local playerPed = GetPlayerPed(-1)
	while true do
	Citizen.Wait(0)
	--ESX.ShowHelpNotification(DrunkLevel)
		if DrunkLevel > 0.25 and DrunkLevel < 0.6 then
		RequestAnimSet("move_m@drunk@slightlydrunk")
			while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
			Citizen.Wait(0)
			end
		SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
		elseif DrunkLevel >= 0.6 and DrunkLevel < 1.2 then
		RequestAnimSet("move_m@drunk@moderatedrunk")
			while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
			Citizen.Wait(0)
			end
		SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
		elseif DrunkLevel >= 1.2 and DrunkLevel < 2.0 then
		RequestAnimSet("move_m@drunk@verydrunk")
			while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			Citizen.Wait(0)
			end
		SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
		elseif DrunkLevel <= 0.25 and DrunkLevel >= 0.1 then
		RequestAnimSet("move_m@hipster@a")
			while not HasAnimSetLoaded("move_m@hipster@a") do
			Citizen.Wait(0)
			end
		SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
		end
	end
end)
