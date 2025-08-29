# Azure DevOps

SmartGit provides integration with [Azure DevOps](https://learn.microsoft.com/en-us/azure/devops), including:
- Azure DevOps Services (Cloud)
- Azure DevOps Server (On Premises)

Once integration is configured, the following integrated functionality is available from within SmartGit:

- [Integrated Cloning](Integrated-Cloning.md)
- [Integrated Pull Requests](Integrated-PullRequests.md)
- [Integrated Commenting](Integrated-PullRequest-Comments.md)

## Setup

Azure DevOps integration is set up under **Preferences**, section **Hosting Providers** and under the **Add** button, select **Azure DevOps**.

This will the **Add Hosting Provider** dialog, prompting for an access token.

There are 3 ways to authenticate to Azure DevOps:
- Allowing SmartGit to automatically obtain a Token via [OAuth](#setup-using-oauth) (Recommended)
- Manually obtaining a [Personal Access Token (PAT)](#setup-via-personal-access-token) from Azure DevOps
- Setting up a [custom Azure DevOps Application](#setting-up-a-custom-azure-devops-application-for-smartgit) for SmartGit (For Azure DevOps Server - on prem / Advanced Users).

### Setup using OAuth

Clicking the **Generate token** button will open a Web Browser where you will need to authenticate with Azure DevOps, and you will need to confirm that you wish to provide SmartGit with access to your Azure DevOps organisation(s).

![Azure DevOps Application](../attachments/53215478/53215480.png)

Once you have confirmed this page, you will be redirected to *syntevo.com*, where the generated access code will be displayed on screen.

Use the **Copy to Clipboard** button to copy the access token to the clipboard, and then paste the token into the 'Code' field in the *Add Azure DevOps Account* dialog, and click **OK**.

The code will be used to create an *application access token* which will be used to populate the **Token** field in the Add Hosting Provider dialog.

SmartGit will place the masked token in the Token input, and you can click **Add** to complete the integration to Azure DevOps.

#### Note
> - If the browser does not open to Azure DevOps automatically, or if the browser opened to a different identity to the one you use on Azure DevOps, SmartGit will also show a hyperlink which you can use to initiate the authorization process with Azure DevOps.
> Copy the hyperlink and paste it into the browser that you use with Azure DevOps in order to resume the integration connection workflow.

> - If above procedure fails make sure to allow **Third-party application access via OAuth** in your Azure DevOps [Organization Settings](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/change-application-access-policies).
>
> ![Enable 3rd party Application Access via OAuth in Azure DevOps](../attachments/53215478/53215479.png)

#### Re-setup OAuth

Sometimes you may need to re-run the *OAuth* setup, e.g. if a more recent version of SmartGit requires additional scopes. 
Often, it is sufficient to just open **Preferences \| Hosting Providers**, select your Azure DevOps connection, and click **Edit**.
This will bring up the Configure Azure DevOps Account, where you can regenerate the access token using one of the methods listed under [Setup](#setup)

If this does not work as intended, take following steps to rerun the *OAuth* setup from scratch:

1. In SmartGit:
    1. Remove all Azure DevOps-related credentials from **Preferences**, section **Authentication**
    2. Remove the Azure DevOps hosting provider from **Preferences**, section **Hosting Providers**
2. In Azure DevOps, open your [profile](https://aex.dev.azure.com/me?mkt=en-US#) from the top-right corner:
    1. Select "Manage Authorizations":
       ![Azure DevOps Authorizations](../attachments/azure-app-revoke.png)
    2. Invoke **Revoke** for **SmartGit**
3. In SmartGit, rerun through the [Setup](#setup) actions again.

#### Setup with Multiple Accounts

If you have multiple Azure DevOps accounts, you can run through the above procedure for each of your accounts.
This requires to login for every account in your web browser before invoking **Generate Token**.

To have the **OAuth** token to work for multiple accounts, Git has to request credentials per-repository. 

To check if the proper configuration is already set, invoke:

```
git pull
```

in your repository. If Git request credentials only for `dev.azure.com`, try to configure:

```
git config --global credential.dev.azure.com.useHttpPath true
```

Then run `git pull` again to confirm that Git will now ask for the complete repository URL.

### Setup via Personal Access Token

As an alternative to OAuth, you can establish Azure DevOps integration by providing SmartGit with a Personal Access Token ("PAT").
PATs can be generated in the User Settings area of the Azure DevOps portal - please refer to Microsoft's [PAT documentation](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate).

#### Note:
> - For PATs to be usable by SmartGit, it's important that Organization access is set to **All accessible organizations** (even if you just have a single organization).
> - The scopes can be limited to **Code** - **Read&Write**.
> - PATs are valid for a maximum of 1 year. When a PAT expires, you will need to regenerate it.

![Azure DevOps PAT Scopes](../images/Integrations-DevOps-PAT.png)

### Setting up a Custom Azure DevOps Application for SmartGit

To get OAuth authentication working for Azure DevOps On-Premise instances or to avoid callbacks to `https://www.syntevo.com` you can set up a custom *Azure DevOps application* and configure SmartGit to use it for OAuth authentication.

#### Azure DevOps configuration

First, you have to create the application in your [Azure DevOps profile](https://app.vsaex.visualstudio.com/me?mkt=en-US). Click **Create new application**.

![](../attachments/azure-app-overview.png)

Then configure the application, with your custom **Authorization callback URL** and scopes **Code (read and write)** selected.

![](../attachments/azure-app-create-1.png)

![](../attachments/azure-app-create-2.png)

Once SmartGit initiates the OAuth authentication, Azure DevOps will return the initial code to the **Authorization callback URL**. The code will be passed as URL parameter `code`. This is what the user has to copy over to SmartGit's **Generate Token** dialog.

Finally, confirm with **Create Application**. Next, Azure DevOps will display the application details.

![](../attachments/azure-app-details.png)

#### SmartGit configuration

Now SmartGit has to be configured to authenticate with this custom application. Add following lines to `smartgit.properties` (in [SmartGit's settings directory](../Installation/Installation-and-Files.md#default-path-of-smartgits-settings-directory)):

```
smartgit.azure.oauth.appId=33A0E667-FA23-4759-A184-32FFA0F090E6
smartgit.azure.oauth.clientSecret=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im9PdmN6NU1fN3AtSGpJS2xGWHo5M3VfVjBabyJ9.eyJjaWQiOiIzM2EwZTY2Ny1mYTIzLTQ3NTktYTE4NC0zMmZmYTBmMDkwZTYiLCJjc2kiOiJkNDAwYzIxYy02ODZiLTQ5NTctODg4Zi1kMTI5ZmY3MTc4ZWMiLCJuYW1laWQiOiJlMDY1YmIyYi0wMjc4LTYwMWMtOTc4Ny0zMGI2NGY0ZWI2MDMiLCJpc3MiOiJhcHAudnN0b2tlbi52aXN1YWxzdHVkaW8uY29tIiwiYXVkIjoiYXBwLnZzdG9rZW4udmlzdWFsc3R1ZGlvLmNvbSIsIm5iZiI6MTY1MTgzMTY1OCwiZXhwIjoxODA5NTk4MDU4fQ.jCcLR77IZtl56KS9KS39hrtHPm4d4HtUyCu_Xv4c9V1zNSuXMRTL49TP02OHoP6aXqtq7PWhKxEMBXTYdGMCPBMXoxLBPwEJTW7wCWTQH9AFHikZnpeqBjYwO18a7vg7u69Hm-kp-X_0-Vsdg1rTLojM-DwyAn0Ceb8FqYdnLXzgXl7D6c5Ux6GNVt5oA8wFDiQIEq-9paPgE2FbJKQ7yUroODNC4G7WzVsp41UKU8BOIN2YQgmMA8QSXdhxQsHfwgdVSrHCKkiGTBznJCXhmZkKkUkJ9QikXQ8s3FHBDormbJtT_m3Yx8fn24Vrm0_b7WV-Y9HdoZi1selRHTZU9Q
smartgit.azure.oauth.appCallback=https://www.syntevo.com/test-callback
```

Note, that `clientSecret` is actually the **Client Secret** from Azure DevOps, not the **App Secret**!

### Repository access using "Generate Git Credentials"

If you are only interested in accessing your Azure DevOps Git repositories, but you don't need the additional *Azure DevOps Hosting Provider functionality* (e.g. managing pull requests in SmartGit), you may open the Azure website, navigate to your Azure DevOps repository, invoke **Clone** and then **Generate Git Credentials**. When SmartGit asks you for **User Name** and **Password** enter these credentials.
