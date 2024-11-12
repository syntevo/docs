# Sign Tags and Commits

## Windows
- install Gpg4win (verified with Gpg4win 3.1.16)
- run `gpa.exe` (usually found in `C:\Program Files (x86)\Gpg4win\bin` and create a key pair securing it with a passphrase
- in SmartGit [Repository \| Settings](../Latest/Repository-Settings.md), tab "Signing", configure the full path to the `gpg.exe` (usually found in `C:\Program Files (x86)\GnuPG\bin`) and enter the *Key ID* of your created key pair
- if necessary, select "Sign all commits"
- when committing a file or tagging, a popup of GPG will occur and ask you for the key's passphrase

## MacOS
- install [GPG Suite](https://gpgtools.org/)
	- this will start the **GPG Keychain** application and ask for creating a new key pair; do that
	- right-click your new key pair and select **Details**; in the occurring window find your **Key ID**
- in SmartGit [Repository \| Settings](../Latest/Repository-Settings.md), tab "Signing", enter `/usr/local/bin/gpg` as *GPG Program* and enter the *Key ID* of your created key pair
- if necessary, select "Sign all commits"
- when committing a file or tagging, a popup of GPG will occur and ask you for the key's passphrase

#### Note
> If you encounter errors like "Couldn't load public key &lt;my-key&gt;", please check whether `gpg.format` is set correctly.
> If in doubt, unset it.