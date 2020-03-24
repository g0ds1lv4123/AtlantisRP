ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_fishing:caughtFish')
AddEventHandler('esx_fishing:caughtFish', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.addInventoryItem('fish', 1)
	TriggerClientEvent('esx:showNotification', source, 'You caught a Pompano')

end)

ESX.RegisterUsableItem('fish', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fish', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx_fishing:onEatFish', source)
	TriggerClientEvent('esx:showNotification', source, 'Zjadasz surową rybę ~ r ~ nie jest za smaczna ~ s ~')

end)

ESX.RegisterUsableItem('fishlicense', function(source)

		local xPlayer  = ESX.GetPlayerFromId(source)	

		local licenseQuantity = xPlayer.getInventoryItem('fishlicense').count

		xPlayer.removeInventoryItem('fishlicense', 0)

		TriggerClientEvent('esx_fishing:onShowLicense', source)			   
		

end)

RegisterServerEvent('esx_fishing:SellFish')
AddEventHandler('esx_fishing:SellFish', function(item, count)

		
			local xPlayer  = ESX.GetPlayerFromId(source)

			local fishQuantity = xPlayer.getInventoryItem('fish').count

			if fishQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, 'Nie masz już ryb na sprzedaż')
			else
				xPlayer.removeInventoryItem('fish', 1)
				   xPlayer.addMoney(20)
				   TriggerClientEvent('esx:showNotification', source, 'Sprzedałeś rybę w skupie')				   
				   
			end
end)

RegisterServerEvent('esx_fishing:removeInventoryItem')
AddEventHandler('esx_fishing:removeInventoryItem', function(item, quantity)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, quantity)
end)