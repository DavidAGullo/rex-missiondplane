local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for locationIndex = 1, #Config.DrugDropoff do
        Citizen.Wait(10)
        local locationPos = Config.DrugDropoff[locationIndex]
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local dist = pedCoords - locationPos
        local blip = AddBlipForCoord(locationPos)

        SetBlipSprite (blip, 765)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 24)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Drop-off")
        EndTextCommandSetBlipName(blip)
    end
)
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local sleepThread = 500

        for locationIndex = 1, #Config.DrugDropoff do
            local locationPos = Config.DrugDropoff[locationIndex]
            local dstCheck = pedCoords - locationPos

            if dstCheck.x >= 50.0 and dstCheck.y >= 50.0 and dstCheck.z >= 50.0 then
                sleepThread = 100000 -- This is so it doesn't check unless its within a radius
            elseif dstCheck.x >= 15.0 and dstCheck.y >= 15.0 and dstCheck.z >= 15.0 then
                sleepThread = 1000
            elseif dstCheck.x <= 5.0 and dstCheck.y <= 5.0 and dstCheck.z <= 5.0 then
                CreateDuffle()
                sleepThread = 5
                if dstCheck.x <= 1.5 and dstCheck.y <= 1.5 and dstCheck.z <= 1.0 then
                    if IsControlJustReleased(0, 54) then
                        TriggerServerEvent("rex-dropoff") 
                    end
                end     
                QBCore.Functions.DrawText3D(locationPos.x, locationPos.y, locationPos.z + 1.0, '[~g~E~s~] to Pick Up Drug Bag')
            end
        end
        Citizen.Wait(sleepThread)
    end
)

function CreateDuffle()
    if isDropped then
        --Nothing
    else
        CreateObject(GetHash(Config.DuffleBag) , locationPos.x , locationPos.y, locationPos.z - 1.0, false, false, false)
    end