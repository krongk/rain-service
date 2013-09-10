
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