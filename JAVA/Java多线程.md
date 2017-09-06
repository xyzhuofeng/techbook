# Java 多线程

by HyperQing 2017-09-06

## 线程两种实现方式

- 继承`class Thread`
- 实现接口`interface Runnable`

## 线程执行内容

线程执行内容要在`run()`方法中书写。由`start()`方法调用才有多线程效果，不能手动调用`run()`方法。

例如：
```
class SubThread extends Thread
    public void run(){
        System.out.println("子进程执行内容");
    }
}
```

## 线程对象创建(实例化)

第一种，继承Thread类的可以直接实例化。
```
Thread subThread = new SubThread();
```
第二种，实现接口的需要传`Runnable`对象给`Thread()`。
设有定义
```
class SubThread implements Runnable{
    public void run(){
        System.out.println("子进程执行内容");
    }
}
```
则可以
```
Thread subThread = new Thread(new SubThread());
```

## 线程的启动

很简单，只需执行对象方法start()即可。
```
subThread.start();
```

## 线程的一些操作方法

当前线程等待1000毫秒。（静态方法）
```
Thread.sleep(1000);
```
当前运行线程释放处理器资源后，各个线程重新竞争时间片。
```
Thread.yield();
```
返回当前运行的线程引用
```
Thread.currentThread();
```
设置/获取当前线程的名称
```
subThread.setName();
subThread.getName();
Thread.currentThread().setName();
Thread.currentThread().getName();
```
等待子线程subTread运行结束。
```
subThread.join();
```

## 线程的停止方法

**禁止使用stop()方法停止线程，这将导致线程瞬间停止，会使未完成的操作中止。**

应当使用标志位令其自然停止。

## volatile


