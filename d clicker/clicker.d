module clicker;

import core.sys.windows.w32api;
import core.sys.windows.windows;
import std.stdio;

import hooks;
import vars;

import std.random;

auto random_int(int min, int max)
{
  return uniform!"[]"(min, max);
}

void get_cps_value()
{
	write("cps: ");
  readf("%d", &left_cps);
}

bool is_in_minecraft()
{
	return GetForegroundWindow() == FindWindowA("LWJGL", null);
}

int randomization()
{
	// very simplistic randomization, but should bypass decent server anti-cheats.
	// this is the only thing i will not spoonfeed. 
	// make a good randomization yourself!

	return random_int(450, 550) / left_cps;
}

void send_mouse_click(click_type type)
{
	static POINT pos; GetCursorPos(&pos);

	if(type == click_type.mouse_down)
	{
		PostMessage(
			GetForegroundWindow(),
			WM_LBUTTONDOWN,
			MK_LBUTTON,
			MAKELPARAM(pos.x, pos.y));
	}

	// just for the sake of brevity
  if(type == click_type.mouse_up) 
	{
		PostMessage(
		  GetForegroundWindow(),
			WM_LBUTTONUP,
			MK_LBUTTON,
			MAKELPARAM(pos.x, pos.y));
	}
}

void clicker_thread()
{
  while(true)
	{
		if(is_in_minecraft() && clicker_enabled)
		{
			if(GetAsyncKeyState(VK_LBUTTON) & 0x8000)
			{
				Sleep(randomization());
				send_mouse_click(click_type.mouse_down);

				Sleep(randomization());
				send_mouse_click(click_type.mouse_up);
			}
		}

		Sleep(1);
	}
}