# Azure Service Endpoints

## Puzzle
I had a vnet that looked like this:

![vnet](/images/az-service-endpoints/vnet.png)

The SMS Router needed to be able to call the CC Survey.

I wanted to set an access restriction on CC Survey so that it would only accept requests from Subnet-apps.

From the Azure Portal, I navigated to CC Survery\Networking\Inbound Traffic\Access Restriction

![access-restriction](/images/az-service-endpoints/access-restrictions.png)

After adding the rule, I noticed that the "Endpoint status" column of the new row was listed as "Disabled" - what did this mean!?

## Explanation
It was trying to tell me that the source subnet was not allowing traffic out. The reason was because I needed to create a "Service Endpoint" on the source subnet to all web traffic to be routed through vnet integration.

To enable this, from the Azure Portal I navigated to Virtual Network\Subnets\Subnet-Survey and selected "Microsoft.Web" from the "Services" drop-down under the "Service Endpoints" heading:

![service-endpoints](/images/az-service-endpoints/service-endpoints.png)

## A Great Video
There are lots of explanations of Service Endpoints on the web but I found [this youtube](https://www.youtube.com/watch?v=gxsitRRgylI) to be the most useful - from 6mins 21 secs in particular.

## A Better Name
Personally, I don't find the name "Service Endpoints" conveys what they actually do. It had me thinking this was something to be configured on the target. In fact, it's enabling a route out of the source subnet for a particular type of traffic - web in my case.

## What's Next
Now I need to plumb this rules back into my bicep templates - just wanted to get this written down first before I forget how it works!


<script src="https://utteranc.es/client.js"
    repo="RobBowman/RobBowman.github.io"
    issue-term="pathname"
    theme="github-light"
    crossorigin="anonymous"
    async>
</script>



