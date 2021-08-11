import core.sys.windows.w32api;
import core.sys.windows.windows;
import std.stdio;

import vars;

static extern (Windows) LRESULT keyboard_hook(int n_code, WPARAM w_param, LPARAM l_param) nothrow
{
	KBDLLHOOKSTRUCT* details = cast(KBDLLHOOKSTRUCT*) l_param;

	try
	{
		if (w_param == WM_KEYDOWN && n_code == HC_ACTION)
		{
			// toggle our clicker on/off
			if(details.vkCode == toggle_key)
			{
				clicker_enabled = !clicker_enabled;

				if(clicker_enabled)
					writeln("[debug] clicker enabled");
				else
					writeln("[debug] clicker disabled");
			}		
		}

		return CallNextHookEx(&keyboard_hook, n_code, w_param, l_param);
	}
	catch(Exception) 
	{ 
		return 0;
	}
} 

void initialize_hooks() 
{
	HHOOK keyboard = SetWindowsHookExA(WH_KEYBOARD_LL, &keyboard_hook, null, 0);

	MSG msg;

	while (GetMessage(&msg, null, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	UnhookWindowsHookEx(keyboard);
}