from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import subprocess
import os

from widgets.my_volume import MyVolume

mod = "mod4"  # set mod to super key
terminal = "alacritty -e zsh"
dmenu_run = 'dmenu_run -m 0 -p "run:"'

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key(
        [mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"
    ),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod, "shift"],
        "c",
        lazy.window.kill(),
        desc="Kill focused window",
    ),
    Key(
        [mod], "period", lazy.next_screen(), desc="Move focus to next monitor"
    ),
    Key([mod], "comma", lazy.prev_screen(), desc="Move focus to prev monitor"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key(
        [mod, "shift"], "q", lazy.spawn("dm_sysact"), desc="Reload the config"
    ),
    Key([mod], "p", lazy.spawn(dmenu_run), desc="Run dmenu"),
    Key([mod], "backslash", lazy.spawn("dm_maim"), desc="Run dmenu"),
    # SOUND
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="mute sound",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
        desc="volume +",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        desc="volume -",
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        desc="mute mic",
    ),
    # BRIGHTNESS
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 5"),
        desc="increase brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 5"),
        desc="decrease brightness",
    ),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(
                    i.name,
                    # switch to group when moving window
                    # switch_group=True
                ),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

# Setting colors
Gruvbox = dict(
    gray1="#20201d",
    gray2="#928374",
    gray3="#eaeaea",
    accent1="#fabd2f",
    accent2="#98971a",
)

TokyoNight = dict(
    gray1="#1a1b26",
    gray2="#414868",
    gray3="#c0caf5",
    accent1="#7aa2f7",
    accent2="#bb9af7",
)

COLORS = Gruvbox

layout_theme = {
    "border_width": 1,
    "margin": 4,
    "border_focus": COLORS["accent1"],
    "border_normal": COLORS["gray2"],
}

layouts = [
    layout.MonadTall(
        **layout_theme,
        single_border_width=0,
        single_margin=0,
        new_client_position="top",
    ),
    layout.Max(),
    layout.Floating(
        border_focus=COLORS["accent2"],
    ),
]

widget_defaults = dict(
    font="monospace",
    fontsize=16,
    padding=2,
    background=COLORS["gray1"],
    foreground=COLORS["gray3"],
)

extension_defaults = widget_defaults.copy()


def widgets():
    return [
        widget.GroupBox(
            highlight_method="block",
            hide_unused=True,
            rounded=False,
            padding_x=6,
            padding_y=2,
            this_current_screen_border=COLORS["accent1"],
            this_screen_border=COLORS["gray2"],
            other_current_screen_border=COLORS["accent1"],
            other_screen_border=COLORS["gray2"],
            block_highlight_text_color=COLORS["gray1"],
        ),
        widget.CurrentLayoutIcon(
            padding=2,
            scale=0.7,
        ),
        widget.WindowName(
            padding=10,
            foreground=COLORS["gray1"],
            background=COLORS["accent1"],
        ),
        MyVolume(
            padding=5,
        ),
        # widget.PulseVolume(
        #     padding=5,
        # ),
        widget.Clock(padding=5, format="📅 %Y %b %d (%a) 🕓 %I:%M %p"),
        widget.Systray(),
    ]


def widget_screen1():
    return widgets()


def widget_screen2():
    widgets_s2 = widgets()
    # removing status widgets from second screen
    del widgets_s2[3:6]
    return widgets_s2


screens = [
    Screen(
        top=bar.Bar(
            widget_screen1(),
            28,
        ),
    ),
    Screen(
        top=bar.Bar(
            widget_screen2(),
            28,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])
