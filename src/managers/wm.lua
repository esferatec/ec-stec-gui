-- Defines a widget management module.
local wm = {} -- version 2025.04

-- Checks if the parameter is a valid child widget.
-- isValidChild(parameter: any) -> boolean
local function isValidChild(parameter)
  local invalidTypes = {
    "nil",
    "boolean",
    "number",
    "string",
    "userdata",
    "function",
    "thread" }

  return not table.concat(invalidTypes, ","):find(type(parameter))
end

-- Checks if the parameter is a string type.
-- isString(parameter: any) -> boolean
local function isString(parameter)
  return type(parameter) == "string"
end

-- Checks if the parameter is a nil type.
-- isNil(parameter: any) -> boolean
local function isNil(parameter)
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
  if not isString(name) then return end
  if name == "" then return end

  self.children[name] = widget
end

-- Hides all child widgets.
-- hide() -> none
function WidgetManager:hide()
  for child in each(self.children) do
    if not isNil(child.visible) then
      child.visible = false
    end
  end
end

-- Shows all child widgets.
-- show() -> none
function WidgetManager:show()
  for child in each(self.children) do
    if not isNil(child.visible) then
      child.visible = true
    end
  end
end

-- Disables all child widgets.
-- disable() -> none
function WidgetManager:disable()
  for child in each(self.children) do
    if not isNil(child.enabled) then
      child.enabled = false
    end
  end
end

-- Enables all child widgets.
-- enable() -> none
function WidgetManager:enable()
  for child in each(self.children) do
    if not isNil(child.enabled) then
      child.enabled = true
    end
  end
end

-- Changes a property for all child widgets.
-- change(key: string, value: any) -> none
function WidgetManager:change(key, value)
  if not isString(key) then return end

  for child in each(self.children) do
    if not isNil(child[key]) then
      child[key] = value
    end
  end
end

-- Sets the focus to a specific child widget.
-- focus(name: string) -> none
function WidgetManager:focus(name)
  if not isString(name) then return end

  if not isNil(self.children[name]) then
    self.children[name]:show()
  end
end

-- Initializes a new widget manager instance.
-- WidgetManager() -> object
function wm.WidgetManager()
  return WidgetManager()
end

return wm
