-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

local NDCore = exports["ND_Core"]:GetCoreObject()
NDCore.Functions.VersionChecker("ND_Doorlocks", GetCurrentResourceName(), "https://github.com/Andyyy7666/ND_Framework", "https://raw.githubusercontent.com/Andyyy7666/ND_Framework/main/ND_Doorlocks/fxmanifest.lua")

local syncedDoors = {}

RegisterNetEvent("ND_Doorlocks:setState", function(doorID, state)
    syncedDoors[doorID] = state
    TriggerClientEvent("ND_Doorlocks:syncDoor", -1, doorID, state)
end)

RegisterNetEvent("ND_Doorlocks:getDoors", function()
    local player = source
    TriggerClientEvent("ND_Doorlocks:returnDoors", player, syncedDoors)
end)