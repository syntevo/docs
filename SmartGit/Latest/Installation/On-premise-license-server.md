# On-premise License Server

To monitor seat usage for a large number of users, it may be convenient to install our *On-premise License Server*.
This will be especially important if the SmartGit installations of your users are not allowed to connect to our central cloud license server.

## Requirements

To run our on-premise server, only Docker is required. This document describes how to set up the *On-premise License Server* in a plain docker environment. If you need to run the server in a more sophisticated environment, like in Kubernetes, please contact our support. Please also note, by default the *On-premise License Server* uses an embedded database that will store data in a volume. Running multiple instances of the *On-premise License Server* in a Kubernetes environment is not supported.

## Server-side installation

1. Contact sales@syntevo.com and provide a short explanation of your environment and SmartGit setup to understand whether an on-premise license server will be appropriate for your company.

1. If appropriate, you will receive a new *on-premise license file*

1. Provide your GitHub username: You need *GitHub credentials* to access the [GitHub packages](https://github.com/users/syntevo/packages/container/package/license-opserver).

1. Create a GitHub Personal Access Token to log in with Docker:

   1. Go to https://github.com/settings/tokens

   1. Click on **Generate Token** and select **Generate new token (classic)**

   1. Configure only the **read:packages** scope

1. From the command line, log in to the GitHub Docker repository:

   ```
   docker login ghcr.io -u <username> -p <pat>
   ```

   For the above command, replace `<username>` with your GitHub username and `<pat>` with the Personal Access Token you have just created.

1. Pull the Docker image:

   ```
   docker pull ghcr.io/syntevo/license-opserver:latest
   ```

1. Prepare host directories for the Docker volumes

   1. On the target server where the Docker image will be run, create a top-level directory `<license-server-root>` which will contain the persistent data of the license server, for example, `/var/syntevo-license-server`.

   1. In this directory, create a sub-directory named `licenses`.

   1. Put the *on-premise license file* you have received from us into this directory. Use a reasonable name that reflects the product, e.g., `smartgit` in the case of a SmartGit license.

1. Start the license server:

   ```
   docker run --restart unless-stopped --name syntevo-license-server -d -v <license-server-root>/data:/data -v <license-server-root>/licenses:/licenses -p 8080:8080 ghcr.io/syntevo/license-opserver:latest
   ```

   For the above command, replace `<license-server-root>` with the actual top-level directory, for example:

   ```
   docker run --restart unless-stopped --name syntevo-license-server -d -v /var/syntevo-license-server/data:/data -v /var/syntevo-license-server/licenses:/licenses -p 8080:8080 ghcr.io/syntevo/license-opserver:latest
   ```

1. Confirm that the license server has been properly started:

   ```
   docker ps | grep syntevo-license-server
   ```

### Logs

Once the Docker container is running, you can check the logs using:

```
docker logs -f syntevo-license-server
```

### Offline installation

If you're unable to directly connect to `ghcr.io` from your server, you have the option to create a tarball for offline installation.

1. On a machine that has access to `ghcr.io`, follow the steps mentioned above to pull the image.

1. Use the following command to create the tarball:

```
docker save -o syntevo-license-opserver.tar ghcr.io/syntevo/license-opserver:latest
```

1. Transfer the `syntevo-license-opserver.tar` to your server.

1. Import the image on your server using the command:

```
docker load -i syntevo-license-opserver.tar
```

## SmartGit Setup

### Configuration by system property

We recommend deploying SmartGit with the [system property](System-Properties.md) `smartgit.opLicenseServer.url` pre-configured, so the license server will be contacted automatically on startup. For example:

```
smartgit.opLicenseServer.url=http://localhost:8080/v1
```

### Configuration during Setup

If required, users can configure the license server on-the-fly during setup:

1. In the Setup wizard, on the **License** page, select **Register existing license**.

1. In the lower right area of the wizard, click **Have an on-premise license server**.

1. For the upcoming **License Server URL** text field, enter the URL of the license server, e.g., `http://localhost:8080/v1`.

### Configuration after Setup

If SmartGit has already been started in evaluation mode and you want to switch to the license server, invoke **Help\|Register** and follow the instructions from the above section.

### Distribution of License Files

Once the license server has been configured properly in SmartGit, SmartGit will request a new license file on every startup and at regular intervals during the program run. A license file is valid for 30 days. To ensure that there are no interruptions, it will be necessary to allow SmartGit to connect to the license server during the current license file's validity to update to a new license file.

## Checking user permissions against LDAP/Active Directory

You can configure the on-premise license server to check authorization to use SmartGit against an LDAP/Active Directory. **Be advised that this is not an authentication!** SmartGit just reads the name of the currently logged-in user from the system environment and transmits this to the server as a string, without any password checks involved:

* On Windows, this is `USERNAME`
* On MacOS/Linux, this is `USER`

### Configure SmartGit

Configure SmartGit to read the logged-in user on the client and send it to the license server. For this, just append `?verify=ldap` to the property `smartgit.opLicenseServer.url`, e.g.:

```
smartgit.opLicenseServer.url=http://localhost:8080/v1?verify=ldap
```

### Configure License Server

You can configure the on-premise server LDAP functionality using environment variables that you set for your container:

* `LDAPACTIVE=true`: to enable LDAP query functionality
* `LDAPQUERY`: the LDAP query with which to query your LDAP; you can use `{0}` as part of this query which will by replaced with the username sent by the client
* `SPRING_LDAP_URLS`: the hostname(s) you want to connect to; if multiple LDAP servers are available, you can set them comma-separated
* `SPRING_LDAP_USERNAME`: the username which the license server will use to connect to LDAP
* `SPRING_LDAP_PASSWORD`: the password (you are advised to use Docker/Kubernetes secrets for this)
* `SPRING_LDAP_BASE`: root node to start the search in; we'll always do a subtree search

#### Example
> A Linux/MacOS example for starting the on-premise license server which queries the Active Directory:
>```
>docker run --restart unless-stopped --name syntevo-license-server -d -v /var/syntevo-license-server/data:/data -v /var/syntevo-license-server/licenses:/licenses -p 8080:8080 -e LDAPACTIVE=true -e LDAPQUERY='(&(objectClass=user)(userPrincipalName={0}))' -e SPRING_LDAP_URLS=ldap://ad.syntevo.com -e SPRING_LDAP_USERNAME='uid=admin' -e SPRING_LDAP_PASSWORD=secret -e SPRING_LDAP_BASE='dc=syntevo,dc=com' ghcr.io/syntevo/license-opserver:latest
>```
>
> Notes:
> * Some parameters are enclosed by single-quotes (`'`). On Windows, you will have to use double-quotes (`"`).
> * The Active Directory server is located at `ldap://ad.syntevo.com` and runs on the default port.

#### Example
> A Windows example for connecting to a local LDAP server (e.g. for testing):
> ```
> docker run --rm --network syntevo-op-server --name syntevo-license-server -v D:\license-server\.op\data:/data -v D:\license-server\.op\licenses:/licenses -p 8080:8080 -e LDAPACTIVE=true -e LDAPQUERY="(&(objectClass=person)(uid={0}))" -e SPRING_LDAP_URLS="ldap://syntevo-license-ldap-server:8389" -e SPRING_LDAP_USERNAME="uid=admin" -e SPRING_LDAP_PASSWORD=secret -e SPRING_LDAP_BASE="dc=springframework,dc=org" ghcr.io/syntevo/license-opserver:latest
> ```
>
> Notes:
> * We are using double-quotes (`"`). On Windows, you will have to use single-quotes (`'`). 
> * We are assuming that `D:\license-server\.op` contains both `data` and `licenses`.
> * Both, the local LDAP server and the on-premise license server run on the same Docker network `syntevo-op-server`.
> * The image of the LDAP server is `syntevo-license-ldap-server` which results in URL `ldap://syntevo-license-ldap-server:8389`; it serves `dc=springframework,dc=org`.
> * We are using `--rm` to re-create the container from scratch with every invocation.

We use Spring Boot (currently at version 2.7) with its built-in LDAP functionality. Please refer to the [Spring Boot documentation](https://docs.spring.io/spring-boot/docs/2.7.18/reference/html/application-properties.html#appendix.application-properties) to find additional LDAP properties that the framework supports.

In case you need to connect to your LDAP using SSL, you need to set up keystore and truststore in the container using [standard JVM properties](https://docs.oracle.com/en/java/javase/11/security/java-secure-socket-extension-jsse-reference-guide.html#GUID-460C3E5A-A373-4742-9E84-EB42A7A3C363). This requires modifying the container startup arguments, so it is a more advanced use case. Please get in touch with us should you have this requirement.

## Reporting

The license server provides a reporting endpoint which is meant to be used by administrators only. It is protected by HTTP basic authentication.

1. Find out password: By default, a random password is generated for every startup which is logged to the Docker log file. To find out the password, invoke:

   ```
   docker logs license-opserver | grep "Reporting: "
   ```

1. Invoke the `reportOp` endpoint:

   ```
   curl -u admin:<password> <license-server-url>/v1/reportOp?type=<type>
   ```

   1. `<password>` needs to be replaced by the current password.
   1. `<license-server-url>` needs to be replaced by the root URL of your on-premise license server.
   1. `<type>` specifies the report type: `raw`, `user` or `masterLicense`

#### Note
> You can specify a custom admin password, by adding the Docker environment variable `-e ADMIN_PASSWORD=<password>`, for example:
> 
> ```
> docker run -e ADMINPASSWORD=mysecretpassword --restart unless-stopped --name syntevo-license-server -d -v /var/syntevo-license-server/data:/data -v /var/syntevo-license-server/licenses:/licenses -p 8080:8080 ghcr.io/syntevo/license-opserver:latest
> ```

### Raw Usage Data

The report type `raw` provides detailed, low-level usage information and has the following format:

```
curl -u admin:<password> <license-server-url>/v1/reportOp?type=raw[&from=<from>&to=<to>]
```

Optional parameters `<from>` and `<to>` specify the time range for the `raw` report. If either `<from>` or `<to>` is present, the other must also be included.

#### Example
> ```
> curl -u admin:ebc89b1511c6eaf29921d7f9219b608e383384df3ac161287d80c39911e10eb4 "https://syntevo.com/license-server/v1/reportOp?type=raw&from=2000-01-01&to=2030-12-31"
> ```

### User Data

The report type `user` provides a high-level summary of usage, with data aggregated per user:

```
curl -u admin:<password> <license-server-url>/v1/reportOp?type=user
```

### Master License

The report type `masterLicense` provides an executive summary, with data aggregated per master license:

```
curl -u admin:<password> <license-server-url>/v1/reportOp?type=masterLicense
```

## Debugging

### Manually requesting a license file from the command line

For testing purposes, it may be convenient to manually perform the same kind of license request that SmartGit will use. For a server running at `http://localhost:8080`, sending an example request using *curl* might look like:

```
curl -X POST http://localhost:8080/v1/licenseOp -H "Content-Type: application/json" -d "{ \"Build\": 20118, \"Email\": \"someone@example.com\", \"HardwareHashes\": { \"wmg\": \"foo\", \"wvi\": \"bar\" }, \"MajorVersion\": \"23.1\", \"MinorVersion\": \"23.1.1\", \"OperatingSystem\": \"windows\", \"Product\": \"SmartGit\" }"
```
