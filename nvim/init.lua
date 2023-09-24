require ("edubrovsky")

-- useful for debugging 
function _G.printTable(t, indent)
    indent = indent or ""

    for k, v in pairs(t) do
        if type(v) == "table" then
            print(indent .. k .. ":")
            _G.printTable(v, indent .. "  ")
        else
            print(indent .. k .. ": " .. tostring(v))
        end
    end
end

