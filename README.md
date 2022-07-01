# Long_Timer
长达999小时的长计时器

## 用处
可以很方便的长时间计时，比如项目完成用时（这也是我设计的目的）  
如果使用不同的打开方式，计时器也不会互相影响

## 用法
下载下来Releases会有两个文件，直接双击exe就可以用了  
但是这长计时器可不会傻傻的把时间只存在内存里，不然一个蓝屏……  
所以计时需要存储在文件里  
要先创建一个json文件，地址、名称随意  
文件内容为  
```
{"hour":0,"minute":0,"second":0}
```
~~显而易见的格式~~  
然后给Long Timer.exe创个快捷方式，在 快捷方式-属性-目标 后面添加参数  
```
…………\Long Timer.exe --addr xxxx.json
```
xxxx.json是你刚刚创建的json文件的路径  
好了，此时这个计时器就带保存功能了  
创建不同的json文件以及快捷方式，能分开单独计时  
重置键需要按两次才能起效果  
重置时当前json文件也会被重置

## 关于
本项目使用Godot v3.4.4编写  
字体使用[思源黑体](https://github.com/adobe-fonts/source-han-sans)  
很抱歉时区只有东八区  
本人也是是刚刚初中毕业，也是第一次发布项目，各位请见谅  

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="知识共享许可协议" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />本作品采用<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">知识共享署名-非商业性使用 4.0 国际许可协议</a>进行许可。  
作品所有权归属于：Anslate Anslate2020@outlook.com
