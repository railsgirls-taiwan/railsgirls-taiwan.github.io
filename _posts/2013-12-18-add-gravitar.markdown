---
layout: default
title: 加入個人大頭貼
permalink: gravatar
---

# 加入個人大頭貼（Gravatar）

*Created by Catherine Jones*

*Translation by JuanitoFatas, [@JuanitoFatas](https://twitter.com/juanitofatas)*

**本指南假設妳已經跟著[打造第一個 APP](/app)指南，寫好了一個 RailsGirls APP，並且已經[用 devise 新增了驗證功能](/devise)**。

### 重要！

妳需要去 [Gravatar 網站](https://en.gravatar.com/)，註冊一個 Email。Email 會綁定一張照片。

## *1.*安裝 Gravtastic Gem

打開專案的 `Gemfile`，在 `devise` 下面新增：

{% highlight erb %}
gem 'gravtastic'
{% endhighlight %}

接著到終端機，輸入：

{% highlight sh %}
bundle
{% endhighlight %}

Gravtastic Gem 就裝好了。記得要重新啟動 Rails 伺服器哦。

## *2.*設定 Gravtastic

打開 `app/models/user.rb` 加入這兩行

{% highlight sh %}
include Gravtastic
gravtastic
{% endhighlight %}

這樣子 Gravtastic 就設定好了！

## *3.*設定 Gravatar 的 HTML 與 CSS

打開 `app/views/layouts/application.html.erb` 並找到這一段

{% highlight erb %}
<% if user_signed_in? %>
{% endhighlight %}

下面的 `<% else %>`

{% highlight erb %}
<% else %>
{% endhighlight %}

上面加入

{% highlight erb %}
<span class="user-gravatar"><%= image_tag current_user.gravatar_url %></span>
{% endhighlight %}

並打開 `app/assets/stylesheets/application.css` 加入：

```css
.user-gravatar {
    display: inline-block;
    width: 32px;
    position: relative;
    margin: 0;
}

.user-gravatar img {
    position: absolute;
    width: 32px;
    height: 32px;
    border-radius: 16px;
    top: -22px;
}
```

現在打開瀏覽器，登入妳的網站，應該會看到在 Gravatar 網站註冊時，與 E-mail 所綁定的大頭貼了！恭喜妳！
