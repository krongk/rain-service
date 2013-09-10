结构说明
   clean_canvas
  | assets => 用于插入到theme表的资源列表，临时用
  | css  => 该模板独有的css文件, 包含bootstrap.min文件（因为各个版本兼容问题）。
  | js   => 该模板独有的js文件
  | img  => 该模板的图片资源
  | *.html => 名字与themes.default_pages里面对应的用于动态插入site_pages表的内容。 记住名称一定要一致，否则程序找不到（程序在models/site.rb), 模板的首页内容（assets/index.html），直接插入到themes表中去了，不用重复在这里插入到site_pages.

名称的一致性：
  1. theme名字必须跟表themes.name一致
     如‘clean_canvas'

  2. page名称必须跟表themes.default_pages里的一致
    如‘首页, index|关于, about|产品特色, features|产品列表, portfolio|博客, blog|联系方式, contact|在线帮助, comment|帮助说明, faq’
    对应的page依次是: index.html, about.html, features.html ...

  3. 模版page里面的变量名有：(short_id)
    如，要链接about.html页面， 链接的路径应设置为：<a href="/s-(short_id)-page-about">关于我们</a>

  4. 所有图片的地址替换为根路径，如：
    "img/about_slide1.jpg" => "/themes/clean_canvas/img/about_slide1.jpg"

关于css和js:
   程序默认集成了：
      <%= javascript_include_tag "jquery", "turbolinks" %>
      <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
   也就是说theme.js_url里面只需要集成模板本身独有的文件。
 