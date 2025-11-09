-- Defines a data management module.
local dm = {} -- version 2025.11

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
-- isStringType(parameter: any) -> boolean
local function isStringType(parameter)
  return type(parameter) == "string"
end

-- Checks if the paramter is a function type.
-- isFunctionType(parameter: any) -> boolean
local function isFunctionType(parameter)
  return type(parameter) == "function"
end

-- Checks if the parameter is a nil type.
-- isNilType(parameter: any) -> boolean
local function isNilType(parameter)
  return type(parameter) == "nil"
end

-- Defines the data manager object.
local DataManager = Object({})

-- Creates the data manager constructor.
function DataManager:constructor()
  self.source = {}
  self.children = {}
end

-- Adds a widget, widget property, source field, field converter and default value.
-- add(widget: object, property: string, field: string, converter: function, default: any) -> none
function DataManager:add(widget, property, field, converter, default)
  if not isValidChild(widget) then return end
  if not isStringType(property) then return end
  if not isStringType(field) then return end
  if not isNilType(converter) and not isFunctionType(converter) then return end
  if not isStringType(property) then return end
  if property == "" then return end
  if field == "" then return end

  local newChild = {
    widget = widget,
    property = property,
    field = field,
    converter = converter,
    default = default
  }

  table.insert(self.children, newChild)
end

-- Loads the source value for each widget.
-- load() -> none
function DataManager:load()
  for _, child in ipairs(self.children) do
    local sourceValue = self.source[child.field]
    child.widget[child.property] = sourceValue and sourceValue or child.default
  end
end

-- Saves the source value for each widget.
-- save() -> none
function DataManager:save()
  for _, child in ipairs(self.children) do
    local widgetValue = child.widget[child.property]
    self.source[child.field] = child.converter and child.converter(widgetValue) or widgetValue
  end
end

-- Sets the default value for each widget.
-- default() -> none
function DataManager:default()
  for _, child in ipairs(self.children) do
    child.widget[child.property] = child.default
  end
end

-- Gets the source value for a field.
-- value(field: string) -> any
function DataManager:value(field)
  if not isStringType(field) then return end
  if field == "" then return end
  return self.source[field] or nil
end

-- Updates the source value for a field.
-- update(field: string, value: any) -> none
function DataManager:update(field, value)
  if not isStringType(field) then return end
  if field == "" then return end
  self.source[field] = value
end

-- Initializes a new data manager instance.
-- dataManager() -> object
function dm.DataManager()
  return DataManager()
end

return dm
