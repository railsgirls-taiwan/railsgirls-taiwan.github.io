---
layout: default
title: 貢獻指南
permalink: contributing
---

# 貢獻指南

本站背後的技術採用 [jekyll](https://github.com/mojombo/jekyll)，所有的文件用 [markdown](http://markdown.tw/) 寫成。要貢獻指南，只需要下列幾個簡單的步驟。

1. 到 [GitHub repository](https://github.com/railsgirls/railsgirls.github.com) 按 Fork 按鈕 Fork 一份。

2. `git clone` 把 fork 抓下來。

3. 在 `_posts` 目錄下新增一個名字是這種格式 `YYYY-MM-DD-guide_name.markdown` 的檔案。

4. 在這個檔案裡，需要在檔案最上方加入一種叫做 YAML 格式的資料：

{% highlight yaml %}
---
layout: default
title: Name of the Guide
permalink: one-word-summary.html
---
{% endhighlight %}

5. 指南寫好 commit 一下。

6. Commit 完就 push 到妳的 fork 上吧。

7. 現在妳可以開一個 pull request ，並解釋妳寫的指南是關於什麼的，就這麼簡單！

文章的結構可以參考我們的 [Rails Girls App 教學](https://github.com/railsgirls/railsgirls.github.com/blob/master/_posts/2012-04-18-app.markdown)。

非常感謝您花費寶貴時間，使得 Rails Girls 變得更好。
