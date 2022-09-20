-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

doorList = {
    { -- Mission Row Police Station front doors.
        state = 0,
        rate = 2.0,
        accessDistance = 1.5,
        textCoords = vector3(434.7345, -981.9468, 30.7102),
        doors = {
            {hash = -383826246, model = -1215222675, coords = vector3(434.75, -980.62, 30.84)},
            {hash = -1333201680, model = 320433149, coords = vector3(434.75, -983.22, 30.84)}
        },
        authorizedJobs = {"SAHP", "LSPD", "BCSO"}
    },
    { -- Mission Row Police Station weapon locker door.
        state = 1,
        accessDistance = 1.0,
        textCoords = vector3(453.14, -982.52, 30.69),
        doors = {
            {hash = -591568775, model = 749848321, coords = vector3(453.08, -983.19, 30.84)}
        },
        authorizedJobs = {"SAHP", "LSPD", "BCSO"}
    },
    { -- Sandy Shores Sherrif front door.
        state = 0,
        accessDistance = 1.5,
        textCoords = vector3(1855.09, 3683.55, 34.27),
        doors = {
            {hash = -1564447255, model = -1765048490, coords = vector3(1855.68, 3683.93, 34.59)}
        },
        authorizedJobs = {"SAHP", "LSPD", "BCSO"}
    },
    { -- Paleto bay sheriff front doors.
        state = 0,
        rate = 2.0,
        accessDistance = 1.5,
        textCoords = vector3(-443.55, 6016.18, 31.72),
        doors = {
            {hash = -682357686, model = -1501157055, coords = vector3(-444.50, 6017.06, 31.87)},
            {hash = -2065247820, model = -1501157055, coords = vector3(-442.66, 6015.22, 31.87)}
        },
        authorizedJobs = {"SAHP", "LSPD", "BCSO"}
    },
}