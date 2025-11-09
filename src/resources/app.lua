local sys = require("sys")

local app = {}

app.NAME = "ecSTECGUI"
app.VERSION = "0.2.0"
app.WEBSITE = "https://github.com/esferatec/ec-stec-gui"
app.COPYRIGHT = "(c) 2025"
app.DEVELOPER = "esferatec"

app.ARGUMENT = arg[1]

app.FILE = {
  path = sys.File(arg[0] or arg[-1]).path,
  name = sys.File(arg[0] or arg[-1]).name,
  fullpath = sys.File(arg[0] or arg[-1]).fullpath,
  type = ".ecstec",
  default = "noname.ecstec"
}

app.TITLE = {
  about = app.NAME .. " - About",
  confirmation = app.NAME .. " - Confirmation",
  error = app.NAME .. " - Error",
  information = app.NAME .. "- Information ",
  setup = app.NAME .. " - Setup",
  select = app.NAME .. " - Select",
  warning = app.NAME .. " - Warning",
}

return app
