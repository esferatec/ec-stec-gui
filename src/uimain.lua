require("common.extension")

local ui = require("ui")
local uiextension = require("modules.uiextension")
local sys = require("sys")

local dm = require("managers.dm") -- data manager
local gm = require("managers.gm") -- geometry manager
local mm = require("managers.mm") -- menu manager
local vm = require("managers.vm") -- validation manager
local wm = require("managers.wm") -- widget manager

--#region Functions

local function isRequired(value)
  value = string.trim(value)
  return not string.isnil(value) and not string.isempty(value)
end

local function isValidFile(value)
  value = string.trim(value)
  if string.isempty(value) then return true end
  return sys.File(value).exists
end

local function isValidDirectory(value)
  value = string.trim(value)
  if string.isempty(value) then return true end
  return sys.Directory(value).exists
end

local function isValidScriptFile(value)
  value = string.trim(value)
  if string.isempty(value) then return true end
  return string.match(".lua .wlua", sys.File(value).extension)
end

local function isValidIconFile(value)
  value = string.trim(value)
  if string.isempty(value) then return true end
  return string.match(".ico", sys.File(value).extension)
end

local function isValidOutputFile(value)
  value = string.trim(value)
  if string.isempty(value) then return true end
  return string.match(".exe", sys.File(value).extension)
end

--#endregion

--#region Menu

local MenuBurger = ui.Menu("Setup", "Help", "About", "", "Exit")

--#endregion

--#region Window

local Window     = ui.Window("ecSTEC", "single", 700, 630)
Window.bgcolor   = 0xa3c2c2
Window.modified  = false
Window.menu      = ui.Menu()
Window.menu:add("|||", MenuBurger)

--#endregion

--#region Managers

Window.DM                    = dm.DataManager()
Window.GM_PRODUCT_LABEL      = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 18, 95, 88)
Window.GM_PRODUCT_ENTRY      = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 120, 14, 220, 88)
Window.GM_FILE_LABEL         = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 360, 18, 95, 88)
Window.GM_FILE_ENTRY         = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 465, 14, 220, 88)
Window.GM_SCRIPT_LABEL       = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 136, 95, 116)
Window.GM_SCRIPT_ENTRY       = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 120, 132, 565, 116)
Window.GM_MODULE_LABEL       = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 277, 95, 44)
Window.GM_MODULE_CHECKBOX    = gm.GeometryManager():MatrixLayout(Window, 5, 4, gm.RESIZE.None, 0, 120, 277, 565, 100)
Window.GM_TOOLBAR_BUTTON     = gm.GeometryManager():RowLayout(Window, gm.DIRECTION.Left, 10, 15, 402, 670, 34)
Window.GM_TOOLS_LABEL        = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 470, 95, 116)
Window.GM_TOOLS_ENTRY        = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 120, 466, 565, 116)
Window.MM                    = mm.MenuManager()
Window.VM_SAVE               = vm.ValidationManager()
Window.VM_GENERATE           = vm.ValidationManager()
Window.WM                    = wm.WidgetManager()
Window.WM_MODULES            = wm.WidgetManager()

--#endregion

--#region Widgets

local LabelProjectName       = ui.Label(Window, "Project Name", 0, 0, 999, 20)
local EntryProjectName       = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelProductName       = ui.Label(Window, "Product Name", 0, 0, 999, 20)
local EntryProductName       = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelProductVersion    = ui.Label(Window, "Product Version", 0, 0, 999, 20)
local EntryProductVersion    = ui.Entry(Window, "", 0, 0, 220, 24)

local LabelFileDescription   = ui.Label(Window, "File Description", 0, 0, 999, 20)
local EntryFileDescription   = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelFileVersion       = ui.Label(Window, "File Version", 0, 0, 999, 20)
local EntryFileVersion       = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelLegalCopyright    = ui.Label(Window, "Legal Copyright", 0, 0, 999, 20)
local EntryLegalCopyright    = ui.Entry(Window, "", 0, 0, 220, 24)

local LabelScriptFile        = ui.Label(Window, "Script File", 0, 0, 999, 20)
local EntryScriptFile        = uiextension.FileEntry(Window, "", 0, 0, 999, 24)
local LabelScriptDirectory   = ui.Label(Window, "Script Directory", 0, 0, 999, 20)
local EntryScriptDirectory   = uiextension.DirectoryEntry(Window, "", 0, 0, 999, 24)
local LabelIconFile          = ui.Label(Window, "Icon File", 0, 0, 999, 20)
local EntryIconFile          = uiextension.FileEntry(Window, "", 0, 0, 999, 24)
local LabelOutputFile        = ui.Label(Window, "Output File", 0, 0, 999, 20)
local EntryOutputFile        = uiextension.FileEntry(Window, "", 0, 0, 999, 24)

