require("common.extension")

local ui          = require("ui")

local gm          = require("managers.gm") -- geometry manager
local wm          = require("managers.wm") -- widget manager

local fct         = require("resources.fct")

--#region Constants

local DONE        = "\t\t done"
local ERROR       = "\t\t error"
local SKIPPED     = "\t\t skipped"

--#endregion

--#region Dialog

local Dialog      = ui.Window("ecSTEC - Status", "raw", 680, 550)

--#endregion

--#region Managers

Dialog.GM         = gm.GeometryManager():ColumnLayout(Dialog, gm.DIRECTION.Top, 40, 0, 0, 680, 480)
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

local function compileScript(compiler, iconfile, embededmodules, outputfile, scriptdirectory, scriptfile, moduledirectory)
  if fct.compilescript(compiler, iconfile, embededmodules, outputfile, scriptdirectory, scriptfile, moduledirectory) then
    return DONE
  else
    return ERROR
  end
end

local function setProductName(tool, file, productname)
  if string.isempty(productname) then
    return SKIPPED
  end
  if fct.setproductname(tool, file, productname) then
    return DONE
  else
    return ERROR
  end
end

local function setProductVersion(tool, file, productversion)
  if string.isempty(productversion) then
    return SKIPPED
  end
  if fct.setproductversion(tool, file, productversion) then
    return DONE
  else
    return ERROR
  end
end

local function setFileDescription(tool, file, filedescription)
  if string.isempty(filedescription) then
    return SKIPPED
  end
  if fct.setfiledescription(tool, file, filedescription) then
    return DONE
  else
    return ERROR
  end
end

local function setFileVersion(tool, file, fileversion)
  if string.isempty(fileversion) then
    return SKIPPED
  end
  if fct.setfileversion(tool, file, fileversion) then
    return DONE
  else
    return ERROR
  end
end

local function setLegalCopyright(tool, file, legalcopyright)
  if string.isempty(legalcopyright) then
    return SKIPPED
  end
  if fct.setlegalcopyright(tool, file, legalcopyright) then
    return DONE
  else
    return ERROR
  end
end

--#endregion

--#region Events

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

  LabelStatus.text = LabelStatus.text .. "\n\n\t compile script \t"
  LabelStatus.text = LabelStatus.text ..
      compileScript(self.scriptcompiler, self.iconfile, self.embededmodules, self.outputfile, self.scriptdirectory, self.scriptfile, self.moduledirectory)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set product name \t"
  LabelStatus.text = LabelStatus.text .. setProductName(self.propertytool, self.outputfile, self.productname)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set product version "
  LabelStatus.text = LabelStatus.text .. setProductVersion(self.propertytool, self.outputfile, self.productversion)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set file description "
  LabelStatus.text = LabelStatus.text .. setFileDescription(self.propertytool, self.outputfile, self.filedescription)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set file version \t"
  LabelStatus.text = LabelStatus.text .. setFileVersion(self.propertytool, self.outputfile, self.fileversion)

  LabelStatus.text = LabelStatus.text .. "\n\n\t set legal copyright "
  LabelStatus.text = LabelStatus.text .. setLegalCopyright(self.propertytool, self.outputfile, self.legalcopyright)

  LabelStatus.text = LabelStatus.text .. "\n\n\t ... end"

  ButtonClose.visible = true
end

function ButtonClose:onClick()
  Dialog:hide()
end

--#endregion

return Dialog
