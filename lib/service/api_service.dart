import 'package:dd_taoke_sdk/model/product.dart';
import '../model/product_detail_model.dart';
import '../model/taobao_detail_info.dart';
import '../model/tkl_model.dart';
import '../model/topic_model.dart';

/// 接口定义
abstract class ApiServiceAbstract  {

  /// 精选专题
  Future<List<Topic>> getTopics();

  // 获取榜单商品
  Future<List<Product>> getTopList(int rankType,
      {int? pageId, int? pageSize, int? cid});

  // 商品详情
  Future<ProductDetail> detail({String? id, String? goodsId});

  // 商品评论
  Future<dynamic> getComments(String id);

  // 获取相似的商品
  Future<List<Product>> getLikeProducts(String id, int size);

  // 创建淘口令
  Future<TklModel> createTkl(String text, String url,
      {String? userId, String? logo});

  // 创建淘口令,用淘宝官方的
  Future<dynamic> createTklWithTaobao(String text, String url,
      {String? userId, String? logo});

  // 淘宝官方的获取详情 /tb-getInfo
  Future<TaobaoDetailInfo> getInfo(String goodsId);

}
