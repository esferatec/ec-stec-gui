local bl = require("managers.layouts.baselayout")

-- Arranges child widgets into a single column.
-- Default direction is "top" and default alignment is "left".
-- local columnlayout = {}

-- Defines specific constants.
local DIRECTION = { Top = 1, Bottom = 2 }
local ALIGNMENT = { Left = 1, Right = 2, Center = 3, Stretch = 4 }

-- Defines the column layout object.
local ColumnLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object, alignment?[Left, Right, Center, Strecht]: number) -> none
function ColumnLayout:add(widget, alignment)
  if not bl.isvalidchild(widget) then return end

  -- validates alignment parameter and sets default value
  if alignment == nil then alignment = ALIGNMENT.Left end
  if type(alignment) ~= "number" then alignment = ALIGNMENT.Left end
  if alignment > 4 then alignment = ALIGNMENT.Left end

  local newWidget = {}
  newWidget.widget = widget
  newWidget.width = (widget.width > self.width) and self.width or widget.width
  newWidget.height = widget.height
  newWidget.positionx = self.nextx
  newWidget.positiony = self.nexty
  newWidget.alignment = alignment

  -- overwrites current values if direction is "bottom"
  if self.direction == DIRECTION.Bottom then
    newWidget.positiony = self.nexty - newWidget.height
  end

  -- overwrites current values if alignemt is "right"
  if newWidget.alignment == ALIGNMENT.Right then
    newWidget.positionx = self.nextx + self.width - newWidget.width
  end

  -- overwrites current values if alignemt is "center"
  if newWidget.alignment == ALIGNMENT.Center then
    newWidget.positionx = self.nextx + (self.width * 0.5) - (newWidget.width * 0.5)
  end

  -- overwrites current values if alignemt is "stretch"
  if newWidget.alignment == ALIGNMENT.Stretch then
    newWidget.width = self.width
  end

  -- sets current values for the next widget
  if self.direction == DIRECTION.Bottom then
    self.nexty = self.nexty - newWidget.height - self.gap
  else
    self.nexty = self.nexty + newWidget.height + self.gap
  end

  table.insert(self.children, newWidget)
end

-- Updates all child widgets.
-- update() -> none
function ColumnLayout:update()
  local heightDifference = 0

  -- overwrites default values if direction is "bottom"
  if self.direction == DIRECTION.Bottom then
    heightDifference = self.parent.height - self.parentheight
  end

  for _, child in pairs(self.children) do
    child.widget.x = child.positionx
    child.widget.y = child.positiony + heightDifference
  end
end

-- Creates the column layout constructor.
function ColumnLayout:constructor(parent, direction, gap, positionx, positiony, width, heigth)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  -- validates parameter values and sets default values
  if direction == nil then direction = DIRECTION.Top end
  if direction > 2 then direction = DIRECTION.Top end

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
  self.direction = direction
  self.gap = gap or 0
  self.positionx = positionx or 0
  self.positiony = positiony or 0
  self.width = width or (self.parentwidth - self.positionx)
  self.height = heigth or (self.parentheight - self.positiony)
  self.startx = self.positionx
  self.starty = self.positiony
  self.endx = self.width
  self.endy = self.height
  self.nextx = self.startx
  self.nexty = self.starty

  -- overwrites default values if direction is "bottom"
  if self.direction == DIRECTION.Bottom then
    self.nexty = self.endy
  end
end

return ColumnLayout
