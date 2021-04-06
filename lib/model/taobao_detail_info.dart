// To parse this JSON data, do
//
//     final taobaoDetailInfo = taobaoDetailInfoFromJson(jsonString);

import 'dart:convert';

TaobaoDetailInfo taobaoDetailInfoFromJson(String str) => TaobaoDetailInfo.fromJson(json.decode(str));

String taobaoDetailInfoToJson(TaobaoDetailInfo data) => json.encode(data.toJson());

class TaobaoDetailInfo {
  TaobaoDetailInfo({
    this.tbkItemInfoGetResponse,
  });

  TbkItemInfoGetResponse tbkItemInfoGetResponse;

  factory TaobaoDetailInfo.fromJson(Map<String, dynamic> json) => TaobaoDetailInfo(
    tbkItemInfoGetResponse: TbkItemInfoGetResponse.fromJson(json["tbk_item_info_get_response"]),
  );

  Map<String, dynamic> toJson() => {
    "tbk_item_info_get_response": tbkItemInfoGetResponse.toJson(),
  };
}

class TbkItemInfoGetResponse {
  TbkItemInfoGetResponse({
    this.results,
    this.requestId,
  });

  Results results;
  String requestId;

  factory TbkItemInfoGetResponse.fromJson(Map<String, dynamic> json) => TbkItemInfoGetResponse(
    results: Results.fromJson(json["results"]),
    requestId: json["request_id"],
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "request_id": requestId,
  };
}

class Results {
  Results({
    this.nTbkItem,
  });

  List<NTbkItem> nTbkItem;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    nTbkItem: List<NTbkItem>.from(json["n_tbk_item"].map((x) => NTbkItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "n_tbk_item": List<dynamic>.from(nTbkItem.map((x) => x.toJson())),
  };
}

class NTbkItem {
  NTbkItem({
    this.catLeafName,
    this.catName,
    this.freeShipment,
    this.itemUrl,
    this.juOnlineEndTime,
    this.juOnlineStartTime,
    this.juPreShowEndTime,
    this.juPreShowStartTime,
    this.materialLibType,
    this.nick,
    this.numIid,
    this.pictUrl,
    this.presaleDeposit,
    this.presaleEndTime,
    this.presaleStartTime,
    this.presaleTailEndTime,
    this.presaleTailStartTime,
    this.provcity,
    this.reservePrice,
    this.sellerId,
    this.smallImages,
    this.superiorBrand,
    this.title,
    this.tmallPlayActivityEndTime,
    this.tmallPlayActivityStartTime,
    this.userType,
    this.volume,
    this.zkFinalPrice,
  });

  String catLeafName;
  String catName;
  bool freeShipment;
  String itemUrl;
  String juOnlineEndTime;
  String juOnlineStartTime;
  String juPreShowEndTime;
  String juPreShowStartTime;
  String materialLibType;
  String nick;
  int numIid;
  String pictUrl;
  String presaleDeposit;
  int presaleEndTime;
  int presaleStartTime;
  int presaleTailEndTime;
  int presaleTailStartTime;
  String provcity;
  String reservePrice;
  int sellerId;
  SmallImages smallImages;
  String superiorBrand;
  String title;
  int tmallPlayActivityEndTime;
  int tmallPlayActivityStartTime;
  int userType;
  int volume;
  String zkFinalPrice;

  factory NTbkItem.fromJson(Map<String, dynamic> json) => NTbkItem(
    catLeafName: json["cat_leaf_name"],
    catName: json["cat_name"],
    freeShipment: json["free_shipment"],
    itemUrl: json["item_url"],
    juOnlineEndTime: json["ju_online_end_time"],
    juOnlineStartTime: json["ju_online_start_time"],
    juPreShowEndTime: json["ju_pre_show_end_time"],
    juPreShowStartTime: json["ju_pre_show_start_time"],
    materialLibType: json["material_lib_type"],
    nick: json["nick"],
    numIid: json["num_iid"],
    pictUrl: json["pict_url"],
    presaleDeposit: json["presale_deposit"],
    presaleEndTime: json["presale_end_time"],
    presaleStartTime: json["presale_start_time"],
    presaleTailEndTime: json["presale_tail_end_time"],
    presaleTailStartTime: json["presale_tail_start_time"],
    provcity: json["provcity"],
    reservePrice: json["reserve_price"],
    sellerId: json["seller_id"],
    smallImages: SmallImages.fromJson(json["small_images"]),
    superiorBrand: json["superior_brand"],
    title: json["title"],
    tmallPlayActivityEndTime: json["tmall_play_activity_end_time"],
    tmallPlayActivityStartTime: json["tmall_play_activity_start_time"],
    userType: json["user_type"],
    volume: json["volume"],
    zkFinalPrice: json["zk_final_price"],
  );

  Map<String, dynamic> toJson() => {
    "cat_leaf_name": catLeafName,
    "cat_name": catName,
    "free_shipment": freeShipment,
    "item_url": itemUrl,
    "ju_online_end_time": juOnlineEndTime,
    "ju_online_start_time": juOnlineStartTime,
    "ju_pre_show_end_time": juPreShowEndTime,
    "ju_pre_show_start_time": juPreShowStartTime,
    "material_lib_type": materialLibType,
    "nick": nick,
    "num_iid": numIid,
    "pict_url": pictUrl,
    "presale_deposit": presaleDeposit,
    "presale_end_time": presaleEndTime,
    "presale_start_time": presaleStartTime,
    "presale_tail_end_time": presaleTailEndTime,
    "presale_tail_start_time": presaleTailStartTime,
    "provcity": provcity,
    "reserve_price": reservePrice,
    "seller_id": sellerId,
    "small_images": smallImages.toJson(),
    "superior_brand": superiorBrand,
    "title": title,
    "tmall_play_activity_end_time": tmallPlayActivityEndTime,
    "tmall_play_activity_start_time": tmallPlayActivityStartTime,
    "user_type": userType,
    "volume": volume,
    "zk_final_price": zkFinalPrice,
  };
}

class SmallImages {
  SmallImages({
    this.string,
  });

  List<String> string;

  factory SmallImages.fromJson(Map<String, dynamic> json) => SmallImages(
    string: List<String>.from(json["string"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "string": List<dynamic>.from(string.map((x) => x)),
  };
}
