# Using the Built-In File Connector for On-Prem Files
Previously, we'd been accessing on-prem files from logic apps via the on-prem data gateway, as illustrated below:

![](/images/logic-apps-in-asev3/managed-connector.png)

This worked ok but there's a couple of issues:

+ there's a cost for each execution of the managed connector - and we have lots of files to move!
+ we have to maintain the on-prem Windows Server that hosts the on-prem data gateway service

## ASEv3
I tried a quick test by swapping out the managed file connector for the new (currently preview) "built-in" connector. The designer in the Azure portal refused and gave a helpful message informing me that the built-in file connector can only run in an App Service Environment.

The new design is shown below:

![](/images/logic-apps-in-asev3/built-in-connector.png)

When provisioning the ASE, I assigned it to an existing vnet. I had to provide a new dedicated subnet for it. It took approximately 4 hours but then I had an ASE which was able to reach the on-prem network over out site-2-site vpn.

## Jumpbox Needed
One complication with the ASE is debugging logic apps. Because they run in a dedicated subnet, in order to debug via the Azure portal, you must open in a browser from a machine that has connectivity to the subnet. To solve this problem in my PoC I made use of a VM "jumpbox" running in the same vnet as the ASE. I don't see this as a major issue since it's now possible for developers to run logic apps in their local environment (VS Code).

## Pricing
A requirement of the "built-in" file connector is that it is hosted by a logic app running in an App Service Environment.

Logic apps standard hosting cost without ASE (Logic Apps Standard Plan) = £156 per vCPU / month. This gives 1 vCore, 3.5gb ram, 250 gb storage
ASEv3 requires an Isolated v2 Service Plan. The cheapest is an I1v2 which has 2 cores, 8gb ram and 1tb storage. Standard cost is £342 per month. Up to 1st Jan 2023 there was a 45% discount available for a 3 year commitment. This discount has now reduced to 22%

 ![](/images/logic-apps-in-asev3/pricing.png)

<script src="https://utteranc.es/client.js"
    repo="RobBowman/RobBowman.github.io"
    issue-term="pathname"
    theme="github-light"
    crossorigin="anonymous"
    async>
</script>

