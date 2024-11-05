# How to add a file with "inconsistent newlines"?

Usually, inconsistent newlines indicate a problem of the file content:
it means that the file contains a mixture of line endings (for example
\\n and \\r\\n). Such files can't be handled by Subversion's integrated
line-ending conversion which will check out files with appropriate line
endings for every platform. For this reason, SmartSVN by default
disallows to add such files. If you are sure that the inconsistent
newlines are by intention, you may add such a file from command line:



``` java
$ svn add --no-auto-props path/to/file
```


