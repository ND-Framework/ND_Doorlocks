-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

local NDCore = exports["ND_Core"]:GetCoreObject()
local updatedDoors = {}
local job
local hasAccess = false
local ped
local pedCoords
local doorNear
local syncedDoors = {}

local character = NDCore.Functions.GetSelectedCharacter()
if character then job = character.job end

function drawText3D(coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z + 0.5)
    if onScreen then
        SetTextScale(0.4, 0.4)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextEntry("STRING")
        SetTextCentre(true)
        SetTextColour(255, 255, 255, 255)
        SetTextOutline()
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

function doorGetText(locked)
    if locked == 1 and hasAccess then
        return "Locked [E]"
    elseif locked == 0 and hasAccess then
        return "Unlocked [E]"
    elseif locked == 1 and not hasAccess then
        return "🔒"
    end
    return ""
end

function doorAuthorized(door)
    if door.hasAccess then return true end
    if door.authorizedJobs then
        for _, authorizedJob in pairs(door.authorizedJobs) do
            if job == authorizedJob then
                return true
            end
        end
    end
    return false
end

function doorCreate(door)
    AddDoorToSystem(door.hash, door.model, door.coords.x, door.coords.y, door.coords.z, false, false, false)
    DoorSystemSetDoorState(door.hash, 4, false, false)
    DoorSystemSetDoorState(door.hash, door.state, false, false)
    if door.rate then
        DoorSystemSetAutomaticRate(door.hash, door.rate, false, false)
    end
end

function doorChangeState(state)
    if state == 0 then
        return 1
    end
    return 0
end

function nearbyDoorUnlock()
    if not doorNear then return end
    local doorInfo = updatedDoors[doorNear]
    if not doorInfo then return end
    doorInfo.state = 0
    TriggerServerEvent("ND_Doorlocks:setState", doorNear, doorInfo.state)
end

function nearbyDoorLock()
    if not doorNear then return end
    local doorInfo = updatedDoors[doorNear]
    if not doorInfo then return end
    doorInfo.state = 1
    TriggerServerEvent("ND_Doorlocks:setState", doorNear, doorInfo.state)
end

function doorsResetDefault()
    updatedDoors = {}
    for id, door in pairs(doorList) do
        updatedDoors[id] = door
    end
end

function doorAdd(doorInfo)
    local id = #updatedDoors + 1
    if syncedDoors[id] then
        doorInfo.state = syncedDoors[id]
    end
    updatedDoors[id] = doorInfo
    for _, door in pairs(doorInfo.doors) do
        door.state = doorInfo.state
        if doorInfo.rate then
            door.rate = doorInfo.rate
        end
        doorCreate(door)
    end
end

function updateRegisteredDoors(newDoors)
    doorsResetDefault()
    updatedDoors = newDoors
    for _, doorInfo in pairs(updatedDoors) do
        for _, door in pairs(doorInfo.doors) do
            door.state = doorInfo.state
            if doorInfo.rate then
                door.rate = doorInfo.rate
            end
            doorCreate(door)
        end
    end
end

function getRegisteredDoors()
    return updatedDoors
end

RegisterNetEvent("ND:setCharacter", function(character)
    doorsResetDefault()
    job = character.job
    TriggerServerEvent("ND_Doorlocks:getDoors")
end)

RegisterNetEvent("ND_Doorlocks:syncDoor", function(id, state)
    syncedDoors[id] = state
    local doorInfo = updatedDoors[id]
    if not doorInfo then return end
    doorInfo.state = state
    for _, door in pairs(doorInfo.doors) do
        DoorSystemSetDoorState(door.hash, doorInfo.state, false, false)
    end
end)

RegisterNetEvent("ND_Doorlocks:returnDoors", function(newSyncedDoors)
    syncedDoors = newSyncedDoors
    for id, state in pairs(syncedDoors) do
        local doorInfo = updatedDoors[id]
        if doorInfo then
            doorInfo.state = state
            for _, door in pairs(doorInfo.doors) do
                DoorSystemSetDoorState(door.hash, doorInfo.state, false, false)
            end
        end
    end
end)

CreateThread(function()
    while true do
        ped = PlayerPedId()
        pedCoords = GetEntityCoords(ped)
        Wait(500)
    end
end)

CreateThread(function()
    doorsResetDefault()
    for _, doorInfo in pairs(updatedDoors) do
        for _, door in pairs(doorInfo.doors) do
            door.state = doorInfo.state
            if doorInfo.rate then
                door.rate = doorInfo.rate
            end
            doorCreate(door)
        end
    end
end)

CreateThread(function()
    while true do
        for id, doorInfo in pairs(updatedDoors) do
            if #(pedCoords - doorInfo.textCoords) < doorInfo.accessDistance then
                doorNear = id
                hasAccess = doorAuthorized(doorInfo)
                drawText3D(doorInfo.textCoords, doorGetText(doorInfo.state))
                if hasAccess and IsControlJustPressed(0, 51) then
                    doorInfo.state = doorChangeState(doorInfo.state)
                    TriggerServerEvent("ND_Doorlocks:setState", id, doorInfo.state)
                end
            end
        end
        Wait(0)
    end
end)
