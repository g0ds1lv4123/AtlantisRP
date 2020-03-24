ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- DRUGS
ESX.RegisterUsableItem('rweed', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('rweed', 1)
	TriggerClientEvent('esx_fnkydrugs:onWeed', source)
	TriggerClientEvent('esx_status:remove', source, 'hunger', 100000)
end)

ESX.RegisterUsableItem('rhybrid', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('rhybrid', 1)
	TriggerClientEvent('esx_fnkydrugs:rhybrid', source)
			TriggerClientEvent('esx_status:remove', source, 'hunger', 150000)
end)

ESX.RegisterUsableItem('rsativa', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('rsativa', 1)

	TriggerClientEvent('esx_fnkydrugs:rsativa', source)
			TriggerClientEvent('esx_status:remove', source, 'hunger', 250000)
end)

ESX.RegisterUsableItem('opium', function(source)
       
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('esx_fnkydrugs:onOpium', source)
end)

ESX.RegisterUsableItem('meth_sudo', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth_sudo', 1)

	TriggerClientEvent('esx_fnkydrugs:onMeth', source)
end)

ESX.RegisterUsableItem('rcoke100', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rcoke100', 1)

	TriggerClientEvent('esx_fnkydrugs:onCoke100', source)
end)

ESX.RegisterUsableItem('rcoke90', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rcoke90', 1)

	TriggerClientEvent('esx_fnkydrugs:onCoke90', source)
end)

ESX.RegisterUsableItem('rcoke70', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rcoke70', 1)

	TriggerClientEvent('esx_fnkydrugs:onCoke70', source)
end)

ESX.RegisterUsableItem('xanax', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('xanax', 1)
	
	TriggerClientEvent('esx_fnkydrugs:onXanax', source)
end)

ESX.RegisterUsableItem('acid', function(source)
        
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('acid', 1)

	TriggerClientEvent('esx_fnkydrugs:onAcid', source)
end)

-- ALCO
ESX.RegisterUsableItem('beer', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('beer', 1)
	
	TriggerClientEvent('esx_fnkydrugs:onBeer', source)
end)

ESX.RegisterUsableItem('vine', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vine', 1)
	
	TriggerClientEvent('esx_fnkydrugs:onWine', source)
end)

ESX.RegisterUsableItem('whisky', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('whisky', 1)
	
	TriggerClientEvent('esx_fnkydrugs:onWhisky', source)
end)

ESX.RegisterUsableItem('vodka', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vodka', 1)
	
	TriggerClientEvent('esx_fnkydrugs:onVodka', source)
end)

-- Drug craft

-- Cutting weed in one chain, because i am badass madafaka dis who i am
ESX.RegisterUsableItem('scissors', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local weed_ammount = xPlayer.getInventoryItem('weed') -- Indica
    local hybrid_ammount = xPlayer.getInventoryItem('weed_hybrid') -- Ruderalis
    local sativa_ammount = xPlayer.getInventoryItem('weed_sativa') -- Sativa
	local rweed_amount = xPlayer.getInventoryItem('rweed') -- Indica
	local rhybrid_ammount = xPlayer.getInventoryItem('rhybrid') -- Ruderalis
    local rsativa_ammount = xPlayer.getInventoryItem('rsativa') -- Sativa
    
    if weed_ammount.count >= 1 then
        while (weed_ammount.count >= 15 and rweed_amount.count <= 90) do
            xPlayer.removeInventoryItem('weed', 15)
            xPlayer.addInventoryItem('rweed', 15)
			if math.random(1,100) >= 95 then
				xPlayer.addInventoryItem('seed_weed', 1)
			end
            weed_ammount = xPlayer.getInventoryItem('weed') -- Indica
		end

    elseif hybrid_ammount.count >= 1 then
		while (hybrid_ammount.count >= 15 and rhybrid_ammount.count <= 90) do
			xPlayer.removeInventoryItem('weed_hybrid', 15)
			xPlayer.addInventoryItem('rhybrid', 15)
			if math.random(1,100) >= 95 then
				xPlayer.addInventoryItem('seed_hybrid', 1)
			end
            hybrid_ammount = xPlayer.getInventoryItem('weed_hybrid') -- Ruderalis
		end
		
	elseif sativa_ammount.count >= 1 then
		while (sativa_ammount.count >= 15 and rsativa_ammount.count <= 90) do
			xPlayer.removeInventoryItem('weed_sativa', 15)
			xPlayer.addInventoryItem('rsativa', 15)
			if math.random(1,100) >= 95 then
				xPlayer.addInventoryItem('seed_sativa', 1)
			end
            sativa_ammount = xPlayer.getInventoryItem('weed_sativa') -- Sativa
		end
	end
end)

