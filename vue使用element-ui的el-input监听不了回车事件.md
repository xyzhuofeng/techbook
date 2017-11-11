vue使用element-ui的el-input监听不了回车事件，原因应该是element-ui自身封装了一层input标签之后，把原来的事件隐藏了，所以如下代码运行是无响应的：
<el-input v-model="form.loginName" placeholder="账号" @keyup.enter="doLogin"></el-input>

解决方法需要在事件后面加上.native

<el-input v-model="form.loginName" placeholder="账号" @keyup.enter.native="doLogin"></el-input>