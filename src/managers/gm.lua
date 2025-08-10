local AbsoluteLayout = require("managers.layouts.absolutelayout")
local BottomLayout = require("managers.layouts.bottomlayout")
local ColumnLayout = require("managers.layouts.columnlayout")
local LeftLayout = require("managers.layouts.leftlayout")
local MatrixLayout = require("managers.layouts.matrixlayout")
local PackLayout = require("managers.layouts.packlayout")
local RelativeLayout = require("managers.layouts.relativelayout")
local RightLayout = require("managers.layouts.rightlayout")
local RowLayout = require("managers.layouts.rowlayout")
local SingleLayout = require("managers.layouts.singlelayout")
local TopLayout = require("managers.layouts.toplayout")

-- Defines a geometry management module.
local gm = {} -- version 2025.04

-- Defines specific constants.
gm.RESIZE = { X = 1, Y = 2, Both = 3, None = 4 }
gm.DIRECTION = { Left = 1, Right = 2, Top = 1, Bottom = 2 }
gm.ALIGNMENT = { Top = 1, Bottom = 2, Center = 3, Left = 1, Right = 2, Stretch = 4 }
gm.ANCHOR = { TopLeft = 1, TopRight = 2, BottomLeft = 3, BottomRight = 4, Center = 5 }
gm.MAXIMUM = { Width = 99999, Height = 99999 }

-- Defines the geometry manager object.
local GeometryManager = Object({})

-- Initializes a new absolute layout instance.
-- AbsoluteLayout(parent: object) -> object
function GeometryManager:AbsoluteLayout(parent)
    return AbsoluteLayout(parent)
end

-- Initializes a new bottom layout instance.
-- BottomLayout(parent: object, direction?[Left, Right]: number, gap?: number, margin?{left, right, top, bottom}: table, height?: number) -> object
function GeometryManager:BottomLayout(parent, direction, gap, margin, height)
    return BottomLayout(parent, direction, gap, margin, height)
end

-- Initializes a new column layout instance.
-- ColumnLayout(parent: object, direction?[Top, Bottom]: number, gap?: number, positionx?: number, positiony?: number, width?: number, height?: number) -> object
function GeometryManager:ColumnLayout(parent, direction, gap, positionx, positiony, width, heigth)
    return ColumnLayout(parent, direction, gap, positionx, positiony, width, heigth)
end

-- Initializes a new left layout instance.
-- LeftLayout(parent: object, direction?[Top, Bottom]: number, gap?: number, margin?{left, right, top, bottom}: table, width?: number) -> object
function GeometryManager:LeftLayout(parent, direction, gap, margin, width)
    return LeftLayout(parent, direction, gap, margin, width)
end

-- Initializes a new matrix layout instance.
-- MatrixLayout(parent: object, columns?: number, rows?: number, require?[X, Y, Both, None]: number, gab?: number, positionx?: number, positiony?: number, width?: number, height?: number) -> object
function GeometryManager:MatrixLayout(parent, columns, rows, resize, gap, positionx, positiony, width, height)
    return MatrixLayout(parent, columns, rows, resize, gap, positionx, positiony, width, height)
end

-- Initializes a new pack layout instance.
-- PackLayout(parent: object, resize?: boolean, positionx?: number, positiony?: number, width?: number, height?: number) -> object
function GeometryManager:PackLayout(parent, resize, positionx, positiony, width, height)
    return PackLayout(parent, resize, positionx, positiony, width, height)
end

-- Initializes a new relative layout instance.
-- RelativeLayout(parent: object) -> object
function GeometryManager:RelativeLayout(parent)
    return RelativeLayout(parent)
end

-- Initializes a new right layout instance.
-- RightLayout(parent: object, direction?[Top, Bottom]: number, gap?: number, margin?{left, right, top, bottom}: table, width?: number) -> object
function GeometryManager:RightLayout(parent, direction, gap, margin, width)
    return RightLayout(parent, direction, gap, margin, width)
end

-- Initializes a new row layot instance.
-- RowLayout(parent: object, direction?[Left, Right]: number, gap?: number, positionx?: number, positiony?: number, width?: number, heigth?: number) -> object
function GeometryManager:RowLayout(parent, direction, gap, positionx, positiony, width, heigth)
    return RowLayout(parent, direction, gap, positionx, positiony, width, heigth)
end

-- Initializes a new single layout instance.
-- SingleLayout(parent: object, resize?[X, Y, Both, None]: number, positionx?: number, positiony?: number, width?: number, height?: number) -> object
function GeometryManager:SingleLayout(parent, resize, positionx, positiony, width, height)
    return SingleLayout(parent, resize, positionx, positiony, width, height)
end

-- Initializes a new top layout instance.
-- TopLayout(parent: object, direction?[Left, Right]: number, gap?: number, margin?{left, right, top, bottom}: table, height?: number) -> object
function GeometryManager:TopLayout(parent, direction, gap, margin, height)
    return TopLayout(parent, direction, gap, margin, height)
end

-- Initializes a new geometry manager instance.
-- GeometryManager() -> object
function gm.GeometryManager()
    return GeometryManager()
end

return gm
