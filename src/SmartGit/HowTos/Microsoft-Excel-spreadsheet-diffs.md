# External Diff: configuring Microsoft Excel spreadsheet diffs

If one has Microsoft Office installed, a tool called "SpreadSheet
Compare" exists which is usually located at
`C:\Program Files (x86)\Microsoft Office\root\Office16\DCF\spreadsheetcompare`.
From command line, it takes a text file with two lines; each line is a
file name.

To call this from SmartGit, in the **Preferences**, create a **Diff
Tool** for e.g. `*.xls` pattern with **Arguments**
`${leftFile} ${rightFile}` and set **Command** to a script like the
following:



``` powershell
@ECHO OFF
rem smartgit diff passes two arguments: old-file, new-file.
set TEMP_FILE=%TEMP%\smartgit-excel-diff.txt
ECHO %1 > %TEMP_FILE%
ECHO %2 >> %TEMP_FILE%
"C:\Program Files\Microsoft Office\root\vfs\ProgramFilesX86\Microsoft Office\Office16\DCF\spreadsheetcompare" %TEMP_FILE%
```




#### Note
> For older/ 32-Bit MS Office versions, the executable's path may be:
> 
> `"C:\Program Files (x86)\Microsoft Office\root\Office16\DCF\spreadsheetcompare"`


