-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

author "Andyyy#7666"
description "Doorlocks for ND Framework"
version "3.1.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

client_scripts {
    "config.lua",
    "source/client.lua"
}
server_script "source/server.lua"

exports {
    "doorAdd",
    "nearbyDoorLock",
    "nearbyDoorUnlock",
    "doorsResetDefault",
    "updateRegisteredDoors",
    "getRegisteredDoors"
}

dependency "ND_Core"
