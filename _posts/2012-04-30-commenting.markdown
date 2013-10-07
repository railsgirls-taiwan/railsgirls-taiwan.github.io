---
layout: default
title: 給 Rails Girls 應用加入評論功能
permalink: commenting
---

# Rails Girls App 評論功能

*Created by Janika Liiv, [@janikaliiv](https://twitter.com/janikaliiv)*

替妳的 **railsgirls** app 加入評論功能。

## Step 1: 加入 foreigner gem

加入 Gemfile

{% highlight ruby %}
gem 'foreigner'
{% endhighlight %}

安裝相依套件（如果伺服器正在跑，按 `CTRL-C` 停止。）

{% highlight sh %}
bundle install
{% endhighlight %}

## Step 2: 建立 comment 鷹架

建立 comment 鷹架，有評論者的姓名（user_name）、評論內容（body）以及評論哪個 idea （idea_id）。

{% highlight sh %}
rails g scaffold comment user_name:string body:text idea_id:integer
{% endhighlight %}

## Step 3: 加入 foreign key 連結

找到這個檔案 `db/migrate/YYYYMMDDXXXXXX_create_comments.rb` ，在這行之後

{% highlight ruby %}
t.timestamps
end
{% endhighlight %}

加入

{% highlight ruby %}
add_foreign_key :comments, :ideas
{% endhighlight %}

現在給資料庫做遷移：

{% highlight sh %}
rake db:migrate
{% endhighlight %}

啟動伺服器

{% highlight sh %}
rails s
{% endhighlight %}

## Step 4: 加入模型關係

必須讓 Rails 知道 comments 與 idea 之間的關係（ideas 與 comments）。

一個 idea 可以有很多 comments，但我們得告訴 idea model 這件事才行。

打開 app/models/idea.rb 在這行之後

{% highlight ruby %}
class Idea < ActiveRecord::Base
{% endhighlight %}

加入

{% highlight ruby %}
has_many :comments
{% endhighlight %}

也必須告訴 comment 她屬於單一個 idea。打開 app/models/comment.rb，並在這行之後

{% highlight ruby %}
class Comment < ActiveRecord::Base
{% endhighlight %}

加入

{% highlight ruby %}
belongs_to :idea
{% endhighlight %}

## Step 5: 渲染評論的表格及加入現有評論

打開 app/views/ideas/show.html 並在 image_tag 之後

{% highlight erb %}
<%= image_tag(@idea.picture_url, :width => 600) if @idea.picture.present? %>
{% endhighlight %}

加入

{% highlight erb %}
<h3>Comments</h3>
<% @idea.comments.each do |comment| %>
  <div>
    <strong><%= comment.user_name %></strong>
    <br />
    <p><%= comment.body %></p>
  </div>
<% end %>
<%= render 'comments/form' %>
{% endhighlight %}

在 app/controllers/ideas_controller.rb 將此行加入 show action。

{% highlight ruby %}
@comment = @idea.comments.build
{% endhighlight %}

打開 app/views/comments/_form.html 並在這行之後

{% highlight erb %}
  <div class="field">
    <%= f.label :body %><br />
    <%= f.text_area :body %>
  </div>
{% endhighlight %}

加入

{% highlight erb %}
<%= f.hidden_field :idea_id %>
{% endhighlight %}

完成了！現在進去一個 idea 看看，會看到有添加評論的表單，添加個新的評論看看吧。
