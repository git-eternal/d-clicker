module main;

import std.stdio;
import std.concurrency : spawn;

import hooks;
import clicker;
import vars;

int main()
{
  get_cps_value();
  
  // initialize our threads
  spawn(&initialize_hooks);
  spawn(&clicker_thread);
 
  return 0;
}
