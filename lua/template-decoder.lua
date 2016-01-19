require "string"
require "os"
local json = require "cjson"
local flush_timer = require "flush_timer"

initial = 0
json_template_sdp = ""
json_template_cms = ""
template_values_sdp = {}
template_values_cms = {}

local function format_cdr(cdr)
    local newtempcdr = string.gsub(cdr, "||", "|N/A|")
    local newcdr = string.gsub(newtempcdr, "||", "|N/A|")
    return newcdr
end

local function decode_template_sdp(tab)
    for i, value in ipairs(tab) do
        template_values_sdp[value["name"]] = value["position"]
    end
end

local function initialize_sdp(template)
    json_template_sdp = template
    local temp_json = json.decode(template)
    decode_template_sdp(temp_json["parameters"])
end

function process_message()
    local message = {
        Timestamp = nil,
        Logger = "event_decoded",
        Type = read_config("type"),
        Payload = nil,
        Fields = {}
    }

    local log_type = read_message("Logger")

    if initial == 0 then
        initialize_sdp(read_config("sdp"))
        initial = 1
    end

    local raw_message = read_message("Payload")

    local i = 1
    local message_sections = {}

    local formatted_message = format_cdr(raw_message)

    for token in string.gmatch(formatted_message, "[^|]+") do
        message_sections[i] = token
        i = i + 1
    end


    if log_type == "demo_log" then
        for key, value in pairs(template_values_sdp) do
            message.Fields[key] = message_sections[value]
        end
        message.Fields.type = "event_decoded"
    end

    if not pcall(inject_message, message) then return -1 end

    return 0
end







