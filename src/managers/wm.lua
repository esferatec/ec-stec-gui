-- Defines a widget management module.
local wm = {} -- version 2025.11

-- Checks if the parameter is a valid child widget.
-- isValidChild(parameter: any) -> boolean
local function isValidChild(parameter)
  local invalidTypes = {
    ["nil"] = true,
    ["boolean"] = true,
    ["number"] = true,
    ["string"] = true,
    ["userdata"] = true,
    ["function"] = true,
    ["thread"] = true
  }

  return not invalidTypes[type(parameter)]
end

-- Checks if the parameter is a string type.
-- isString(parameter: any) -> boolean
local function isStringType(parameter)
  return type(parameter) == "string"
end

-- Checks if the parameter is a nil type.
-- isNil(parameter: any) -> boolean
local function isNilType(parameter)
  return type(parameter) == "nil"
end

-- Defines the widget manager object.
local WidgetManager = Object({})

-- Creates the widget manager constructor.
function WidgetManager:constructor()
  self.children = {}
end

-- Adds a widget and name.
-- add(widget: object, name: string) -> none
function WidgetManager:add(widget, name)
  if not isValidChild(widget) then return end
  if not isStringType(name) then return end
  if name == "" then return end

  self.children[name] = widget
end

-- Hides all child widgets.
-- hide() -> none
function WidgetManager:hide()
  for child in each(self.children) do
    if not isNilType(child.visible) then
      child.visible = false
    end
  end
end

-- Shows all child widgets.
-- show() -> none
function WidgetManager:show()
  for child in each(self.children) do
    if not isNilType(child.visible) then
      child.visible = true
    end
  end
end

-- Disables all child widgets.
-- disable() -> none
function WidgetManager:disable()
  for child in each(self.children) do
    if not isNilType(child.enabled) then
      child.enabled = false
    end
  end
end

-- Enables all child widgets.
-- enable() -> none
function WidgetManager:enable()
  for child in each(self.children) do
    if not isNilType(child.enabled) then
      child.enabled = true
    end
  end
end

-- Changes a property for all child widgets.
-- change(key: string, value: any) -> none
function WidgetManager:change(key, value)
  if not isStringType(key) then return end

  for child in each(self.children) do
    if not isNilType(child[key]) then
      child[key] = value
    end
  end
end

-- Sets the focus to a specific child widget.
-- focus(name: string) -> none
function WidgetManager:focus(name)
  if not isStringType(name) then return end

  if not isNilType(self.children[name]) then
    self.children[name]:show()
  end
end

-- Initializes a new widget manager instance.
-- WidgetManager() -> object
function wm.WidgetManager()
  return WidgetManager()
end

return wm