-- Coke crafting

ESX.RegisterUsableItem('mortar', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local coke100_ammount	= xPlayer.getInventoryItem('coke100')
    local coke90_ammount 	= xPlayer.getInventoryItem('coke90')
    local coke70_ammount 	= xPlayer.getInventoryItem('coke70')
    if coke100_ammount.count > 0 or coke90_ammount.count > 0 or coke70_ammount.count > 0 then
    	TriggerClientEvent('esx_fnkydrugs:checkpos', _source)
    end
end)

RegisterServerEvent('esx_fnkydrugs:mortar')
AddEventHandler('esx_fnkydrugs:mortar', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local coke100_ammount	= xPlayer.getInventoryItem('coke100')
    local coke90_ammount 	= xPlayer.getInventoryItem('coke90')
    local coke70_ammount 	= xPlayer.getInventoryItem('coke70')
	local rcoke100_ammount	= xPlayer.getInventoryItem('rcoke100')
    local rcoke90_ammount 	= xPlayer.getInventoryItem('rcoke90')
    local rcoke70_ammount 	= xPlayer.getInventoryItem('rcoke70')
	local mortar_ammount	= xPlayer.getInventoryItem('mortar')
    
	if mortar_ammount.count >= 1 then
		if coke100_ammount.count >= 15 then
			while (coke100_ammount.count >= 15 and rcoke100_ammount.count <= 105) do
				xPlayer.removeInventoryItem('coke100', 15)
				xPlayer.addInventoryItem('rcoke100', 15)
				coke100_ammount 	= xPlayer.getInventoryItem('coke100')
				rcoke100_ammount	= xPlayer.getInventoryItem('rcoke100')
				break
			if math.random(1,100) >= 99 then
				xPlayer.addInventoryItem('seed_coke100', 1)
			end
		end
	
		elseif coke90_ammount.count >= 15  then
			while (coke90_ammount.count >= 15 and rcoke90_ammount.count <= 105) do
				xPlayer.removeInventoryItem('coke90', 15)
				xPlayer.addInventoryItem('rcoke90', 15)
				coke90_ammount 		= xPlayer.getInventoryItem('coke90')
				rcoke90_ammount		= xPlayer.getInventoryItem('rcoke90')
				break
			if math.random(1,100) >= 96 then
				xPlayer.addInventoryItem('seed_coke90', 1)
			end
		end

		elseif coke70_ammount.count >= 15  then
			while (coke70_ammount.count >= 15 and rcoke70_ammount.count <= 105) do
				xPlayer.removeInventoryItem('coke70', 15)
				xPlayer.addInventoryItem('rcoke70', 15)
				coke70_ammount 		= xPlayer.getInventoryItem('coke70')
				rcoke70_ammount		= xPlayer.getInventoryItem('rcoke70')
				break
			if math.random(1,100) >= 92 then
				xPlayer.addInventoryItem('seed_coke70', 1)
			end
		end
	  end
	end
end)

