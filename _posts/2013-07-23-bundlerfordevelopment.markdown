---
layout: default
title: 開發 Bundler
permalink: bundlerfordevelopment
---

# 如何設定環境來開發 Bundler

1. Fork Bundler

    造訪 Bundler 的 Github 主頁 [https://github.com/bundler/bundler](https://github.com/bundler/bundler)

    按下 fork 按鈕。

    Fork Bundler ，才能將妳的修改發 pull requests 回去。

<p>
<img src="../images/fork1.jpg" />
<br />
</p>

2. 下載一份妳 fork 的 Bundler

    `$ git clone https://github.com/your_user_name/bundler.git`


3. 切換至 Bundler 目錄

    `$ cd bundler`

4. 設定一下原項目的網址

    `$ git remote add upstream https://github.com/bundler/bundler.git`

    這將妳本機的 repo 與上游 repo 連結起來。


5. 安裝 Bundler 開發所依賴的軟體

    `$ rake spec:deps`

    rake 是什麼？ [http://rake.rubyforge.org/](http://rake.rubyforge.org/)

6. 執行 Bundler 的測試套裝

    `$ rake spec`

    大約要 15 分鐘。
