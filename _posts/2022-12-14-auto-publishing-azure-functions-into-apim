# Automatically Publishing Azure Functions into Apim

## Acknowledgement
I'd like to start by saying I was able to find answers to several problem in an excellent [blog post](https://devkimchi.com/2022/03/02/publishing-openapi-doc-from-azfunc-to-apim-within-cicd-pipeline/) from Justin Yoo.

## Requirement
A benefit of Azure Api Management is the ability to route requests to Azure functions. Due to the fact that the majority of our Azure Functions will be accessed via APIM, the ability to automatically publish the API as part fo the devops pipeline process is valuable.

## Structure
The devops process is made up of two pipelines:

+ Scaffolding - to provision to Azure resource required by the app
+ Build & Release - compile the function app and release to target environment

## Target 
To meet the requirement, the following steps will be completed

+ function app and dependencies such as storage account, key vault etc. deployed into Azure
+ a *get* http request issues from the devops agent to the func app's swagger endpoint
+ swagger definition persisted to blob storage
+ devops provisions APIM api using bicep and swagger definition

In order to implement these steps, several infrastructure / security hurdles have to be overcome.

## Scaffolding
An illustration of the scaffolding process is shown below:

![scaffolding](/images/auto-publishing-to-apim/scaffolding.png)

This begins with the devops pipeline [run-bicep.yml](../scaffolding/run-bicep.yml). The main steps of this pipeline are:
 
+ use existing yaml template to "build & scan" the main scaffolding bicep template
+ run the main bicep
+ add function app key to key vault

# Build and Release

An illustration of the build and release process is shown below:

![scaffolding](/images/auto-publishing-to-apim/build-and-release.png)


In contrast to the scaffolding stage where most of the work is done by the bicep template, for build and release, most of the work is run from the yaml devops pipeline.

This begins as a conventional pipeline for a function app with tasks to:

+ build
+ execute tests
+ publish function app to a zip
+ archive zip as a pipeline artefact, to be retrieved by the pipelines next stage

With the deployable zip now available, the pipeline has a deploy stage for each target environment: dev, int, act and prod. This contains the following tasks:

+ deploy zip from build stage into function app provisioned by the scaffolding bicep
+ get ip address of devops build agent by sending a curl request to http://ipinfo.io/ip
+ run PowerShell to add a network access rule to allow access to the function app from the devops agent
+ wait 30secs for function app to start
+ run PowerShell's Invoke-RestMethod to get the swagger definition from the function app 
+ run PowerShell to remove the previously added network access rule
+ PowerShell to write the swagger definition to blob storage
+ run a bicep module to provision the apim components as described below

## Apim Components
For apim to successfully route requests to the function app, several related components must be deployed:

+ a 'named value' refers to the key vault secret that holds the function key
+ a 'backend' that contains the url of the target azure function and a link to the 'named value' above
+ an 'api' which is a collection of 'operations'. This is created by importing the swagger definition that was published to blob storage earlier in the pipeline
+ one or more policies, to be applied at 'operation' or 'api' scope

### api policies
These are defined in xml, as per the example below:

````xml
<policies>
    <inbound>
        <base />
        <set-backend-service id="apim-generated-policy" backend-id="backend-func-nurseryfees-dev-001" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
````