-- Coke crafting
--ESX.RegisterUsableItem('mortar', function(source)
--    local _source = source
--    local xPlayer = ESX.GetPlayerFromId(_source)
--    local coke100_ammount	= xPlayer.getInventoryItem('coke100')
--    local coke90_ammount 	= xPlayer.getInventoryItem('coke90')
 --   local coke70_ammount 	= xPlayer.getInventoryItem('coke70')
--	local coke100paste_ammount	= xPlayer.getInventoryItem('coke100paste')
 --   local coke90paste_ammount 	= xPlayer.getInventoryItem('coke90paste')
 --   local coke70paste_ammount 	= xPlayer.getInventoryItem('coke70paste')
    
 --   if coke100_ammount.count >= 1  then
  --      while (coke100_ammount.count >= 5 and coke100paste_ammount.count <= 15) do
 --           xPlayer.removeInventoryItem('coke100', 1)
  --          xPlayer.addInventoryItem('coke100paste', 1)
	--		if math.random(1,100) >= 99 then
	--			xPlayer.addInventoryItem('seed_coke100', 1)
	--		end
    --        coke100_ammount = xPlayer.getInventoryItem('coke100')
	--		coke100paste_ammount	= xPlayer.getInventoryItem('coke100paste')
	--	end
		
   -- elseif coke90_ammount.count >= 1  then
	--	while (coke90_ammount.count >= 1 and coke90paste_ammount.count <= 15) do
	--		xPlayer.removeInventoryItem('coke90', 1)
	--		xPlayer.addInventoryItem('coke90paste', 1)
	--		if math.random(1,100) >= 96 then
	--			xPlayer.addInventoryItem('seed_coke90', 1)
	--		end
    --        coke90_ammount = xPlayer.getInventoryItem('coke90')
	--		coke100paste_ammount	= xPlayer.getInventoryItem('coke90paste')
	--	end
		
	--elseif coke70_ammount.count >= 1  then
	--	while (coke70_ammount.count >= 5 and coke70paste_ammount.count <= 15) do
	--		xPlayer.removeInventoryItem('coke70', 1)
	--		xPlayer.addInventoryItem('coke70paste', 5)
	--		if math.random(1,100) >= 92 then
	--			xPlayer.addInventoryItem('seed_coke70', 1)
	--		end
     --       coke70_ammount = xPlayer.getInventoryItem('coke70')
	--		coke100paste_ammount	= xPlayer.getInventoryItem('coke70paste')
	--	end
	--end
--end)

--ESX.RegisterUsableItem('refinedpetrol', function(source)
--    local _source = source
 --   local xPlayer = ESX.GetPlayerFromId(_source)
--    local coke100paste_ammount	= xPlayer.getInventoryItem('coke100paste')
 --   local coke90paste_ammount 	= xPlayer.getInventoryItem('coke90paste')
--    local coke70paste_ammount 	= xPlayer.getInventoryItem('coke70paste')
--	local rcoke100_ammount	= xPlayer.getInventoryItem('rcoke100')
--    local rcoke90_ammount 	= xPlayer.getInventoryItem('rcoke90')
--    local rcoke70_ammount 	= xPlayer.getInventoryItem('rcoke70')
--	local petrol_ammount	= xPlayer.getInventoryItem('refinedpetrol')
    
--	if petrol_ammount.count >= 1 then
--		if coke100paste_ammount.count >= 1  then
		
--			while (coke100paste_ammount.count >= 1) do
--				if petrol_ammount.count == 0 and coke100paste_ammount.count < 10 and rcoke100_ammount.count <= 200 then break end
--				xPlayer.removeInventoryItem('refinedpetrol', 1)
--				xPlayer.removeInventoryItem('coke100paste', 10)
--				xPlayer.addInventoryItem('rcoke100', 10)
--				coke100paste_ammount 	= xPlayer.getInventoryItem('coke100paste')
--				petrol_ammount			= xPlayer.getInventoryItem('refinedpetrol')
--				rcoke100_ammount		= xPlayer.getInventoryItem('rcoke100')
--			end
	
--		elseif coke90paste_ammount.count >= 1  then
--			while (coke90paste_ammount.count > 0) do
--				if petrol_ammount.count == 0 and coke90paste_ammount.count < 10 and rcoke90_ammount.count <= 200 then break end
--				xPlayer.removeInventoryItem('refinedpetrol', 1)
--				xPlayer.removeInventoryItem('coke90paste', 10)
--				xPlayer.addInventoryItem('rcoke90', 10)
--				coke90paste_ammount 	= xPlayer.getInventoryItem('coke90paste')
--				petrol_ammount			= xPlayer.getInventoryItem('refinedpetrol')
--				rcoke90_ammount			= xPlayer.getInventoryItem('rcoke90')
--			end
--
--		elseif coke70paste_ammount.count >= 1  then
--			while (coke70paste_ammount.count > 0) do
--				if petrol_ammount.count == 0 and coke70paste_ammount.count < 10 and rcoke90_ammount.count <= 200 then break end
--				xPlayer.removeInventoryItem('refinedpetrol', 1)
--				xPlayer.removeInventoryItem('coke70paste', 10)
--				xPlayer.addInventoryItem('rcoke70', 10)
--				coke70paste_ammount 	= xPlayer.getInventoryItem('coke70paste')
--				petrol_ammount			= xPlayer.getInventoryItem('refinedpetrol')
--				rcoke70_ammount			= xPlayer.getInventoryItem('rcoke70')
--			end
--		end
--	end
--end)