---
layout: default
title: 列出 idea 時顯示縮圖
permalink: thumbnails
---

# 用 Carrierwave 建立縮圖

*Created by Miha Filej, [@mfilej](https://twitter.com/mfilej)*

*Translation by JuanitoFatas, [@JuanitoFatas](https://twitter.com/juanitofatas)*

**教練：** 在第四個步驟完成時，解釋用 HTML 指定圖片寬度與伺服器來縮圖的差別。

## 安裝 ImageMagick

* OS X：在終端機輸入 `brew install imagemagick`。如果你沒有 `brew` 命令，可以[到這裡安裝 homebrew。][in-homebrew]
* Windows：下載並執行 [ImageMagick installer][im-win] （用第一個連結下載）。
* Linux：Ubuntu 以及 Debian，打開終端機輸入 `sudo apt-get install imagemagick`。其它的發行版請用對應的套件管理命令（請洽教練）。

  [im-win]: http://www.imagemagick.org/script/binary-releases.php#windows
  [in-homebrew]: http://brew.sh/index_zh-tw.html

**教練：** ImageMagick 是什麼？跟我們之前用的 `libraries/gems` 有什麼差別？

打開專案的 `Gemfile`，在這行下面

{% highlight ruby %}
gem 'carrierwave'
{% endhighlight %}

加入

{% highlight ruby %}
gem 'mini_magick', '3.5.0'
{% endhighlight %}

接著到終端裡輸入

{% highlight sh %}
bundle
{% endhighlight %}

## 上傳圖片時建立縮圖

開啟 `app/uploaders/picture_uploader.rb` 並找到這行

{% highlight ruby %}
  # include CarrierWave::MiniMagick
{% endhighlight %}

移除 `#` 符號。

**教練：** 解釋程式語言裡註解的概念。

在妳剛剛修改的那行下面，新增這段程式碼：

{% highlight ruby %}
version :thumb do
  process :resize_to_fill => [50, 50]
end
{% endhighlight %}

現在上傳的圖片應該會改變大小了，之前加入的圖片不會受影響。來編輯看看已加入的圖片，並重新傳一張圖片。

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
