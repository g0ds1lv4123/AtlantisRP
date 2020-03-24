--[[
 ___________________________________________________________________________________
|																					|
|							Code Edited by: Johnny2525								|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
	if not IsPedInAnyVehicle(ped, 1) and not IsPedCuffed(ped) then
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")

	mp_pointing = true
	end
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) and not IsPedCuffed(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
		SetPedConfigFlag(ped, 36, 0)
    end

	mp_pointing = false
end

local handsup = false

Citizen.CreateThread(function()

    --local dict = "missminuteman_1ig_2"
	local dict = "mp_am_hold_up"
    local dict2 = "random@arrests@busted"
    local dict3 = "anim@mp_player_intincarsurrenderstd@ds@"
    local dict4 = "anim@heists@heist_corona@single_team"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
  RequestAnimDict(dict2)
  while not HasAnimDictLoaded(dict2) do
    Citizen.Wait(100)
  end
  RequestAnimDict(dict3)
  while not HasAnimDictLoaded(dict3) do
    Citizen.Wait(100)
  end
  RequestAnimDict(dict4)
  while not HasAnimDictLoaded(dict4) do
    Citizen.Wait(100)
  end
	while true do
		Citizen.Wait(0)
    if(not IsPedInAnyVehicle(PlayerPedId(), false)) then
      if(not IsControlPressed(1, 21)) then
    		if IsControlJustPressed(1, 323) then --Click X
                if handsup then
                    handsup = false
    			end
            end
    		if IsControlJustPressed(1, 289) then --Click Z
                if not handsup then
                    TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_base", 3.0, 3.0, -1, 50, 0, false, false, false)
                    handsup = true
                else
                    handsup = false
                    ClearPedTasks(GetPlayerPed(-1))
                end
            end
    		if IsControlJustPressed(1, 323) then --Click X
                if handsup then
                    handsup = false
    			end
            end
    	else
        if IsControlJustPressed(1, 323) then --Click X
                if handsup then
                    handsup = false
    			end
            end
    		if IsControlJustPressed(1, 289) then --Click Z
                if not handsup then
                    TaskPlayAnim(GetPlayerPed(-1), dict2, "enter", 3.0, 3.0, -1, 50, 0, false, false, false)
                    handsup = true
                else
                TaskPlayAnim(GetPlayerPed(-1), dict2, "idle_c", 3.0, 3.0, -1, 1, 0, false, false, false)
					handsup = false
                end
            end
    		if IsControlJustPressed(1, 323) then --Click X
                if handsup then
                    handsup = false
    			end
            end
          end
          if IsControlJustPressed(1, 74) then
            if not handsup and not IsPedArmed(PlayerPedId(), 7) then
                SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
                TaskPlayAnim(GetPlayerPed(-1), dict4, "single_team_loop_boss", 1.5, 3.0, -1, 50, 0, false, false, false)
                handsup = true
			elseif not handsup and IsPedArmed(PlayerPedId(), 7) then
                SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
				Citizen.Wait(1200)
                TaskPlayAnim(GetPlayerPed(-1), dict4, "single_team_loop_boss", 1.5, 3.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
          end
      else
        if IsControlJustPressed(1, 323) then --Click X
                if handsup then
                    handsup = false
          end
            end
        if IsControlJustPressed(1, 289) then --Click Z
                if not handsup then
                    TaskPlayAnim(GetPlayerPed(-1), dict3, "idle_a", 3.0, 3.0, -1, 50, 0, false, false, false)
                    handsup = true
                else
                    handsup = false
                    ClearPedTasks(GetPlayerPed(-1))
                end
            end
        if IsControlJustPressed(1, 323) then --Click X
                if handsup then
                    handsup = false
          end
            end
          end
        if IsControlJustPressed(1, 145) then --Click X
                  if handsup then
                      ClearPedSecondaryTask(PlayerPedId())
                      handsup = false
                  end
        end
        if IsControlJustPressed(1, 113) then --Click X
                  if handsup then
                      ClearPedSecondaryTask(PlayerPedId())
                      handsup = false
                  end
        end	

  		--Finger Point

  		--if not keyPressed then
  		if not handsup then

  			if IsControlJustPressed(1, 29) then
  				startPointing()
  			elseif IsControlJustReleased(1, 29) then
  				stopPointing()
  			end

  			if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
  				--if not IsPedOnFoot(PlayerPedId()) then
  				--	stopPointing()
  				--else
  					local ped = GetPlayerPed(-1)
  					local camPitch = GetGameplayCamRelativePitch()
  					if camPitch < -70.0 then
  						camPitch = -70.0
  					elseif camPitch > 42.0 then
  						camPitch = 42.0
  					end
  					camPitch = (camPitch + 70.0) / 112.0

  					local camHeading = GetGameplayCamRelativeHeading()
  					local cosCamHeading = Cos(camHeading)
  					local sinCamHeading = Sin(camHeading)
  					if camHeading < -180.0 then
  						camHeading = -180.0
  					elseif camHeading > 180.0 then
  						camHeading = 180.0
  					end
  					camHeading = (camHeading + 180.0) / 360.0

  					local blocked = 0
  					local nn = 0

  					local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
  					local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
  					nn,blocked,coords,coords = GetRaycastResult(ray)

  					Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
  					Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
  					Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
  					Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

  				--end
  			end
  		end
  		--if(handsup or mp_pointing) then
  		--local dupa2 = IsEntityPlayingAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_enter", 3)
  		local dupa2 = IsEntityPlayingAnim(PlayerPedId(), "mp_am_hold_up", "handsup_base", 3)
		local dupa3 = IsEntityPlayingAnim(PlayerPedId(), "random@arrests@busted", "enter", 3)
		local dupa4 = IsEntityPlayingAnim(PlayerPedId(), "anim@mp_player_intincarsurrenderstd@ds@", "idle_a", 3)
    local dupa5 = IsEntityPlayingAnim(PlayerPedId(), "anim@heists@heist_corona@single_team", "single_team_loop_boss", 3)
    local predkoscswiatla = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))

  		if dupa2 or dupa3 or dupa5 then

  			DisableControlAction(0, 25,   true) -- Input Aim
  			DisableControlAction(0, 24,   true) -- Input Attack
  			DisableControlAction(0, 140,  true) -- Melee Attack Alternate
  			DisableControlAction(0, 141,  true) -- Melee Attack Alternate
  			DisableControlAction(0, 142,  true) -- Melee Attack Alternate
  			DisableControlAction(0, 257,  true) -- Input Attack 2
  			DisableControlAction(0, 263,  true) -- Input Melee Attack
  			DisableControlAction(0, 264,  true) -- Input Melee Attack 2
  			DisableControlAction(0, 44,  true) -- Q
  			DisableControlAction(0, 157,  true) -- 1
  			DisableControlAction(0, 158,  true) -- 2
  			DisableControlAction(0, 160,  true) -- 3
  			DisableControlAction(0, 164,  true) -- 4
  			DisableControlAction(0, 165,  true) -- 5
  			DisableControlAction(0, 159,  true) -- 6
  			DisableControlAction(0, 161,  true) -- 7
  			DisableControlAction(0, 162,  true) -- 8
  			DisableControlAction(0, 163,  true) -- 9
  			DisableControlAction(0, 37,  true) -- TAB

		  elseif dupa4 then
            if predkoscswiatla >= 1 then
      			DisableControlAction(0, 25,   true) -- Input Aim
      			DisableControlAction(0, 24,   true) -- Input Attack
      			DisableControlAction(0, 140,  true) -- Melee Attack Alternate
      			DisableControlAction(0, 141,  true) -- Melee Attack Alternate
      			DisableControlAction(0, 142,  true) -- Melee Attack Alternate
      			DisableControlAction(0, 257,  true) -- Input Attack 2
      			DisableControlAction(0, 263,  true) -- Input Melee Attack
      			DisableControlAction(0, 264,  true) -- Input Melee Attack 2
      			DisableControlAction(0, 44,  true) -- Q
      			DisableControlAction(0, 44,  true) -- Q
      			DisableControlAction(0, 157,  true) -- 1
      			DisableControlAction(0, 158,  true) -- 2
      			DisableControlAction(0, 160,  true) -- 3
      			DisableControlAction(0, 164,  true) -- 4
      			DisableControlAction(0, 165,  true) -- 5
      			DisableControlAction(0, 159,  true) -- 6
      			DisableControlAction(0, 161,  true) -- 7
      			DisableControlAction(0, 162,  true) -- 8
      			DisableControlAction(0, 163,  true) -- 9
      			DisableControlAction(0, 37,  true) -- TAB
      			DisableControlAction(0, 59,  true) -- Turn
      			DisableControlAction(0, 76,  true) -- Handbrake
      			DisableControlAction(0, 74,  true) -- Headlight
      			DisableControlAction(0, 86,  true) -- Horn
      			DisableControlAction(0, 244,  true) -- M
      			DisableControlAction(0, 81,  true) -- .
      			DisableControlAction(0, 82,  true) -- ,
      			DisableControlAction(0, 85,  true) -- Q
      			DisableControlAction(0, 91,  true) -- INPUT_VEH_PASSENGER_AIM
      			DisableControlAction(0, 92,  true) -- INPUT_VEH_PASSENGER_ATTACK
      			DisableControlAction(0, 99,  true) -- INPUT_VEH_SELECT_NEXT_WEAPON
      			DisableControlAction(0, 100,  true) -- INPUT_VEH_SELECT_PREV_WEAPON
      			DisableControlAction(0, 246,  true) -- Y
      			DisableControlAction(0, 303,  true) -- U
      			DisableControlAction(0, 313,  true) -- ]
      			DisableControlAction(0, 213,  true) -- Home
      			DisableControlAction(0, 87,  true) -- INPUT_VEH_FLY_THROTTLE_UP
      			DisableControlAction(0, 88,  true) -- INPUT_VEH_FLY_THROTTLE_DOWN
      			DisableControlAction(0, 89,  true) -- INPUT_VEH_FLY_YAW_LEFT
      			DisableControlAction(0, 90,  true) -- INPUT_VEH_FLY_YAW_RIGHT
      			DisableControlAction(0, 91,  true) -- INPUT_VEH_PASSENGER_AIM
      			DisableControlAction(0, 92,  true) -- INPUT_VEH_PASSENGER_ATTACK
      			DisableControlAction(0, 106,  true) -- INPUT_VEH_MOUSE_CONTROL_OVERRIDE
      			DisableControlAction(0, 114,  true) -- INPUT_VEH_FLY_ATTACK
      			DisableControlAction(0, 115,  true) -- INPUT_VEH_FLY_SELECT_NEXT_WEAPON
      			DisableControlAction(0, 116,  true) -- INPUT_VEH_FLY_SELECT_PREV_WEAPON
			--  DisableControlAction(0, 72,  true) -- Brake
          else
      			DisableControlAction(0, 25,   true) -- Input Aim
      			DisableControlAction(0, 24,   true) -- Input Attack
      			DisableControlAction(0, 140,  true) -- Melee Attack Alternate
      			DisableControlAction(0, 141,  true) -- Melee Attack Alternate
      			DisableControlAction(0, 142,  true) -- Melee Attack Alternate
      			DisableControlAction(0, 257,  true) -- Input Attack 2
      			DisableControlAction(0, 263,  true) -- Input Melee Attack
      			DisableControlAction(0, 264,  true) -- Input Melee Attack 2
      			DisableControlAction(0, 44,  true) -- Q
      			DisableControlAction(0, 44,  true) -- Q
      			DisableControlAction(0, 157,  true) -- 1
      			DisableControlAction(0, 158,  true) -- 2
      			DisableControlAction(0, 160,  true) -- 3
      			DisableControlAction(0, 164,  true) -- 4
      			DisableControlAction(0, 165,  true) -- 5
      			DisableControlAction(0, 159,  true) -- 6
      			DisableControlAction(0, 161,  true) -- 7
      			DisableControlAction(0, 162,  true) -- 8
      			DisableControlAction(0, 163,  true) -- 9
      			DisableControlAction(0, 37,  true) -- TAB
      			DisableControlAction(0, 59,  true) -- Turn
      			DisableControlAction(0, 76,  true) -- Handbrake
      			DisableControlAction(0, 74,  true) -- Headlight
      			DisableControlAction(0, 86,  true) -- Horn
      			DisableControlAction(0, 244,  true) -- M
      			DisableControlAction(0, 81,  true) -- .
      			DisableControlAction(0, 82,  true) -- ,
      			DisableControlAction(0, 85,  true) -- Q
      			DisableControlAction(0, 91,  true) -- INPUT_VEH_PASSENGER_AIM
      			DisableControlAction(0, 92,  true) -- INPUT_VEH_PASSENGER_ATTACK
      			DisableControlAction(0, 99,  true) -- INPUT_VEH_SELECT_NEXT_WEAPON
      			DisableControlAction(0, 100,  true) -- INPUT_VEH_SELECT_PREV_WEAPON
      			DisableControlAction(0, 246,  true) -- Y
      			DisableControlAction(0, 303,  true) -- U
      			DisableControlAction(0, 313,  true) -- ]
      			DisableControlAction(0, 213,  true) -- Home
      			DisableControlAction(0, 87,  true) -- INPUT_VEH_FLY_THROTTLE_UP
      			DisableControlAction(0, 88,  true) -- INPUT_VEH_FLY_THROTTLE_DOWN
      			DisableControlAction(0, 89,  true) -- INPUT_VEH_FLY_YAW_LEFT
      			DisableControlAction(0, 90,  true) -- INPUT_VEH_FLY_YAW_RIGHT
      			DisableControlAction(0, 91,  true) -- INPUT_VEH_PASSENGER_AIM
      			DisableControlAction(0, 92,  true) -- INPUT_VEH_PASSENGER_ATTACK
      			DisableControlAction(0, 106,  true) -- INPUT_VEH_MOUSE_CONTROL_OVERRIDE
      			DisableControlAction(0, 114,  true) -- INPUT_VEH_FLY_ATTACK
      			DisableControlAction(0, 115,  true) -- INPUT_VEH_FLY_SELECT_NEXT_WEAPON
      			DisableControlAction(0, 116,  true) -- INPUT_VEH_FLY_SELECT_PREV_WEAPON
				DisableControlAction(0, 72,  true) -- Brake
          end
  		end
  	end
  end)
