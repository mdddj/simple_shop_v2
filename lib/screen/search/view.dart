import '../../provider/app.dart';
import '../../components/search/search_list_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchLogic logic = Get.put(SearchLogic());

  final ScrollController _scrollController = ScrollController();

  var _showSearchInput = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      final _p = _scrollController.offset;
      if (_p >= 30) {
        if (_showSearchInput) {
          setState(() {
            _showSearchInput = false;
          });
        }
      } else {
        if (!_showSearchInput) {
          setState(() {
            _showSearchInput = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchInit = context.watch<AppProvider>().searchInit;
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: Get.height - 64,
        child: Column(
          children: [
            _appbar,
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: _showSearchInput
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSearchTextField(
                        onChanged: logic.onKeyWorldsChange,
                      ))
                  : Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Text('正在搜索:${logic.searchKeyWorlds.value}'),
                    ),
            ),
            Expanded(
                child: searchInit
                    ? Container()
                    : SearchListComponent(
                        searchRepostory: logic.searchRepostory,
                        controller: _scrollController,
                      ))
          ],
        ),
      ),
    );
  }

  /// 标题栏
  Widget get _appbar => AppBar(
        title: Text('搜索'),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
