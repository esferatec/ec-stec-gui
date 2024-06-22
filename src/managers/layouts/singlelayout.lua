local bl = require("managers.layouts.baselayout")

-- Places a single child widget at the given position.
-- Default resize is "none".
-- local singlelayout = {}

-- Defines specific constants.
local RESIZE = { X = 1, Y = 2, Both = 3, None = 4 }

-- Defines the single layout object.
local SingleLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object) -> none
function SingleLayout:add(widget)
  if not bl.isvalidchild(widget) then return end

  local newWidget = {}
  newWidget.widget = widget
  newWidget.width = self.width
  newWidget.height = self.height
  newWidget.positionx = self.nextx
  newWidget.positiony = self.nexty

  self.children[1] = newWidget
end

-- Updates the child widget.
-- update() -> none
function SingleLayout:update()
  if self.resize == RESIZE.None then return end

  local widthDifference, heightDifference = 0, 0

  -- overwrites default values if resize is "X" or "Both"
  if self.resize ~= RESIZE.Y then
    widthDifference = self.parent.width - self.parentwidth
  end

  -- overwrites default values if resize is "Y" or "Both"
  if self.resize ~= RESIZE.X then
    heightDifference = self.parent.height - self.parentheight
  end

  for _, child in pairs(self.children) do
    child.widget.width = child.width + widthDifference
    child.widget.height = child.height + heightDifference
  end
end

-- Creates the single layout constructor.
function SingleLayout:constructor(parent, resize, positionx, positiony, width, height)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  -- validates parameter values and sets default values
  if resize == nil then resize = RESIZE.None end
  if resize > 4 or resize < 1 then resize = RESIZE.None end

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
  self.resize = resize
  self.width = width or self.parentwidth
  self.height = height or self.parentheight
  self.startx = positionx or 0
  self.starty = positiony or 0
  self.endx = self.startx + self.width
  self.endy = self.starty + self.height
  self.nextx = self.startx
  self.nexty = self.starty
end

return SingleLayout
