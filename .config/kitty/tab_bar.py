# pyright: reportMissingImports=false

import datetime
import os
import subprocess

from kitty.fast_data_types import Screen, get_boss
from kitty.rgb import Color
from kitty.tab_bar import (DrawData, ExtraData, Formatter, TabBarData, as_rgb,
                           draw_attributed_string, draw_tab_with_powerline)
from kitty.utils import color_as_int, log_error

timer_id = None


def get_conda_env():
    try:
        return os.environ["CONDA_DEFAULT_ENV"]
    except KeyError:
        return "not found"


def get_date_time():
    curr_time = datetime.datetime.today().strftime("%a %b %d %H:%M")
    dk = (datetime.datetime.utcnow() + datetime.timedelta(hours=2)).strftime("%H:%M")

    return f" {curr_time} | {dk}"


def get_cwd():
    tm = get_boss().active_tab_manager
    if tm is not None:
        w = tm.active_window
        if w is not None:
            cwd = w.cwd_of_child or ""
            log_error(cwd)
    user = os.path.expanduser("~")
    return f" {cwd.replace(user, '~')}"


def get_battery_status():
    battery_status = subprocess.check_output(["pmset", "-g", "batt"]).decode("utf-8")
    battery_pct = battery_status.split("\n")[1].split("\t")[1].split("%")[0]
    return f"{ ''[int( battery_pct ) // 10]}{'' if 'AC' in battery_status else ' '} {battery_pct}%"


def get_active_branch_name():

    tm = get_boss().active_tab_manager
    if tm is not None:
        w = tm.active_window
        if w is not None:
            cwd = w.cwd_of_child or ""
            log_error(cwd)

    if (
        subprocess.call(
            ["git", "branch"],
            stderr=subprocess.STDOUT,
            stdout=open(os.devnull, "w"),
            cwd=cwd,
        )
        != 0
    ):
        branch = ""
    else:
        root_dir = subprocess.check_output(
            ["git", "rev-parse", "--show-toplevel"], cwd=cwd
        )
        head_dir = os.path.join(root_dir.decode("utf-8").strip(), ".git", "HEAD")
        with open(head_dir, "r") as f:
            content = f.read().splitlines()

        for line in content:
            if line[0:4] == "ref:":
                branch = line.partition("refs/heads/")[2]
        # branch = str(head_dir)
    return f" {branch}"


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last:
        draw_right_status(draw_data, screen)
    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()
    # Drop cells that won't fit
    while True:
        if not cells:
            return
        padding = screen.columns - screen.cursor.x - sum(len(c) + 3 for c in cells)
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        padding += 4
        screen.draw(" " * padding)

    # tab_bg = as_rgb(int(draw_data.inactive_bg))
    # default_bg = as_rgb(int(draw_data.default_bg))
    for cell in cells:
        # if cell == cells[0]:
        #     screen.cursor.fg = tab_bg
        # else:
        #     screen.cursor.fg = default_bg
        #     screen.cursor.bg = tab_bg

        # screen.cursor.bg = tab_bg
        screen.cursor.fg = as_rgb(color_as_int(Color(255, 250, 205)))
        screen.draw(f" {cell} ")


def create_cells() -> list[str]:
    return [
        get_cwd(),
        # get_conda_env(),
        get_active_branch_name(),
        get_battery_status(),
        get_date_time(),
    ]
