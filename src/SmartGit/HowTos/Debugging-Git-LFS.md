# Debugging Git-LFS

When working with Git Large File Storage (Git-LFS), you might occasionally encounter issues, especially with the `smudge` filter. This guide provides a structured approach to debugging such problems, particularly on Windows.

## Debugging the `smudge` Filter

### Problem Overview

If you are experiencing long delays, hangs, or unresponsive behavior in **SmartGit** during repository refresh operations, it could be related to the Git-LFS `smudge` filter. This typically manifests with log entries similar to the following in SmartGit's log file:

``` text
killing 'c:\app\tools\git\usr\bin\sh.exe -c "git-lfs smudge ...
```

The following steps will help you debug and isolate the issue.

### Step-by-Step Debugging on Windows

Assume the problematic file is located at `dir/file` and your Git installation is located at `C:\Portable\Git`.

#### 1. Prepare the Environment

- Open a command prompt.
- Navigate to the root directory of your Git repository:
  
  ``` text
  cd path\to\your\repository
  ```

- Adjust the `PATH` to ensure the correct Git executable is used:

  ``` text
  SET PATH=C:\Portable\Git;C:\Portable\Git\mingw64\bin;%PATH%
  ```

#### 2. Identify the File's SHA

Run the following command to locate the Git-LFS entry for the file:

``` bash
git ls-files -s | grep dir/file
```

- Note the SHA provided in the output. This SHA represents the Git pointer file.

#### 3. Inspect the Git-LFS Pointer

Retrieve the Git object associated with the file:

``` bash
git show <sha> > out-lfs
```

- Open the `out-lfs` file and verify that it contains content resembling this format:

  ``` text
  version https://git-lfs.github.com/spec/v1
  oid sha256:520928654e8615ebc33bfae21f91cea3a5d04a2883af00c409f0a5f24950059b
  size 1048576
  ```

This confirms that the file is being tracked by Git-LFS.

#### 4. Run the `smudge` Filter Manually

Test the `smudge` filter in isolation to observe its behavior:

``` text
C:\Portable\Git\usr\bin\sh.exe -c "git-lfs smudge -- 'dir/file'" < out-lfs > out-blob
```

- This command simulates the `smudge` process that (Smart)Git would normally perform during checkout.
- Review `out-blob` to ensure the expected file content is present and no errors occurred.

## Final Notes

- This procedure is particularly useful for isolating whether the issue lies within Git-LFS, the Git executable, or SmartGit's handling of Git commands.
- If the manual `smudge` operation succeeds but SmartGit continues to hang, the problem may be related to the Git integration within SmartGit or environmental path configurations.

## Additional Tips

- Try with SmartGit's bundle Git Executable
- Always ensure you are using compatible versions of Git and Git-LFS.
- Consider updating Git if persistent issues occur.
- Review SmartGit's settings to verify the configured Git executable matches the one you are debugging with.
