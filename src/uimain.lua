require("common.extension")

local ui = require("ui")
local uiextension = require("modules.uiextension")

local dm = require("managers.dm") -- data manager
local gm = require("managers.gm") -- geometry manager
local km = require("managers.km") -- key manager
local mm = require("managers.mm") -- menu manager
local vm = require("managers.vm") -- validation manager
local wm = require("managers.wm") -- widget manager

--#region Functions

local function isRequired(value)
  value = string.trim(value)
  return not string.isnil(value) and not string.isempty(value)
end

--#endregion

--#region Menu

local MenuBurger = ui.Menu("Setup", "Help", "About", "", "Exit")

--#endregion

--#region Window

local Window     = ui.Window("ecSTEC", "single", 700, 550)
Window.bgcolor   = 0xa3c2c2
Window.menu      = ui.Menu()
Window.menu:add("|||", MenuBurger)

--#endregion

--#region Managers

Window.DM                   = dm.DataManager()
Window.GM_PRODUCT_LABEL     = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 18, 95, 88)
Window.GM_PRODUCT_ENTRY     = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 120, 14, 220, 88)
Window.GM_FILE_LABEL        = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 360, 18, 95, 88)
Window.GM_FILE_ENTRY        = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 465, 14, 220, 88)
Window.GM_SCRIPT_LABEL      = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 136, 95, 116)
Window.GM_SCRIPT_ENTRY      = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 8, 120, 132, 565, 116)
Window.GM_MODULE_LABEL      = gm.GeometryManager():ColumnLayout(Window, gm.DIRECTION.Top, 12, 15, 277, 95, 44)
Window.GM_MODULE_CHECKBOX   = gm.GeometryManager():MatrixLayout(Window, 5, 2, gm.RESIZE.None, 0, 120, 277, 565, 44)
Window.GM_GENERATE_BUTTON   = gm.GeometryManager():SingleLayout(Window, gm.RESIZE.None, 15, 364, 670, 40)
Window.GM_TOOLBAR_BUTTON    = gm.GeometryManager():RowLayout(Window, gm.DIRECTION.left, 10, 15, 446, 670, 34)
Window.KM                   = km.KeyManager()
Window.MM                   = mm.MenuManager()
Window.VM                   = vm.ValidationManager()
Window.WM                   = wm.WidgetManager()
Window.WM_ZERO              = wm.WidgetManager()
Window.WM_MODULES           = wm.WidgetManager()

--#endregion

--#region Widgets

local LabelProjectName      = ui.Label(Window, "Project Name", 0, 0, 999, 20)
local EntryProjectName      = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelProductName      = ui.Label(Window, "Product Name", 0, 0, 999, 20)
local EntryProductName      = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelProductVersion   = ui.Label(Window, "Product Version", 0, 0, 999, 20)
local EntryProductVersion   = ui.Entry(Window, "", 0, 0, 220, 24)

local LabelFileDescription  = ui.Label(Window, "File Description", 0, 0, 999, 20)
local EntryFileDescription  = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelFileVersion      = ui.Label(Window, "File Version", 0, 0, 999, 20)
local EntryFileVersion      = ui.Entry(Window, "", 0, 0, 220, 24)
local LabelLegalCopyright   = ui.Label(Window, "Legal Copyright", 0, 0, 999, 20)
local EntryLegalCopyright   = ui.Entry(Window, "", 0, 0, 220, 24)

local LabelScriptFile       = ui.Label(Window, "Script File", 0, 0, 999, 20)
local EntryScriptFile       = uiextension.FileEntry(Window, "", 0, 0, 999, 24)
local LabelScriptDirectory  = ui.Label(Window, "Script Directory", 0, 0, 999, 20)
local EntryScriptDirectory  = uiextension.DirectoryEntry(Window, "", 0, 0, 999, 24)
local LabelIconFile         = ui.Label(Window, "Icon File", 0, 0, 999, 20)
local EntryIconFile         = uiextension.FileEntry(Window, "", 0, 0, 999, 24)
local LabelOutputFile       = ui.Label(Window, "Output File", 0, 0, 999, 20)
local EntryOutputFile       = uiextension.FileEntry(Window, "", 0, 0, 999, 24)

