local bl = require("managers.layouts.baselayout")

-- Places a child widget at the given absolute position. 
-- local absolutelayout = {}

-- Defines the absolute layout object.
local AbsoluteLayout = Object(bl.BaseLayout())

-- Adds a child widget.
-- add(widget: object, positionx?: number, positiony?: number) -> none
function AbsoluteLayout:add(widget, positionx, positiony)
  if not bl.isvalidchild(widget) then return end

  local newWidget = {}
  newWidget.widget = widget
  newWidget.width = widget.width
  newWidget.height = widget.height
  newWidget.positionx = positionx or widget.x
  newWidget.positiony = positiony or widget.y

  table.insert(self.children, newWidget)
end

-- Creates the absolute layout constructor.
function AbsoluteLayout:constructor(parent)
  assert(bl.isvalidparent(parent), bl.ERRORMESSAGE.notvalidparent)

  self.parent = parent
  self.parentwidth = parent.width
  self.parentheight = parent.height
  self.children = {}
end

return AbsoluteLayout
