---
layout: default
title: Add design to your App with HTML and CSS
permalink: design-html-css
---

# 用 HTML 與 CSS 給 App 加入更多設計

*Created by Rails Girls*

*Translation by JuanitoFatas, [@JuanitoFatas](https://twitter.com/juanitofatas)*

##*1.*設計選單

+ 將下面的程式碼放到 `app/assets/stylesheets/application.css` 檔案的最後面:

    ```css
    .navbar {
        min-height: 38px;
        background-color: #f55e55;
    }
    ```

  重新整理頁面，看看有什麼變化。妳可以修改選單的顏色與字型。顏色可以參考 [http://hslpicker.com/](http://hslpicker.com/)。

    __教練：__ 解釋 `display` 屬性，`inline` 與 `block` 元素是什麼。

+ 接著將這段程式碼加到後面：

    ```css
    .navbar a.brand { font-size: 18px; }
    .navbar a.brand:hover {
        color: #fff;
        background-color: transparent;
        text-decoration: none;
    }
    ```

    __教練：__ 解釋連結的四種狀態（無狀態、`visited`、`hover`、`active`）

##*2.*設計 table

 + 我們使用 [Twitter Bootstrap](http://getbootstrap.com/2.3.2/) 來美化表格。把 `app/views/ideas/index.html.erb` 檔案裡，找到：

   ```html
   <table>
   ```

   換成

   ```html
   <table class="table">
   ```

 + 下面這行程式碼來修改圖片大小

     ```erb
     <%= image_tag(idea.picture_url, width: 600) if idea.picture.present? %>
     ```

     試著修改 `width` 的值，看看發生了什麼。

 + 將下段 CSS 加入到 `app/assets/stylesheets/ideas.css.scss` 檔案的最後面：

  ```css
  .container a:hover {
      color: #f55e55;
      text-decoration: none;
      background-color: rgba(255, 255, 255, 0);
  }
  ```

 + 試著使用 `background-image` 屬性來加入背景圖片，背景圖片可以參考
   [http://subtlepatterns.com/](http://subtlepatterns.com/)。

##*3.*加入 Footer 的樣式

+ 將下段 CSS 程式碼加入至 `app/assets/stylesheets/application.css` 檔案的最後面：

    ```css
    footer {
        position: absolute;
        bottom: 0;
        width: 100%;
        padding: 20px 0;
        background-color: #f5f5f5;
        height: 60px;
    }
    ```

    試著在 `footer` 裡面放入更多樣式。

##*4.*給按鈕加上樣式

  + 打開
    [http://localhost:3000/ideas/new](http://localhost:3000/ideas/new)
    ，並找到 `Create Idea` 的按鈕。

   加入下列 CSS 至 `app/assets/stylesheets/ideas.css.scss` 檔案：

   ```css
   .container input[type="submit"] {
        height: 30px;
        font-size: 13px;
        background-color: #f55e55;
        border: none;
        color: #fff;
    }
   ```

   **教練：** 解釋 CSS 的 `border` 屬性怎麼使用，試著修改按鈕的樣式，像是加點陰影、改變顏色、加邊角等。