local LabelEmbededModules    = ui.Label(Window, "Embeded Modules", 0, 0, 999, 40)
local CheckboxModuleAudio    = ui.Checkbox(Window, "audio ", 0, 0, 20, 999)
local CheckboxModuleCanvas   = ui.Checkbox(Window, "canvas ", 0, 0, 20, 999)
local CheckboxModuleCrypto   = ui.Checkbox(Window, "crypto", 0, 0, 20, 999)
local CheckboxModuleIni      = ui.Checkbox(Window, "ini", 0, 0, 20, 999)
local CheckboxModuleJson     = ui.Checkbox(Window, "json", 0, 0, 20, 999)
local CheckboxModuleNet      = ui.Checkbox(Window, "net", 0, 0, 20, 999)
local CheckboxModuleSqlite   = ui.Checkbox(Window, "sqlite", 0, 0, 20, 999)
local CheckboxModuleWebview  = ui.Checkbox(Window, "webview ", 0, 0, 20, 999)
local CheckboxModuleSysutils = ui.Checkbox(Window, "sysutils", 0, 0, 20, 999)
local CheckboxModuleKeyboard = ui.Checkbox(Window, "keyboard", 0, 0, 20, 999)
local CheckboxModuleSerial   = ui.Checkbox(Window, "serial", 0, 0, 20, 999)
local CheckboxModuleC        = ui.Checkbox(Window, "C", 0, 0, 20, 999)
local CheckboxModuleCpu      = ui.Checkbox(Window, "cpu", 0, 0, 20, 999)
local CheckboxModulePower    = ui.Checkbox(Window, "power", 0, 0, 20, 999)
local CheckboxModuleUi       = ui.Checkbox(Window, "ui", 0, 0, 20, 999)
local CheckboxModuleWifi     = ui.Checkbox(Window, "wifi", 0, 0, 20, 999)
local CheckboxModuleXml      = ui.Checkbox(Window, "xml", 0, 0, 20, 999)
local CheckboxModuleYaml     = ui.Checkbox(Window, "yaml", 0, 0, 20, 999)

local ButtonGenerate         = ui.Button(Window, "Generate", 0, 0, 160, 999)
local ButtonSave             = ui.Button(Window, "Save", 0, 0, 160, 999)
local ButtonNew              = ui.Button(Window, "New", 0, 0, 160, 999)
local ButtonUpdate           = ui.Button(Window, "Update", 0, 0, 160, 999)

local LabelScriptCompiler    = ui.Label(Window, "Script Compiler", 0, 0, 999, 20)
local EntryScriptCompiler    = uiextension.FileEntry(Window, "", 0, 0, 999, 24)
local LabelModuleDirectory   = ui.Label(Window, "Module Directory", 0, 0, 999, 20)
local EntryModuleDirectory   = uiextension.DirectoryEntry(Window, "", 0, 0, 999, 24)
local LabelPropertyTool      = ui.Label(Window, "Property Tool", 0, 0, 999, 20)
local EntryPropertyTool      = uiextension.FileEntry(Window, "", 0, 0, 999, 24)

--#endregion

--#region GeometryManager

Window.GM_PRODUCT_LABEL:add(LabelProjectName)
Window.GM_PRODUCT_LABEL:add(LabelProductName)
Window.GM_PRODUCT_LABEL:add(LabelProductVersion)

Window.GM_PRODUCT_ENTRY:add(EntryProjectName)
Window.GM_PRODUCT_ENTRY:add(EntryProductName)
Window.GM_PRODUCT_ENTRY:add(EntryProductVersion)

Window.GM_FILE_LABEL:add(LabelFileDescription)
Window.GM_FILE_LABEL:add(LabelFileVersion)
Window.GM_FILE_LABEL:add(LabelLegalCopyright)

Window.GM_FILE_ENTRY:add(EntryFileDescription)
Window.GM_FILE_ENTRY:add(EntryFileVersion)
Window.GM_FILE_ENTRY:add(EntryLegalCopyright)

Window.GM_SCRIPT_LABEL:add(LabelScriptFile)
Window.GM_SCRIPT_LABEL:add(LabelScriptDirectory)
Window.GM_SCRIPT_LABEL:add(LabelIconFile)
Window.GM_SCRIPT_LABEL:add(LabelOutputFile)

Window.GM_SCRIPT_ENTRY:add(EntryScriptFile)
Window.GM_SCRIPT_ENTRY:add(EntryScriptDirectory)
Window.GM_SCRIPT_ENTRY:add(EntryIconFile)
Window.GM_SCRIPT_ENTRY:add(EntryOutputFile)

