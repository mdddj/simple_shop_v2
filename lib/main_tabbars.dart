import 'package:flutter/cupertino.dart';
import 'screen/nine_nine/view.dart';
import 'screen/category/view.dart';
import 'screen/index/index.dart';
import 'package:flutter/material.dart';

import 'screen/intelligence/view.dart';
import 'screen/search/view.dart';
import 'widget/loading/simple_loadings.dart';

const kTabData = [
  {'layout': '首页', 'icon': CupertinoIcons.home},
  {'layout': '分类', 'icon': CupertinoIcons.archivebox_fill},
  {'layout': '搜索', 'icon': CupertinoIcons.search},
  {'layout': '消息', 'icon': CupertinoIcons.chart_bar_alt_fill},
  {'layout': '九块九', 'icon': CupertinoIcons.volume_down},
];

/// 主页面结构
class MainTabbars extends StatefulWidget {
  @override
  _MainTabbarsState createState() => _MainTabbarsState();
}

class _MainTabbarsState extends State<MainTabbars>
    with SingleTickerProviderStateMixin{

  int _currentIndex = 0;


  void _onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _renderPage(context,int index){
    switch(index){
      case 0:
        return AppIndex();
      case 1:
        return CategoryPage();
      case 2:
        return SearchPage();
      case 3:
        return NineNinePage();
    }
    return IntelligencePage();
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
    kTabData.forEach((element) {
      list.add(BottomNavigationBarItem(
        icon: Icon(
          element['icon'] as IconData?,
          size: 20,
        ),
      ));
    });
    return list;
  }

}
