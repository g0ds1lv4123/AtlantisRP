ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('apple', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('apple', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	TriggerClientEvent('esx_basicneeds:onEatFruit', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_fruit'))
end)

ESX.RegisterUsableItem('orange', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('orange', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	TriggerClientEvent('esx_basicneeds:onEatFruit', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_fruit'))
end)

ESX.RegisterUsableItem('hamburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onEatBurger', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_burger'))
end)

ESX.RegisterUsableItem('hotdog', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hotdog', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEatHotdog', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_hotdog'))
end)

ESX.RegisterUsableItem('baton', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('baton', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 120000)
	TriggerClientEvent('esx_basicneeds:onEatBaton', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_baton'))
end)

ESX.RegisterUsableItem('donut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('donut', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 120000)
	TriggerClientEvent('esx_basicneeds:onEatDonut', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_donut'))
end)

ESX.RegisterUsableItem('kebab', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('kebab', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 520000)
	TriggerClientEvent('esx_basicneeds:onEatKebab', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_kebab'))
end)

------
ESX.RegisterUsableItem('juice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('juice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:drinkdo', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_juice'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

ESX.RegisterUsableItem('coffe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffe', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:oncoffe', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_coffe'))
end)

ESX.RegisterUsableItem('energyd', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('energyd', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onEnergy', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_energy'))
end)

ESX.RegisterUsableItem('cola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onCola', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cola'))
end)

--[[TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = tonumber(args[1])
		
		-- is the argument a number?
		if target ~= nil then
			
			-- is the number a valid player?
			if GetPlayerName(target) then
				print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing a player!')
				TriggerClientEvent('esx_basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "You have been healed!")
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing!')
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Heal a player, or yourself - restores thirst, hunger and health."})]]