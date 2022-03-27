import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:dataoke_sdk/params/product_list_param.dart';
import 'package:loading_more_list/loading_more_list.dart';

/// 数据请求类
class ProductListRepository extends LoadingMoreBase<Product> {
  var _page = 1;
  final _pageSize = 10;
  var _hasMore = false;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _page = 1;
    _hasMore = true;
    return await super.refresh(notifyStateChanged);
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    var _isSuccess = false;
    try {
      // await Future.delayed(Duration(seconds: 5));
      final result = await DdTaokeSdk.instance.getProducts(
          param: ProductListParam(pageId: '$_page', pageSize: '$_pageSize'));
      if (result != null) {
        _page++;
        addAll(result.list!);
      }

      _hasMore = result != null && result.list!.length == _pageSize;
      _isSuccess = true;
    } catch (e) {
      _isSuccess = false;
    }

    return _isSuccess;
  }

  @override
  bool get hasMore => _hasMore;
}
