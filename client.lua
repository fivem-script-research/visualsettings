local function parse_visual_settings(file_content)
    -- split the file content into lines
    local lines = {}

    for line in file_content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    -- parse each line and store the settings in a table
    local settings = {}
    --local count = 0

    for _, line in ipairs(lines) do
        -- ignore comments and empty lines
        if not line:match("^%s*$") and not line:match("^%s*#") and not line:match("^%s*//") then
            
            local key, value = line:match("^%s*(%S+)%s+(%S+)")

            if key and value then
                value = value:gsub("[fF]$", "")
                settings[key] = value

                --count = count + 1
            end
        end
    end

    --print("Parsed " .. count .. " lines")

    return settings
end


local function load_visual_settings(file_path)
    -- load the specified file into memory
    local visual_settings_file = LoadResourceFile(GetCurrentResourceName(), file_path)

    -- check if the file was loaded successfully
    if not visual_settings_file then
        print("Failed to load visual settings file: " .. file_path)
    end

    -- parse the visual settings
    local visual_settings = parse_visual_settings(visual_settings_file)
    --local count = 0

    -- apply the visual settings
    for setting, value in pairs(visual_settings) do
        SetVisualSettingFloat(setting, value * 1.0)
        --count = count + 1
    end

    --print("Applied " .. count .. " visual settings from " .. file_path)
end


Citizen.CreateThread(function()
    load_visual_settings("data/test_visualsettings.dat")
end)