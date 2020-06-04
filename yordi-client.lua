local yordiChance = math.random(1, 10)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)

        local yPed = GetPlayerPed(-1)

        if IsPedShooting(GetPlayerPed(-1)) then
            if yordiChance > 3 then
                Citizen.Wait(1000)
                TriggerServerEvent('yordi:shotFire', source)
            end
        end
    
        if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) and Config.yordivehicleStolen then
            if yordiChance > 2 then
                Citizen.Wait(1000)
                TriggerServerEvent('yordi:vehicleStolen', source)
            end
        end
        
    end
end)

RegisterCommand("10-13", function()
	if PlayerData.job and PlayerData.job.name == 'police' then
		TriggerServerEvent('yordi:policeDeath', source)
	end
end)

function yordiNotify(type, title, text)
	SendNUIMessage({
        type = type,
        title = title,
		text = text
	})
end

RegisterNetEvent('yordi:shotfireNotify')
AddEventHandler('yordi:shotfireNotify', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local yordilocationPed = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local yordilocationPed2 = GetStreetNameFromHashKey(yordilocationPed)
    yordiNotify('yordi', 'Silah Atış İhbarı', yordilocationPed2)
    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
end)

RegisterNetEvent('yordi:vehiclestolenNotify')
AddEventHandler('yordi:vehiclestolenNotify', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local yordilocationPed = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local yordilocationPed2 = GetStreetNameFromHashKey(yordilocationPed)
    yordiNotify('yordi', 'Araç Çalma Girişimi', yordilocationPed2)
    PlaySoundFrontend(-1, "YES", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
end)

RegisterNetEvent('yordi:policedeathNotify')
AddEventHandler('yordi:policedeathNotify', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local yordilocationPed = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local yordilocationPed2 = GetStreetNameFromHashKey(yordilocationPed)
    yordiNotify('yordi', 'Polis Düştü (10-13)', yordilocationPed2)
    PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 0)
end)

RegisterNetEvent('yordi:clientpoliceDeath')
AddEventHandler('yordi:clientpoliceDeath', function()
    yordipoliceDeath()
end)

RegisterNetEvent('yordi:clientshotFire')
AddEventHandler('yordi:clientshotFire', function()
    yordishotFire()
end)

RegisterNetEvent('yordi:clientvehicleStolen')
AddEventHandler('yordi:clientvehicleStolen', function()
    yordivehicleStolen()
end)

function yordishotFire()
    if Config.yordishotFire then
        local ped = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(ped)
        local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    
        SetBlipSprite(blip, 119)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 2.25)
        SetBlipColour(blip, 79)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('* Shotfire Bölgesi')
        EndTextCommandSetBlipName(blip)
        
        Citizen.Wait(60000)
    
        RemoveBlip(blip)
    end
end

function yordivehicleStolen()
    if Config.yordivehicleStolen then
        local ped = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(ped)
        local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    
        SetBlipSprite(blip, 225)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 2.75)
        SetBlipColour(blip, 79)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('* Araç Çalma Bölgesi')
        EndTextCommandSetBlipName(blip)
        
        Citizen.Wait(60000)
    
        RemoveBlip(blip)
    end
end

function yordipoliceDeath()
    if Config.yordipoliceDeath then
        local ped = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(ped)
        local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    
        SetBlipSprite(blip, 489)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 2.75)
        SetBlipColour(blip, 80)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('* 10-13 Bölgesi')
        EndTextCommandSetBlipName(blip)
        
        Citizen.Wait(60000)
    
        RemoveBlip(blip)
    end
end