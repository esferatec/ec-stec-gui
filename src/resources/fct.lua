require("common.extension")

local sys = require("sys")

local fct = {}

function fct.compilescript(compiler, icon, modules, output, directory, script, module)
  local command = string.format('%s -s -w -i %s -l%s -o %s %s %s -L%s\n', compiler, icon, modules, output, directory,
    script, module)

  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setfileversion(tool, file, version)
  local command = string.format('%s %s --set-file-version "%s"\n', tool, file, version)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setproductversion(tool, file, version)
  local command = string.format('%s %s --set-product-version "%s"\n', tool, file, version)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setproductname(tool, file, name)
  local command = string.format('%s %s --set-version-string "ProductName" "%s"\n', tool, file, name)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setfiledescription(tool, file, description)
  local command = string.format('%s %s --set-version-string "FileDescription" "%s"\n', tool, file, description)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

function fct.setlegalcopyright(tool, file, copyright)
  local command = string.format('%s %s --set-version-string "LegalCopyright" "%s"\n', tool, file, copyright)
  local success, result = pcall(sys.cmd, command)
  return success == result
end

return fct
