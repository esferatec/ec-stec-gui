-- Defines a validation management module.
local vm = {} -- version 2025.04

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
    "thread"
  }

  return not table.concat(invalidTypes, ","):find(type(parameter))
end

-- Checks if the parameter is a string type.
-- isString(parameter: any) -> boolean
local function isString(parameter)
  return type(parameter) == "string"
end

-- Checks if the paramter is a function type.
-- isFunction(parameter: any) -> boolean
local function isFunction(parameter)
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

-- Adds a widget, property, validation rule and error message.
-- add(widget: object, property: string, rule: function, message: string) -> none
function ValidationManager:add(widget, property, rule, message)
  if not isValidChild(widget) then return end
  if not isString(property) then return end
  if not isFunction(rule) then return end
  if not isString(message) then return end

  local newChild = {
    widget = widget,
    property = property,
    rule = rule,
    message = message
  }

  table.insert(self.children, newChild)
end

-- Performs validation checks for each widget.
-- apply() -> none
function ValidationManager:apply()
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
