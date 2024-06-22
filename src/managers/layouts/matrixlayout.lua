local bl = require("managers.layouts.baselayout")
 
-- Arranges child widgets into a given matix.
-- Default resize is "none".
-- local matrixlayout = {}

-- Defines specific constants.
local RESIZE = { X = 1, Y = 2, Both = 3, None = 4 }

-- Defines the matrix layout object.
local MatrixLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object) -> none
function MatrixLayout:add(widget)
  if not bl.isvalidchild(widget) then return end
  if #self.children >= (self.columns * self.rows) then return end

  local newWidget = {}
  newWidget.widget = widget
  newWidget.width = (self.width-((self.columns-1)*self.gap))/self.columns
  newWidget.height = (self.height-((self.rows-1)*self.gap))/self.rows
  newWidget.positionx = self.nextx
  newWidget.positiony = self.nexty
  newWidget.column = self.column
  newWidget.row = self.row

  self.nextx = self.nextx + newWidget.width + self.gap
  self.column = self.column + 1

  if (self.nextx-self.gap) >= self.endx then
    self.nextx = self.startx
    self.nexty = self.nexty + newWidget.height + self.gap
    self.column = 1
    self.row = self.row + 1
  end

  table.insert(self.children, newWidget)
end

-- Updates the child widget.
-- update() -> none
function MatrixLayout:update()
  if self.resize == RESIZE.None then
    return
  end

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
    child.widget.width = child.width + (widthDifference / self.columns)
    child.widget.height = child.height + (heightDifference / self.rows)
    child.widget.x = child.positionx + ((widthDifference / self.columns) * (child.column - 1))
    child.widget.y = child.positiony + ((heightDifference / self.rows) * (child.row - 1))
  end
end

-- Creates the matrix layout constructor.
function MatrixLayout:constructor(parent, columns, rows, resize, gap, positionx, positiony, width, height)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  -- validates parameter values and sets default values
  if resize == nil then resize = RESIZE.None end
  if resize > 4 or resize < 1 then resize = RESIZE.None end

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
  self.columns = columns or 1
  self.rows = rows or 1
  self.resize = resize
  self.gap = gap or 0
  self.width = width or self.parentwidth
  self.height = height or self.parentheight
  self.startx = positionx or 0
  self.starty = positiony or 0
  self.endx = self.startx + self.width
  self.endy = self.starty + self.height
  self.nextx = self.startx
  self.nexty = self.starty
  self.column = 1
  self.row = 1
end

return MatrixLayout
