# External Tools: configuring a 3-way diff

You can set up custom external 3-way diffs which can be invoked from a
**File Log**:

1.  In the **Preferences**, be sure to have **Low-level
    property** `tools.useFileLogPathInsteadOfRepositoryRoot` set
    to `true`. This is necessary to have the externals tools
    variable `${repositoryRootPath`} providing the path to the logged
    file instead of just the path to the repository root.

2.  Create a *bash* script wrapper, similar to the one below:



    ``` java
    #!/bin/bash
    includeWt=0
    windows=0
    POSITIONAL=()
    while [[ $# -gt 0 ]]
    do
      key="$1"
      case $key in
        --include-wt)
          includeWt=1
          shift
          ;;
        --windows)
          windows=1
          shift
          ;;
        *)
          POSITIONAL+=("$1")
          shift
        ;;
      esac
    done
    set -- "${POSITIONAL[@]}"

    abspath=$1
    if [ $windows == 1 ]; then
        abspath=$(echo "$abspath" | sed 's/\\/\//g')
        abspath=$(echo "$abspath" | tr '[:upper:]' '[:lower:]')
    fi

    commit=$2
    difftool=$3

    repo=$(cd "$(dirname "$abspath")" && git rev-parse --show-toplevel)
    if [ $windows == 1 ]; then
        repo=$(echo "$repo" | tr '[:upper:]' '[:lower:]')
    fi

    relpath=$(realpath --relative-to="$repo" "$abspath")

    cd $repo
    theirs=$(mktemp "/tmp/diff.XXXXXX")
    git show $commit:$relpath > $theirs

    if [ $includeWt == 0 ]; then
      ours=$(mktemp "/tmp/diff.XXXXXX")
      git show HEAD:$relpath > $ours
    else    
      ours=$abspath
    fi

    mergebase=$(git merge-base HEAD $commit)

    base=$(mktemp "/tmp/diff.XXXXXX")
    git show $mergebase:$relpath > $base

    "$difftool" $ours $theirs $base
    ```



3.  In the **Preferences**, configure this tool for your custom diff
    program, for example:  
    ![](attachments/18677790/18677789.png)  
      
    Note the optional usage of `--include-wt` which will use the current
    working tree file, instead of the clean version of the file from  
    `HEAD`. `--windows` signals the wrapper that it will be called on a
    Windows platform (which requires some special handling).

4.  Now, in the **File Log**, you can select a target commit to diff
    your current working tree file (or HEAD) with and invoke the tool
    from the **Commits** graph context menu.

  

  

  

  


