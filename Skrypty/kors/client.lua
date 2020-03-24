

Citizen.CreateThread(function()
    local dict = "anim@heists@heist_corona@single_team"
	
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 74) then -- Press H
		if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if not handsup then
				SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "single_team_loop_boss", 3.0, 3.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
			

			end
		end
     end
	end
end)

Citizen.CreateThread(function()
    while true do
    	local dupa = IsEntityPlayingAnim(PlayerPedId(), "anim@heists@heist_corona@single_team", "single_team_loop_boss", 3)
		Citizen.Wait(0)	
		if dupa then
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
		end
    end
end)