local LabelEmbededModules   = ui.Label(Window, "Embeded Modules", 0, 0, 999, 40)
local CheckboxModuleAudio   = ui.Checkbox(Window, "audio ", 0, 0, 20, 999)
local CheckboxModuleCanvas  = ui.Checkbox(Window, "canvas ", 0, 0, 20, 999)
local CheckboxModuleCrypto  = ui.Checkbox(Window, "crypto", 0, 0, 20, 999)
local CheckboxModuleIni     = ui.Checkbox(Window, "ini", 0, 0, 20, 999)
local CheckboxModuleJson    = ui.Checkbox(Window, "json", 0, 0, 20, 999)
local CheckboxModuleNet     = ui.Checkbox(Window, "net", 0, 0, 20, 999)
local CheckboxModuleSqlite  = ui.Checkbox(Window, "sqlite", 0, 0, 20, 999)
local CheckboxModuleWebview = ui.Checkbox(Window, "webview ", 0, 0, 20, 999)

local ButtonGenerate        = ui.Button(Window, "Generate", 0, 0, 999, 999)

local ButtonFirst           = ui.Button(Window, "|<", 0, 0, 55, 999)
local ButtonPrevious        = ui.Button(Window, "<", 0, 0, 55, 999)
local ButtonGoto            = ui.Button(Window, "(   )", 0, 0, 70, 999)
local ButtonNext            = ui.Button(Window, ">", 0, 0, 55, 999)
local ButtonLast            = ui.Button(Window, ">|", 0, 0, 55, 999)
local ButtonNew             = ui.Button(Window, "New", 0, 0, 75, 999)
local ButtonSave            = ui.Button(Window, "Save", 0, 0, 75, 999)
local ButtonCancel          = ui.Button(Window, "Cancel", 0, 0, 75, 999)
local ButtonDelete          = ui.Button(Window, "Delete", 0, 0, 75, 999)

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
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleCanvas)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleCrypto)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleIni)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleJson)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleNet)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleSqlite)
Window.GM_MODULE_CHECKBOX:add(CheckboxModuleWebview)

Window.GM_GENERATE_BUTTON:add(ButtonGenerate)

Window.GM_TOOLBAR_BUTTON:add(ButtonFirst)
Window.GM_TOOLBAR_BUTTON:add(ButtonPrevious)
Window.GM_TOOLBAR_BUTTON:add(ButtonGoto)
Window.GM_TOOLBAR_BUTTON:add(ButtonNext)
Window.GM_TOOLBAR_BUTTON:add(ButtonLast)
Window.GM_TOOLBAR_BUTTON:add(ButtonNew)
Window.GM_TOOLBAR_BUTTON:add(ButtonSave)
Window.GM_TOOLBAR_BUTTON:add(ButtonCancel)
Window.GM_TOOLBAR_BUTTON:add(ButtonDelete)

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

Window.WM:add(CheckboxModuleAudio, "CheckboxModuleAudio")
Window.WM:add(CheckboxModuleCanvas, "CheckboxModuleCanvas")
Window.WM:add(CheckboxModuleCrypto, "CheckboxModuleCrypto")
Window.WM:add(CheckboxModuleIni, "CheckboxModuleIni")
Window.WM:add(CheckboxModuleJson, "CheckboxModuleJson")
Window.WM:add(CheckboxModuleNet, "CheckboxModuleNet")
Window.WM:add(CheckboxModuleSqlite, "CheckboxModuleSqlite")
Window.WM:add(CheckboxModuleWebview, "CheckboxModuleWebview")

Window.WM:add(ButtonGenerate, "ButtonGenerate")

Window.WM:add(ButtonFirst, "ButtonFirst")
Window.WM:add(ButtonPrevious, "ButtonPrevious")
Window.WM:add(ButtonGoto, "ButtonGoto")
Window.WM:add(ButtonNext, "ButtonNext")
Window.WM:add(ButtonLast, "ButtonLast")
Window.WM:add(ButtonNew, "ButtonNew")
Window.WM:add(ButtonSave, "ButtonSave")
Window.WM:add(ButtonCancel, "ButtonCancel")
Window.WM:add(ButtonDelete, "ButtonDelete")

