local sqlite = require("sqlite")
local sys    = require("sys")
local ui     = require("ui")

local app    = require("resources.app")

if app.ARGUMENT == nil then
  local selected = ui.savedialog("Create ecSTEC Database", false, "ecstec database (*.ecstec)|*.ecstec")

  if not selected then
    sys.exit()
  end

  if selected.exists then
    ui.warn("This database already exists.", app.TITLE.warning)
    sys.exit()
  end

  local database = sqlite.Database(selected)
  app.ARGUMENT = database.file.fullpath
  sqlite.Database.close(database)
end

if app.ARGUMENT ~= nil then
  if not string.find(app.ARGUMENT, app.DATABASE.type) then
    ui.error("This database type is not supported.", app.TITLE.error)
    sys.exit()
  end

  app.DATABASE.fullpath = app.ARGUMENT
end

dofile(embed and embed.File("cbmain.lua").fullpath or "cbmain.lua")

if sys.error then
  ui.error(sys.error, app.TITLE.error)
end

sys.exit()
