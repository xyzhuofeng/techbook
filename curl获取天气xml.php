<?php 
  header('Content-Type:text/xml;charset=utf8');
  $ccc=curl_init();
  // 指定URL
  curl_setopt($ccc,CURLOPT_URL,'http://www.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather');

  $data='theUserID=&theCityCode=广州';
  $header=[
    'Content-Type: application/x-www-form-urlencoded;charset=utf8',
    'Content-length: '.strlen($data),
    'Cache-Control: max-age=0',
    'Accept-Encoding: gzip, deflate',
  ];
  //  启用时会将头文件的信息作为数据流输出。
  curl_setopt($ccc, CURLOPT_HEADER, false);// 不需要输出
  //  将curl_exec()获取的信息以字符串返回，而不是直接输出
  curl_setopt($ccc,CURLOPT_RETURNTRANSFER,true);
  // post方式传输
  curl_setopt($ccc, CURLOPT_POST, true);
  // post数据，默认为字符串
  // 传递一个数组到CURLOPT_POSTFIELDS，cURL会把数据编码成 multipart/form-data，而然传递一个URL-encoded字符串时，数据会被编码成 application/x-www-form-urlencoded。
  curl_setopt($ccc, CURLOPT_POSTFIELDS, $data);
  // 设置header
  curl_setopt($ccc, CURLOPT_HTTPHEADER, $header);
  // 必须有UA信息
  curl_setopt ($ccc, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
  $str=curl_exec($ccc);
  // $str=htmlspecialchars($str);
  echo $str;
  curl_close($ccc);