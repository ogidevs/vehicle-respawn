local QBCore = exports['qb-core']:GetCoreObject()
local despawnedVehicles = {}

RegisterNetEvent('QBCore:Client:LeftVehicle', function(data)
    if data.vehicle == nil or data.plate == nil then return end
    local plate = data.plate
    local vehCoords = GetEntityCoords(data.vehicle)
    local vehHeading = GetEntityHeading(data.vehicle)
    local vehModel = GetEntityModel(data.vehicle)
    local vehProperties = QBCore.Functions.GetVehicleProperties(data.vehicle)
    TriggerServerEvent('Ogi-NoDespawn:Server:AddVehicleNoDespawn', plate, vehProperties, vehCoords, vehModel, NetworkGetNetworkIdFromEntity(data.vehicle), vehHeading)
end)

RegisterNetEvent('Ogi-NoDespawn:Client:UpdateDespawnedVehicle', function(vehProps, vehModel, vehPlate, vehCoords, vehHeading)
    Citizen.CreateThread(function()
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            if DoesEntityExist(veh) then
                NetworkRequestControlOfEntity(veh)
                local timeout = 2000
                while timeout > 0 and not NetworkHasControlOfEntity(veh) do
                    Wait(100)
                    timeout = timeout - 100
                end
                SetVehicleHasBeenOwnedByPlayer(veh, true)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleIsStolen(veh, false)
                SetVehicleIsWanted(veh, false)
                SetVehRadioStation(veh, 'OFF')
                SetNetworkIdCanMigrate(netId, true)
                SetVehicleNumberPlateText(veh, vehPlate)
                SetEntityHeading(veh, vehHeading)
    
                while (NetworkGetEntityOwner(veh) ~= NetworkPlayerIdToInt()) do
                    Wait(500)
                end

                QBCore.Functions.SetVehicleProperties(veh, vehProps)
                TriggerServerEvent('Ogi-NoDespawn:Server:AddVehicleNoDespawn', vehPlate, vehProps, vehCoords, vehModel, netId, vehHeading)
            end
        end, vehModel, vehCoords, false)
    end)
end)
