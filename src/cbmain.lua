require("common.extension")

local sys          = require("sys")
local sysextension = require("modules.sysextension")
local ui           = require("ui")
local uidialogs    = require("modules.uidialogs")

local app          = require("resources.app")

--#region win initialization

local win          = require("uimain")
win:center()
win:status()

--#endregion

--#region db initialization

local db = require("dbmain")
db:create()

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
  self.title = app.NAME .. " - " .. app.DATABASE.fullpath
end

function win:updatestatus()
  self:status(" ")

  if db.record ~= nil then
    local text = string.format("  project %d of %d", db.record, db.total)
    self:status(text)
  end
end

function win:updatewidget()
  if db.record == nil then
    win.WM_ZERO:disable()
  else
    win.WM_ZERO:enable()
  end

  win.WM:focus(win.WM.children.EntryProjectName)
end

function win:updatedata()
  if db.total == 0 or db.record == nil then
    db.record = nil
    win.DM:apply()
    return
  end

  if db.total ~= 0 and db.record ~= nil then
    win.DM:select(db.record - 1)
    return
  end
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

function win.WM.children.ButtonFirst:onClick()
  if db.record == nil then return end

  db.record = 1

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonPrevious:onClick()
  if db.record == nil then return end
  if db.record <= 1 then return end

  db.record = db.record - 1

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonGoto:onClick()
  if db.record == nil then return end

  local items = db:list()

  local index = uidialogs.choiceindexdialog(win, app.TITLE.select, "Please select an option below:", items, nil, 400)

  if index ~= nil then
    db.record = index

    win:updatedata()
    win:updatestatus()
  end
end

function win.WM.children.ButtonNext:onClick()
  if db.record == nil then return end
  if db.record >= db.total then return end

  db.record = db.record + 1

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonLast:onClick()
  if db.record == nil then return end

  db.record = db.total

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonNew:onClick()
  if db.record == nil then return end

  db.record = nil

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonSave:onClick()
  win.VM:apply()

  if not win.VM.isvalid then
    local message = ""

    for _, text in ipairs(win.VM.message) do
      message = message .. text .. "\n"
    end

    ui.warn(message, app.TITLE.warning)
    return
  end

  if win.DM.key == -1 then
    win.DM:insert()

    db.total = db:count()
    db.record = (db.total ~= 0 and db.total) or nil
  else
    win.DM:update()
  end

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonCancel:onClick()
  if win.DM.key == -1 then
    db.record = 1
  end

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonDelete:onClick()
  if db.record == nil then return end

  win.DM:delete()

  db.total = db:count()
  db.record = (db.total ~= 0 and 1) or nil

  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win.WM.children.ButtonGenerate:onClick()
  if db.record == nil then return end

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
  win.GM_GENERATE_BUTTON:apply()
  win.GM_TOOLBAR_BUTTON:apply()
end

function win:onShow()
  win.DM.database = db
  win.DM.datatable = db.table

  db.total = db:count()
  db.record = (db.total ~= 0 and 1) or nil

  win:updatetitle()
  win:updatedata()
  win:updatewidget()
  win:updatestatus()
end

function win:onKey(key)
  win.KM:apply(key)
end

--#endregion

ui.run(win):wait()
