hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_PLUGIN_PATH", "/usr/lib/qt/plugins")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DBUS_REMOTE", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic-TotalPurple")
hl.env("XCURSOR_SIZE", "14")

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("swaync")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic-TotalPurple 14")
    hl.exec_cmd("hyprctl keyword vsync 1")
    hl.exec_cmd("swayosd-server --top-margin 0.95")
end)

hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_options = "grp:alt_shift_toggle",
    },
})

hl.config({
    general = {
        gaps_in     = 8,
        gaps_out    = 15,
        border_size = 0,
        col = {
            active_border   = "0x806C57FF",
            inactive_border = "0x00000000", 
    },
        layout = "dwindle",
    },

    misc = {
        disable_hyprland_logo    = true,
        force_default_wallpaper  = 0,
        disable_splash_rendering = true,
        vrr                      = true,
        animate_manual_resizes   = false,
    },

    decoration = {
        rounding = 26,

        active_opacity   = 0.85,
        inactive_opacity = 0.85,

        shadow = {
            enabled       = false,
            range         = 2,
            render_power  = 5,
            color         = 0xff5a2eff,
            color_inactive = "rgba(00000000)",
        },

        blur = {
            enabled = true,
            size    = 6,
            passes  = 2,
            noise   = 0.0117,
            contrast   = 1.0,
            brightness = 1.0,
            vibrancy   = 0.5,
            vibrancy_darkness = 0.5,

            ignore_opacity = true,
            xray = false,

            special = true,
            new_optimizations = true,

            popups = true,
            popups_ignorealpha = 0.2,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { repeating = true })
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))

hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + T", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"))

local floatW, floatH = 1800, 1100
hl.bind(mainMod .. " + G", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.resize({ x = floatW, y = floatH, relative = false }))
    local monW, monH = 2560, 1440
    local centerX = math.floor((monW - floatW) / 2)
    local centerY = math.floor((monH - floatH) / 2)
    hl.dispatch(hl.dsp.window.move({ x = centerX, y = centerY, relative = false }))
end)

hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(
    'grim -g "$(slurp)" -t png - | tee "$HOME/Screenshots/$(date +%F-%T).png" | wl-copy --type image/png'
))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd(
    'grim -g "$(slurp)" -t png - | wl-copy --type image/png'
))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/recording.sh"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t"))

local resizeStep = 30
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = resizeStep, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -resizeStep, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -resizeStep, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = resizeStep, relative = true }), { repeating = true })

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("default",  { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("wind",     { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("overshot", { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.08} } })
hl.curve("liner",    { type = "bezier", points = { {1, 1}, {1, 1} } })

hl.animation({ leaf = "windows",        enabled = true, speed = 8,  bezier = "wind",     style = "popin" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 8,  bezier = "overshot", style = "popin" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 8,  bezier = "overshot", style = "popin" })
hl.animation({ leaf = "windowsMove",    enabled = true, speed = 8,  bezier = "overshot", style = "slide" })

hl.animation({ leaf = "layers",         enabled = true, speed = 9,  bezier = "default", style = "popin" })

hl.animation({ leaf = "fadeIn",         enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fadeOut",        enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fadeSwitch",     enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fadeShadow",     enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fadeDim",        enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fadeLayers",     enabled = true, speed = 8,  bezier = "default" })

hl.animation({ leaf = "workspaces",     enabled = true, speed = 8,  bezier = "overshot", style = "slidevert" })

hl.animation({ leaf = "border",         enabled = true, speed = 1  , bezier = "liner" })
hl.animation({ leaf = "borderangle",    enabled = true, speed = 30 , bezier = "liner", style = "loop" })

hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 7, bezier = "overshot", style = "slidevert" })

hl.window_rule({
    name  = "kitty_opaque",
    match = { class = "kitty" },
    opaque = true,
})

hl.window_rule({
    name  = "vpn_window",
    match = { class = "AmneziaVPN" },
    float = true,
})

hl.window_rule({
    name  = "dota_cap",
    match = { class = "dota2" },
    opaque = true,
})

hl.layer_rule({
    name  = "waybar_blur",
    match = { namespace = "waybar" },
    blur = true,
    ignore_alpha = 0,
    no_anim = true,
})

hl.layer_rule({
    name  = "hyprpicker_noanim",
    match = { namespace = "hyprpicker" },
    no_anim = true,
})

hl.layer_rule({
    name  = "selection_noanim",
    match = { namespace = "selection" },
    no_anim = true,
})

hl.layer_rule({
    name  = "rofi_blur",
    match = { namespace = "rofi" },
    blur = true,
})

hl.layer_rule({
    name  = "swaync_notification_blur",
    match = { class = "swaync-notification-window" },
    blur = true,
})

hl.layer_rule({
    name  = "swaync_control_blur",
    match = { class = "swaync-control-center" },
    blur = true,
})

hl.layer_rule({
    name  = "cairo_dock_blur",
    match = { class = "cairo-dock" },
    blur = true,
    ignore_alpha = 0.3,
})

hl.layer_rule({
    name  = "hyprpaper",
    match = { namespace = "hyprpaper" },
    blur = false,
    no_anim = true,
})

hl.layer_rule({
    name  = "swayosd",
    match = { namespace = "swayosd" },
    blur = true,
})
