-- Defines a data management module.
local dm = {} -- version 1.0

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

-- Checks if the parameter is a number type.
-- isNumber(parameter: any) -> boolean
local function isNumber(parameter)
  return type(parameter) == "number"
end

-- Checks if the parameter is a boolean type.
-- isBoolean(parameter: any) -> boolean
local function isBoolean(parameter)
  return type(parameter) == "boolean"
end

-- Checks if the parameter is a database type.
-- isDatabase(parameter: any) -> boolean
local function isDatabase(parameter)
  return type(parameter) == "Database"
end

-- Conparameterert a number or string to boolean
-- toboolean(parameter: any) -> boolean
local function toboolean(parameter)
  if isNumber(parameter) then
    return parameter ~= 0
  end

  if isString(parameter) then
    return parameter:lower() == "true"
  end

  return false
end

-- Defines the data manager object.
local DataManager = Object({})

-- Creates the data manager constructor.
function DataManager:constructor()
  local _database = {}

  function self:set_database(value)
    if not isDatabase(value) then
      value = nil
    end

    _database = value
  end

  function self:get_database()
    return _database
  end

  local _datatable = {}

  function self:set_datatable(value)
    if not isString(value) then
      value = nil
    end

    _datatable = value
  end

  function self:get_datatable()
    return _datatable
  end

  self.children = {}
  self.key = -1
end

-- Adds a field, widget, property and default value.
-- add(field: string, widget: object, property: string) -> none
function DataManager:add(field, widget, property, default)
  if not isString(field) then return end
  if not isValidChild(widget) then return end
  if not isString(property) then return end

  local newChild = {
    field = field,
    widget = widget,
    property = property,
    default = default
  }

  table.insert(self.children, newChild)
end

-- Sets default value for each widget.
-- apply() -> none
function DataManager:apply()
  for _, child in ipairs(self.children) do
    child.widget[child.property] = child.default
  end

  self.key = -1
end

-- Selects a row of the table.
-- select(record: number) -> none
function DataManager:select(record)
  if not isNumber(record) then return end

  local statement = string.format("SELECT * FROM %s ORDER BY id ASC LIMIT 1 OFFSET %d;", self.datatable, record)

  local row = self.database:exec(statement)

  for _, child in ipairs(self.children) do
    if isBoolean(child.widget[child.property]) then
      child.widget[child.property] = toboolean(row[child.field])
      goto nextchild
    end

    if isString(child.widget[child.property]) then
      child.widget[child.property] = tostring(row[child.field])
      goto nextchild
    end

    if isNumber(child.widget[child.property]) then
      child.widget[child.property] = tonumber(row[child.field])
      goto nextchild
    end

    ::nextchild::
  end

  self.key = row["id"]
end

-- Insert a record to the database table.
-- insert() -> none
function DataManager:insert()
  local fields = {}
  local values = {}

  for _, child in ipairs(self.children) do
    table.insert(fields, child.field)
    table.insert(values, "'" .. tostring(child.widget[child.property]) .. "'")
  end

  local fieldStr = table.concat(fields, ", ")
  local valueStr = table.concat(values, ", ")

  local statement = string.format("INSERT INTO %s (%s) VALUES (%s);", self.datatable, fieldStr, valueStr)

  self.database:exec(statement)
end

-- Update a record of the database table.
-- update() -> none
function DataManager:update()
  local updates = {}

  for _, child in ipairs(self.children) do
    table.insert(updates, child.field .. " = '" .. tostring(child.widget[child.property]) .. "'")
  end

  local updateString = table.concat(updates, ", ")

  local statement = string.format("UPDATE %s SET %s WHERE id = %d", self.datatable, updateString, self.key)

  self.database:exec(statement)
end

-- Delete a record from the database table.
-- delete() -> none
function DataManager:delete()
  local statement = string.format("DELETE FROM %s WHERE id = %d;", self.datatable, self.key)
  self.database:exec(statement)
end

-- Initializes a new data manager instance.
-- DataManager() -> object
function dm.DataManager()
  return DataManager()
end

return dm
