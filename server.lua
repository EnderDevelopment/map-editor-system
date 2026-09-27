local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('mapEditor:checkAdmin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isAdmin = false

    for _, group in ipairs(Config.AdminGroups) do
        if xPlayer.getGroup() == group then
            isAdmin = true
            break
        end
    end

    cb(isAdmin)
end)

RegisterServerEvent('mapEditor:saveProp')
AddEventHandler('mapEditor:saveProp', function(propModel, x, y, z, rx, ry, rz)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isAdmin = false

    for _, group in ipairs(Config.AdminGroups) do
        if xPlayer.getGroup() == group then
            isAdmin = true
            break
        end
    end

    if isAdmin then
        MySQL.Async.execute('INSERT INTO ' .. Config.Database.TableName .. ' (prop_model, x, y, z, rx, ry, rz) VALUES (@prop_model, @x, @y, @z, @rx, @ry, @rz)', {
            ['@prop_model'] = propModel,
            ['@x'] = x,
            ['@y'] = y,
            ['@z'] = z,
            ['@rx'] = rx,
            ['@ry'] = ry,
            ['@rz'] = rz
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', source, 'Prop placed successfully!')
            else
                TriggerClientEvent('esx:showNotification', source, 'Failed to place prop!')
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to place props!')
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    MySQL.Async.fetchAll('SELECT * FROM ' .. Config.Database.TableName, {}, function(props)
        TriggerClientEvent('mapEditor:loadProps', -1, props)
    end)
end)