Window.WM_ZERO:add(ButtonGenerate, "ButtonGenerate")
Window.WM_ZERO:add(ButtonFirst, "ButtonFirst")
Window.WM_ZERO:add(ButtonPrevious, "ButtonPrevious")
Window.WM_ZERO:add(ButtonGoto, "ButtonGoto")
Window.WM_ZERO:add(ButtonNext, "ButtonNext")
Window.WM_ZERO:add(ButtonLast, "ButtonLast")
Window.WM_ZERO:add(ButtonNew, "ButtonNew")
Window.WM_ZERO:add(ButtonDelete, "ButtonDelete")

Window.WM_MODULES:add(CheckboxModuleAudio, "CheckboxModuleAudio")
Window.WM_MODULES:add(CheckboxModuleCanvas, "CheckboxModuleCanvas")
Window.WM_MODULES:add(CheckboxModuleCrypto, "CheckboxModuleCrypto")
Window.WM_MODULES:add(CheckboxModuleIni, "CheckboxModuleIni")
Window.WM_MODULES:add(CheckboxModuleJson, "CheckboxModuleJson")
Window.WM_MODULES:add(CheckboxModuleNet, "CheckboxModuleNet")
Window.WM_MODULES:add(CheckboxModuleSqlite, "CheckboxModuleSqlite")
Window.WM_MODULES:add(CheckboxModuleWebview, "CheckboxModuleWebview")

--#endregion

--#region MenuManager

Window.MM:add(MenuBurger.items[1], "BurgerSetup")
Window.MM:add(MenuBurger.items[2], "BurgerHelp")
Window.MM:add(MenuBurger.items[3], "BurgerAbout")
Window.MM:add(MenuBurger.items[5], "BurgerExit")

--#endregion

--#region KeyManager

Window.KM:add(ButtonFirst, "VK_HOME")
Window.KM:add(ButtonPrevious, "VK_PRIOR")
Window.KM:add(ButtonGoto, "VK_F2")
Window.KM:add(ButtonNext, "VK_NEXT")
Window.KM:add(ButtonLast, "VK_END")
Window.KM:add(ButtonNew, "VK_F3")
Window.KM:add(ButtonSave, "VK_F4")
Window.KM:add(ButtonCancel, "VK_F5")
Window.KM:add(ButtonDelete, "VK_F6")
Window.KM:add(ButtonGenerate, "VK_F7")

--#endregion

--#region ValidationManager

Window.VM:add(EntryProjectName, "text", isRequired, "Please enter a project name.")
Window.VM:add(EntryScriptFile, "text", isRequired, "Please enter a script file.")
Window.VM:add(EntryOutputFile, "text", isRequired, "Please enter a output file.")

--#endregion

--#region DataManager

Window.DM:add("projectname", EntryProjectName, "text", "")
Window.DM:add("productname", EntryProductName, "text", "")
Window.DM:add("productversion", EntryProductVersion, "text", "")

Window.DM:add("filedescription", EntryFileDescription, "text", "")
Window.DM:add("fileversion", EntryFileVersion, "text", "")
Window.DM:add("legalcopyright", EntryLegalCopyright, "text", "")

Window.DM:add("scriptfile", EntryScriptFile, "text", "")
Window.DM:add("scriptdirectory", EntryScriptDirectory, "text", "")
Window.DM:add("iconfile", EntryIconFile, "text", "")
Window.DM:add("outputfile", EntryOutputFile, "text", "")

Window.DM:add("moduleaudio", CheckboxModuleAudio, "checked", false)
Window.DM:add("modulecanvas", CheckboxModuleCanvas, "checked", false)
Window.DM:add("modulecrypto", CheckboxModuleCrypto, "checked", false)
Window.DM:add("moduleini", CheckboxModuleIni, "checked", false)
Window.DM:add("modulejson", CheckboxModuleJson, "checked", false)
Window.DM:add("modulenet", CheckboxModuleNet, "checked", false)
Window.DM:add("modulesqlite", CheckboxModuleSqlite, "checked", false)
Window.DM:add("modulewebview", CheckboxModuleWebview, "checked", false)

--#endregion

Window.GM_PRODUCT_ENTRY:change("fontsize", 10)
Window.GM_FILE_ENTRY:change("fontsize", 10)
Window.GM_SCRIPT_ENTRY:change("fontsize", 10)

ButtonSave.tooltip = "F4"

return Window
