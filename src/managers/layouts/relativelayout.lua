local bl = require("managers.layouts.baselayout")

-- Places child widgets at the given relative position.
-- Default anchor is "topleft".
-- local relativelayout = {}

-- Defines specific constants.
local ANCHOR = { TopLeft = 1, TopRight = 2, BottomLeft = 3, BottomRight = 4, Center = 5 }

-- Defines the relative layout object.
local RelativeLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object, relativex?: number, relativey?: number, anchor?[TopLeft, TopRigt, BottomLeft, BottomRight, Center]: number) -> none
function RelativeLayout:add(widget, relativex, relativey, anchor)
  if not bl.isvalidchild(widget) then return end

  -- validates anchor parameter and sets default value
  if anchor == nil then anchor = ANCHOR.TopLeft end
  if type(anchor) ~= "number" then anchor = ANCHOR.TopLeft end
  if anchor > 5 then anchor = ANCHOR.TopLeft end

  local newWidget = {}
  newWidget.widget = widget
  newWidget.width = widget.width
  newWidget.height = widget.height
  newWidget.anchor = anchor
  newWidget.relativex = relativex or 0
  newWidget.relativey = relativey or 0
  newWidget.positionx = self.parentwidth * newWidget.relativex
  newWidget.positiony = self.parentheight * newWidget.relativey

  -- overwrites current values if anchor is "topright"
  if newWidget.anchor == ANCHOR.TopRight then
    newWidget.positionx = (self.parent.width * newWidget.relativex) - newWidget.width
  end

  -- overwrites current values if anchor is "bottomleft"
  if newWidget.anchor == ANCHOR.BottomLeft then
    newWidget.positiony = (self.parent.height * newWidget.relativey) - newWidget.height
  end

  -- overwrites current values if anchor is "bottomright"
  if newWidget.anchor == ANCHOR.BottomRight then
    newWidget.positionx = (self.parent.width * newWidget.relativex) - newWidget.width
    newWidget.positiony = (self.parent.height * newWidget.relativey) - newWidget.height
  end

  -- overwrites current values if anchor is "center"
  if newWidget.anchor == ANCHOR.Center then
    newWidget.positionx = (self.parent.width * newWidget.relativex) - (newWidget.width * 0.5)
    newWidget.positiony = (self.parent.height * newWidget.relativey) - (newWidget.height * 0.5)
  end

  table.insert(self.children, newWidget)
end

-- Updates the child widget.
-- update() -> none
function RelativeLayout:update()
  local widthDifference, heightDifference = 0, 0

  widthDifference = self.parent.width - self.parentwidth
  heightDifference = self.parent.height - self.parentheight

  for _, child in pairs(self.children) do
    child.widget.x = child.positionx + (widthDifference * child.relativex)
    child.widget.y = child.positiony + (heightDifference * child.relativey)
  end
end

-- Creates the relative layout constructor.
function RelativeLayout:constructor(parent)
  if not bl.isvalidparent(parent) then return end

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
end

return RelativeLayout