Window.GM_MODULE_LABEL:add(LabelEmbededModules)

Window.GM_MODULE_CHECKBOX:add(CheckboxModuleAudio)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleC)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleCanvas)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleCpu)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleCrypto)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleIni)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleJson)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleKeyboard)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleNet)
Window.GM_MODULE_CHECKBOX:add(CheckboxModulePower)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleSerial)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleSqlite)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleSysutils)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleUi)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleWebview)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleWifi)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleXml)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleYaml)

Window.GM_TOOLBAR_BUTTON:add(ButtonNew)
Window.GM_TOOLBAR_BUTTON:add(ButtonUpdate)
Window.GM_TOOLBAR_BUTTON:add(ButtonSave)
Window.GM_TOOLBAR_BUTTON:add(ButtonGenerate)

Window.GM_TOOLS_LABEL:add(LabelScriptCompiler)
Window.GM_TOOLS_LABEL:add(LabelModuleDirectory)
Window.GM_TOOLS_LABEL:add(LabelPropertyTool)

Window.GM_TOOLS_ENTRY:add(EntryScriptCompiler)
Window.GM_TOOLS_ENTRY:add(EntryModuleDirectory)
Window.GM_TOOLS_ENTRY:add(EntryPropertyTool)

--#endregion

--#region WidgetManager

Window.WM:add(EntryProjectName, "EntryProjectName")
Window.WM:add(EntryProductName, "EntryProductName")
Window.WM:add(EntryProductVersion, "EntryProductVersion")
Window.WM:add(EntryFileVersion, "EntryFileVersion")
Window.WM:add(EntryFileDescription, "EntryFileDescription")
Window.WM:add(EntryLegalCopyright, "EntryLegalCopyright")
Window.WM:add(EntryScriptFile, "EntryScriptFile")
Window.WM:add(EntryScriptDirectory, "EntryScriptDirectory")
Window.WM:add(EntryIconFile, "EntryIconFile")
Window.WM:add(EntryOutputFile, "EntryOutputFile")
Window.WM:add(EntryScriptCompiler, "EntryScriptCompiler")
Window.WM:add(EntryModuleDirectory, "EntryModuleDirectory")
Window.WM:add(EntryPropertyTool, "EntryPropertyTool")
Window.WM:add(ButtonGenerate, "ButtonGenerate")
Window.WM:add(ButtonSave, "ButtonSave")
Window.WM:add(ButtonUpdate, "ButtonUpdate")
Window.WM:add(ButtonNew, "ButtonNew")

Window.WM_MODULES:add(CheckboxModuleAudio, "CheckboxModuleAudio")
Window.WM_MODULES:add(CheckboxModuleCanvas, "CheckboxModuleCanvas")
Window.WM_MODULES:add(CheckboxModuleCrypto, "CheckboxModuleCrypto")
Window.WM_MODULES:add(CheckboxModuleIni, "CheckboxModuleIni")
Window.WM_MODULES:add(CheckboxModuleJson, "CheckboxModuleJson")
Window.WM_MODULES:add(CheckboxModuleNet, "CheckboxModuleNet")
Window.WM_MODULES:add(CheckboxModuleSqlite, "CheckboxModuleSqlite")
Window.WM_MODULES:add(CheckboxModuleWebview, "CheckboxModuleWebview")
Window.WM_MODULES:add(CheckboxModuleSysutils, "CheckboxModuleSysutils")
Window.WM_MODULES:add(CheckboxModuleKeyboard, "CheckboxModuleKeyboard")
Window.WM_MODULES:add(CheckboxModuleSerial, "CheckboxModuleSerial")
Window.WM_MODULES:add(CheckboxModuleC, "CheckboxModuleC")
Window.WM_MODULES:add(CheckboxModuleCpu, "CheckboxModuleCpu")
Window.WM_MODULES:add(CheckboxModulePower, "CheckboxModulePower")
Window.WM_MODULES:add(CheckboxModuleUi, "CheckboxModuleUi")
Window.WM_MODULES:add(CheckboxModuleWifi, "CheckboxModuleWifi")
Window.WM_MODULES:add(CheckboxModuleXml, "CheckboxModuleXml")
Window.WM_MODULES:add(CheckboxModuleYaml, "CheckboxModuleYaml")

--#endregion

--#region MenuManager

Window.MM:add(MenuBurger.items[1], "BurgerSetup")
Window.MM:add(MenuBurger.items[2], "BurgerHelp")
Window.MM:add(MenuBurger.items[3], "BurgerAbout")
Window.MM:add(MenuBurger.items[5], "BurgerExit")

--#endregion

--#region ValidationManager

Window.VM_SAVE:add(EntryProjectName, "text", isRequired, "Please enter a project name.")

