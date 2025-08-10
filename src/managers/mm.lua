-- Defines a menu management module.
local mm = {} -- version 2025.04

-- Checks if the parameter is a valid child widget.
-- isValidChild(parameter: any) -> boolean
local function isValidChild(parameter)
  local childType = type(parameter)
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

-- Defines the menu manager object.
local MenuManager = Object({})

-- Creates the menu manager constructor.
function MenuManager:constructor()
  self.children = {}
end

-- Adds a menu object.
-- add(menu: object, name: string) -> none
function MenuManager:add(menu, name)
  if not isValidChild(menu) then return end
  if not isString(name) then return end
  if name == "" then return end

  self.children[name] = menu
end

-- Unchecks all child menus.
-- change(key: string, value: any) -> none
function MenuManager:uncheck()
  for child in each(self.children) do
    if not isNil(child.checked) then
      child.checked = false
    end
  end
end

-- Disables all child widgets.
-- disable() -> none
function MenuManager:disable()
  for child in each(self.children) do
    if not isNil(child.enabled) then
      child.enabled = false
    end
  end
end

-- Enables all child widgets.
-- enable() -> none
function MenuManager:enable()
  for child in each(self.children) do
    if not isNil(child.enabled) then
      child.enabled = true
    end
  end
end

-- Initializes a new menu manager instance.
-- WMenuManager() -> object
function mm.MenuManager()
  return MenuManager()
end

return mm
