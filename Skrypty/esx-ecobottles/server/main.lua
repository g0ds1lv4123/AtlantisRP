ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-ecobottles:sellBottles')
AddEventHandler('esx-ecobottles:sellBottles', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local currentBottles = xPlayer.getInventoryItem('bottle').count
    local randomMoney = math.random(1, 4)

    if currentBottles > 0 then
        xPlayer.removeInventoryItem('bottle', currentBottles)
        xPlayer.addMoney(randomMoney * currentBottles)
        TriggerClientEvent('esx:showNotification', src, 'Oddano do skupu ' .. currentBottles .. ' butelek, za co otrzymano $' .. randomMoney * currentBottles .. '!')
    else
        TriggerClientEvent('esx:showNotification', src, 'Nie masz wystarczająco butelek!')
    end
end)


RegisterServerEvent('esx-ecobottles:retrieveBottle')
AddEventHandler('esx-ecobottles:retrieveBottle', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local luck = math.random(0, 100)
    local randomBottle = math.random(2, 4)

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent('esx:showNotification', src, 'Niczego nie znaleziono')
    elseif luck >= 30 and luck <= 60 then
        xPlayer.addInventoryItem('bottle', randomBottle)
        TriggerClientEvent('esx:showNotification', src, 'Znaleziono ' .. randomBottle .. ' butelki')
	else
		xPlayer.addInventoryItem('seed_weed', 1)
        TriggerClientEvent('esx:showNotification', src, 'O! A co to takiego?')
    end
end)
