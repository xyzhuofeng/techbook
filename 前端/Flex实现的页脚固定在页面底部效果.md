# Flex实现的页脚固定在页面底部效果

by HyperQing 2017-12-05

```html
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            height: 100%;
            margin: 0;
            padding: 0;
        }
        main{
            flex: 1;
        }
        footer{
            padding: 20px 0;
            text-align: center;
            color: #aaa;
            background: #222;
        }
    </style>
</head>
<body>
<header>页头</header>
<main>主体内容</main>
<footer>页脚</footer>
</body>
</html>
```