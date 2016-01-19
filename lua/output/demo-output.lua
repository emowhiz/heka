local os = require "os"
local io = require "io"
local logs = require "file"
local table = require "table"
local json = require "cjson"

local buffer_file = "/hms/data/crm-etl/events-buffer.log"

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local function create_buffer(buffer_file)
    if not file_exists(buffer_file) then
        local f = io.open(buffer_file, "a+")
        if f then
            f:close()
        else
            return false
        end
    end
    return true
end

assert(create_buffer(buffer_file))

function process_message()

    local id = {}
    local event = {}

    id["consumer"] = read_message("Fields[consumer]")

    if read_message("Fields[consumer]") == "CUS_00001" then
        event["date"] = read_message("Fields[timestamp]")
        event["telephone"] = read_message("Fields[telephone]")
    elseif read_message("Fields[consumer]") == "CUS_00002"  then
        event["date"] = read_message("Fields[timestamp]")
        event["telephone"] = read_message("Fields[telephone]")
    end

    local serializedString = json.encode({ _id = id, event = event })

    local outputbatch = serializedString .. "\n"
    local backup_file, e = io.open(buffer_file, "a+")
    backup_file:write(outputbatch)
    backup_file:close()

    return 0
end