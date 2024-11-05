# Set or Delete Property

Use **Properties\|Set or Delete property** to change a property for
multiple files/directories at once.

Enter the name of the **Property**; the drop-down button offers the SVN
internal properties for selection. To set a property value, either
select **Set Value To** and enter the new property value, or, in case of
boolean SVN-properties, select **Set boolean property**. To remove the
property, select **Delete Property**.

For directories, choose to **Recurse into subdirectories** and
optionally to **Include this directory**. Choose **Force** to skip a
couple of checks which are performed for certain property (values).



#### Example
>
>
>
>To get rid of all *explicit mergeinfo* from your project except from the
>project root, select `svn:mergeinfo` for **Property**, choose **Delete
>Property** and **Recurse into subdirectories** and deselect **Include
>this directory**.
>
>
