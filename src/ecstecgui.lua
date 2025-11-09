require("common.extension")

local sys          = require("sys")
local sysextension = require("modules.sysextension")
local ui           = require("ui")
local uidialogs    = require("modules.uidialogs")
local json         = require("json")

local app          = require("resources.app")

--#region win initialization

local win          = require("uimain")
win:center()
win:status()

--#endregion

--#region local functions

local function getListEmbededModules()
  local result = {}
  for box in each(win.WM_MODULES.children) do
    if box.checked == true then
      table.insert(result, box.text)
    end
  end

  return table.concat(result, " -l")
end

--#endregion

--#region window methods

function win:updatetitle()
  self.title = app.NAME .. " - " .. app.VERSION
end

function win:updatestatus()
  self:status(app.FILE.fullpath)
end

--#endregion

--#region menu events

function win.MM.children.BurgerSetup:onClick()
  local succeeded, message = nil, nil

  local options = {
    "create startmenu shortcut",
    "create desktop shortcut",
    "create file type association",
    "delete startmenu shortcut",
    "delete desktop shortcut",
    "delete file type association" }

  local index = uidialogs.choiceindexdialog(win, app.TITLE.setup, "Please select an option below:", options, nil,
    250)

  if index == 1 then
    succeeded, message = pcall(sysextension.shortcut.create, sysextension.specialfolders.startmenu, app.NAME,
      app.FILE.path)
  end

  if index == 2 then
    succeeded, message = pcall(sysextension.shortcut.create, sysextension.specialfolders.desktop, app.NAME, app.FILE
      .path)
  end

  if index == 3 then
    succeeded, message = pcall(sysextension.filetype.add, app.FILE.path, app.NAME)
  end

  if index == 4 then
    succeeded, message = pcall(sysextension.shortcut.delete, sysextension.specialfolders.startmenu, app.NAME)
  end

  if index == 5 then
    succeeded, message = pcall(sysextension.shortcut.delete, sysextension.specialfolders.desktop, app.NAME)
  end

  if index == 6 then
    succeeded, message = pcall(sysextension.filetype.remove, app.NAME)
  end

  if index ~= nil and not succeeded then
    ui.info(message, app.TITLE.information)
  end
end

function win.MM.children.BurgerHelp:onClick()
  sys.cmd("start " .. app.WEBSITE, true, true)
end

function win.MM.children.BurgerAbout:onClick()
  local message = app.NAME .. " " .. app.VERSION .. "\n\n"
  message = message .. app.DEVELOPER .. " " .. app.COPYRIGHT .. "\n\n"
  ui.info(message, app.TITLE.about)
end

function win.MM.children.BurgerExit:onClick()
  win:hide()
end

--#endregion

--#region button events

function win.WM.children.ButtonSave:onClick()
  win.VM_SAVE:validate()

  if not win.VM_SAVE.isvalid then
    local message = ""

    for _, text in ipairs(win.VM_SAVE.message) do
      message = message .. text .. "\n"
    end

    ui.warn(message, app.TITLE.warning)
    return
  end

  local selected = ui.savedialog("Create ecSTEC File", false, "ecstec file (*.ecstec)|*.ecstec")

  if not selected then
    return
  end

  if selected.exists then
    if ui.confirm("This file already exists. Would you like to override the file?", app.TITLE.confirmation) ~= "yes" then
      return
    end
  end

  win.DM:save()

  local saved, retval = pcall(json.save, selected.fullpath, win.DM.source)

  if not saved then
    ui.error(retval, app.TITLE.error)
    return
  end

  app.FILE.fullpath = selected.fullpath
  win:updatestatus()
end

function win.WM.children.ButtonGenerate:onClick()
  win.VM_GENERATE:validate()

  if not win.VM_GENERATE.isvalid then
    local message = ""

    for _, text in ipairs(win.VM_GENERATE.message) do
      message = message .. text .. "\n"
    end

    ui.warn(message, app.TITLE.warning)
    return
  end

  local dlg_status = require("uistatus")
  dlg_status.parent = win

  dlg_status.scriptfile = win.WM.children.EntryScriptFile.text
  dlg_status.scriptdirectory = win.WM.children.EntryScriptDirectory.text
  dlg_status.iconfile = win.WM.children.EntryIconFile.text
  dlg_status.outputfile = win.WM.children.EntryOutputFile.text

  dlg_status.embededmodules = getListEmbededModules()

  dlg_status.productname = win.WM.children.EntryProductName.text
  dlg_status.productversion = win.WM.children.EntryProductVersion.text
  dlg_status.filedescription = win.WM.children.EntryFileDescription.text
  dlg_status.fileversion = win.WM.children.EntryFileVersion.text
  dlg_status.legalcopyright = win.WM.children.EntryLegalCopyright.text

  dlg_status.scriptcompiler = win.WM.children.EntryScriptCompiler.text
  dlg_status.moduledirectory = win.WM.children.EntryModuleDirectory.text
  dlg_status.propertytool = win.WM.children.EntryPropertyTool.text

  win:showmodal(dlg_status)
end

--#endregion

--#region window events

function win:onCreate()
  win.GM_PRODUCT_LABEL:apply()
  win.GM_PRODUCT_ENTRY:apply()
  win.GM_FILE_LABEL:apply()
  win.GM_FILE_ENTRY:apply()
  win.GM_SCRIPT_LABEL:apply()
  win.GM_SCRIPT_ENTRY:apply()
  win.GM_MODULE_LABEL:apply()
  win.GM_MODULE_CHECKBOX:apply()
  win.GM_TOOLBAR_BUTTON:apply()
  win.GM_TOOLS_LABEL:apply()
  win.GM_TOOLS_ENTRY:apply()
end

function win:onShow()
  if app.ARGUMENT == nil then
    win.DM.source = {}
    win.DM:default()
    app.FILE.fullpath = app.FILE.path .. app.FILE.default
  end

  if app.ARGUMENT ~= nil then
    if not string.find(app.ARGUMENT, app.FILE.type) then
      ui.error("This file type is not supported.", app.TITLE.error)
      sys.exit()
    end

    local loaded, retval = pcall(json.load, app.ARGUMENT)

    if not loaded then
      ui.error(retval, app.TITLE.error)
      sys.exit()
    end

    win.DM.source = retval
    win.DM:load()
    app.FILE.fullpath = app.ARGUMENT
  end

  win:updatetitle()
  win:updatestatus()
end

--#endregion

ui.run(win):wait()
