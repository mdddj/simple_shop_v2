import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:dd_models/models/product.dart';
import 'package:loading_more_list/loading_more_list.dart';

class SearchRepostory extends LoadingMoreBase<Product> {
  var _page = 1;
  final _type = 0;
  final _pageSize = 20;
  var _searchKeyWorlds = '';
  Function? onLoaded; // 加载完毕执行的事件

  /// 执行搜索
  void onChangeKeyWorld(String keyworld) {
    _searchKeyWorlds = keyworld;
    refresh(true);
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _page = 1;
    return super.refresh(notifyStateChanged);
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    if (_searchKeyWorlds.isEmpty) return true;
    var _isSuccess = false;
    try {
      if (_page == 1) clear();
      final params = SuperSearchParam(
          keyWords: _searchKeyWorlds,
          pageSize: '$_pageSize',
          type: '$_type',
          pageId: '$_page');
      final result = await DdTaokeSdk.instance.superSearch(
          param: params,
          requestParamsBuilder: (RequestParams requestParams) {
            return requestParams.copyWith(data: params.toJson());
          });
      if (result != null && result.list != null) {
        addAll(result.list!);
        _isSuccess = true;
        _page++;
      }
    } catch (e) {
      _isSuccess = false;
    }

    onLoaded?.call();
    return _isSuccess;
  }
}
