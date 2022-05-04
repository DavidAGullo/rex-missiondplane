RegisterServerEvent('rex-dropoff')
AddEventHandler('rex-dropoff', function()
	Player.Functions.AddItem("Drug Bag", 1, false)
end)