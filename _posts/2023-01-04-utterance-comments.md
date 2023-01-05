# Adding Comments Feature to this Blog
This blog runs on github pages. It was created by following [this excellent post](https://chadbaldwin.net/2021/03/14/how-to-build-a-sql-blog.html) by Chad Baldwin.

I wanted to add a comments feature. After a little googling, I came across a github app called [utternces](https://utteranc.es/)

This seems to work well, so I thought I'd document the steps I took to implement in case any more users of Chad's blog template would like to follow.

## Install the App
I didn't even know github apps were a thing! It turned out the be quite easy to add, from my github repo page I navigated to the [github marketplace](https://github.com/marketplace/utterances) and clicked the setup button

After installation, it should be possible to check you have it installed correctly by navigating to Settings\Integrations\GitHub apps from your github repo - as shown below

![installed](/images/utterance-comments/installed.png)

## Adding the Comment Block
To add the comment block, I simply pasted the following at the foot of my markdown page:

````
<script src="https://utteranc.es/client.js"
    repo="RobBowman/RobBowman.github.io"
    issue-term="pathname"
    theme="github-light"
    crossorigin="anonymous"
    async>
</script>
````

I hope this helps someone. If it does, or if I've missed something, please leave a comment :)

<script src="https://utteranc.es/client.js"
    repo="RobBowman/RobBowman.github.io"
    issue-term="pathname"
    theme="github-light"
    crossorigin="anonymous"
    async>
</script>