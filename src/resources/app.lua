local sys = require("sys")

local app = {}

app.NAME = "ecSTEC"
app.VERSION = "0.1.0"
app.WEBSITE = "https://github.com/esferatec/ec-stec-gui"
app.COPYRIGHT = "(c) 2024"
app.DEVELOPER = "esferatec"

app.ARGUMENT = arg[1]

app.FILE = {
  path = sys.File(arg[0] or arg[-1]).path,
  name = sys.File(arg[0] or arg[-1]).name
}

app.DATABASE = {
  fullpath = ":memory:",
  type = ".ecstec"
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
