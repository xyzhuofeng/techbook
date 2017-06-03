#Python 速记
by HyperQing

----

- **数字**

```python
123.456   -5.2   0xffac12   1.23e9   3.5e-4
```

- **字符串**

```python
"hello"   'world'
print "hello",'world'    #==>hello world   字符串拼接，遇到逗号“,”会输出一个空格
```

- **布尔**

`True`，`False`（请注意大小写）
逻辑运算：`and`,`or`,`not`
Python把`0`、空字符串`''`和`None`看成 `False`，其他数值和非空字符串都看成`True`

-  **\# 注释**(也只有#)

- **变量**

变量名必须是大小写英文、数字和下划线（_）的组合，且不能用数字开头

- raw字符串与多行字符串

字符串前加`r`取消转义，r''' '''多行字符串，里面所有标点符号和换行均无需加转义
```
print 'Hello\nworld!'
print r'''Hello
world!'''            #这两句print的输出效果是一样的，分两行显示Hello和world
```

- **unicode**

```python
# -*- coding: utf-8 -*-
print u'''中文'''
```

- **除法**

```python
11 / 4    # ==> 2  商，一个整数
11 % 4    # ==> 3  余数
11.0 / 4    # ==> 2.75  精确值
```

- **list** （本质：数组 Array）

下标越界：IndexError: list index out of range
```python
a=['Adam',20, 'Lisa',10, 'Bart',0]  #初始化数组，可混合类型
a[-1] #表示倒数第一个元素,倒序也不要越界！
a.append('hello') #在数组尾添加元素
a.insert(0,'hello')  #在下标0号位置插入元素，原0号及其后面的元素等向后移一位
a.pop()  #删掉list的最后一个元素，并且它还返回这个元素，所以我们执行 L.pop() 后，会打印出 'Paul'
a.pop(2)  #可指定下标
```

- **tuple**（本质：只读型数组 Array）

**一旦创建就不能修改**
```python
t = (0,1,2,3)
t[0]='hello'    #错误'tuple'对象不支持赋值
t=(1,)  #如果tuple只有一个数字，要在后面加‘,’来区别数字1和tuple
t=('hello',)  #原理同上
```
注意区别一种情况，如果以list数组做tuple的元素，list是可变的
```python
t=(['A','B'],1,2,3)
t[0][0]='C'
print t    #==>(['C','B'],1,2,3)  tuple的内容发生变化
```
与此相反的是，如果以tuple数组做tuple的元素，那么整个tuple都不可变
```pyhton
t=(('A','B']),1,2,3)   #t[0]是个tuple对象，也是不可变的
```

- **if** 控制语句

>Python代码的缩进规则。具有相同缩进的代码被视为代码块。
缩进请严格按照Python的习惯写法：**4个空格**，不要使用`Tab`，**更不要混合Tab和空格**，否则很容易造成因为缩进引起的语法错误。

**注意:** `if` 语句后接表达式，然后用`:`表示代码块开始。
**注意:** `else` 后面有个`:`。
```python
score = 85

if score>=90:
    print 'excellent'
elif score>=80:
    print 'good'
elif score>=60:
    print 'passed'
else:
    print 'failed'

```

- **循环**控制语句

```python
for x in ['A', 'B', 'C']:         #for语句
    for y in ['1', '2', '3']:     #循环嵌套
        print x + y
while x<=100:    #while语句
    sum = sum + x
    break         #退出循环
    continue      #继续循环
```

- **dict** （本质：哈希表Hash，key-value型）

> dict的**第一个特点是查找速度快**，无论dict有10个元素还是10万个元素，查找速度都一样。

> dict的缺点是**占用内存大**，还会浪费很多内容，list正好相反，占用内存小，但是查找速度慢。

> dict的第二个特点就是**存储的key-value序对是没有顺序的！**

> dict的第三个特点是**作为 key 的元素必须不可变**，例如不能用list对象作为key

```python
d = {
    'Adam': 95,
    'Lisa': 85,
    'Bart': 59
}
len(d)   #==>3  len()返回一个集合的元素个数

if 'Paul' in d:   # in 判断值'Paul'是否在d表中
    print d['Paul']
    
d.get('Bart')   #get()存在元素则返回值,不存在元素则返回None

d['Paul'] = 72   #可直接赋值
#遍历输出
d= {
    'Adam': 95,
    'Lisa': 85,
    'Bart': 59
}
for key in d:
    print key + ':', d[key]
```

- **set**（不重复的无序数组）

>set 持有一系列元素，这一点和 list 很像，但是set的元素没有重复，而且是无序的，这点和 dict 的 key很像。

创建 set 的方式是调用 set() 并传入一个 list，list的元素将作为set的元素：

```python
s = set(['A', 'B', 'C','C'])  #传入一个list，这里写入的两个'C'在赋值时会自动去重
print s   #==>set(['A', 'B', 'C'])

'A' in s   #==>True   主要用于判断某个元素是否在set中

for name in s:   #只要是个集合就能遍历
    print name

s.add(4)   #添加元素，如果添加的元素已经存在于set中，add()不会报错
s.remove(4)   #删除元素，如果元素不存在会报错"KeyError",故需要先做检查再删除
```



