-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
	local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
	local entry = share .. "/hypr/hyde.lua"
	local handle = io.open(entry, "r")
	if not handle then
		error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
	end
	handle:close()
	dofile(entry)
end

hl.config({
    input = {
        kb_layout = "br",
        kb_variant = "",
        kb_model = "abnt2",
    },
})

-- Your Hyprland configuration. HyDE never overwrites this file.
--
-- It loads after HyDE's own binds, so settings here take precedence. Replacing
-- a bind needs more than that: see below. HyDE's defaults live in
-- ~/.local/share/hypr/lua/ and are overwritten on every update, so edits there
-- do not survive.
--
-- Adding a keybind:
--
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(hyde.sh.gamelauncher()), {
--         description = "[Utilities] game launcher",
--     })
--
-- Replacing one of HyDE's: bind the same combination again and yours takes
-- over, but copy its flags across as well. A bind counts as the same one only
-- when its flags match, and `description` is not a flag — miss one and both
-- binds stay live on that combination. Copy the whole options table from
-- ~/.local/share/hypr/lua/key_binds.lua and change only what you need:
--
--     hl.bind("F9", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), {
--         locked = true,
--         description = "[Hardware Controls|Audio] un/mute output",
--     })
--
-- Press SUPER + / to see what is actually loaded, your own binds included.
-- The full reference is KEYBINDINGS.md in the HyDE repository.
--
-- Other Lua files next to this one can be pulled in with require("name").

local mod = "SUPER"

hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close(), {
    description = "[Window] close window",
})

local dirs = { h = "l", l = "r", k = "u", j = "d" }
for key, d in pairs(dirs) do
    local K = key:upper()
    hl.bind("CTRL + " .. K, hl.dsp.focus({ direction = d }), {
        description = "[Window] focus " .. d,
    })
    hl.bind("CTRL + SHIFT + " .. K, hl.dsp.window.move({ direction = d }), {
        description = "[Window] move window " .. d,
    })
    hl.bind(mod .. " + SHIFT + " .. K,
        hl.dsp.window.move({ direction = d, group_aware = true }), {
        description = "[Group] move window into/out of group " .. d,
    })
end

hl.bind(mod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"), { description = "[Utilities] lock screen" })
hl.bind(mod .. " + SHIFT + B",
    hl.dsp.exec_cmd("pkill -x rofi || hyde-shell wallbashtoggle -m"),
    { description = "[Utilities] wallbash mode selector" })
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("killall waybar"), { description = "[Utilities] restart waybar" })

-- Cycle windows inside a group (overrides HyDE's lock / split / layout-switch)
hl.bind(mod .. " + H", hl.dsp.group.prev(), { description = "[Group] previous" })
hl.bind(mod .. " + K", hl.dsp.group.prev(), { description = "[Group] previous" })
hl.bind(mod .. " + L", hl.dsp.group.next(), { description = "[Group] next" })
hl.bind(mod .. " + J", hl.dsp.group.next(), { description = "[Group] next" })
