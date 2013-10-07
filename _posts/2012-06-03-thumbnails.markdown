---
layout: default
title: 列出 idea 時顯示縮圖
permalink: thumbnails
---

# 用 Carrierwave 建立縮圖

*Created by Miha Filej, [@mfilej](https://twitter.com/mfilej)*

**教練：** 在第四個步驟完成時，解釋 HTML 怎麼控制圖片寬度跟伺服器將圖重新縮放的差別。

## 安裝 ImageMagick

* OS X: 執行 `brew install imagemagick`. 如果你沒有 `brew` 命令，可以[在這裡安裝 homebrew。][in-homebrew]
* Windows: 下載並執行 [ImageMagick installer][im-win] （用第一個連結下載）。
* Linux: Ubuntu 以及 Debian，執行 `sudo apt-get install imagemagick`。其它的發行版請用對應的套件管理命令。

  [im-win]: http://www.imagemagick.org/script/binary-releases.php?ImageMagick=vkv0r0at8sjl5qo91788rtuvs3#windows
  [in-homebrew]: http://mxcl.github.io/homebrew/

**教練：** ImageMagick 是什麼？跟我們之前用的 `libraries/gems` 有什麼差別？

打開專案的 `Gemfile` 並加入

{% highlight ruby %}
gem 'mini_magick', '3.5.0'
{% endhighlight %}

在這行下面

{% highlight ruby %}
gem 'carrierwave'
{% endhighlight %}

在終端裡執行

{% highlight sh %}
bundle
{% endhighlight %}

## 跟 app 說上傳圖片時建立縮圖

開啟 `app/uploaders/picture_uploader.rb` 並找到這行

{% highlight ruby %}
  # include CarrierWave::MiniMagick
{% endhighlight %}

移除 `#` 符號。

**教練：** 解釋程式碼裡註解的概念。

在妳剛剛變更的那行下面，新增

{% highlight ruby %}
version :thumb do
  process :resize_to_fill => [50, 50]
end
{% endhighlight %}

現在上傳的圖片應該可以變更大小了，已經加入的圖片不受影響。來編輯看看已加入的圖片，並重新傳一張圖。

## 顯示縮圖

要確認上傳的圖片有縮圖成功，打開 `app/views/ideas/index.html.erb`。將這行

{% highlight erb %}
<td><%= idea.picture %></td>
{% endhighlight %}

改成

{% highlight erb %}
<td><%= image_tag idea.picture_url(:thumb) if idea.picture? %></td>
{% endhighlight %}

到瀏覽器看看 idea 清單，看看縮圖是不是有出現。
