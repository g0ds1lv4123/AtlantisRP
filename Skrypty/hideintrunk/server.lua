RegisterServerEvent("hidein:trunk_force")
AddEventHandler("hidein:trunk_force", function(id)
    TriggerClientEvent('hidein:trunk_forceput', id)
end)
