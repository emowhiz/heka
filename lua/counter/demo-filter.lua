require "string"
require "os"

local message = {
    Payload = nil,
    Fields = {
        type = "event_aggregated",
    }
}

function process_message()

    message.Fields = {
            type = "event_aggregated",
        }


    if read_message("Fields[customer-id]") == "CUS_00001" then
        message.Fields["consumer"] = read_message("Fields[customer-id]")
        message.Fields["timestamp"] = read_message("Fields[timestamp]")
        message.Fields["telephone"] = read_message("Fields[telephone]")

        message.Fields.type = "events"
        if not pcall(inject_message, message) then return -1 end


    elseif read_message("Fields[customer-id]") == "CUS_00002" then

        message.Fields["consumer"] = read_message("Fields[customer-id]")
        message.Fields["timestamp"] = read_message("Fields[timestamp]")
        message.Fields["telephone"] = read_message("Fields[telephone]")

        message.Fields.type = "events"
        if not pcall(inject_message, message) then return -1 end
    end

    return 0
end






