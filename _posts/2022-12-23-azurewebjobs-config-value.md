# 'AzureWebJobsAzureWebJobsStorage' does not exist

I created a new azure function app today, which I deployed to a dev azure subscription through a devops pipeline. I tested it via an http request and received a 500 error response. 

On checking application insights, I could see the following error:

> connection string 'AzureWebJobsAzureWebJobsStorage' does not exist

# Using Managed Identity
Recent Microsoft docs have suggested the function app references its storage account without holding any secret element of a connection string. This is described [here](https://learn.microsoft.com/en-us/samples/azure-samples/functions-storage-managed-identity/using-managed-identity-between-azure-functions-and-azure-storage/).

# Careful with the Package Version
I had followed the guidance and had a config setting in my function app as follows:

> AzureWebJobsStorage__accountName = "the name of my storage account"

I had a previous function app that was working ok and using the same method to reference its storage account. So, I started to compare Azure Functions nuget packages that each referenced.

I removed:
Microsoft.Azure.Functions.Worker.Extensions.Storage version 4.0.4

I added: 
Microsoft.Azure.Functions.Worker.Extensions.Storage.Queues version 5.0.0

This left me with the following azure functions package references - with the function app working :)

````xml
<PackageReference Include="Microsoft.Azure.Functions.Worker" Version="1.8.0" />
    <PackageReference Include="Microsoft.Azure.Functions.Worker.Extensions.Http" Version="3.0.13" />
    <PackageReference Include="Microsoft.Azure.Functions.Worker.Extensions.Storage.Queues" Version="5.0.0" />
    <PackageReference Include="Microsoft.Azure.Functions.Worker.Sdk" Version="1.7.0" />
    <PackageReference Include="Microsoft.Azure.Functions.Worker.Extensions.OpenApi" Version="1.4.0" />
````

<script src="https://utteranc.es/client.js"
    repo="RobBowman/RobBowman.github.io"
    issue-term="pathname"
    theme="github-light"
    crossorigin="anonymous"
    async>
</script>