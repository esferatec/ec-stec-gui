local ui = require("ui")

-- Provides common dialog ui functions.
local uidialogs = {}

uidialogs.cancelcaption = "Cancel"
uidialogs.confirmcaption = "OK"

--#region dialog

-- Creates a new dialog object.
local Dialog = Object(ui.Window)

-- Overrides the default window constructor.
function Dialog:constructor(parent, title, width, height)
  super(self).constructor(self, parent, title or parent.title, "fixed", width, height)

  local buttonCancel = ui.Button(self, uidialogs.cancelcaption)
  buttonCancel.width = 100
  buttonCancel.x = (self.width - 110)
  buttonCancel.y = (self.height - buttonCancel.height - 10)

  local buttonConfirm = ui.Button(self, uidialogs.confirmcaption)
  buttonConfirm.width = 100
  buttonConfirm.x = (self.width - buttonCancel.width - buttonConfirm.width - 20)
  buttonConfirm.y = buttonCancel.y

  local isConfirmed = false

  function buttonCancel:onClick()
    isConfirmed = false
    self.parent:hide()
  end

  function buttonConfirm:onClick()
    isConfirmed = true
    self.parent:hide()
  end

  function self:isconfirmed()
    return isConfirmed
  end
end

--#endregion

--#region textentrydialog

--Displays a dialog that requests a text input (single line) from the user.
function uidialogs.textentrydialog(parent, title, message, text, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 300, height or 125)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local entryValue = ui.Entry(windowDialog, text or "", 10, 50, (windowDialog.width - 20))

  parent:showmodal(windowDialog)
  windowDialog:center()
  entryValue:show()
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = #entryValue.text > 0 and tostring(entryValue.text) or nil
  else
    result = nil
  end

  return result
end

--#endregion

--#region numberentrydialog

-- Displays a dialog that requests a number input from the user.
function uidialogs.numberentrydialog(parent, title, message, value, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 300, height or 125)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local entryValue = ui.Entry(windowDialog, tostring(value) or "", 10, 50, (windowDialog.width - 20))

  function entryValue:onChange()
    if #self.text > 0 and tonumber(self.text) == nil then
      self.text = string.gsub(self.text, "%D", "")
    end
  end

  parent:showmodal(windowDialog)
  windowDialog:center()
  entryValue:show()
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = #entryValue.text > 0 and tostring(entryValue.text) or nil
  else
    result = nil
  end

  return result
end

--#endregion

--#region passwordentrydialog

-- Displays a dialog that requests a password input from the user.
function uidialogs.passwordentrydialog(parent, title, message, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 300, height or 125)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local entryValue = ui.Entry(windowDialog, "", 10, 50, (windowDialog.width - 20))
  entryValue.masked = true

  parent:showmodal(windowDialog)
  windowDialog:center()
  entryValue:show()
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = #entryValue.text > 0 and tostring(entryValue.text) or nil
  else
    result = nil
  end

  return result
end

--#endregion

--#region choicetextdialog

-- Displays a dialog that shows a list of choices, and allows the user to select one.
function uidialogs.choicetextdialog(parent, title, message, choices, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 300, height or 200)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local listChoices = ui.List(windowDialog, choices, 10, 50, (windowDialog.width - 20), (windowDialog.height - 40 - 60))

  parent:showmodal(windowDialog)
  windowDialog:center()
  listChoices.selected = listChoices.items[1]
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = listChoices.selected and listChoices.selected.text or nil
  else
    result = nil
  end

  return result
end

--#endregion

--#region choiceindexdialog

-- Displays a dialog that shows a list of choices, and allows the user to select one.
function uidialogs.choiceindexdialog(parent, title, message, choices, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 300, height or 200)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local listChoices = ui.List(windowDialog, choices, 10, 50, (windowDialog.width - 20), (windowDialog.height - 40 - 60))

  parent:showmodal(windowDialog)
  windowDialog:center()
  listChoices.selected = listChoices.items[1]
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = listChoices.selected and listChoices.selected.index or nil
  else
    result = nil
  end

  return result
end

--#endregion

--#region texteditdialog

-- Displays a dialog that requests a text input (multiple lines) from the user.
function uidialogs.texteditdialog(parent, title, message, text, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 300, height or 200)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local editValue = ui.Edit(windowDialog, "", 10, 50, (windowDialog.width - 20), (windowDialog.height - 40 - 60))
  editValue.wordwrap = true
  editValue.rtf = false
  editValue:append(text or "")

  parent:showmodal(windowDialog)
  windowDialog:center()
  editValue:show()
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = #editValue.text > 0 and tostring(editValue.text) or nil
  else
    result = nil
  end

  return result
end

--#endregion

--#region calenderdialog

-- Displays a dialog that shows a month calendar to choose a date.
function uidialogs.calendardialog(parent, title, message, select, width, height)
  local result = nil

  local windowDialog = Dialog(parent, title, width or 246, height or 260)
  local labelMessage = ui.Label(windowDialog, message, 10, 10, (windowDialog.width - 20), 30)
  labelMessage.textalign = "center"
  local calendarMonth = ui.Calendar(windowDialog, 10, 50, (windowDialog.width - 20), (windowDialog.height - 40 - 60))

  parent:showmodal(windowDialog)
  windowDialog:center()
  if select then
    calendarMonth.selected = select
  end
  ui.run(windowDialog):wait()

  if windowDialog:isconfirmed() then
    result = calendarMonth.selected
  else
    result = nil
  end

  return result
end

--#endregion

return uidialogs
