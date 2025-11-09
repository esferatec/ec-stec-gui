-- Defines a validation management module.
local vm = {} -- version 2025.11

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

-- Checks if the paramter is a function type.
-- isFunction(parameter: any) -> boolean
local function isFunctionType(parameter)
  return type(parameter) == "function"
end

-- Defines the validation manager object.
local ValidationManager = Object({})

-- Creates the validation manager constructor.
function ValidationManager:constructor()
  self.isvalid = true
  self.message = {}
  self.children = {}
end

-- Adds a widget, widget property, validation rule and error message.
-- add(widget: object, property: string, rule: function, message: string) -> none
function ValidationManager:add(widget, property, rule, message)
  if not isValidChild(widget) then return end
  if not isStringType(property) then return end
  if not isFunctionType(rule) then return end
  if not isStringType(message) then return end
  if property == "" then return end

  local newChild = {
    widget = widget,
    property = property,
    rule = rule,
    message = message
  }

  table.insert(self.children, newChild)
end

-- Performs validation checks for each widget.
-- validate() -> none
function ValidationManager:validate()
  self.isvalid = true
  self.message = {}

  for _, child in pairs(self.children) do
    local validationResult = child.rule(child.widget[child.property])

    if not validationResult then
      table.insert(self.message, child.message)
      self.isvalid = false
    end
  end
end

-- Initializes a new validation manager instance.
-- ValidationManager() -> object
function vm.ValidationManager()
  return ValidationManager()
end

return vm
