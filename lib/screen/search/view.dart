import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/search/search_list_component.dart';
import '../../provider/app.dart';
import 'logic.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

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
      navigationBar: _appbar,
      child: SafeArea(
        child: SizedBox(
          height: Get.height - 64,
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _showSearchInput
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoSearchTextField(
                          onChanged: logic.onKeyWorldsChange,
                          placeholder: '查询优惠券'.tr,
                        ))
                    : Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${'正在搜索'.tr}:${logic.searchKeyWorlds.value}'),
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
      ),
    );
  }

  /// 标题栏
  CupertinoNavigationBar get _appbar =>  CupertinoNavigationBar(
        middle: Text('搜索'.tr),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
