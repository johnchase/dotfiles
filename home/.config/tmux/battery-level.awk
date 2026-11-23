BEGIN {
    split("󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹", icons, " ")
}

{
    while (match($0, /[0-9]+%/)) {
        percent = substr($0, RSTART, RLENGTH)
        icon = icons[1 + int(percent / 10)]
        printf "%s%s %s", substr($0, 1, RSTART - 1), icon, percent
        $0 = substr($0, RSTART + RLENGTH)
    }
    print
}
