# 三方API收录

[TOC]

### 天气查询

GET
```
http://www.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theUserID=&theCityCode=广州
```
响应
```xml
<?xml version="1.0" encoding="utf-8"?>
<ArrayOfString xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://WebXml.com.cn/">
  <string>广东 广州</string>
  <string>广州</string>
  <string>2350</string>
  <string>2018/07/13 12:52:06</string>
  <string>今日天气实况：气温：30℃；风向/风力：东北风 1级；湿度：70%</string>
  <string>紫外线强度：弱。空气质量：优。</string>
  <string>紫外线指数：弱，辐射较弱，涂擦SPF12-15、PA+护肤品。
健臻·血糖指数：不易波动，天气条件不易引起血糖波动。
穿衣指数：热，适合穿T恤、短薄外套等夏季服装。
洗车指数：不宜，有雨，雨水和泥水会弄脏爱车。
空气污染指数：优，气象条件非常有利于空气污染物扩散。
</string>
  <string>7月13日 中雨转雷阵雨</string>
  <string>26℃/31℃</string>
  <string>无持续风向小于3级</string>
  <string>8.gif</string>
  <string>4.gif</string>
  <string>7月14日 中雨转阴</string>
  <string>25℃/30℃</string>
  <string>东风3-4级转无持续风向小于3级</string>
  <string>8.gif</string>
  <string>2.gif</string>
  <string>7月15日 中雨</string>
  <string>25℃/30℃</string>
  <string>无持续风向小于3级</string>
  <string>8.gif</string>
  <string>8.gif</string>
  <string>7月16日 中雨转多云</string>
  <string>26℃/31℃</string>
  <string>无持续风向小于3级</string>
  <string>8.gif</string>
  <string>1.gif</string>
  <string>7月17日 多云</string>
  <string>27℃/33℃</string>
  <string>无持续风向小于3级</string>
  <string>1.gif</string>
  <string>1.gif</string>
</ArrayOfString>
```

