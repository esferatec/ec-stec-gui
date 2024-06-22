-- Represents the base module for all layouts.
local baselayout = {}

-- Defines specific error massages.
baselayout.ERRORMESSAGE = {}
baselayout.ERRORMESSAGE.notvalidparent = "Not a valid parent widget."
baselayout.ERRORMESSAGE.notvalidchild = "Not a valid child widget."

-- Checks if the parameter is a valid parent widget.
-- isvalidparent(parameter: any) -> boolean
function baselayout.isvalidparent(parameter)
  local parentType = tostring(parameter)
  local validTypes = { "Window", "Groupbox", "TabItem", "Panel" }

  for _, validType in pairs(validTypes) do
    if string.find(parentType, validType) ~= nil then return true end
  end

  return false
end

-- Checks if the parameter is a valid child widget.
-- isValidChild(parameter: any) -> boolean
function baselayout.isvalidchild(parameter)
  local childType = type(parameter)
  local invalidTypes = { "nil", "boolean", "number", "string", "userdata", "function", "thread" }

  for _, invalidType in ipairs(invalidTypes) do
    if string.find(childType, invalidType) then return false end
  end

  return true
end

-- Checks if the paramter is a number or nil type.
-- isnumberornil(name: any) -> boolean
function baselayout.isnumberornil(parameter)
  return type(parameter) == "number" or type(parameter) == "nil"
end

-- Checks if the paramter is a table or nil type.
-- istableornil(name: any) -> boolean
function baselayout.istableornil(parameter)
  return type(parameter) == "table" or type(parameter) == "nil"
end

-- Defines the base layout prototype.
local BaseLayout = Object({})

-- Creates the base layout constructor.
function BaseLayout:constructor()
  self.children = {}
  self.parent = 0
  self.parentwidth = 0
  self.parentheight = 0
end

-- Positions all child widgets.
-- apply() -> none
function BaseLayout:apply()
  for _, child in pairs(self.children) do
    child.widget.x = child.positionx
    child.widget.y = child.positiony
    child.widget.width = child.width
    child.widget.height = child.height
  end
end

-- Hides all child widgets.
-- hide() -> none
function BaseLayout:hide()
  for _, child in pairs(self.children) do
    child.widget.visible = false
  end
end

-- Shows all child widgets.
-- show() -> none
function BaseLayout:show()
  for _, child in pairs(self.children) do
    child.widget.visible = true
  end
end

-- Changes a property for all child widgets.
-- change(key: string, value: any) -> none
function BaseLayout:change(key, value)
  if type(key) ~= "string" then
    return
  end

  for _, child in pairs(self.children) do
    child.widget[key] = value
  end
end

-- Resets the parent widget.
-- reset() -> none
function BaseLayout:reset()
  self.parent.width = self.parentwidth
  self.parent.height = self.parentheight
end

-- Initializes a new base layout class.
-- BaseLayout() -> object
function baselayout.BaseLayout()
  return BaseLayout()
end

return baselayout
