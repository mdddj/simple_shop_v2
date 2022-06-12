import 'package:dataoke_sdk/network/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'mixin/theme.dart';
import 'provider/app.dart';
import 'screen/category/view.dart';
import 'screen/index/index.dart';
import 'screen/intelligence/view.dart';
import 'screen/nine_nine/view.dart';
import 'screen/search/view.dart';

///首页菜单
const kTabData = [
  {'layout': '首页', 'icon': CupertinoIcons.home},
  {'layout': '分类', 'icon': CupertinoIcons.archivebox_fill},
  {'layout': '搜索', 'icon': CupertinoIcons.search},
  {'layout': '情报', 'icon': CupertinoIcons.chart_bar_alt_fill},
  {'layout': '九块九', 'icon': CupertinoIcons.volume_down},
];

/// 主页面结构
class MainTabbars extends StatefulWidget {
  const MainTabbars({Key? key}) : super(key: key);

  @override
  _MainTabbarsState createState() => _MainTabbarsState();
}

class _MainTabbarsState extends State<MainTabbars>
    with SingleTickerProviderStateMixin{

  int _currentIndex = 0;


  late final ThemeObs _themeObs = ThemeObs(themeChange);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_themeObs);
    Future.microtask(() => context.read<AppProvider>().changeThemeModel(MediaQuery.of(context).platformBrightness));
    Future.microtask(() {
      // DdCheckPlugin.instance.init(DdTaokeUtil.instance.createInstance()!);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_themeObs);
    super.dispose();
  }

  ///主题切换回调
  void themeChange(){
    final mode = MediaQuery.of(context).platformBrightness;
    context.read<AppProvider>().changeThemeModel(mode==Brightness.dark ? Brightness.light : Brightness.dark);
  }


  void _onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _renderPage(context,int index){
    switch(index){
      case 0:
        return const AppIndex();
      case 1:
        return const CategoryPage();
      case 2:
        return const SearchPage();
      case 3:
        return const IntelligencePage();
    }
    return const NineNinePage();
  }

  @override
  Widget build(BuildContext context) {

    /// 主页面结构
    return CupertinoTabScaffold(
      tabBuilder:_renderPage, tabBar: CupertinoTabBar(items: _renderTabs(),onTap: _onTap,currentIndex: _currentIndex,),);
  }


  /// 底部导航
  List<BottomNavigationBarItem> _renderTabs() {
    var list = <BottomNavigationBarItem>[];
    for (var element in kTabData) {
      list.add(BottomNavigationBarItem(
        icon: Icon(
          element['icon'] as IconData?,
          size: 20,
        ),
        label: element['layout'].toString().tr
      ));
    }
    return list;
  }




}
