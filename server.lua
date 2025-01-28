local QBCore = exports['qb-core']:GetCoreObject()
local vehicles = {}

local function isVehiclePresent(plate)
    local vehicles = GetAllVehicles()
    for _, vehicle in pairs(vehicles) do
        local pl = GetVehicleNumberPlateText(vehicle)
        if pl == plate then
            return true
        end
    end
    return false
end


RegisterServerEvent('Ogi-NoDespawn:Server:AddVehicleNoDespawn', function(plate, properties, coords, model, vehicleNetId, heading)
    if plate == nil or properties == nil then return end
    vehicles[plate] = {properties = properties, coords = coords, model = model, vehicle = vehicle, netid = vehicleNetId, heading = heading}
end)

RegisterServerEvent('Ogi-NoDespawn:Server:RemoveVehicleNoDespawn', function(plate)
    if vehicles[plate] then
        vehicles[plate] = nil
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.RespawnCheckInterval * 60 * 1000) -- waiting interval
        local players = QBCore.Functions.GetPlayers()
        for vehPlate, v in pairs(vehicles) do
            local veh = NetworkGetEntityFromNetworkId(v.netid)
            if not veh or not isVehiclePresent(vehPlate) then
                local vehCoords = v.coords
                for _, player in pairs(players) do
                    local playerPed = GetPlayerPed(player)
                    local playerCoords = GetEntityCoords(playerPed)
                    local dist = #(playerCoords - vector3(vehCoords.x, vehCoords.y, vehCoords.z))
                    if dist < Config.PlayerDistanceForDespawn then
                        local vehModel = v.model
                        local vehProps = v.properties
                        local vehHeading = v.heading
                        TriggerClientEvent('Ogi-NoDespawn:Client:UpdateDespawnedVehicle', player, vehProps, vehModel, vehPlate, vehCoords, vehHeading)
                        vehicles[vehPlate] = nil
                        Wait(1000) -- this is mandatory to avoid the vehicles being respawned with wrong properties
                        break
                    end
                end
            end
        end
    end
end)