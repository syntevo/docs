# Bug Reports

## Detailed Bug Reports

In case of a crash, SmartGit offers to send a detailed bug report
directly to syntevo.com. If you prefer to have a look at the file first,
you may locate the given ZIP file in the file system, inspect its
contents, remove possibly sensitive data and finally send the file by
email to redacted@syntevo.com.

## Crash Footprints

SmartGit by default automatically transfers the footprint of a crash to
a *crash server* for the purpose of quality assurance. The sent
information contains details about the user machine (e.g. version of
operating system), SmartGit version/build, the JVM state and where the
error occurred. *It contains no potentially sensitive information like
user names, email addresses, file contents, file paths or server names.*

A Java crash footprint file looks like this:



``` text
This crash footprint has been created automatically and will be sent to
http://www.syntevo.com/api/bugstat/smartgit for the purposes of quality assurance
for SmartGit. This footprint does not contain any sensitive information
nor any information from your repositories.

HEADER
time=20141111183916
run=46bb4878207d0b97
debugging=false
version=6.5
build=4113
buildid=
machine=64f9152d
os=Windows 7
osv=6.1
osarch=x86
maxmem=1024
java=1.7.0_45
uptime=0.01
thread=smartgit.F
exceptionCount=1

STACKTRACE
smartgit.G
  at smartgit.F.a(SourceFile:33)
  at smartgit.Yd.run(SourceFile:28)
Caused by: java.lang.RuntimeException
  at smartgit.F.a(SourceFile:33)
  at smartgit.Yd.run(SourceFile:28)
Caused by: java.lang.InternalError
  at smartgit.F.a(SourceFile:33)
  at smartgit.Yd.run(SourceFile:28)
```



A native crash footprint looks like this:



``` text
This crash footprint has been created automatically and will be sent to
https://www.syntevo.com/api/crashtrace/smartgit for the purposes of quality
assurance for SmartGit. This footprint does not contain any sensitive
information nor any information from your repositories.

HEADER
time=20181125162040
run=5f4811655b72b715
debugging=true
version=18.2 RC 2
build=13190
buildid=302eac5b
machine=b37b09cb
os=Windows 8.1
osv=6.3
osarch=amd64
maxmem=1100
java=10.0.1 (Java HotSpot(TM) 64-Bit Server VM)
uptime=0.00
thread=smartgit.ang
exceptionCount=0
swtVersion=4.922

CRASHTRACE
# A fatal error has been detected by the Java Runtime Environment:
#  EXCEPTION_ACCESS_VIOLATION (0xc0000005) at pc=0x00007ffbcd077fbb, pid=5636, tid=4436
# JRE version: Java(TM) SE Runtime Environment (10.0.1+10) (build 10.0.1+10)

---------------  S U M M A R Y ------------

Host: Intel(R) Core(TM) i7-4710HQ CPU @ 2.50GHz, 8 cores, 15G,  Windows 8.1 , 64 bit Build 9600 (6.3.9600.17415)
Time: Thu Nov 15 09:22:55 2018 W. Europe Standard Time elapsed time: 3088 seconds (0d 0h 51m 28s)

---------------  T H R E A D  ---------------

Current thread (0x0000000002c5e800):  JavaThread "main" [_thread_in_native, id=4436, stack(0x0000000000450000,0x0000000000550000)]

Stack: [0x0000000000450000,0x0000000000550000],  sp=0x000000000054cfe0,  free space=1011k
Native frames: (J=compiled Java code, j=interpreted, Vv=VM code, C=native code)
C  [jnidispatch.dll+0x17fbb]

Java frames: (J=compiled Java code, j=interpreted, Vv=VM code)
j  com.sun.jna.Native.ffi_call(JJJJ)V+0
j  smartgit.oP.a()V+4
j  smartgit.Yx.b(Lorg/eclipse/swt/widgets/Widget;)V+105
j  smartgit.Yx.a(Lorg/eclipse/swt/widgets/Widget;)V+2
j  smartgit.Yx.a(Lorg/eclipse/swt/widgets/Event;)V+14
j  smartgit.Yx$$Lambda$236.handleEvent(Lorg/eclipse/swt/widgets/Event;)V+5
J 5953 c2 org.eclipse.swt.widgets.EventTable.sendEvent(Lorg/eclipse/swt/widgets/Event;)V (584 bytes) @ 0x000000000dd856ec [0x000000000dd855c0+0x000000000000012c]
J 12417 c2 org.eclipse.swt.widgets.Display.runDeferredEvents()Z (109 bytes) @ 0x000000000df6c2c0 [0x000000000df6bf20+0x00000000000003a0]
J 11503 c2 org.eclipse.swt.widgets.Display.readAndDispatch()Z (96 bytes) @ 0x000000000e518c6c [0x000000000e5187c0+0x00000000000004ac]
J 13057% c2 smartgit.WU.d()V (35 bytes) @ 0x000000000e785ca8 [0x000000000e785b20+0x0000000000000188]
j  com.syntevo.smartgit.q.a(Lsmartgit/aoR;Lsmartgit/mY;Lcom/syntevo/smartgit/aE;Ljava/lang/Boolean;Lsmartgit/ajS;)V+493
j  com.syntevo.smartgit.q.a(Ljoptsimple/OptionSet;)V+599
j  smartgit.apt.a()V+60
j  com.syntevo.smartgit.SmartGit.main([Ljava/lang/String;)V+8
v  ~StubRoutines::call_stub
j  jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+0 java.base@10.0.1
j  jdk.internal.reflect.NativeMethodAccessorImpl.invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+100 java.base@10.0.1
j  jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+6 java.base@10.0.1
j  java.lang.reflect.Method.invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+59 java.base@10.0.1
j  com.syntevo.QBootLoader.main([Ljava/lang/String;)V+582
v  ~StubRoutines::call_stub
j  jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+0 java.base@10.0.1
j  jdk.internal.reflect.NativeMethodAccessorImpl.invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+100 java.base@10.0.1
j  jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+6 java.base@10.0.1
j  java.lang.reflect.Method.invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;+59 java.base@10.0.1
j  com.exe4j.runtime.LauncherEngine.launch(Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZLjava/lang/ClassLoader;)V+186
j  com.exe4j.runtime.WinLauncher.main([Ljava/lang/String;)V+208
v  ~StubRoutines::call_stub

siginfo: EXCEPTION_ACCESS_VIOLATION (0xc0000005), reading address 0x000000000000001c

---------------  P R O C E S S  ---------------

java_command: SmartGit
```


