import 'dart:convert';

import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dd_js_util/dd_js_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../components/utils.dart';
import '../model/pdd_detail.dart';
import '../model/wph_detail_resul.dart';

/// 淘客的一些接口
class TKApiService {
  /// 美团领券
  Future<String> meituan(Map<String, String> data,
      {ResultDataMapHandle? mapHandle}) async {
    final result = await utils.api.get('/api/zhe/mt/tg',
        data: data,
        mapHandle: mapHandle, error: (int code, String message, dynamic data) {
    });
    return result;
  }

  /// 设置最新版本号
  /// 需要登录
  /// 需要有admin权限
  Future<void> setNewVersionNumber(
      String number, String desc, String url) async {
    final result = await utils.api.post('/api/admin/set-last-version',
        {'version': number, 'desc': desc, 'url': url});
    utils.showMessage(result);
  }

  /// 获取服务器最新的版本号
  Future<String> getLastVersion() async {
    return await utils.api.get('/api/version/last-version');
  }

  /// 返回唯品会精编商品
  Future<void> getWphJbProducts(int page,
      {String? pageSize,
      String? sort,
      String? totalCount,
      ValueChanged<List<dynamic>>? valueChanged}) async {
    var data = <String, dynamic>{};
    data['page'] = '$page';
    if (pageSize != null) {
      data['pageSize'] = pageSize;
    }
    if (sort != null) {
      data['sort'] = sort;
    }
    if (totalCount != null) {
      data['totalCount'] = totalCount;
    }
    final result = await utils.api.get('/api/zhe/jb', data: data);
    try {
      final map = jsonDecode(result);
      if (map['status'] == 200) {
        final list = map['content'] as List<dynamic>;
        valueChanged?.call(list);
      }
    } catch (_) {
    }
  }

  /// 获取唯品会商品详情
  /// id  --  id 或者url
  Future<WeipinhuiDetail?> getWphProductInfo(String id) async {
    final result = await utils.api
        .get('/api/zhe/wph-detail-v2', data: {'id': id, 'queryDetail': true});
    if (result.isNotEmpty) {
      try {
        final item = jsonDecode(result)['result'][0];
        return WeipinhuiDetail.fromJson(item);
      } catch (_) {
      }
    }
    return null;
  }

  /// 拼多多搜索
  Future<List<PddDetail>> pddSearch(String keyWorlds,
      {Map<String, dynamic>? map}) async {
    var result = <PddDetail>[];

    var data = <String, dynamic>{};
    data['keyword'] = keyWorlds;
    if (map != null) {
      data.addAll(map);
    }
    final response =
        await utils.api.get('/tkapi/api/v1/dtk/apis/pdd-search', data: data);

    if (response.isNotEmpty) {
      try {
        final _map = jsonDecode(response);
        if (_map['goodsList'] is List<dynamic>) {
          final _list = List<PddDetail>.from(
              (_map['goodsList'] as List<dynamic>)
                  .map((e) => PddDetail.fromJson(e))).toList();
          result.addAll(_list);
        }
      } catch (_) {
      }
    }
    return result;
  }

  /// 拼多多推荐商品
  Future<List<dynamic>> pddRecommendGoods(int page, int channelType) async {
    final result = await BaseApi.getDio().get<String>('/pdd/recommend',
        queryParameters: {'page': page, 'channelType': channelType});
    if (result.statusCode == 200 && result.data != null) {
      final json = result.data;
      if (json != null && json.isNotEmpty) {
        try {
          final data = jsonDecode(json);
          final pddRespose = data['goods_basic_detail_response'];
          if (pddRespose != null) {
            if (pddRespose['list'] is List<dynamic>) {
              return pddRespose['list'] as List<dynamic>;
            }
          }
        } catch (_) {
        }
      }
    }
    return [];
  }

  /// 获取平多多详情
  Future<PddDetail?> ppdDetail(String goodsSgin) async {
    final result = await BaseApi.getDio()
        .get<String>('/pdd/detail', queryParameters: {'id': goodsSgin});
    if (result.statusCode == 200 && result.data != null) {
      final json = result.data;
      if (json != null && json.isNotEmpty) {
        try {
          final data = jsonDecode(json);
          final pddRespose = data['goods_detail_response']['goods_details'];
          if (pddRespose is List<dynamic>) {
            final item = pddRespose.first;
            return PddDetail.fromJson(item);
          }
        } catch (_) {
        }
      }
    }
    return null;
  }

  /// 拼多多转链
  Future<dynamic> pddCovert(String goodsSgin) async {
    var data = {'id': goodsSgin};
    final result = await BaseApi.getDio()
        .get<String>('/pdd/covert', queryParameters: data);
    if (result.statusCode == 200 && result.data != null) {
      final json = result.data ?? '';
      if (json.isNotEmpty) {
        try {
          final map = jsonDecode(json);
          return map['goods_promotion_url_generate_response']
              ['goods_promotion_url_list'][0];
        } catch (_) {}
      }
    }
  }
}

/// 开放调用
TKApiService get tkApi => GetIt.I.get<TKApiService>();
