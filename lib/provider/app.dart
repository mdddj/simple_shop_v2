import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/material.dart';

/// app 全局的数据仓库
class AppProvider extends ChangeNotifier {
  /// 构造函数,app启动的时候加载数据
  /// [getCategoryList] 加载分类数据
  AppProvider() {
    getCategoryList();
  }

  ///主题
  Brightness themModel = Brightness.light;

  /// 搜索初始化搜索
  bool searchInit = true;

  /// 是否正在加载分类数据
  bool loadingWithCategory = false;

  /// 分类
  List<Category> categorys = [];

  /// 当前选中的分类
  Category? currentCategory;

  ///改变主题
  void changeThemeModel(Brightness mode){
    themModel = mode;
    notifyListeners();
  }

  /// 改变搜索结果状态
  void changeSearchInitState(bool value) {
    searchInit = value;
    notifyListeners();
  }

  /// 从服务器加载分类
  Future<void> getCategoryList() async {
    loadingWithCategory = true;
    notifyListeners();
    final result = await DdTaokeSdk.instance.getCategorys();
    categorys.addAll(result);
    if (result.isNotEmpty) {
      currentCategory = result[0];
    }
    loadingWithCategory = false;
    notifyListeners();
  }

  /// 改变当前选中的分类数据
  void changeCurrentCategory(Category category) {
    currentCategory = category;
    notifyListeners();
  }
}
