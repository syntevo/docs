# Bug Reports

## Detailed Bug Reports

In case of a crash, DeepGit offers to send a detailed bug report
directly to our webserver. If you prefer to have a look at the file
first, you may locate the given ZIP file in the file system, inspect its
contents, remove possibly sensitive data and finally send us the file by
email.

## Crash Footprints

DeepGit by default automatically transfers the footprint of a crash to a
*crash server* for the purpose of quality assurance. The sent
information contains details about the user machine (e.g. version of
operating system), DeepGit version/build, the JVM state and where the
error occurred. *It contains no potentially sensitive information like
user names, email addresses, file contents, file paths or server names.*

A crash footprint file looks like this:



``` text
This crash footprint has been created automatically and will be sent to
http://www.syntevo.com/deepgit/bugstat for the purposes of quality assurance
for DeepGit. This footprint does not contain any sensitive information
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
thread=deepgit.F
exceptionCount=1

STACKTRACE
deepgit.G
  at deepgit.F.a(SourceFile:33)
  at deepgit.Yd.run(SourceFile:28)
Caused by: java.lang.RuntimeException
  at deepgit.F.a(SourceFile:33)
  at deepgit.Yd.run(SourceFile:28)
Caused by: java.lang.InternalError
  at deepgit.F.a(SourceFile:33)
  at deepgit.Yd.run(SourceFile:28)
```



You can switch the automatic crash reporting off in the Preferences,
section **Crash Reporting**.
