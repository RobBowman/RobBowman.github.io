"""
    {{ addcomments }}

Add a comment widget, managed by utterances <https://utteranc.es>.
"""
function hfun_addcomments()
    html_str = """
    <script src="https://utteranc.es/client.js"
        repo="RobBowman/RobBowman.github.io"
        issue-term="pathname"
        theme="github-light"
        crossorigin="anonymous"
        async>
    </script>
    """
    return html_str
end