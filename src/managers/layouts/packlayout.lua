local bl = require("managers.layouts.baselayout")

-- Arranges child widgets into a single resizeable column.
-- Default alignment is "left".
-- local packlayout = {}

-- Defines specific constants.
local ALIGNMENT = { Left = 1, Right = 2, Center = 3, Stretch = 4 }

-- Defines the pack layout object.
local PackLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object, gap?:number, alignment?[Left, Right, Center, Strecht]: number) -> none
function PackLayout:add(widget, gap, alignment)
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
  newWidget.gap = gap or 0
  newWidget.alignment = alignment

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

  self.nexty = self.nexty + newWidget.height + newWidget.gap

  table.insert(self.children, newWidget)
end

-- Updates all child widgets.
-- update() -> none
function PackLayout:update()
  if not self.resize then return end

  local widthDifference = 0

  widthDifference = self.parent.width - self.parentwidth
  
  for _, child in pairs(self.children) do
    child.widget.width = child.width + widthDifference
  end
end

-- Creates the pack layout constructor.
function PackLayout:constructor(parent, resize, positionx, positiony, width, heigth)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
  self.resize = resize or false
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
end

return PackLayout
