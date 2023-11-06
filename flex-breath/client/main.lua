local QBCore = exports['qb-core']:GetCoreObject()

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

local function loadProp()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    RequestModel(GetHashKey("prop_breath"))
    while not HasModelLoaded(GetHashKey("prop_breath")) do Citizen.Wait(50) end
    breathObject = CreateObject(GetHashKey("prop_breath"), pos.x, pos.y, pos.z + 0.2, true, true, true)
    SetEntityCollision(breathObject, false, false)
    AttachEntityToEntity(breathObject, ped, GetPedBoneIndex(ped, 60309), 0.040000, 0.0350000, -0.060000, 0.000000, 180.000, 0.00, true, true, false, true, 1, true)
end

RegisterNetEvent('flex-breath:client:showBreath', function()
    SendNUIMessage({
        type = "ui",
        display = true
    })
    SetNuiFocus(true, true)
    ExecuteCommand('point')
    loadProp()
end)

RegisterNUICallback('CloseNui', function(data, cb)
    local ped = PlayerPedId()
    SetNuiFocus(false, false)
    ExecuteCommand('point')
    if DoesEntityExist(breathObject) then
        SetEntityAsMissionEntity(breathObject, false, false)
        DeleteObject(breathObject)
    end
end)

RegisterNUICallback('StartBreath', function(data, cb)
    local player, distance = GetClosestPlayer()
    if player ~= -1 then
        if distance < 5.0 then
            local TargetId = GetPlayerServerId(player)
            QBCore.Functions.TriggerCallback('police:GetPlayerStatusIdTime', function(id, time)
                if id[1] and time[1] then
                    for k, v in pairs(id) do
                        if v == 'alcohol' then
                            TriggerServerEvent('flex-breath:server:testPlayer', TargetId, Config.alcohol)
                            break
                        elseif v == 'heavy_alcohol' then
                            TriggerServerEvent('flex-breath:server:testPlayer', TargetId, Config.heavyalcohol)
                            break
                        elseif k == #id then
                            TriggerServerEvent('flex-breath:server:testPlayer', TargetId, math.random(50,100))
                        end
                    end
                else
                    TriggerServerEvent('flex-breath:server:testPlayer', TargetId, math.random(50,100))
                end
            end, TargetId)
        else
            QBCore.Functions.Notify(Lang:t('error.getcloser'), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t('error.nobodynear'), 'error')
    end
end)

RegisterNetEvent('flex-breath:client:loading', function()
    QBCore.Functions.Progressbar('beathingtest', Lang:t("info.breathing"), 1000 * Config.beathTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        QBCore.Functions.Notify(Lang:t("success.breath"), "success")
    end, function() -- Cancel
        QBCore.Functions.Notify(Lang:t("error.stoppedbreath"), "error")
    end)
end)

RegisterNetEvent('flex-breath:client:sendResults', function(result)
    SendNUIMessage({
        type = "ui",
        display = true,
        amount = result
    })
end)