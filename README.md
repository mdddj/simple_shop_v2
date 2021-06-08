# 典典的小卖部v2版本

![](https://badgen.net/badge/QQ群/667186542)![](https://badgen.net/badge/Flutter/v2.2.1)

下载下来,安装好flutter环境,用控制台打开项目目录,执行下面的运行命令

> 安卓运行如果提示找不到`key.properties`文件,需要自己生成一个!具体操作请百度关键字`flutter生成jks签名`

```dart
// 拉取依赖
flutter pub get

flutter run -d chrome  // 运行在谷歌浏览器
flutter run -d Edge	// 运行在微软浏览器
flutter run // 运行在安卓设备
```

> 如果请求不到数据,请修改`main.dart`大约在19行

```dart
/// 替换成这句,有数据就不要替换了
DdTaokeUtil.instance.init('http://itbug.shop', '80', proxy: '');
```

**运行后数据啥的都有,没有报错,没有警告提示,此项目仅供学习**

下面放几张截图

|                            详情页                            |                             首页                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![](https://static.saintic.com/picbed/huang/2021/04/28/1619577585953.png) | ![](https://static.saintic.com/picbed/huang/2021/05/11/1620721238832.png) |
|                             分类                             |                             搜索                             |
| ![](https://static.saintic.com/picbed/huang/2021/05/11/1620721469874.png) | ![](https://static.saintic.com/picbed/huang/2021/05/11/1620721541018.png) |















