-- Chisel description
description = "Finds time gaps between succeeding events larger than a threshold. Output fir formatted according to '%evt.num %evt.time (%evt.deltatime) %proc.name %evt.dir %evt.type %evt.args'"
short_description = "find time gaps between events"
category = "misc"

-- Chisel argument list
args =
{
    {
        name = "threshold",
        description = "in seconds, default 1 s, i.e., 1.0",
        argtype = "float",
        optional = true
    },
}

-- Constants
ns =1000000000
-- Default values
threshold = 1.0 * ns -- Threshold in ns

-- Argument notification callback
function on_set_arg(name, val)
    if name == "threshold" then
        threshold = tonumber(val) * ns -- Threshold in ns
        return true
    end

    return false
end

-- Initialization callback
function on_init()
    -- Request the fileds that we need
    fe_time = chisel.request_field("evt.time")
    fe_deltatime = chisel.request_field("evt.deltatime")
    fe_name = chisel.request_field("proc.name")
    fe_dir = chisel.request_field("evt.dir")
    fe_type = chisel.request_field("evt.type")
    fe_args = chisel.request_field("evt.args")

    return true
end

-- Event parsing callback
function on_event()
    local num = evt.get_num()
    local time = evt.field(fe_time)
    local deltatime = evt.field(fe_deltatime)
    local name = evt.field(fe_name)
    local dir = evt.field(fe_dir)
    local e_type = evt.field(fe_type)
    local args = evt.field(fe_args)

    if deltatime >= threshold then
      -- %evt.num %evt.time (%evt.deltatime) %proc.name %evt.dir %evt.type %evt.args
      print(num .. " " .. time .. " (" .. deltatime / ns .. ") " .. name .. " " .. dir .. " " .. e_type .. " " .. args)
    end

    return true
end

