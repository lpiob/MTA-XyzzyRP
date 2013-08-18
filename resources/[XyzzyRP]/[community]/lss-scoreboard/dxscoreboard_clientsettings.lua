settings = {
	["useanimation"] = false,
	["toggleable"] = true,
	["showserverinfo"] = true,
	["showgamemodeinfo"] = false,
	["showteams"] = true,
	["usecolors"] = true,
	["drawspeed"] = 3.5,
	["scale"] = 1.0,
	["columnfont"] = "default",
	["contentfont"] = "default-bold",
	["teamfont"] = "default-bold",
	["serverinfofont"] = "clear",
	["bg_color"] = {
		["r"] = 0,
		["g"] = 0,
		["b"] = 0,
		["a"] = 220
	},
	["selection_color"] = {
		["r"] = 82,
		["g"] = 103,
		["b"] = 188,
		["a"] = 170
	},
	["highlight_color"] = {
		["r"] = 255,
		["g"] = 255,
		["b"] = 255,
		["a"] = 50
	},
	["header_color"] = {
		["r"] = 100,
		["g"] = 100,
		["b"] = 100,
		["a"] = 255
	},
	["team_color"] = {
		["r"] = 100,
		["g"] = 100,
		["b"] = 100,
		["a"] = 100
	},
	["border_color"] = {
		["r"] = 100,
		["g"] = 100,
		["b"] = 100,
		["a"] = 55
	},
	["serverinfo_color"] = {
		["r"] = 250,
		["g"] = 250,
		["b"] = 250,
		["a"] = 255
	},
	["content_color"] = {
		["r"] = 255,
		["g"] = 255,
		["b"] = 255,
		["a"] = 255
	}
}
defaultSettings = {
	["useanimation"] = false,
	["toggleable"] = true,
	["showserverinfo"] = true,
	["showgamemodeinfo"] = false,
	["showteams"] = true,
	["usecolors"] = true,
	["drawspeed"] = 1.5,
	["scale"] = 1.5,
	["columnfont"] = "default-bold",
	["contentfont"] = "default-bold",
	["teamfont"] = "clear",
	["serverinfofont"] = "default",
	["bg_color"] = {
		["r"] = 0,
		["g"] = 0,
		["b"] = 0,
		["a"] = 170
	},
	["selection_color"] = {
		["r"] = 82,
		["g"] = 103,
		["b"] = 188,
		["a"] = 170
	},
	["highlight_color"] = {
		["r"] = 255,
		["g"] = 255,
		["b"] = 255,
		["a"] = 50
	},
	["header_color"] = {
		["r"] = 100,
		["g"] = 100,
		["b"] = 100,
		["a"] = 255
	},
	["team_color"] = {
		["r"] = 100,
		["g"] = 100,
		["b"] = 100,
		["a"] = 100
	},
	["border_color"] = {
		["r"] = 100,
		["g"] = 100,
		["b"] = 100,
		["a"] = 50
	},
	["serverinfo_color"] = {
		["r"] = 150,
		["g"] = 150,
		["b"] = 150,
		["a"] = 255
	},
	["content_color"] = {
		["r"] = 255,
		["g"] = 255,
		["b"] = 255,
		["a"] = 255
	}
}

tempColors = {
	["bg_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["selection_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["highlight_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["header_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["team_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["border_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["serverinfo_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	},
	["content_color"] = {
		["r"] = nil,
		["g"] = nil,
		["b"] = nil,
		["a"] = nil
	}
}
MAX_DRAWSPEED = 4.0
MIN_DRAWSPEED = 0.5
MAX_SCALE = 2.5
MIN_SCALE = 0.5
fontIndexes = {
	["column"] = 1,
	["content"] = 1,
	["team"] = 1,
	["serverinfo"] = 1
}
fontNames = { "default", "default-bold", "clear", "arial", "sans","pricedown", "bankgothic", "diploma", "beckett" }

function readScoreboardSettings()
	useAnimation = settings.useanimation
	scoreboardIsToggleable = settings.toggleable
	showServerInfo = settings.showserverinfo
	showGamemodeInfo = settings.showgamemodeinfo
	showTeams = settings.showteams
	useColors = settings.usecolors
	drawSpeed = settings.drawspeed
	scoreboardScale = settings.scale
	columnFont = settings.columnfont
	contentFont = settings.contentfont
	teamHeaderFont = settings.teamfont
	serverInfoFont = settings.serverinfofont
	cScoreboardBackground = tocolor( settings.bg_color.r, settings.bg_color.g, settings.bg_color.b, settings.bg_color.a )
	cSelection = tocolor( settings.selection_color.r, settings.selection_color.g, settings.selection_color.b, settings.selection_color.a )
	cHighlight = tocolor( settings.highlight_color.r, settings.highlight_color.g, settings.highlight_color.b, settings.highlight_color.a )
	cHeader = tocolor( settings.header_color.r, settings.header_color.g, settings.header_color.b, settings.header_color.a )
	cTeam = tocolor( settings.team_color.r, settings.team_color.g, settings.team_color.b, settings.team_color.a )
	cBorder = tocolor( settings.border_color.r, settings.border_color.g, settings.border_color.b, settings.border_color.a )
	cServerInfo = tocolor( settings.serverinfo_color.r, settings.serverinfo_color.g, settings.serverinfo_color.b, settings.serverinfo_color.a )
	cContent = tocolor( settings.content_color.r, settings.content_color.g, settings.content_color.b, settings.content_color.a )
end

function restoreDefaultSettings()
	saveSettings( defaultSettings )
end

function saveSettings( settingsTable )

end

function validateRange( number )
	if type( number ) == "number" then
		local isValid = number >= 0 and number <= 255
		if isValid then
			return number
		end
	end
	return false
end
