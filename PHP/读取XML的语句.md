读取XML的语句
```php
libxml_disable_entity_loader(true);
$json_str = json_encode(simplexml_load_string($request->getContent(), 'SimpleXMLElement', LIBXML_NOCDATA));
$data = json_decode($json_str, true);
```