# Internationalization (for developers/authors)


#### Info
> This page is only intended to be read by internationalization developers/authors.
> If you are a user who is interested in a localized SmartGit GUI, vote for [smartgit.userecho.com/communities/1/topics/76-](https://smartgit.userecho.com/communities/1/topics/76-internationalization-support).

#### Note
> If you want to help us to translate SmartGit to your language, please contact us at <smartgit@syntevo.com> (in English, please ![](images/icons/emoticons/smile.png)).

# Switching the SmartGit GUI to a certain locale

You can switch SmartGit to supported non-English locales in the **Preferences**, **User Interface**, **Language**.

# Contributing translations

SmartGit translations are managed in the public repository <https://github.com/syntevo/smartgit-translations>.
Contributing to translations happens in two ways:

-   translating not yet translated texts from a language mapping file, like [zh-CN/mapping_dev.zh_CN](https://github.com/syntevo/smartgit-translations/blob/master/zh-CN/mapping_dev.zh_CN)
-   i18n development mode (translation changes are reread automatically)

## Translating existing texts from language mapping files

This requires only minimal effort on your side, however you will not immediately benefit from your translations but you have to wait until they have been incorporated into the next SmartGit build.

-   fork the [smartgit-translations](https://github.com/syntevo/smartgit-translations) repository in GitHub
-   apply your translations to [zh-CN/mapping_dev.zh_CN](https://github.com/syntevo/smartgit-translations/blob/master/zh-CN/mapping_dev.zh_CN)
-   send us a pull request to incorporate your translations

## I18n development mode

This requires an initial setup effort but rewards you by seeing your translations immediately.

1.  Fork the [smartgit-translations](https://github.com/syntevo/smartgit-translations)  repository in GitHub and get a local clone of your fork to your disk.
    For subsequent explanations, we assume the clone to be located in `D:\smartgit-translations`.

2.  To put SmartGit into i18n development mode, add following properties to [smartgit.properties](../Latest/System-Properties.md):

    ```
    smartgit.i18n=<locale>
    smartgit.debug.i18n.development=<development-directory>
    smartgit.debug.i18n.master=<repo-root>/mapping
    ```

    Replace `<locale>` by the locale you want to work with and set `<development-directory>` to the appropriate locale's sub-directory of the translation repository.
    For example:

    **Example**

    ```
    smartgit.i18n=zh-CN
    smartgit.debug.i18n.development=D:/smartgit-translations/zh-CN
    smartgit.debug.i18n.master=D:/smartgit-translations/mapping
    ```



3.  Exit and restart SmartGit

### Layout of the development area

In i18n development mode following files will be created in the development directory:

-   `mapping.<locale>`: the validated and reformatted version of `mapping_dev.<locale>`; it will be rewritten on every restart of SmartGit, and during the program run, too, if changes to `mapping_dev.<locale>` have been detected
-   `unmapped.<locale>`: mappings which are present in the master mapping file (`smartgit.debug.i18n.master`) but which are not yet present in `mapping.<locale>`
-   `unknown`: texts which have been detected at runtime but which are not yet present in the master mapping file
-   `mapping`: an extended version of the 'master' file which also contains newly detected `unknown` mappings

`mapping_dev.<locale>` is the only file which you should edit.
**All other files will be rewritten by SmartGit and thus changes will be lost!**


#### Warning
> The `mapping_dev.<locale>` will be reread by SmartGit when creating GUI elements, hence it will usually work well to modify and save this file, reopen a dialog or window and already see the results of the modification.

### Content of a mapping file

Mapping files are basically key-value files, where the key represents a certain piece of text in SmartGit and the value represents its translation.
Keys and values (translations) are separated by '='.
Keys may consist of prefixes, hard-coded constants and (dynamic) text which has been detected during runtime.
(Dynamic) text will be enclosed in quotes.


#### Example


> `dlgSgCommit.btn"Commit"=提交       `
> 
> consists of the prefix `dlg` which denotes a dialog, the hard-coded
> constant `SgCommit` which represents the Commit-Dialog, the prefix `btn`
> which denotes a button (in this dialog), and the detected (dynamic) text
> "Commit". The translation for this key will be `提交`.

There are also special mappings, called "macros" which are starting with ':' and which can be thought of as "pre-processor" directives.
Macros will be used to substitute regular mapping values when writing the `mapping.<locale>` file.


#### Example

> ```
> :\*"Git-Flow"=Git工作流
> ```
> will replace every "Git-Flow" text by "`Git工作流`" when writing
> `mapping.<locale>`. Thus, following lines:
> 
> ```
> wnd(Log|Project).mnu"Git-Flow"=Git-Flow
> wnd(Log|Project).tbr"Git-Flow"=Git-Flow
> ```
> will turn to:
> ```
> wnd(Log|Project).mnu"Git-Flow"=Git工作流
> wnd(Log|Project).tbr"Git-Flow"=Git工作流
> ```

For keys, following meta characters are supported to create patterns which may match multiple 'simple' keys in SmartGit:

-   `\` - escape character to escape itself or other meta characters
-   `*` - match zero or more characters
-   `$` - variable start
-   `(,),|` - "or"-group
-   `%` - variable count
-   `[,],{,}` - reserved, but not yet used

For values (=translations), following meta characters are supported:

-   `$` - variable start

The wildcard match (`*`) is expensier to process and for regular mappings should only be used for a very small amount of keys, like "OK"-Buttons.
It's fine and even encouraged to use `*` within macros.
Actually, the `*` is even the reason why macros exist: instead of having many `*`-patterns at runtime which are expensive to process for SmartGit (for every user running SmartGit), the expensive matching is done at translation development time (only once per developer).

Variables are of the form `$1`, `$2`, ... and can be used to match a piece of text in the key and substitute the corresponding variable in the translation by this text.


#### Example
> `dlgSgSvnClientCertificate.wrn"Authentication to the SVN repository '$1' failed with error: $2"= 对SVN版本库'$1'的身份验证失败，错误：$2'`

For certain, unique keys, the matching happens indirectly by using the master mapping.
This allows to skip the dynamic text part from the key.
Still it's necessary to declare the variables used in the mapped translation and this is where `%` will be used.


#### Example

> `dlgQProxyConnectionFailed.hdl%1=无法连接到 $1.`

"or"-groups are used to summarize identical translations for a set of keys.


#### Example

> `wnd(Log|Project|Compare|ConflictSolver).mniWindow-fullScreen=全屏`

If a special character needs to be used *literally* in a key or value, it has to be escaped using `\`.


#### Example
> ```
> wnd(Log|Project).tab"Changes of $1 - $2"=$1 的变化 - $2
> wnd(Log|Project).tab"Changes of $1 - $2 \($3\)"=\
>  $1 的变化 - $2 \($3\)
> wnd(Log|Project).tab"Changes of $1 \($2\) - $3"=\
>  $1 的变化\($2\) - $3
> wnd(Log|Project).tab"Changes of $1 \($2\)"=$1 的变化\($2\)
> wnd(Log|Project).tab"Changes"=的变化
> ```
> are the translations of the various forms of the 'Changes' tab title in the Log window.



For long mappings, `\` after the `=`-separator can be used to wrap the mapping.


#### Tip
> If SmartGit suddenly fails to pick up modifications of the mapping file, this may be caused by invalid/unparsable lines.
> In this case try to restart SmartGit.
> If anything is wrong with the mapping file, SmartGit won't start up and a corresponding error message is logged to `logs/log.txt.0` in the Settings directory.



### Contributing changes to language mapping files

To contribute your changes to a language mapping file:

1.  setup SmartGit as explained above (we assume your repository located  at `<repo>` and your development directory located at `<dev>`)
2.  apply your changes to `<dev>/mapping_dev.<locale>`
3.  test the changes
4.  wait until SmartGit has rewritten `<dev>/mapping_dev.<locale>` to `<dev>/mapping.<locale>` (as long as you stick to the formatting rules, these files should be identical now)
5.  copy `<dev>/mapping.<locale>` over to `<dev>/mapping_dev.<locale>` (to continue your work with the reformatted version)
6.  commit and push your changes of `<dev\>/mapping_dev.<locale>` to your GitHub fork
7.  send us a pull request

### Contributing changes to the master mapping

While SmartGit is in i18n development mode, it will collect not yet known text pieces in the `unknown` file.
This is what we are doing ourselves during SmartGit development and which serves as foundation for extending the master `mapping` file (see above).
Contributing changes to this file is similar to language mapping files:

1.  setup SmartGit as explained above (we assume your repository located  at `<repo>` and your development directory located at `<dev>`)
2.  use SmartGit to collect new changes in `<dev>/unknown`; these changes will at the same time be combined with known changes and  written to `<dev>/mapping`
3.  copy `<dev>/`mapping over to `<repo>/mapping` (this is the versioned file in the translations repository)
4.  review changes to `<repo>/m`apping using Git's diff (e.g. in the Changes view in SmartGit)
5.  **tricky part**: in `<repo>/mapping` try to figure out which of the changes are static and which are dynamic text and replace the dynamic text
    1.  by **variables ($) in key and value** if the key actually contains the dynamic text in quotes
    2.  by **variable count (%) in key and variable ($) in value** if the key does not contain the dynamic text (i.e. if there are no quotes)


		#### Tip
		> Usually, it's a good idea to trigger the display of the text with dynamic content in a way that the dynamic content changes (e.g. by applying a certain operation to two different branches or commits).
		> This way, SmartGit will log both text pieces (which only differ in the dynamic part) to `unknown` and it will become easy to join these separate lines into one line by substituting with variables.


6.  exit SmartGit
7.  get rid of the those lines from `<dev>/unknown` which you have processed
8.  restart SmartGit
9.  immediately after starting up, SmartGit should rewrite the `<dev>/mapping` file from your updated `<repo>/mapping` and the reduced `<dev>/unknown` file
10. continue working with SmartGit and retrigger the operation for which you have extended the `mapping` file with even different dynamic content; now SmartGit should not add anymore lines to `<dev>/unknown` (check this)
11. commit and push your changes of `<repo>/mapping` to your GitHub fork
12. send us a pull request

We will review your pull request and apply, or ask for further changes related to static-vs-dynamic texts.
