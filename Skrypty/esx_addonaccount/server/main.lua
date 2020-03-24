ESX                  = nil
local AccountsIndex  = {}
local Accounts       = {}
local SharedAccounts = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account')

	for i=1, #result, 1 do
		local name   = result[i].name
		local label  = result[i].label
		local shared = result[i].shared

		local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name', {
			['@account_name'] = name
		})

		if shared == 0 then

			table.insert(AccountsIndex, name)
			Accounts[name] = {}

			for j=1, #result2, 1 do
				local addonAccount = CreateAddonAccount(name, result2[j].owner, result2[j].money)
				table.insert(Accounts[name], addonAccount)
			end

		else

			local money = nil

			if #result2 == 0 then
				MySQL.Sync.execute('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, NULL)',
				{
					['@account_name'] = name,
					['@money']        = 0
				})

				money = 0
			else
				money = result2[1].money
			end

			local addonAccount   = CreateAddonAccount(name, nil, money)
			SharedAccounts[name] = addonAccount

		end
	end
end)

function GetAccount(name, owner)
	for i=1, #Accounts[name], 1 do
		if Accounts[name][i].owner == owner then
			return Accounts[name][i]
		end
	end
end
function GetAccountReset(name, owner)
	for i=1, #Accounts[name], 1 do
		if Accounts[name][i] ~= nil then
			if Accounts[name][i].owner == owner then
				--print("Usuwam -> ".. Accounts[name][i].name)
				table.remove(Accounts[name], i)
			end
		end
	end
	return true
end
function GetSharedAccount(sharedName)
	return SharedAccounts[sharedName]
end
function ReRegisterShared () 
	SharedAccounts = {}
	local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account WHERE shared = 1')

	for i=1, #result, 1 do
		local name   = result[i].name
		local label  = result[i].label
		local shared = result[i].shared

		local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name', {
			['@account_name'] = name
		})

		if shared == 1 then
		
			local money = nil

			if #result2 == 0 then
				MySQL.Sync.execute('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, NULL)',
				{
					['@account_name'] = name,
					['@money']        = 0
				})

				money = 0
			else
				money = result2[1].money
			end

			local addonAccount   = CreateAddonAccount(name, nil, money)
			SharedAccounts[name] = addonAccount
		end
	end
end
AddEventHandler('esx_addonaccount:getAccount', function(name, owner, cb)
	cb(GetAccount(name, owner))
end)

AddEventHandler('esx_addonaccount:getSharedAccount', function(name, cb)
	cb(GetSharedAccount(name))
end)


RegisterServerEvent('esx_fixAddon:Accounts')
AddEventHandler('esx_fixAddon:Accounts', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local addonAccounts = {}
	xPlayer.set('addonAccounts', addonAccounts)
	for i=1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local accountReset = GetAccountReset(name, xPlayer.identifier)
	end
	local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account')
	for i=1, #result, 1 do
		local name   = result[i].name
		local label  = result[i].label
		local shared = result[i].shared
		if shared == 0 then
			local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name AND owner = @owner', 
			{
				['@account_name'] = name,
				['@owner'] = xPlayer.identifier
			})
			for j=1, #result2, 1 do
				--print(name)
				--print(result2[j].owner)
				--print(result2[j].money)
				local addonAccount = CreateAddonAccount(name, result2[j].owner, result2[j].money)
				table.insert(Accounts[name], addonAccount)
			end
		end
	end
	for i=1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local account = GetAccount(name, xPlayer.identifier)
		if account == nil then
			MySQL.Async.execute('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, @owner)',
			{
				['@account_name'] = name,
				['@money']        = 0,
				['@owner']        = xPlayer.identifier
			})

			account = CreateAddonAccount(name, xPlayer.identifier, 0)
			table.insert(Accounts[name], account)
		end

		table.insert(addonAccounts, account)
	end

	xPlayer.set('addonAccounts', addonAccounts)
	ReRegisterShared()

end)
AddEventHandler('esx:playerLoaded', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local addonAccounts = {}
	xPlayer.set('addonAccounts', addonAccounts)
	for i=1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local accountReset = GetAccountReset(name, xPlayer.identifier)
	end
	local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account')
	for i=1, #result, 1 do
		local name   = result[i].name
		local label  = result[i].label
		local shared = result[i].shared
		if shared == 0 then
			local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name AND owner = @owner', 
			{
				['@account_name'] = name,
				['@owner'] = xPlayer.identifier
			})
			for j=1, #result2, 1 do
				--print(name)
				--print(result2[j].owner)
				--print(result2[j].money)
				local addonAccount = CreateAddonAccount(name, result2[j].owner, result2[j].money)
				table.insert(Accounts[name], addonAccount)
			end
		end
	end
	for i=1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local account = GetAccount(name, xPlayer.identifier)
		if account == nil then
			MySQL.Async.execute('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, @owner)',
			{
				['@account_name'] = name,
				['@money']        = 0,
				['@owner']        = xPlayer.identifier
			})

			account = CreateAddonAccount(name, xPlayer.identifier, 0)
			table.insert(Accounts[name], account)
		end

		table.insert(addonAccounts, account)
	end

	xPlayer.set('addonAccounts', addonAccounts)
end)
