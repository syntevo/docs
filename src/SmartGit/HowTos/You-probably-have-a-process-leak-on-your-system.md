# You probably have a process leak on your system

This article is for Windows. It is not known whether a similar problem
can occur on other platforms.

# What is a process leak

When a process (program) ends running, not all system resources are
released immediately. For example, some system memory (in ballpark of
200KB) will continue to be used until all references to the process are
released. If another process, or kernel driver, opens references for
whatever reason and then forgets to release them, you will have a
process leak, eating up memory with every started program. Many
developers actually run lots of programs without noticing it - for
example, in many programming languages one compiler instance is invoked
per source file.

# Diagnosing with SysInternals tools

1.  Download SysInternals Suite from
    [Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)
2.  Run RAMMap.exe from downloaded package.
3.  Go to 'Processes' tab and sort by 'Total'. Scroll to the bottom of
    the list.
4.  If you see hundreds of processes with zeroes in 'Private' column,
    these are the leaks that cause problems for you.
5.  Keep RAMMap.exe open and run procexp.exe from the same package **as
    administrator** (to be able to see misbehaving programs also running
    as admin).
6.  In Process Explorer, use "Find \| Find Handle or DLL..." top-level
    menu.
7.  Input the number from PID column shown in RAMMap.exe and search.
8.  In search results, find lines containing "\<Non-existent
    Process>".  
    Ignore lines related to RAMMap: keeping processes alive is a side
    effect of its work.
9.  If you found anything, this is the program that causes problems for
    you.
10. Repeat steps 7-9 for a few other PID numbers from step 4 and see if
    the same program is found.
11. Open Task Manager, go to Performance tab, notice current memory
    usage.
12. Close RAMMap.exe - otherwise it will keep the leaked processes and
    you won't see changes in next steps.
13. Kill program identified in steps 8-9.
14. Check memory usage again. If it was reduced significantly, you found
    the problem.
15. Please let us know about any findings! Seriously, I'm very
    interested to know, and too few users reply!

If there was no such program, then the leak is probably caused by a
kernel driver. Unfortunately, there are no easy steps to diagnose it.

# Diagnosing without SysInternals tools (not recommended)

Process leak is often easy to notice:

1.  Open Task Manager
2.  Go to "Details" tab
3.  Open context menu in the list's header area
4.  Click "Select Columns"
5.  Select "PID" column
6.  Sort list by "PID"
7.  If there are values above 50.000, then it's quite likely that you
    have a process leak

Here's how you can try to find the program that causes the problem:

1.  Open Task Manager
2.  Go to "Details" tab
3.  Click "Show processes from all users" if there is such button
4.  Open context menu in the list's header area
5.  Click "Select Columns"
6.  Select "Handles" column
7.  Sort list by "Handles"
8.  If there's a program with value over 10.000, then it's quite likely
    this program is to be blamed.
9.  Go to "Performance" tab and check memory graph.
10. Close the program you identified in step 8.
11. Go to "Performance" tab and check memory graph again. If the value
    dropped significantly, then indeed the identified program was
    causing the problem.
12. If you identified a program, please let us know! This will allow us
    to help other users acing the same problem.

If there was no such program, then the leak is probably caused by a
kernel driver. Unfortunately, there are no easy steps to diagnose it.
