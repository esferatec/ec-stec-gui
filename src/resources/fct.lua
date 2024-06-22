require("common.extension")

local sys = require("sys")
local ui = require("ui")

local fct = {}

function fct.compileScript(icon, modules, output, directory, script)
 --local command = string.format('rtc -w -i "%s" -l"%s" -o "%s" %s "%s"\n', icon, modules, output, directory, script)

 local command = string.format('rtc -w -i %s -l%s -o %s %s %s\n', icon, modules, output, directory, script)

  sys.clipboard = command
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setFileVersion(file, version)
  if not isstring(file) then return false end
  if not isstring(version) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(version) then return false end

  local command = string.format('rcedit %s --set-file-version "%s"\n', file, version)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setProductVersion(file, version)
  if not isstring(file) then return false end
  if not isstring(version) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(version) then return false end

  local command = string.format('rcedit %s --set-product-version "%s"\n', file, version)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setProductName(file, name)
  if not isstring(file) then return false end
  if not isstring(name) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(name) then return false end

  local command = string.format('rcedit %s --set-version-string "ProductName" "%s"\n', file, name)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setFileDescription(file, description)
  if not isstring(file) then return false end
  if not isstring(description) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(description) then return false end

  local command = string.format('rcedit %s --set-version-string "FileDescription" "%s"\n', file, description)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setLegalCopyright(file, copyright)
  if not isstring(file) then return false, false end
  if not isstring(copyright) then return false, false end

  if string.iswhitespace(file) then return false, false end
  if string.iswhitespace(copyright) then return false, false end

  local command = string.format('rcedit %s --set-version-string "LegalCopyright" "%s"\n', file, copyright)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

return fct
