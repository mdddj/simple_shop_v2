

var hello = false;
const test = "";

class DocTest{

  /// markdown 类型的文档
  ///
  /// [典典博客](https://itbug.com)
  ///   * 列表项1
  ///   * 列表项2
  ///
  /// ```dart
  /// print("hello world")
  /// //你可以尝试执行:
  /// void fun(String name) {
  ///   print("你好,$name");
  /// }
  ///
  /// ```
  ///
  void print(){}
}
void run(){
  DocTest().print();
}