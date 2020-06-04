ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('yordi:shotFire')
AddEventHandler('yordi:shotFire', function()
	local xPlayers = ESX.GetPlayers()
	
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('yordi:clientshotFire', xPlayers[i])
			TriggerClientEvent('yordi:shotfireNotify', xPlayers[i])
		end
	end

end)

RegisterServerEvent('yordi:vehicleStolen')
AddEventHandler('yordi:vehicleStolen', function()
	local xPlayers = ESX.GetPlayers()
	
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('yordi:clientvehicleStolen', xPlayers[i])
			TriggerClientEvent('yordi:vehiclestolenNotify', xPlayers[i])
		end
	end

end)

RegisterServerEvent('yordi:policeDeath')
AddEventHandler('yordi:policeDeath', function()
	local xPlayers = ESX.GetPlayers()
		
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('yordi:clientpoliceDeath', xPlayers[i])
			TriggerClientEvent('yordi:policedeathNotify', xPlayers[i])
		end
	end

end)