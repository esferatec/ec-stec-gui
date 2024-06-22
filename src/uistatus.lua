require("common.extension")
local ui          = require("ui")

local gm          = require("managers.gm") -- geometry manager
local wm          = require("managers.wm") -- widget manager

local fct         = require("resources.fct")

--#region Dialog

local Dialog      = ui.Window("ecSTEC - Status", "raw", 680, 480)

--#endregion

--#region Managers

Dialog.GM         = gm.GeometryManager():ColumnLayout(Dialog, gm.DIRECTION.top, 40, 0, 0, 680, 480)
Dialog.WM         = wm.WidgetManager()

--#endregion

--#region Widgets

local LabelStatus = ui.Label(Dialog, "", nil, nil, gm.MAXIMUM.Width, 365)
local ButtonClose = ui.Button(Dialog, "Close", nil, nil, gm.MAXIMUM.Width, 40)

--#endregion

--#region GeometryManager

Dialog.GM:add(LabelStatus)
Dialog.GM:add(ButtonClose)

--#endregion

--#region WidgetManager

Dialog.WM:add(LabelStatus, "LabelStatus")
Dialog.WM:add(ButtonClose, "ButtonClose")

--#endregion

--#region Functions

local function compileScript(iconfile, embededmodules, outputfile, scriptdirectory, scriptfile)
  local task = sys.Task(fct.compileScript)
  if await(task, iconfile, embededmodules, outputfile, scriptdirectory, scriptfile) then
    return "\t\t done"
  else
    return "\t\t error"
  end
end

local function setProductName(file, productname)
  local task = sys.Task(fct.setProductName)
  if await(task, file, productname) then
    return "\t\t done"
  else
    return "\t\t error"
  end
end

local function setProductVersion(file, productversion)
  local task = sys.Task(fct.setProductVersion)
  if await(task, file, productversion) then
    return "\t\t done"
  else
    return "\t\t error"
  end
end

local function setFileDescription(file, filedescription)
  local task = sys.Task(fct.setFileDescription)
  if await(task, file, filedescription) then
    return "\t\t done"
  else
    return "\t\t error"
  end
end

local function setFileVersion(file, fileversion)
  task = sys.Task(fct.setFileVersion)
  if await(task, file, fileversion) then
    return "\t\t done"
  else
    return "\t\t error"
  end
end

local function setLegalCopyright(file, legalcopyright)
  local task = sys.Task(fct.setLegalCopyright)
  if await(task, file, legalcopyright) then
    return "\t done"
  else
    return "\t error"
  end
end

--#region Events

function ButtonClose:onClick()
  Dialog:hide()
end

function Dialog:onCreate()
  Dialog.GM:apply()
end

function Dialog:onShow()
  Dialog.title = Dialog.parent.title
  Dialog.fgcolor = Dialog.parent.fgcolor
  Dialog.bgcolor = Dialog.parent.bgcolor

  Dialog.x = Dialog.parent.x + 15
  Dialog.y = Dialog.parent.y + 60

  LabelStatus.text = ""
  LabelStatus.fontsize = 12
  LabelStatus.fontstyle.bold = true

  ButtonClose.visible = false
  LabelStatus.text = LabelStatus.text .. "\n\n\t start ..."

  LabelStatus.text = LabelStatus.text .. "\n\n\t compile script"
  LabelStatus.text = LabelStatus.text .. compileScript()

  LabelStatus.text = LabelStatus.text .. "\n\n\t set product name"
  LabelStatus.text = LabelStatus.text .. setProductName(self.outputfile, self.productname)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set product version"
  LabelStatus.text = LabelStatus.text .. setProductVersion(self.outputfile, self.productversion)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set file description"
  LabelStatus.text = LabelStatus.text .. setFileDescription(self.outputfile, self.filedescription)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set file version"
  LabelStatus.text = LabelStatus.text .. setFileVersion(self.outputfile, self.fileversion)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set legal copyright"
  LabelStatus.text = LabelStatus.text .. setLegalCopyright(self.outputfile, self.legalcopyright)

  LabelStatus.text = LabelStatus.text .. "\n\n\t ... end"
  ButtonClose.visible = true
end

--#endregion

return Dialog
