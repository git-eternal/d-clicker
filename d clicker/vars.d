module vars;

import std.stdio;

import core.sys.windows.w32api;
import core.sys.windows.windows;

enum click_type
{
	mouse_down = 0, mouse_up = 1
}

shared bool clicker_enabled;
shared int toggle_key = VK_F4;
shared int left_cps = 12;
