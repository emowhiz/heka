require "string"
require "os"

SECONDS_PER_HOUR = 3600
seconds_count_previous = 0
seconds_count_previous_cur = 0
seconds_count_previous_prov = 0
seconds_count_previous_sdp = 0
seconds_count_previous_soltura = 0
--
local M = {}



local function time_in_seconds2(time)
    local curr_year, curr_month, curr_date, curr_hour, curr_minute, curr_second = time:match("([^-]+).([^-]+).([^ ]+).([^:]+).([^:]+).([^ ]+)")
    local milis = os.time { year = curr_year, month = curr_month, day = curr_date, hour = curr_hour }
    return milis
end

function M:time_in_seconds(time)
    local milis = time_in_seconds2(time)
    return milis
end

function M:activate_daily_logging(time)
    if seconds_count_previous == 0 then
        seconds_count_previous = time_in_seconds2(time)
    end

    local seconds_count_now = time_in_seconds2(time)
    local time_diff = os.difftime(seconds_count_now, seconds_count_previous)

    if time_diff > SECONDS_PER_HOUR - 1 then
        seconds_count_pre = seconds_count_previous
        seconds_count_previous = seconds_count_now
        return {1,seconds_count_pre}
    end
    return {0,0}
end


function M:activate_daily_logging_cur(time)
    if seconds_count_previous_cur == 0 then
        seconds_count_previous_cur = time_in_seconds2(time)
    end

    local seconds_count_now = time_in_seconds2(time)
    local time_diff = os.difftime(seconds_count_now, seconds_count_previous_cur)

    if time_diff > SECONDS_PER_HOUR - 1 then
        seconds_count_pre_cur = seconds_count_previous_cur
        seconds_count_previous_cur = seconds_count_now
        return {1,seconds_count_pre_cur}
    end
    return {0,0}
end


function M:activate_daily_logging_prov(time)
    if seconds_count_previous_prov == 0 then
        seconds_count_previous_prov = time_in_seconds2(time)
    end

    local seconds_count_now = time_in_seconds2(time)
    local time_diff = os.difftime(seconds_count_now, seconds_count_previous_prov)

    if time_diff > SECONDS_PER_HOUR - 1 then
        seconds_count_pre_prov = seconds_count_previous_prov
        seconds_count_previous_prov = seconds_count_now
        return {1,seconds_count_pre_prov}
    end
    return {0,0}
end

function M:activate_daily_logging_sdp(time)
    if seconds_count_previous_sdp == 0 then
        seconds_count_previous_sdp = time_in_seconds2(time)
    end

    local seconds_count_now = time_in_seconds2(time)
    local time_diff = os.difftime(seconds_count_now, seconds_count_previous_sdp)

    if time_diff > SECONDS_PER_HOUR - 1 then
        seconds_count_pre_sdp = seconds_count_previous_sdp
        seconds_count_previous_sdp = seconds_count_now
        return {1,seconds_count_pre_sdp}
    end
    return {0,0}
end

function M:activate_daily_logging_soltura(time)
    if seconds_count_previous_soltura == 0 then
        seconds_count_previous_soltura = time_in_seconds2(time)
    end


    local seconds_count_now = time_in_seconds2(time)
    local time_diff = os.difftime(seconds_count_now, seconds_count_previous_soltura)

    if time_diff > SECONDS_PER_HOUR - 1 then
        seconds_count_pre_soltura = seconds_count_previous_soltura
        seconds_count_previous_soltura = seconds_count_now
        return {1,seconds_count_pre_soltura}
    end
    return {0,0}
end

return M