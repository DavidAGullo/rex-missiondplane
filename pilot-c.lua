local show, JobStarted = false, false, {}

local bliplocation = vector3(-1650.99, -2757.1, 13.94)
local blip = AddBlipForCoord(bliplocation.x, bliplocation.y, bliplocation.z)

SetBlipSprite(blip, 251)
SetBlipDisplay(blip, 3)
SetBlipScale(blip, 0.9) 
SetBlipColour(blip, 66)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Drug Delivery")
EndTextCommandSetBlipName(blip)




function NewBlip()

    local objectif = math.randomchoice(Config.pos)
    local ped = GetPlayerPed(-1)

    local blip = AddBlipForCoord(objectif.x, objectif.y, objectif.z)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 2)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 2)

    local coords  = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(coords, objectif.x, objectif.y, objectif.z, true)

    while true do 
		Citizen.Wait(0)
        coords  = GetEntityCoords(ped)
        distance = GetDistanceBetweenCoords(coords, objectif.x, objectif.y, objectif.z, true)
		AddTextEntry("press_collect_drugs2", 'Press E or L1 to deliver the drugs.')
		--AddTextEntry("press_collect_trash2", 'Натисни ~INPUT_CONTEXT~ за да си натовариш боклука!')
		DrawMarker(1, objectif.x, objectif.y, objectif.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
            if distance <= 5 then
			DisplayHelpTextThisFrame("press_collect_drugs2")
			if IsControlJustPressed(1, 38) then
                RemoveBlip(blip)
                NotifChoise()
                break
            end
        end
	end
        if IsControlJustPressed(1, 73) then
            RemoveBlip(blip)
				drawnotifcolor ("Bring back the plane! Drug run over.", 25)
				--drawnotifcolor ("Върни камиона и си вземи точките.", 25)
            StopService()
        end
    end

function NotifChoise()

    drawnotifcolor ("Press ~g~E~w~ or L1 for more drug deliveries.\n~r~X~w~ to get out the game!", 140)
	--drawnotifcolor ("Натисни ~g~E~w~ за нова локация.\n~r~X~w~ за да си спреш!", 140)

    local timer = 1500
	while timer >= 1 do
		Citizen.Wait(10)
		timer = timer - 1

		if IsControlJustPressed(1, 38) then
            NewChoise()
			break
        end

		if IsControlJustPressed(1, 73) then
            drawnotifcolor ("Fine then! Bring back the plane!", 25)
			--drawnotifcolor ("Върни камиона и си вземи точките.", 25)
            StopService()

			break
        end

        if timer == 1 then
            drawnotifcolor ("They left the drop area! Bring back the drugs, dumbass.", 25)
			--drawnotifcolor ("Върни камиона и си вземи точките.", 25)
            StopService()
            break
        end

	end
end

function NewChoise()

    local route = math.randomchoice(Config.pos)
    local ped = GetPlayerPed(-1)

    local blip = AddBlipForCoord(route.x, route.y, route.z)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 3)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 3)
    drawnotifcolor("New location is set, press \n~r~X~w~ to stop.", 140)
	--drawnotifcolor("Нова локация бе зададена \n~r~X~w~ за да си спрете смяната!", 140)
    local coords  = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(coords, route.x, route.y, route.z, true)

    while true do 
		Citizen.Wait(0)
		coords  = GetEntityCoords(ped)
        distance = GetDistanceBetweenCoords(coords, route.x, route.y, route.z, true)
		AddTextEntry("press_collect_drugs", 'Press E or L1 to collect the drugs!')
		--AddTextEntry("press_collect_trash", 'Натисни ~INPUT_CONTEXT~ за да си натовариш боклука!')
        if distance <= 60 then 
            drawnotifcolor ("You are getting close!", 140)
			--drawnotifcolor ("Наближавате дестинацията!", 140)
			DrawMarker(1, route.x, route.y, route.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
            if distance <= 5 then
			DisplayHelpTextThisFrame("press_collect_drugs")
			if IsControlJustPressed(1, 38) then
                RemoveBlip(blip)
                NewBlip()
                break
            end
        end
	end
        if IsControlJustPressed(1, 73) then
            RemoveBlip(blip)
            drawnotifcolor ("Bring back the plane or you don't get your cash, bro.", 140)
			--drawnotifcolor ("Върни камиона и си вземи точките.", 140)
			
            StopService()
            break
        end
    end
end

function StopService()

    local coordsEndService = vector3(1636.44, 3238.06, 42.02)
    local ped = GetPlayerPed(-1)
    AddTextEntry("press_ranger_ha420", 'Press E or L1 to return the plane and get your cash.')
	--AddTextEntry("press_ranger_rubble", 'Натисни ~INPUT_CONTEXT~ за да си прибереш камиона!')

    local blip = AddBlipForCoord(coordsEndService)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 1)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 1)

    while true do 
		Citizen.Wait(0)
		local coords  = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(coordsEndService, coords, true)
		DrawMarker(1, 1636.44, 3238.06, 42.02, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
        if distance <= 5 then
            DisplayHelpTextThisFrame("press_ranger_ha420")
            if IsControlPressed(1, 38) then
				local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				if GetEntityModel(vehicle) == GetHashKey("ha420") then
				DeleteEntity(vehicle)
				TriggerServerEvent('GiveReward')
				drawnotifcolor ("You were awarded with $12,900", 140)
				--drawnotifcolor ("Ти беше възнаграден с 100 EP.", 140)
				RemoveBlip(blip)
                JobStarted, show = false, false
				break
			else
                local vehicle = GetVehiclePedIsIn(playerPed, false)
				if GetEntityModel(vehicle) ~= GetHashKey("ha420") then
				drawnotifcolor ("Bring back our plane or you will get nothing, muhfukkah!", 140)
				--drawnotifcolor ("Върни ни камиона или няма да ти дадем точките!", 140)
				JobStarted, show = true, true
						break
					end
				end
			end
		end
	end
end

function StartJob()

    local ped = GetPlayerPed(-1)
    local vehicleName = 'ha420'

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local vehicle = CreateVehicle(vehicleName, -1650.99, -2757.1, 13.94, 323.08, true, false)
    SetPedIntoVehicle(ped, vehicle, -1)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetModelAsNoLongerNeeded(vehicleName)
    JobStarted = true

    NewChoise()

end


Citizen.CreateThread(function()

    AddTextEntry("press_start_job", "Press E or L1 to get into the drug air-trafficking game!")
    while true do 
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local coords  = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(vector3(-1650.69, -2756.1, 12.94), coords, true)
		DrawMarker(1, -1650.99, -2757.1, 13.94, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 1.5001, 0, 255, 0, 200, 0, 0, 0, 0)
        if distance <= 2 then
            DisplayHelpTextThisFrame("press_start_job")
            if IsControlPressed(1, 38) then
                StartJob()
			end
		end
	end
end)

function drawnotifcolor(text, color)
    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end


function math.randomchoice(d)
    local keys = {}
    for key, value in pairs(d) do
        keys[#keys+1] = key
    end
    index = keys[math.random(1, #keys)]
    return d[index]
end
