# How to fix duplicate Unicode file entries on macOS

## Background

On macOS, file names with special characters (such as German, Korean, Japanese, or other Unicode characters) can appear duplicated in the Git *Index* due to different Unicode normalization forms.
macOS uses *decomposed Unicode* (NFD) for file names on the file system, while Git may store them in *composed Unicode* (NFC) format in the *Index*.


> [!IMPORTANT]
> Before proceeding with the cleanup steps described in this guide, ensure that `core.precomposeunicode=true` is configured in your Git repository configuration.
> This is the recommended configuration for macOS and uses composed Unicode format as the canonical representation.
> You can verify or set this with: `git config core.precomposeunicode true`.

When this happens, the `.git/index` contains two versions of the same file name, which map to a single physical file on disk.
SmartGit may display these files differently than command-line Git, and modifying the file in your working tree can cause `git status` to report two modifications for the same file, displayed in different Unicode representations.

**Example:**

For a Korean file name "한.txt":
- Composed (NFC): `ED 95 9C` → `\355\225\234`
- Decomposed (NFD): `E1 84 92 E1 85 A1 E1 86 AB` → `\341\204\222\341\205\241\341\206\253`

Running `git ls-files -s` might show both representations:

```
$ git ls-files -s
100644 fa837f4e2a317771de909276f480b397e7cf8199 0       "\341\204\222\341\205\241\341\206\253.txt"
100644 fa837f4e2a317771de909276f480b397e7cf8199 0       "\355\225\234.txt"
```

Note that both entries typically have the same hash, indicating they point to identical content.

> [!NOTE]
> This issue is specific to macOS and occurs with file names containing non-ASCII Unicode characters.
> The recommended configuration is `core.precomposeunicode=true`, which uses composed Unicode format as the canonical representation.

## Resolution

The resolution is performed using Git from the command line to clean up the duplicate entries and re-add the files in the canonical composed Unicode format:

-   `cd` to your repository.
-   Verify that `core.precomposeunicode=true` is configured:
    ```
    $ git config core.precomposeunicode
    true
    ```
    If this is not set to `true`, configure it now with `git config core.precomposeunicode true`.
-   Verify the duplicate entries by invoking `git ls-files -s` and looking for the affected file names with different octal representations. Note the blob IDs (the hash values) for both entries.
-   For each affected file (using "한.txt" as an example with blob ID `fa837f4e2a317771de909276f480b397e7cf8199`):
-   Copy the working tree file outside the repository:
    ```
    cp 한.txt ../wt.txt
    ```
-   Extract the content from the composed Unicode entry in the *Index*:
    ```
    git show fa837f4e2a317771de909276f480b397e7cf8199 > ../composed.txt
    ```
    (Replace the blob ID with the hash from the `\355\225\234.txt` entry in `git ls-files -s`)
-   Extract the content from the decomposed Unicode entry in the *Index*:
    ```
    git show fa837f4e2a317771de909276f480b397e7cf8199 > ../decomposed.txt
    ```
    (Replace the blob ID with the hash from the `\341\204\222\341\205\241\341\206\253.txt` entry in `git ls-files -s`)
-   Verify the contents of all three files are identical:
    ```
    diff ../wt.txt ../composed.txt
    diff ../wt.txt ../decomposed.txt
    diff ../composed.txt ../decomposed.txt
    ```
    Ideally, all three files should be identical (no output from `diff`). At minimum, `wt.txt` should match at least one of the other files. If the third file differs and `wt.txt` does not match either version, you need to manually edit `../wt.txt` to contain the consolidated/correct version before proceeding.
-   Remove both versions of the file from the *Index* (this will remove both Unicode representations):
    ```
    $ git -c core.precomposeunicode=false rm -f --cached -- $'\341\204\222\341\205\241\341\206\253.txt'
    $ git -c core.precomposeunicode=false rm -f --cached -- $'\355\225\234.txt'
    ```
    (Replace the octal sequences with the actual decomposed representation shown in `git ls-files -s`)
-   Stage and commit the removal:
    ```
    $ git commit -m 'Clean up duplicate Unicode entries'
    [master 9ca4365] Clean up duplicate Unicode entries
    2 files changed, 0 insertions(+), 0 deletions(-)
    delete mode 100644 "\341\204\222\341\205\241\341\206\253.txt"
    delete mode 100644 "\355\225\234.txt"
    ```
    The output shows two file deletions (one for each Unicode representation).
-   Copy the verified working tree file back into the repository:
    ```
    cp ../wt.txt 한.txt
    ```
-   Verify the file now appears once with `git status`:
    ```
    $ git status
    On branch master
    Your branch is ahead of 'origin/master' by 1 commit.
      (use "git push" to publish your local commits)

    Untracked files:
      (use "git add <file>..." to include in what will be committed)
            \355\225\234.txt

    nothing added to commit but untracked files present (use "git add" to track)
    ```
    The file now appears once, displayed in composed Unicode format.
-   Add the file back:
    ```
    $ git add .
    $ git commit --amend -m 'Clean up duplicate Unicode entries'
    [master a4a7cfd] Clean up duplicate Unicode entries
    1 file changed, 0 insertions(+), 0 deletions(-)
    delete mode 100644 "\341\204\222\341\205\241\341\206\253.txt"
    ```
    This amends the previous commit to show one deletion (the decomposed version).
    No file creation is shown because the composed version persists in the repository, and the overall commit still contains the file.
-   Review the results in SmartGit, too.

> [!NOTE]
> If you have multiple files with this issue, repeat the process for each file before the final commit.
> - Verify the cleanup was successful by invoking `git ls-files -s` again.
>   You should now see only one entry per file (the composed variation).
> - Now Git and SmartGit will be able to work with these files normally.
    Don't forget to push your changes!

## Additional Information

-   **Check your Git configuration:** Ensure `core.precomposeunicode=true` is set in your Git configuration to prevent this issue in the future:
    ```
    git config core.precomposeunicode true
    ```
-   **Same hash is good:** If the duplicate entries have the same hash (as shown in `git ls-files -s`), you don't need to decide which version to keep -- they contain identical content.
-   **Alternative squashing:** Instead of using `git commit --amend`, you can create two separate commits and then use SmartGit's Squash feature to combine them.
