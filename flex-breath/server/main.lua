local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.breathItem , function(source,item)
    TriggerClientEvent('flex-breath:client:showBreath', source)
end)

RegisterNetEvent('flex-breath:server:testPlayer', function(TargetId, amount)
    local src = source
    TriggerClientEvent('flex-breath:client:loading', src)
    TriggerClientEvent('flex-breath:client:loading', TargetId)
    SetTimeout(1000*Config.beathTime, function()
        TriggerClientEvent('flex-breath:client:sendResults', src, amount)
    end)
end)