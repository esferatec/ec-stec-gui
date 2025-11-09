-- Defines a menu management module.
local mm = {} -- version 2025.11

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

-- Defines the menu manager object.
local MenuManager = Object({})

-- Creates the menu manager constructor.
function MenuManager:constructor()
  self.children = {}
end

-- Adds a menu object and name.
-- add(menu: object, name: string) -> none
function MenuManager:add(menu, name)
  if not isValidChild(menu) then return end
  if not isStringType(name) then return end
  if name == "" then return end

  self.children[name] = menu
end

-- Unchecks all child menus.
-- change(key: string, value: any) -> none
function MenuManager:uncheck()
  for child in each(self.children) do
    if not isNilType(child.checked) then
      child.checked = false
    end
  end
end

-- Disables all child menus.
-- disable() -> none
function MenuManager:disable()
  for child in each(self.children) do
    if not isNilType(child.enabled) then
      child.enabled = false
    end
  end
end

-- Enables all child menus.
-- enable() -> none
function MenuManager:enable()
  for child in each(self.children) do
    if not isNilType(child.enabled) then
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
