  ----------------------------------------------------------------------------------------------------------------------
    -- This program is free software: you can redistribute it and/or modify
    -- it under the terms of the GNU General Public License as published by
    -- the Free Software Foundation, either version 3 of the License, or
    -- (at your option) any later version.

    -- This program is distributed in the hope that it will be useful,
    -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- GNU General Public License for more details.

    -- You should have received a copy of the GNU General Public License
    -- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------

local addonName, AM = ...
if not AM then return end


--- Returns a customised layout function (for use with AceGUI)
-- @param layout The name of the layout that is to be looked up
-- @return A reference to the layout function
local function GetLayout(layout)

	-- TODO: Not sure how far the default layouts will take us; this might be obsolete before everything is said and done
	-- TODO: Layouting needs to be interrupted (combat taint perhaps?) - Start/Pause/Resume? Need to look into this further
	
end


AM.GUI.GetLayout = GetLayout

return AM