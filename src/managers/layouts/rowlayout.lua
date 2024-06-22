local bl = require("managers.layouts.baselayout")

-- Arranges child widgets into a single line row.
-- Default direction is "left" and default alignment is "top".
-- local rowlayout = {}

-- Defines specific constants
DIRECTION = { Left = 1, Right = 2 }
ALIGNMENT = { Top = 1, Bottom = 2, Center = 3, Stretch = 4 }

-- Defines the metatable.
local RowLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object, alignment?[Top. Bottom, Center, Strecht]: number) -> none
function RowLayout:add(widget, alignment)
  if not bl.isvalidchild(widget) then return end

  -- validates alignment parameter and sets default value
  if alignment == nil then alignment = ALIGNMENT.Top end
  if type(alignment) ~= "number" then alignment = ALIGNMENT.Top end
  if alignment > 4 then alignment = ALIGNMENT.Top end

  local newWidget = {}
  newWidget.widget = widget
  newWidget.width = widget.width
  newWidget.height = (widget.height > self.height) and self.height or widget.height
  newWidget.positionx = self.nextx
  newWidget.positiony = self.nexty
  newWidget.alignment = alignment

  -- overwrites current values if direction is "right"
  if self.direction == DIRECTION.Right then
    newWidget.positionx = self.nextx - newWidget.width
  end

  -- overwrites current values if alignemt is "bottom"
  if newWidget.alignment == ALIGNMENT.Bottom then
    newWidget.positiony = self.nexty + self.height - newWidget.height
  end

  -- overwrites current values if alignemt is "center"
  if newWidget.alignment == ALIGNMENT.Center then
    newWidget.positiony = self.nexty + (self.height * 0.5) - (newWidget.height * 0.5)
  end

  -- overwrites current values if alignemt is "stretch"
  if newWidget.alignment == ALIGNMENT.Stretch then
    newWidget.height = self.height
  end

  -- sets current values for the next widget
  if self.direction == DIRECTION.Right then
    self.nextx = self.nextx - newWidget.width - self.gap
  else
    self.nextx = self.nextx + newWidget.width + self.gap
  end

  table.insert(self.children, newWidget)
end

-- Updates all child widgets.
-- update() -> none
function RowLayout:update()
  local widthDifference = 0

  -- overwrites default values if direction is "right"
  if self.direction == DIRECTION.Right then
    widthDifference = self.parent.width - self.parentwidth
  end

  for _, child in pairs(self.children) do
    child.widget.x = child.positionx + widthDifference
    child.widget.y = child.positiony
  end
end

-- Creates the column layout constructor.
function RowLayout:constructor(parent, direction, gap, positionx, positiony, width, heigth)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  -- validates parameter values and sets default values
  if direction == nil then direction = DIRECTION.Left end
  if direction > 2 then direction = DIRECTION.Left end

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

  -- overwrites default values if direction is "right"
  if self.direction == DIRECTION.Right then
    self.nextx = self.endx
  end
end

return RowLayout