Window.VM_GENERATE:add(EntryProjectName, "text", isRequired, "Please enter a project name.")
Window.VM_GENERATE:add(EntryScriptFile, "text", isRequired, "Please enter a script file.")
Window.VM_GENERATE:add(EntryScriptFile, "text", isValidScriptFile, "Please enter a lua or wlua file.")
Window.VM_GENERATE:add(EntryScriptFile, "text", isValidFile, "Please enter a script file that exists.")
Window.VM_GENERATE:add(EntryScriptDirectory, "text", isValidDirectory, "Please enter a script directory that exists.")
Window.VM_GENERATE:add(EntryIconFile, "text", isValidIconFile, "Please enter a ico file.")
Window.VM_GENERATE:add(EntryIconFile, "text", isValidFile, "Please enter a icon file that exists.")
Window.VM_GENERATE:add(EntryOutputFile, "text", isRequired, "Please enter a output file.")
Window.VM_GENERATE:add(EntryOutputFile, "text", isValidOutputFile, "Please enter a exe file.")
Window.VM_GENERATE:add(EntryScriptCompiler, "text", isRequired, "Please enter a script compiler.")
Window.VM_GENERATE:add(EntryScriptCompiler, "text", isValidFile, "Please enter a script compiler that exists.")
Window.VM_GENERATE:add(EntryModuleDirectory, "text", isRequired, "Please enter a module directory.")
Window.VM_GENERATE:add(EntryModuleDirectory, "text", isValidDirectory, "Please enter a module directory that exists.")

--#endregion

--#region DataManager

Window.DM:add(EntryProjectName, "text", "projectname", nil, "")
Window.DM:add(EntryProductName, "text", "productname", nil, "")
Window.DM:add(EntryProductVersion, "text", "productversion", nil, "")
Window.DM:add(EntryFileDescription, "text", "filedescription", nil, "")
Window.DM:add(EntryFileVersion, "text", "fileversion", nil, "")
Window.DM:add(EntryLegalCopyright, "text", "legalcopyright", nil, "")
Window.DM:add(EntryScriptFile, "text", "scriptfile", nil, "")
Window.DM:add(EntryScriptDirectory, "text", "scriptdirectory", nil, "")
Window.DM:add(EntryIconFile, "text", "iconfile", nil, "")
Window.DM:add(EntryOutputFile, "text", "outputfile", nil, "")
Window.DM:add(CheckboxModuleAudio, "checked", "moduleaudio", nil, false)
Window.DM:add(CheckboxModuleCanvas, "checked", "modulecanvas", nil, false)
Window.DM:add(CheckboxModuleCrypto, "checked", "modulecrypto", nil, false)
Window.DM:add(CheckboxModuleIni, "checked", "moduleini", nil, false)
Window.DM:add(CheckboxModuleJson, "checked", "modulejson", nil, false)
Window.DM:add(CheckboxModuleNet, "checked", "modulenet", nil, false)
Window.DM:add(CheckboxModuleSqlite, "checked", "modulesqlite", nil, false)
Window.DM:add(CheckboxModuleWebview, "checked", "modulewebview", nil, false)
Window.DM:add(CheckboxModuleSysutils, "checked", "modulesysutils", nil, false)
Window.DM:add(CheckboxModuleKeyboard, "checked", "modulekeyboard", nil, false)
Window.DM:add(CheckboxModuleSerial, "checked", "moduleserial", nil, false)
Window.DM:add(CheckboxModuleC, "checked", "modulec", nil, false)
Window.DM:add(CheckboxModuleCpu, "checked", "cpu", nil, false)
Window.DM:add(CheckboxModulePower, "checked", "power", nil, false)
Window.DM:add(CheckboxModuleUi, "checked", "ui", nil, false)
Window.DM:add(CheckboxModuleWifi, "checked", "wifi", nil, false)
Window.DM:add(CheckboxModuleXml, "checked", "xml", nil, false)
Window.DM:add(CheckboxModuleYaml, "checked", "yaml", nil, false)
Window.DM:add(EntryScriptCompiler, "text", "scriptcompiler", nil, "C:\\LuaRT\\rtc.exe")
Window.DM:add(EntryModuleDirectory, "text", "moduledirectory", nil, "C:\\LuaRT\\modules")
Window.DM:add(EntryPropertyTool, "text", "propertytool", nil, "C:\\LuaRT\\rcedit.exe")

--#endregion

--#region Properties

Window.GM_PRODUCT_ENTRY:change("fontsize", 10)
Window.GM_FILE_ENTRY:change("fontsize", 10)
Window.GM_SCRIPT_ENTRY:change("fontsize", 10)
Window.GM_TOOLS_ENTRY:change("fontsize", 10)

--#endregion

return Window
