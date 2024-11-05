# Relocate

Use **Modify\|Relocate** to change the repository for the selected
directory (and subdirectories) of your local working copy. Typically,
this command is used when the URL/structure of an SVN server has
changed.

**Relocate Directory** shows the directory, relative to the project's
root directory, which will be relocated. **From URL** displays the
repository root URL of the selected directory, if this information is
available locally. Otherwise it displays the complete repository URL of
the directory. With **To URL** you can now specify the replacement
string for **From URL**: Relocate will then search within the selected
directory and subdirectories for URLs starting with **From URL** and
replace the corresponding part by **To URL**.
