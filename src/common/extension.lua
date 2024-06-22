-- Represents a extension module for lua.

--#region type check

-- Return true if the value is a number and false otherwise.
function isnumber(v)
   return type(v) == "number"
end

-- Return true if the value is a integer and false otherwise.
function isinteger(v)
   return math.type(v) == "integer"
end

-- Return true if the value is a float and false otherwise.
function isfloat(v)
   return math.type(v) == "float"
end

-- Return true if the value is a string and false otherwise.
function isstring(v)
   return type(v) == "string"
end

-- Return true if the value is nil and false otherwise.
function isnil(v)
   return type(v) == "nil"
end

-- Return true if the value is a table and false otherwise.
function istable(v)
   return type(v) == "table"
end

-- Return true if the value is a function and false otherwise.
function isfunction(v)
   return type(v) == "function"
end

-- Return true if the value is a boolean and false otherwise.
function isboolean(v)
   return type(v) == "boolean"
end

--#endregion

--#region type convert

-- Convert a number or string to boolean
function toboolean(v)
   if isnumber(v) then
      return v ~= 0
   end

   if isstring(v) then
      return v:lower() == "true"
   end

   return false
end

--#endregion

--#region string functions

-- Remove any leading and trailing whitespace characters.
function string.trim(s)
   return s:gsub("^%s*(.-)%s*$", "%1")
end

-- Remove any leading whitespace characters.
function string.trimstart(s)
   return s:gsub("^%s+", "")
end

-- Remove any trailing whitespace characters.
function string.trimend(s)
   return s:gsub("%s+$", "")
end

-- Return the number of occurrences of substring.
function string.count(s, sub, start, finish)
   start = start or 1
   finish = finish or #s

   local count = 0
   local i = start

   while i <= finish do
      if s:sub(i, i + #sub - 1) == sub then
         count = count + 1
         i = i + #sub
      else
         i = i + 1
      end
   end

   return count
end

-- Return true if all characters in the string are numeric and false otherwise.
function string.isnumeric(s)
   return s:match("^%d+$") ~= nil
end

-- Return true if all characters in the string are upper case and false otherwise.
function string.isupper(s)
   return s == s:upper()
end

-- Return true if all characters in the string are lower case and false otherwise.
function string.islower(s)
   return s == s:lower()
end

-- Return true if the string ends with the specified suffix and false otherwise.
function string.endswith(s, suffix)
   return s:sub(- #suffix) == suffix
end

-- Return true if the string starts with the specified suffix and false otherwise.
function string.startswith(s, prefix)
   return s:sub(1, #prefix) == prefix
end

-- Indicate whether a specified string consists only of whitespace.
function string.iswhitespace(s)
   return s:match("^%s*$") ~= nil
end

-- Indicate whether a specified string is nil.
function string.isnil(s)
   return s == nil
end

-- Indicate whether a specified string is empty.
function string.isempty(s)
   return s == ''
end

--#endregion
