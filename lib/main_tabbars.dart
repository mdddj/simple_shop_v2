import 'package:after_layout/after_layout.dart';
import 'package:dd_tk_shop/screen/index/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/loading/simple_loadings.dart';

const kTabData = [
  {'layout': '首页', 'icon': Icons.home},
  {'layout': '分类', 'icon': Icons.category},
  {'layout': '搜索', 'icon': Icons.search},
  {'layout': '消息', 'icon': Icons.message},
  {'layout': '瞎逛', 'icon': Icons.whatshot},
];

/// 主页面结构
class MainTabbars extends StatefulWidget {
  @override
  _MainTabbarsState createState() => _MainTabbarsState();
}

class _MainTabbarsState extends State<MainTabbars>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<MainTabbars> {
  TabController _tabController;
  var _tabView = <Widget>[];

  @override
  Widget build(BuildContext context) {
    /// 加载中
    if (_tabView.isEmpty) {
      return kLoadingWidget();
    }

    /// 主页面结构
    return Scaffold(
      body: TabBarView(
        children: _tabView,
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          width: Get.width,
          child: FittedBox(
            child: Container(
              width: Get.width / (2 / (Get.height / Get.width)),
              child: TabBar(
                controller: _tabController,
                tabs: _renderTabs(),
                isScrollable: false,
                labelColor: Get.theme.primaryColor,
                indicatorColor: Get.theme.primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(4.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 循环页面
  void _loadTabView() {
    setState(() {
      _tabController = TabController(length: kTabData.length, vsync: this);
    });
    kTabData.forEach((element) {
      setState(() {
        _tabView.add(_renderView(element));
      });
    });
  }

  /// 页面显示组件渲染
  Widget _renderView(Map<String, dynamic> data) {
    switch (data['layout']) {
      case '首页':
        return AppIndex();
      default:
        return Container(
          child: Text(data['layout']),
        );
    }
  }

  /// 底部导航
  List<Widget> _renderTabs() {
    var list = <Widget>[];
    kTabData.forEach((element) {
      list.add(Tab(
        icon: Icon(
          element['icon'],
          size: 20,
        ),
      ));
    });
    return list;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _loadTabView();
  }
}
