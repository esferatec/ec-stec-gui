local sqlite = require("sqlite")

local app = require("resources.app")

local Project = sqlite.Database(app.DATABASE.fullpath)

Project.table = "tbl_project"
Project.record = nil
Project.total = 0

function Project:create()
  self:exec([[CREATE TABLE IF NOT EXISTS "tbl_project" (
    "id" INTEGER NOT NULL,
    "projectname" TEXT NOT NULL,
    "productname" TEXT,
    "productversion" TEXT,
    "filedescription" TEXT,
    "fileversion" TEXT,
    "legalcopyright" TEXT,
    "scriptfile" TEXT,
    "scriptdirectory" TEXT,
    "iconfile" TEXT,
    "outputfile" TEXT,
    "moduleaudio" TEXT,
    "modulecanvas" TEXT,
    "modulecrypto" TEXT,
    "moduleini" TEXT,
    "modulejson" TEXT,
    "modulenet" TEXT,
    "modulesqlite" TEXT,
    "modulewebview" TEXT,
    "modulesysutils" TEXT,
    "modulekeyboard" TEXT,
    "moduleserial" TEXT,
    "modulec" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
  );]])
end

function Project:count()
  local statment = string.format("SELECT COUNT(*) as count FROM %s;", self.table)
  local result = self:exec(statment)
  return result["count"]
end

function Project:list()
  local result = {}
  local statment = string.format("SELECT projectname as name FROM %s;", self.table)

  for project in self:query(statment) do
    table.insert(result, project.name)
  end

  return result
end

return Project
