require("common.extension")

local sys = require("sys")

local fct = {}

function fct.compilescript(icon, modules, output, directory, script)
  if not isstring(output) then return false end
  if not isstring(script) then return false end

  if string.iswhitespace(output) then return false end
  if string.iswhitespace(script) then return false end

  local command = string.format('rtc -w -i %s -l%s -o %s %s %s\n', icon, modules, output, directory, script)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setfileversion(file, version)
  if not isstring(file) then return false end
  if not isstring(version) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(version) then return false end

  local command = string.format('rcedit %s --set-file-version "%s"\n', file, version)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setproductversion(file, version)
  if not isstring(file) then return false end
  if not isstring(version) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(version) then return false end

  local command = string.format('rcedit %s --set-product-version "%s"\n', file, version)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setproductname(file, name)
  if not isstring(file) then return false end
  if not isstring(name) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(name) then return false end

  local command = string.format('rcedit %s --set-version-string "ProductName" "%s"\n', file, name)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setfiledescription(file, description)
  if not isstring(file) then return false end
  if not isstring(description) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(description) then return false end

  local command = string.format('rcedit %s --set-version-string "FileDescription" "%s"\n', file, description)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setlegalcopyright(file, copyright)
  if not isstring(file) then return false end
  if not isstring(copyright) then return false end

  if string.iswhitespace(file) then return false end
  if string.iswhitespace(copyright) then return false end

  local command = string.format('rcedit %s --set-version-string "LegalCopyright" "%s"\n', file, copyright)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

return fct
