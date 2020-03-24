-- Created by Deziel0495 and IllusiveTea --

-- NOTICE
-- This script is licensed under "No License". https://choosealicense.com/no-license/
-- You are allowed to: Download, Use and Edit the Script. 
-- You are not allowed to: Copy, re-release, re-distribute it without our written permission.

--- DO NOT EDIT THIS
local holstered = true
local PlayerData = {}
ESX                           = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	Citizen.Wait(10000)
	
end)
-- RESTRICTED PEDS --
-- I've only listed peds that have a remote speaker mic, but any ped listed here will do the animations.
local skins = {
	"s_m_y_cop_01",
	"s_f_y_cop_01",
	"s_m_y_hwaycop_01",
	"s_m_y_sheriff_01",
	"s_f_y_sheriff_01",
	"s_m_y_ranger_01",
	"s_f_y_ranger_01",
}

-- Add/remove weapon hashes here to be added for holster checks.
local weapons = {
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_STUNGUN",
--	"WEAPON_SNSPISTOL",
--	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_FLAREGUN",
	"WEAPON_REVOLVER",
--	"WEAPON_REVOLVER_MK2",
}

local checked = false
local havelicense = false

-- RADIO ANIMATIONS --

--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait( 1 ) 
--        local ped = PlayerPedId()
--        if DoesEntityExist( ped ) and not IsEntityDead( ped ) then
--            if not IsPauseMenuActive() then
--                if IsControlJustReleased( 0, 244 ) or IsDisabledControlJustReleased( 0, 82 ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
 --                   TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'off', 0.1)
--                    ClearPedTasks(ped)
 --                   Citizen.Wait(500)
 --               else 	
 --                   if IsControlJustPressed( 0, 244 ) or IsDisabledControlJustPressed( 0, 82 ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
 --                       if not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(ped, true) then
--							loadAnimDict( "random@arrests" )
 --                           TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 3.0, -1, 50, 2.0, 0, 0, 0 )						
 --                           TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'on', 0.1)
 --                       elseif IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(ped, true) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
--							loadAnimDict( "random@arrests" )
  --                          TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 3.0, -1, 50, 2.0, 0, 0, 0 )
  --                          TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0,'on', 0.1)
 --                       elseif IsPedInAnyVehicle(ped, true) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
--							loadAnimDict( "random@arrests" )
 --                           TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 3.0, -1, 50, 2.0, 0, 0, 0 )
 --                           TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'on', 0.1)                           
 --                       end    
 --                   end
 --               end
  --              if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_enter", 3) then
   --                 DisableActions(ped)
  --              elseif IsEntityPlayingAnim(ped, "random@arrests", "radio_chatter", 3) then
  --                  DisableActions(ped)
   --             end
  --          end
  --      end
  --  end
--end )

-- HOLD WEAPON HOLSTER ANIMATION --

--Citizen.CreateThread( function()
--	while true do 
--		Citizen.Wait( 0 )
--		local ped = PlayerPedId()
--		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then 
--			DisableControlAction( 0, 20, true ) -- INPUT_MULTIPLAYER_INFO (Z)
--			if not IsPauseMenuActive() then 
--				loadAnimDict( "reaction@intimidation@cop@unarmed" )		
--				if IsDisabledControlJustReleased ( 0, 20 ) and not IsDisabledControlJustPressed( 0, 25 ) then -- INPUT_MULTIPLAYER_INFO (Z)
--					ClearPedTasks(ped)
--					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
--				else
--					if IsDisabledControlJustPressed( 0, 20 ) and not IsDisabledControlJustPressed( 0, 25 ) then -- INPUT_MULTIPLAYER_INFO (Z)
--						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_PISTOL"), true) 
--						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 3.0, -1, 50, 0, 0, 0, 0 )
--				else
--					end
--					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then 
--						DisableActions(ped)
--					end	
--				end
--			end 
--		end
--	end
--end )

-- HOLSTER/UNHOLSTER PISTOL --
 
 Citizen.CreateThread(function()
 		while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle( ped, true) then
			if CheckWeapon(ped) then
			if not IsDisabledControlJustPressed( 0, 20 ) and not IsDisabledControlJustPressed( 0, 25 ) and holstered and not IsEntityPlayingAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 3) then
			--if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
			if licensecheck() then
					loadAnimDict( "rcmjosh4" )
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 3.0, 700, 48, 0, 0, 0, 0 )
					
			else
					loadAnimDict( "reaction@intimidation@1h" )
					TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 3.0, 1400, 48, 2, 0, 0, 0 )
                    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                    Citizen.Wait(1200)
                    SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
				end
					holstered = false
				end
			elseif not CheckWeapon(ped) then
				if not IsDisabledControlJustReleased( 0, 20 ) and not IsDisabledControlJustPressed( 0, 25 ) and not holstered and not IsEntityPlayingAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 3) then 
				--if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
				if licensecheck() then
					loadAnimDict( "weapons@pistol@" )
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 3.0, -1, 48, 0, 0, 0, 0 )
				else
					loadAnimDict( "reaction@intimidation@1h" )
					TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, 1500, 48, 2, 0, 0, 0 )      
					--Citizen.Wait(1500)
					--ClearPedTasks(ped)
				end
					holstered = true
				end
			end
		end		
	end
end)

 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()

		if IsEntityPlayingAnim(ped, "rcmjosh4", "josh_leadout_cop2", 3) or IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) then
			DisableActions(ped)
		end
	end
end)

-- DO NOT REMOVE THESE! --

function CheckSkin(ped)
	
	for i = 1, #skins do
		
		if GetHashKey(skins[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return true
end

function CheckWeapon(ped)
	for i = 1, #weapons do

		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function licensecheck()
	local haveholster = false
  TriggerEvent('skinchanger:holstercheck', function(have)
  	if have then
  		haveholster = true
  	else 
  		haveholster = false
  	end
  end)
  if haveholster then
  	return true
  else
  	return false
  end
end

--[[old
function licensecheck()
	if not checked then
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then
				checked = true
				havelicense = true	
				return true
			end
		end, GetPlayerServerId(PlayerId()), 'weapon')
	elseif checked and not havelicense then
		return false
	elseif checked and havelicense then
		return true
	end
end]]

function DisableActions(ped)
	DisableControlAction(1, 82, true)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisableControlAction(1, 25, true) -- Disables AIM (RMB)
	DisableControlAction(1, 45, true) -- R
	DisableControlAction(1, 44, true) -- Q (Cover)
	DisableControlAction(1, 73, true) -- X
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end
