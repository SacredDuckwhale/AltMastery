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


--- TrackerWindow.lua
-- The main display
-- @section TrackerWindow.lua


--- Show main window for the Tracker
-- @param self ...
local function Show(self)

	-- TODO: Release children back into the widget pool ? Not doing this here because most children are fairly static and should not have to be re-aquired when showing the main display. Instead, the TrackerContent container should release its children, which are the dynamically created Groups and Tasks (that are the main reason for using AceGUI's frame pool in the first place)

	local AceGUI = LibStub("AceGUI-3.0")
	assert(AceGUI, "AceGUI not found")
	
	if not self.frame then -- First call -> Create new instance via AceGUI and configure it
	
		self.frame = AceGUI:Create("AMWindow")
		self.frame:SetLayout("AMRows")
		
		-- Add logo image (TODO: Not very interactive yet)
		local logoSpecs = {
			
			type = "Logo",
			parent = self.frame.frame,
			size = { 132, 60 }
			
		}
		local InteractiveLogo = AM.GUI:BuildFrame(logoSpecs)
		InteractiveLogo:SetPoint("TOPLEFT", self.frame.frame, "TOPLEFT", 0, 60)
		
		-- Retrieve style for the content panes
		local activeStyle = AM.GUI:GetActiveStyle()
		local contentPaneStyle = activeStyle.frameColours.ContentPane
	
		-- Add left content pane
		local LeftPane = AceGUI:Create("SimpleGroup")
		LeftPane:SetRelativeWidth(0.7)
		LeftPane:SetLayout("List")
		local leftPaneBorder = LeftPane.content:GetParent()
		AM.GUI:SetFrameColour(leftPaneBorder, contentPaneStyle)
		LeftPane:SetFullHeight(true) -- TODO: Pointless?
		self.frame:AddChild(LeftPane)
		
		-- -- Add right (spacer) pane
		local RightPane = AceGUI:Create("SimpleGroup")
		RightPane:SetRelativeWidth(0.31)
		local rightPaneBorder = RightPane.content:GetParent()
		self.frame:AddChild(RightPane)
		--RightPane:SetFullHeight(true) TODO???
		
		-- Add container for the group selection icons
		local GroupSelectionPane = AceGUI:Create("InlineGroup") -- TODO: Use same type as content panes?
		border = GroupSelectionPane.content:GetParent()
		
		local titletext = GroupSelectionPane.titletext
		titletext:SetPoint("TOPLEFT", 10, 0)
		titletext:SetPoint("TOPRIGHT", -10, 0)
		titletext:SetJustifyH("CENTER")
		titletext:SetHeight(24)
		--titletext:Hide() -- TODO: Needs to be implemented properly so it fits with the visual style of the rest
	--	titletext:SetSize(activeStyle.fontSizes.normal)
		
		border:ClearAllPoints()
		local padding = AM.db.profile.settings.display.contentPadding
		border:SetPoint("TOPLEFT", padding, 0) -- TODO: What's with the offset? I think it's for the title, but why can't it just work normally?
		border:SetPoint("BOTTOMRIGHT", -padding, 36)
--		GroupSelectionPane:SetAutoAdjustHeight(false)
	
		AM.GUI:SetFrameColour(border, activeStyle.frameColours.GroupSelectionPane)
		local r, g, b = AM.Utils.HexToRGB(activeStyle.frameColours.GroupSelectionPane.border, 255)
		border:SetBackdropBorderColor(r, g, b, activeStyle.frameColours.GroupSelectionPane.borderAlpha) -- This should be updated dynamically (TODO)
--		GroupSelectionPane:SetTitle("GROUPS")
--		GroupSelectionPane:SetFullHeight(true)
		GroupSelectionPane:SetRelativeWidth(1)
		GroupSelectionPane:SetLayout("List")
		RightPane:AddChild(GroupSelectionPane)
		AM.GroupSelector.widget = GroupSelectionPane -- Save the newly-created widget so that it can be used by the GroupSelector API
		
		-- Add container for the tracked groups and tasks
		local TrackerPane = AceGUI:Create("InlineGroup") -- TODO: Use same type as content panes?
		border = TrackerPane.content:GetParent()
		
		border:ClearAllPoints()
		border:SetPoint("TOPLEFT", padding, -padding)
		border:SetPoint("BOTTOMRIGHT", -padding, 36)
	--	TrackerPane:SetAutoAdjustHeight(false)
	
		AM.GUI:SetFrameColour(border, activeStyle.frameColours.TrackerPane)
		local r, g, b = AM.Utils.HexToRGB(activeStyle.frameColours.TrackerPane.border, 255)
		border:SetBackdropBorderColor(r, g, b, activeStyle.frameColours.TrackerPane.borderAlpha) -- This should be updated dynamically (TODO)
	--	TrackerPane:SetTitle("Tasks")
	--	TrackerPane:SetFullHeight(true)
		TrackerPane:SetRelativeWidth(1)
		TrackerPane:SetLayout("List")
		LeftPane:AddChild(TrackerPane)
		
		-- Save the widget so that it can be used with the TrackerPane API
		AM.TrackerPane.widget = TrackerPane
		
	end
	-- TODO: Global GUI:Update() function
	AM.GroupSelector:Update()

	AM.TrackerPane:Update()
--	AM.TrackerPane:ReleaseWidgets() -- TODO: Combine this in Update() and call that instead?
	--AM.TrackerPane:UpdateGroups() -- Update tracker to display all Tasks and nested Groups for the currently active Group
	
	-- Show the frame
	self.frame:Show()

end

-- Reset the window to its original position (calls method on widget, which calls method on frame...)
local function Reset(self)

	self.frame:Reset()

end

--- Show/hide the window (used for the "Show Tracker Window" keybind)
local function Toggle(self)

	if not (self.frame and self.frame:IsShown()) then
		self:Show()
	else
		self.frame:Hide()
		AM.TrackerPane:ReleaseWidgets()
		-- Also release the TaskPane's contents so they can be recycled (if any changes occur with the next startup)
	end

end


local TrackerWindow = {

	Show = Show,
	Reset = Reset,
	Toggle = Toggle,
	
}

AM.TrackerWindow = TrackerWindow

return AM
