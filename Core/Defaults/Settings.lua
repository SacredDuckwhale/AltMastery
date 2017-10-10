  -- ----------------------------------------------------------------------------------------------------------------------
    -- -- This program is free software: you can redistribute it and/or modify
    -- -- it under the terms of the GNU General Public License as published by
    -- -- the Free Software Foundation, either version 3 of the License, or
    -- -- (at your option) any later version.
	
    -- -- This program is distributed in the hope that it will be useful,
    -- -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- -- GNU General Public License for more details.

    -- -- You should have received a copy of the GNU General Public License
    -- -- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- ----------------------------------------------------------------------------------------------------------------------

local addonName, AM = ...
if not AM then return end


--- Table containing the default task entries
local defaults = {
	-- TODO: Restructure this after the GUI is done
	display = {
		
		activeStyle = "Default",
		groupSize = 38,
		taskSize = 30,
		objectiveSize = 24,
		iconSize = 20,
		showCompleted = false,
		showDismissed = false,
		showFiltered = false,
		highlightExpandedElements = true,
		
		windowPadding = 5, -- Border between the outer window border and its content pane
		contentPadding = 2, -- Border between a content pane and its child widgets
	},
	
	groupSelector = {
		
		iconSize = 40,
		padding = 5,
		
	},
	
	debug = {
		isEnabled = false,
	}
	
}


--- Return the table containing default task entries
function GetDefaultSettings()
	return defaults
end


AM.Settings.GetDefaultSettings = GetDefaultSettings


return AM