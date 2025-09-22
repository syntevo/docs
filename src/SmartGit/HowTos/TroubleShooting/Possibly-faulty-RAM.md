# Possibly faulty RAM

# Introduction (for the curious; skip to next chapter if you like)

RAM is the hardware used in computers, also known as "memory".
Due to the technology used in the manufacturing, defects are quite common.
Most of these are weeded out at the factory, but some will slip through to consumers.

There are two common reasons for faulty RAM:
1.  Manufacturing defects. In this case, usually just one of the sticks
    is faulty and others are good.
2.  Incompatible overclocking settings.

If you encounter any of these problems, you should run the test:
1.  Operating system crashes (such as Blue Screens on Windows).
2.  Random crashes in random programs.
3.  You submitted a SmartGit crash report and support replied that
    it happened in a reliable component. Around 50% of users who reported
    such crash find their hardware to be faulty.

It is a good idea to run the test for every computer you are using, whether
or not it has visible problems. It is sufficient to run the test just once
per hardware. Replacing the faulty RAM stick is usually better than
tolerating random bugs and data corruption for years.

# Running the test

It is recommended to run test test overnight, while you're not using the
computer.

If the test is not complete by the time you need the computer, please note
if it found any problems and then cancel it. You could also run a quick test
if full test takes too long, but note that quick test only finds the most
obvious problems. It's quite common that only the full test reveals the
problems.

Select one of the following, depending on your OS:
1.  [Windows Quick test](#windows---quick-test)
2.  [Windows Extended test](#windows---extended-test)
3.  [Ubuntu](#ubuntu)
4.  [Any OS](#any-os)

# Windows - Quick test
1.  If you have a few spare hours when you don't need your computer,
    please run [Extended test](#windows---extended-test)
    instead.
2.  The test will take around half an hour. You won't be able to use
    your computer while the test runs. It could be convenient to run it
    during the lunch break.
3.  Run from Win+R or from command line:
    ```
    MdSched.exe
    ```
4.  Choose whether to restart now or postpone it until next restart.
5.  Once your computer is restarted, the test will run automatically.
6.  If you need your computer before the test completes, you can
    interrupt it with Esc and run again later.
7.  Once the test is finished, the computer will automatically boot back
    into Windows.
8.  You can find test results in Windows Event Log :  
    1. Go to
    `Control Panel > System and Security > Administrative Tools > Event Viewer > Windows Logs > System`
    2. Find event with `Source` equal to `MemoryDiagnostics-Results`
9.  It is quite common that a quick test overlooks existing problems.
    Please also run [Extended test](#windows---extended-test).
    It is convenient to run it overnight when you're not using the computer.
10. Continue to ["What to do after the test"](#what-to-do-after-the-test).

# Windows - Extended test
1.  The test will take a few hours. You won't be able to use your
    computer while the test runs. It could be convenient to run during
    the night.
2.  Run from Win+R or from command line:
    ```
    MdSched.exe
    ```
3.  Choose whether to restart now or postpone it until next restart.
4.  Once your computer is restarted, the test will run automatically.
5.  Press F1 and select `Extended` test. Press F10 to apply.
6.  If you need your computer before the test completes, you can
    interrupt it with Esc and run again later.
7.  Once the test is finished, the computer will automatically boot back
    into Windows.
8.  You can find test results in Windows Event Log :  
    1. Go to
    `Control Panel > System and Security > Administrative Tools > Event Viewer > Windows Logs > System`
    2. Find event with `Source` equal to `MemoryDiagnostics-Results`
9.  Continue to ["What to do after the test"](#what-to-do-after-the-test).

# Ubuntu
1.  Hold Shift when you boot your Ubuntu
2.  Select `memtest86`
3.  Give it a few hours to run. It's convenient to do that overnight.
4.  See if it found any errors ("Errors:" text in bottom right).
5.  Continue to ["What to do after the test"](#what-to-do-after-the-test).

# Any OS
1.  Download [memtest86+](https://www.memtest86.com/)
2.  Create a bootable USB according to [instructions](https://www.memtest86.com/tech_creating-linux-mac.html)
3.  Boot and test according to [instructions](https://www.memtest86.com/tech_booting-memtest.html)
4.  Continue to ["What to do after the test"](#what-to-do-after-the-test).

# What to do after the test
In any case, please reply to support's mail! Getting feedback is really
valuable to understanding which weird crashes are in fact due to hardware
and which are not.

## If test didn't find any problems
Congratulations, your RAM is good. If you still encounter a lot of weird
problems on your computer, this could be due to:
* CPU overheating.    
  Use monitor software of your choice to check.
* Buggy drivers.    
  On windows, [driver verifier](https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/driver-verifier)
  could be used to find which driver causes trouble. Alternatively, update
  as many drivers as you can and see if it helps.
* Buggy programs that inject their components in all other programs.    
  It is possible to investigate using crash dumps.

Please contact support if you'd like to get further hints.

## If test detected lots of errors
It's likely that your RAM is incorrectly overclocked in BIOS. Please check
the settings there.

For example, it's possible that RAM manufacturer has set overly optimistic
timings in XMP settings.

## If test detected just a few errors
### How to fix
1.  If you used Windows test, then Windows will remember the faulty regions and
    will avoid these regions. If the test detected all defects, then this
    should be enough to solve the problem. However, it still makes sense to
    replace the faulty sticks (continue reading for that).
    
    At some later time Windows may forget the regions and you will need to
    repeat the test. You could check the current list with this commandline
    (run as admin):
    ```
    bcdedit /enum {badmemory}
    ```

    It will show this if the list is empty:
    ```
	RAM Defects
	-----------
	identifier              {badmemory}
    ```

    Otherwise, if there are avoided regions in the list, output will be like:
    ```
    RAM Defects
    -----------
    identifier              {badmemory}
    badmemorylist           0x4dd360
                            0x4dd361
                            0x4dd363
                            0x4dd364
                            0x4dd366
                            0x4dd367
    ```

    Note that in this example, faulty addresses make a small cluster.
    This is what is expected for localized manufacturing defects.
2.  It is likely that you have multiple RAM sticks in your computer. It is also
    likely that just one of them is faulty. Test each sticks individually to
    find which one is faulty and remove it.
3.  Replace the faulty stick. If the old one is still under warranty,
    return it to the seller.

### What happens if you leave it as is
1.  Having a faulty region in RAM means that any data stored there will get
    corrupted randomly.
2.  On every computer boot, the region can get allocated to OS or to one of the
    programs. Also, the region could be reallocated to a different purpose
    while computer is working. So the problem will be moving around.
3.  Depending on which program gets this region, the consequences of data
    corruption will be different, such as:
    * OS crashes (Blue Screens on Windows)
    * Program crashes
    * Data corruptions in files
    * Non-permanent artifacts when viewing images/videos
    * Nothing, if some non-important data was corrupted
