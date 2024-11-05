# SSH

## Create private key

To create a private/public key pair, execute following command in a
Terminal:

`$ ssh-keygen -t ed25519`

If you have connection problems, try with this command instead:

`$ ssh-keygen -t rsa -b 4096 -m PEM`

Then update/save the public key to `~/.ssh/authorized_keys` on the Git/SSH server.

### Converting an existing private key to PEM-format

If you have a private key file with an unsupported format, use this command in a Terminal to convert it:

`$ ssh-keygen -f <private_key_file> -p -m PEM`

It will prompt for the old passphrase once (if any) and for the new
passphrase twice.

## Windows 10: Configure OpenSSH Client

- ensure the optional Windows feature **OpenSSH Client** is installed
- ensure the service **OpenSSH Authentication Agent** has at least the *manual* startup type (by default: *disabled*)
- start the service, e.g. by invoking `ssh-agent` (if you get the output `unable to start ssh-agent service, error :1058`, the service most likely is in *disabled* state).
- tell the SSH agent about your private key file:

`$ ssh-add <path-to-private-key-file>`

- if you are using the Git bundled with SmartGit (which contains an SSH executable) or *Git for Windows* installed without the option *Use external OpenSSH*, you will have to tell Git to use the Windows 10 SSH client:
  - set the environment variable `GIT_SSH` to `C:/Windows/System32/OpenSSH/ssh.exe`
  - if SmartGit is already started, restart it so it picks up the environment variable change
- on the SmartGit preferences page *Authentication* select the option *Use system SSH client*.


## Windows: Configure PuTTY and Pageant

### Create your public/private key pair

Use **PuTTY Key Generator** (`puttygen.exe`) to create a new
public/private key pair and save to a location of your choice. Usually
the private key file ends with `.ppk`. It is recommended to use strong
passphrase.

### Tell you SSH server your public key

Copy/paste the long text (actually a long single line) from the large
"Public key" input field in PuTTY Key Generator to the
`~/.ssh/authorized_keys` file of your SSH server or paste to the
appropriate input field of your Git/SSH hosting provider.

### Tell Git to use Plink

Set the environment variable `GIT_SSH` to point to `plink.exe`.

### Start Pageant

Start **Pageant** (`pageant.exe`) which only will show a small icon in
the system tray. Double click that and add your private key file(s) -
those created in the previous step with the PuTTY Key Generator and the
`.ppk` extension - by providing their locations and passphrases.

It looks like Pageant does not remember your private keys and
passphrases, so you have to re-add them again after each start of
Pageant.
