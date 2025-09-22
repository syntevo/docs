# Your pagefile size is limited to a low value

The total amount of memory available to running programs is composed of
RAM (hardware memory) and pagefile (disk file that will hold anything
that doesn't fit in RAM).

Some users limit or even completely disable pagefile. Limiting pagefile
to a low size will cause programs to malfunction and/or crash when
system runs out of memory. Nowadays, hitting this problem is easy
enough: web browser alone could consume a few gigabytes of memory.

It's recommended to change the setting to system managed size, or at
least increase the limit so that (RAM + pagefile limit) is above 16GB.

On Windows, you can do it this way:

1.  Press Win+Break to open Control Panel
2.  Click "Advanced system settings" on the left
3.  Select tab "Advanced"
4.  Click "Settings..." under "Performance"
5.  Select tab "Advanced"
6.  Click "Change..." under "Virtual memory"
7.  Select "Automatically manage paging file size for all drives"

  
