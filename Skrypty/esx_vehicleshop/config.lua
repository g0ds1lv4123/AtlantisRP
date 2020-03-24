Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 211, g = 211, b = 211 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'pl'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 4
Config.PlateNumbers  = 4
Config.PlateUseSpace = false

Config.Zones = {

	ShopEntering = {
		Pos   = { x = -57.466, y = -1096.814, z = 25.442 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 27
	},

	ShopInside = {
		Pos     = { x = -47.570, y = -1097.221, z = 25.422 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = -20.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = -26.382, y = -1082.406, z = 25.565 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 71.138,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	ResellVehicle = {
		Pos   = { x = -43.060, y = -1082.359, z = 25.703 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 27
	}

}
