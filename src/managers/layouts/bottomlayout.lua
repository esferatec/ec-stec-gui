local bl = require("managers.layouts.baselayout")

-- Arranges child widgets into a single row on the bottom border.
-- Default direction is "left" and default alignment is "bottom".
-- local bottomlayout = {}

-- Defines specific constants.
local DIRECTION = { Left = 1, Right = 2 }
local ALIGNMENT = { Top = 1, Bottom = 2, Center = 3 }

-- Defines the bottom layout object.
local BottomLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object, alignment?: number) -> none
function BottomLayout:add(widget, alignment)
  if not bl.isvalidchild(widget) then return end

  -- validates alignment parameter and sets default value
  if alignment == nil then alignment = ALIGNMENT.Bottom end
  if type(alignment) ~= "number" then alignment = ALIGNMENT.Bottom end
  if alignment > 3 then alignment = ALIGNMENT.Bottom end

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
function BottomLayout:update()
  local widthDifference = 0

  -- overwrites default values if direction is "right"
  if self.direction == DIRECTION.Right then
    widthDifference = self.parent.width - self.parentwidth
  end

  local heightDifference = self.parent.height - self.parentheight

  for _, child in pairs(self.children) do
    child.widget.x = child.positionx + widthDifference
    child.widget.y = child.positiony + heightDifference
  end
end

-- Creates the bottom layout constructor.
function BottomLayout:constructor(parent, direction, gap, margin, height)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  -- validates parameter values and sets default values
  if direction == nil then direction = DIRECTION.Left end
  if direction > 2 then direction = DIRECTION.Left end
  if margin == nil then margin = { 0, 0, 0, 0 } end
  if type(margin) == "number" then margin = { margin, margin, margin, margin } end

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
  self.direction = direction
  self.gap = gap or 0
  self.marginleft = margin[1] or 0
  self.marginright = margin[2] or 0
  self.margintop = margin[3] or 0
  self.marginbottom = margin[4] or 0
  self.height = height or (self.parentheight - self.marginbottom - self.margintop)
  self.startx = 0 + self.marginleft
  self.starty = self.parentheight - self.marginbottom - self.height
  self.endx = self.parentwidth - self.marginright
  self.endy = self.starty + self.height
  self.nextx = self.startx
  self.nexty = self.starty

  -- overwrites default values if direction is "right"
  if self.direction == DIRECTION.Right then
    self.nextx = self.endx
  end
end

return BottomLayout
