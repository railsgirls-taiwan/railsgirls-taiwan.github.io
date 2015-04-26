---
layout: default
title: Rails Girls Sinatra tutorial
permalink: sinatra-app
---

# 使用 Sinatra 來建立妳的第一個投票 App

*Created by Piotr Szotkowski, [@chastell](https://twitter.com/chastell)*

*Translation by Daryl Chen, [@otaqato](https://twitter.com/otaqato)*

我們將會使用一個網站開發框架叫做 Sinatra 從無到有的來建立一個小型的投票程式，它跟 Ruby on Rails 很像，是另一個可以完成這件事的工具，一樣也很有趣。

想像妳和一群朋友在想週末的電影馬拉松要看什麼、要叫什麼外送來吃？這時候它就派上用場了！

__教練__：簡短的解釋什麼是 [Sinatra](http://www.sinatrarb.com)。

## 安裝 Sinatra

還記得我們是怎麼安裝 Ruby on Rails？安裝 Sinatra 的方式也一樣：

`gem install sinatra`

### 建立妳的第一個 Sinatra app

建立一個檔案叫 `suffragist.rb` 包含以下內容：

{% highlight ruby %}
require 'sinatra'

get '/' do
  'Hello, voter!'
end
{% endhighlight %}

實際上妳可以任意命名這個 Ruby 檔案，用 `vote.rb` 也可以，不過 [suffragist](http://zh.wikipedia.org/wiki/%E9%80%89%E4%B8%BE%E6%9D%83#.E5.A9.A6.E5.A5.B3.E9.81.B8.E8.88.89.E6.AC.8A) 是根據一個超級重要的女權運動而來，那就用這個名字吧！

### 執行妳的 App

切換到 App 所在的目錄並執行 `ruby suffragist.rb` 指令，
現在瀏覽 [localhost:4567](http://localhost:4567) 妳應該可以看到一個『Hello, voter!』頁面，
這意味著 App 運作得很順利，在進行下一步之前，先在終端機裡按下 `ctrl-c` 終止運作中的 App。

__教練__：解釋 POST 和 GET 方法，以及如何與瀏覽器交流。

### 新增視圖（View）到首頁

為了讓一切井然有序，我們建立一個資料夾 `views`，並且在裡面建立一個檔案 `index.erb`，內容如下：

{% highlight erb %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8' />
    <title>Suffragist</title>
    <link href='//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css' rel='stylesheet' />
  </head>
  <body class='container'>
    <p>What's for dinner?</p>
    <form action='cast' method='post'>
      <ul class='unstyled'>
        <% Choices.each do |id, text| %>
          <li>
            <label class='radio'>
              <input type='radio' name='vote' value='<%= id %>' id='vote_<%= id %>' />
              <%= text %>
            </label>
          </li>
        <% end %>
      </ul>
      <button type='submit' class='btn btn-primary'>Cast this vote!</button>
    </form>
  </body>
</html>
{% endhighlight %}

在 `suffragist.rb` 裡加入：

{% highlight ruby %}
Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}
{% endhighlight %}

改變 `get` 動作的內容：

{% highlight ruby %}
get '/' do
  erb :index
end
{% endhighlight %}

執行 `ruby suffragist.rb`，看看結果，然後 `ctrl-c` 終止運作中的 App。

__教練__：聊聊 HTML 和 erb，解釋 templates 和全域常數的意思

### 樣板

編輯 `views` 裡的 `index.erb` 檔案，加入 `<h1>...</h1>` 這一行，像下面這樣：

{% highlight erb %}
  <body class='container'>
    <h1><%= @title %></h1>
    <p>What's for dinner?</p>
{% endhighlight %}

改變 `get` 動作的內容：

{% highlight ruby %}
get '/' do
  @title = 'Welcome to the Suffragist!'
  erb :index
end
{% endhighlight %}

__教練__：解釋實體變數是什麼，以及 Sinatra 如何讓它們出現在頁面上。

### 替 POST 結果增加一點能力

把以下內容加進 `suffragist.rb`：

{% highlight ruby %}
post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  erb :cast
end
{% endhighlight %}

在 `views` 資料夾裡新增檔案 `cast.erb` 並放進一點 HTML 和 Ruby 程式，內容如下：

{% highlight erb %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8' />
    <title>Suffragist</title>
    <link href='//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css' rel='stylesheet' />
  </head>
  <body class='container'>
    <h1><%= @title %></h1>
    <p>You cast: <%= Choices[@vote] %></p>
    <p><a href='/results'>See the results!</a></p>
  </body>
</html>
{% endhighlight %}

__教練__：解釋 POST 是怎麼運作，要如何接收從表單寄出的內容，`params` 從哪裡來？

### 整理程式碼成一般常見的版型

在 `views` 資料夾裡建立一個檔案 `layout.erb`，並加入以下內容：

{% highlight erb %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8' />
    <title>Suffragist</title>
    <link href='//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css' rel='stylesheet' />
  </head>
  <body class='container'>
    <h1><%= @title %></h1>
    <%= yield %>
  </body>
</html>
{% endhighlight %}

從另外兩個樣板移除和上面重複的內容（分別是 `index.erb` 和 `cast.erb` 在 `views` 資料夾裡）。

__教練__：聊聊 HTML 的文件架構和一般整理程式碼的方式，解釋 `yield` 的意思。

### 加入投票結果路徑和投票結果頁面

將下列程式碼貼到 `suffragist.rb`：

{% highlight ruby %}
get '/results' do
  @votes = { 'waw' => 7, 'krk' => 5 }
  erb :results
end
{% endhighlight %}

在 `views` 資料夾裡建立一個檔案 `results.erb`，內容如下：

{% highlight erb %}
<table class='table table-hover table-striped'>
  <% Choices.each do |id, text| %>
    <tr>
      <th><%= text %></th>
      <td><%= @votes[id] || 0 %>
      <td><%= '#' * (@votes[id] || 0) %></td>
    </tr>
  <% end %>
</table>
<p><a href='/'>Cast more votes!</a></p>
{% endhighlight %}

執行 `ruby suffragist.rb`，看看結果，然後 `ctrl-c` 終止運作中的 App。

__教練__：解釋 HTML 表格以及票數為何為零。

### 使用 YAML::Store 保存投票結果

該是來點新玩意了，讓我們來保存投票結果。

在 `suffragist.rb` 的最上面加上以下內容：

{% highlight ruby %}
require 'yaml/store'
{% endhighlight %}

將下列程式碼加入 `suffragist.rb` ，用它們取代 `post '/cast'` 以及 `post '/results'`：

{% highlight ruby %}
post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end
{% endhighlight %}

__教練__：解釋什麼是 YAML。

### 看看投完票的時候，YAML 檔案是如何變化的

我們打開 `votes.yml`，接著投票，然後再檢查 `votes.yml` 一次

__教練__：或許會有些學員忘了把伺服器關掉再執行，這是與學員一起尋找解答的好機會，學員不用為了懂得如何結束程式而自行尋找解答。

__教練__：在最後稍微解釋一下 Sinatra 與 Rails 的差異。

## 在 App 裡發揮妳的創意

用妳覺得適合的方式，嘗試改變 App 的內容：

* 為頁面加上額外的邏輯
* 投完票直接顯示投票結果
* 增加其他投票主題；YAML 檔案要如何應對新功能的變化
* 嘗試以不同方式設計檔案

