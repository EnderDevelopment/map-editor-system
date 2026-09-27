local ESX = nil
local isEditing = false
local currentProp = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        if isEditing then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local forward = GetEntityForwardVector(playerPed)
            local spawnCoords = vector3(coords.x + forward.x * 2.0, coords.y + forward.y * 2.0, coords.z)

            if currentProp == nil then
                currentProp = CreateObject(GetHashKey(Config.DefaultProp), spawnCoords.x, spawnCoords.y, spawnCoords.z, true, false, true)
                SetEntityCollision(currentProp, false, false)
                FreezeEntityPosition(currentProp, true)
            else
                SetEntityCoords(currentProp, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false, true)
            end

            if IsControlJustPressed(0, 38) then -- E key
                PlaceProp()
            elseif IsControlJustPressed(0, 44) then -- Q key
                CancelPlacement()
            end
        end
    end
end)

function PlaceProp()
    if currentProp then
        local coords = GetEntityCoords(currentProp)
        local rotation = GetEntityRotation(currentProp)
        local propModel = GetEntityModel(currentProp)

        DeleteEntity(currentProp)
        currentProp = nil
        isEditing = false

        TriggerServerEvent('mapEditor:saveProp', propModel, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z)
    end
end

function CancelPlacement()
    if currentProp then
        DeleteEntity(currentProp)
        currentProp = nil
        isEditing = false
    end
end

RegisterNetEvent('mapEditor:startEditing')
AddEventHandler('mapEditor:startEditing', function()
    isEditing = true
end)

RegisterNetEvent('mapEditor:loadProps')
AddEventHandler('mapEditor:loadProps', function(props)
    for _, prop in ipairs(props) do
        local spawnedProp = CreateObject(GetHashKey(prop.prop_model), prop.x, prop.y, prop.z, false, false, true)
        SetEntityRotation(spawnedProp, prop.rx, prop.ry, prop.rz, 2, true)
        FreezeEntityPosition(spawnedProp, true)
    end
end)