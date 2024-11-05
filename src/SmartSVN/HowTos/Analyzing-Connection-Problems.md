# Analyzing Connection Problems

If you are having problems to connect to the repository using SmartSVN,
e.g., after you had changed proxy settings in TortoiseSVN (even if it
has been uninstalled), please check the registry whether
`HKEY_CURRENT_USER\Software\Tigris.org\Subversion\Servers\global\`
exists and contains inappropriate values for `http-proxy-host`,
`http-proxy-port`, `http-proxy-username`, `http-proxy-password` or
`http-proxy-timeout`.
