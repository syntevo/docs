# File Compare

The *File Compare* window shows the contents of two files, one in the
left and one in the right area of the window. A File Compare is
typically invoked via **Query\|Show Changes** from the [Project Window](Project-Window.md#ProjectWindow-project-window) but
there are other ways to invoke a File Compare in SmartSVN. Together with
a File Compare, a [Properties Compare](Properties-Compare.md#PropertiesCompare-properties-compare)
can be invoked, if properties of the files to compare are different as
well.


#### Note
>
>
>Depending on your Preferences, performing a file comparison can also
>invoke an external file compare tool. This section refers only to the
>built-in *File Compare* of SmartSVN.
>
>

Depending on the source of the compared files (local working copy,
repository), none, only the right, or both editors in the File Compare
window may be editable. Depending on the invoking command, when a
*copied* file is compared and the copy source file is *removed*, the
pristine copy of the source file will be used for the comparison,
provided that its contents are available.


#### Tip
>
>
>If the file compare refuses to compare a file because it's *binary*,
>check the corresponding
>[MIME-Type](MIME-Type.md#MIME-Type-commands.mime-type)
>property. Regarding the used encoding, refer to [Text File Encoding](Project-Settings.md#text-file-encoding).
>You can also configure to the set MIME-Type and auto-detect the type in
>the Preferences.
>
>

## Comparison

The file contents are compared line-by-line, where the underlying
algorithm finds the minimum number of changed lines between the left and
the right content. The differences between left and right content is
highlighted by colored regions within the text views, which are linked
together in the center *Link Component*. The Link Component allows to
take over changes from one side to the other, depending on which side is
editable.


#### Tip
>
>
>When the mouse is positioned over the Link Component, you can use the
>mouse wheel to jump from difference to difference.
>
>

Depending on the Preferences, not only complete lines, but also the
content within lines is compared if they are not too different. These
comparison results in *inner-line* changes. You can take over such
changes from left to right or vice versa with **Apply Left** and **Apply
Right**, respectively, from the popup menu (invoked on the change
itself).

## General Settings

The **Tab Size** specifies the width (number of characters) which is
used to display a `TAB` character. With **Show whitespaces** whitespace
characters will be displayed. With **Show line numbers** a line number
gutter will be prepended.

Select **Remember as default** to have the selected options apply to all
File Compare frames.

For basic settings regarding text components, refer to the Preferences.

## Compare Settings

If **Ignore whitespace for line comparison** is selected, two lines are
treated as equal, if they only differ in the number, but not in the
position of whitespaces.

If **Ignore case change for line comparison** is selected, uppercase and
lowercase characters are treated as equal.

The **Inner-Line Comparison** specifies the 'tokenizing' algorithm of
the lines, for which the individual tokens within two lines will be
compared against each other. **Alphanumeric words** results in tokens,
which form alphanumeric words, i.e. words, which are consisting only of
letters and digits and which are starting with a letter. All other
characters are considered as tokens on their own. **Character-based**
treats every character as a single token. This is the most fine-grained
comparison option. **C identifiers** and **Java identifiers** are
similar to **Alphanumeric words**, but in addition to letters and digits
certain other characters are allowed to be part of a single token.
**Off** completely disables the inner line comparison, i.e. every line
is considered as single token.

With **Trim equal start/end of Inner-Line changes** selected and two
tokens being different, the equal starting and ending characters within
both tokens won't be displayed. For instance, for the tokens `foobar`
and `foupar` the difference will only display as `up`.

Select **Remember as default** to have the selected options apply to all
File Compare frames.
