---
layout: default
title: 給 Rails Girls 應用加入留言功能
permalink: commenting
---

# Rails Girls App 留言功能

*Created by Janika Liiv, [@janikaliiv](https://twitter.com/janikaliiv)*

*Translation by JuanitoFatas, [@JuanitoFatas](https://twitter.com/juanitofatas)*

替妳的 **railsgirls** app 加入留言功能。

##*1.*建立 Comment Scaffold

建立 Comment Scaffold，有留言者的姓名（user_name）、留言內容（body）以及給哪個 idea 留言（idea_id）。

{% highlight sh %}
rails g scaffold comment user_name:string body:text idea_id:integer
{% endhighlight %}

> `rails g` 是 `rails generate` 的縮寫

##*2.*建立 Model 的 Relation

首先呢要確定 Rails 知道 ideas 與 comments 之間的關係，我們需要建立 Idea 與 Comment Model 之間的關係。一個 idea 可以有很多人留言，讓我們把這個關係加入 Idea Model。打開 `app/models/idea.rb`，在這行的後面：

{% highlight ruby %}
class Idea < ActiveRecord::Base
{% endhighlight %}

加入

{% highlight ruby %}
has_many :comments
{% endhighlight %}

一個 comment 也需要知道它自己屬於那個 idea。打開 `app/models/comment.rb`，在這行的後面：

{% highlight ruby %}
class Comment < ActiveRecord::Base
{% endhighlight %}

加入

{% highlight ruby %}
belongs_to :idea
{% endhighlight %}

##*3.*加入留言的表單

打開 `app/views/ideas/show.html`，並在 `image_tag` 之後
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

打開 `app/controllers/ideas_controller.rb` 在 show action 裡面的這行後面

{% highlight ruby %}
@idea = Idea.find(params[:id])
{% endhighlight %}

加入

{% highlight ruby %}
@comment = @idea.comments.build
{% endhighlight %}

打開 `app/views/comments/_form.html.erb` 並在這段程式後面：
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

接下來，移除這段程式碼：

{% highlight erb %}
<div class="field">
  <%= f.label :idea_id %><br>
  <%= f.number_field :idea_id %>
</div>
{% endhighlight %}

就這麼簡單。現在看看之前建立的 idea，妳應該會看到一個可以留言的表單了。
