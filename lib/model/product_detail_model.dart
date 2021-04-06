// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

DateTime getTime(String val,Map<String, dynamic> json){
  if(val!=null && val.toString().isNotEmpty){
    return DateTime.parse(json[val]);
  }
  return null;
}
class ProductDetail {
  ProductDetail({
    this.teamName,
    this.tbcid,
    this.shipPercent,
    this.freeshipRemoteDistrict,
    this.yunfeixian,
    this.itemLink,
    this.goldSellers,
    this.reimgs,
    this.couponLink,
    this.haitao,
    this.sellerId,
    this.discounts,
    this.directCommissionLink,
    this.couponStartTime,
    this.serviceScore,
    this.mainPic,
    this.tchaoshi,
    this.id,
    this.brand,
    this.imgs,
    this.brandName,
    this.subcid,
    this.couponConditions,
    this.detailPics,
    this.subdivisionId,
    this.dsrScore,
    this.shopLogo,
    this.dailySales,
    this.shopLevel,
    this.couponTotalNum,
    this.descScore,
    this.brandWenan,
    this.activityEndTime,
    this.shipScore,
    this.brandId,
    this.couponReceiveNum,
    this.shopType,
    this.desc,
    this.cid,
    this.commissionRate,
    this.originalPrice,
    this.actualPrice,
    this.goodsId,
    this.quanMLink,
    this.shopName,
    this.activityStartTime,
    this.video,
    this.title,
    this.dtitle,
    this.monthSales,
    this.subdivisionRank,
    this.hzQuanOver,
    this.isSubdivision,
    this.marketingMainPic,
    this.directCommissionType,
    this.servicePercent,
    this.commissionType,
    this.couponEndTime,
    this.directCommission,
    this.twoHoursSales,
    this.createTime,
    this.dsrPercent,
    this.estimateAmount,
    this.specialText,
    this.couponPrice,
    this.activityType,
    this.hotPush,
    this.subdivisionName,
  });

  String teamName;
  int tbcid;
  double shipPercent;
  int freeshipRemoteDistrict;
  int yunfeixian;
  String itemLink;
  int goldSellers;
  String reimgs;
  String couponLink;
  int haitao;
  String sellerId;
  double discounts;
  String directCommissionLink;
  DateTime couponStartTime;
  double serviceScore;
  String mainPic;
  int tchaoshi;
  int id;
  int brand;
  String imgs;
  String brandName;
  List<int> subcid;
  String couponConditions;
  String detailPics;
  int subdivisionId;
  double dsrScore;
  String shopLogo;
  int dailySales;
  int shopLevel;
  int couponTotalNum;
  double descScore;
  String brandWenan;
  String activityEndTime;
  double shipScore;
  int brandId;
  int couponReceiveNum;
  int shopType;
  String desc;
  int cid;
  double commissionRate;
  double originalPrice;
  double actualPrice;
  String goodsId;
  int quanMLink;
  String shopName;
  String activityStartTime;
  String video;
  String title;
  String dtitle;
  int monthSales;
  int subdivisionRank;
  int hzQuanOver;
  int isSubdivision;
  String marketingMainPic;
  int directCommissionType;
  double servicePercent;
  int commissionType;
  DateTime couponEndTime;
  double directCommission;
  int twoHoursSales;
  DateTime createTime;
  double dsrPercent;
  double estimateAmount;
  List<dynamic> specialText;
  double couponPrice;
  int activityType;
  int hotPush;
  String subdivisionName;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    teamName: json["teamName"],
    tbcid: json["tbcid"],
    shipPercent: json["shipPercent"].toDouble(),
    freeshipRemoteDistrict: json["freeshipRemoteDistrict"],
    yunfeixian: json["yunfeixian"],
    itemLink: json["itemLink"],
    goldSellers: json["goldSellers"],
    reimgs: json["reimgs"],
    couponLink: json["couponLink"],
    haitao: json["haitao"],
    sellerId: json["sellerId"],
    discounts: json["discounts"].toDouble(),
    directCommissionLink: json["directCommissionLink"],
    couponStartTime: DateTime.parse(json["couponStartTime"]),
    serviceScore: json["serviceScore"].toDouble(),
    mainPic: json["mainPic"],
    tchaoshi: json["tchaoshi"],
    id: json["id"],
    brand: json["brand"],
    imgs: json["imgs"],
    brandName: json["brandName"],
    subcid: List<int>.from(json["subcid"].map((x) => x)),
    couponConditions: json["couponConditions"],
    detailPics: json["detailPics"],
    subdivisionId: json["subdivisionId"],
    dsrScore: json["dsrScore"].toDouble(),
    shopLogo: json["shopLogo"],
    dailySales: json["dailySales"],
    shopLevel: json["shopLevel"],
    couponTotalNum: json["couponTotalNum"],
    descScore: json["descScore"].toDouble(),
    brandWenan: json["brandWenan"],
    activityEndTime: json["activityEndTime"],
    shipScore: json["shipScore"].toDouble(),
    brandId: json["brandId"],
    couponReceiveNum: json["couponReceiveNum"],
    shopType: json["shopType"],
    desc: json["desc"],
    cid: json["cid"],
    commissionRate: json["commissionRate"].toDouble(),
    originalPrice: json["originalPrice"].toDouble(),
    actualPrice: json["actualPrice"].toDouble(),
    goodsId: json["goodsId"],
    quanMLink: json["quanMLink"],
    shopName: json["shopName"],
    activityStartTime: json["activityStartTime"],
    video: json["video"],
    title: json["title"],
    dtitle: json["dtitle"],
    monthSales: json["monthSales"],
    subdivisionRank: json["subdivisionRank"],
    hzQuanOver: json["hzQuanOver"],
    isSubdivision: json["isSubdivision"],
    marketingMainPic: json["marketingMainPic"],
    directCommissionType: json["directCommissionType"],
    servicePercent: json["servicePercent"].toDouble(),
    commissionType: json["commissionType"],
    couponEndTime: DateTime.parse(json["couponEndTime"]),
    directCommission: json["directCommission"].toDouble(),
    twoHoursSales: json["twoHoursSales"],
    createTime: getTime('createTime',json),
    dsrPercent: json["dsrPercent"].toDouble(),
    estimateAmount: json["estimateAmount"].toDouble(),
    specialText: List<dynamic>.from(json["specialText"].map((x) => x)),
    couponPrice: json["couponPrice"].toDouble(),
    activityType: json["activityType"],
    hotPush: json["hotPush"],
    subdivisionName: json["subdivisionName"],
  );


  Map<String, dynamic> toJson() => {
    "teamName": teamName,
    "tbcid": tbcid,
    "shipPercent": shipPercent,
    "freeshipRemoteDistrict": freeshipRemoteDistrict,
    "yunfeixian": yunfeixian,
    "itemLink": itemLink,
    "goldSellers": goldSellers,
    "reimgs": reimgs,
    "couponLink": couponLink,
    "haitao": haitao,
    "sellerId": sellerId,
    "discounts": discounts,
    "directCommissionLink": directCommissionLink,
    "couponStartTime": couponStartTime.toIso8601String(),
    "serviceScore": serviceScore,
    "mainPic": mainPic,
    "tchaoshi": tchaoshi,
    "id": id,
    "brand": brand,
    "imgs": imgs,
    "brandName": brandName,
    "subcid": List<dynamic>.from(subcid.map((x) => x)),
    "couponConditions": couponConditions,
    "detailPics": detailPics,
    "subdivisionId": subdivisionId,
    "dsrScore": dsrScore,
    "shopLogo": shopLogo,
    "dailySales": dailySales,
    "shopLevel": shopLevel,
    "couponTotalNum": couponTotalNum,
    "descScore": descScore,
    "brandWenan": brandWenan,
    "activityEndTime": activityEndTime,
    "shipScore": shipScore,
    "brandId": brandId,
    "couponReceiveNum": couponReceiveNum,
    "shopType": shopType,
    "desc": desc,
    "cid": cid,
    "commissionRate": commissionRate,
    "originalPrice": originalPrice,
    "actualPrice": actualPrice,
    "goodsId": goodsId,
    "quanMLink": quanMLink,
    "shopName": shopName,
    "activityStartTime": activityStartTime,
    "video": video,
    "title": title,
    "dtitle": dtitle,
    "monthSales": monthSales,
    "subdivisionRank": subdivisionRank,
    "hzQuanOver": hzQuanOver,
    "isSubdivision": isSubdivision,
    "marketingMainPic": marketingMainPic,
    "directCommissionType": directCommissionType,
    "servicePercent": servicePercent,
    "commissionType": commissionType,
    "couponEndTime": couponEndTime.toIso8601String(),
    "directCommission": directCommission,
    "twoHoursSales": twoHoursSales,
    "createTime": createTime.toIso8601String(),
    "dsrPercent": dsrPercent,
    "estimateAmount": estimateAmount,
    "specialText": List<dynamic>.from(specialText.map((x) => x)),
    "couponPrice": couponPrice,
    "activityType": activityType,
    "hotPush": hotPush,
    "subdivisionName": subdivisionName,
  };
}



List<DetailImage> detailImageFromJson(String str) => List<DetailImage>.from(json.decode(str).map((x) => DetailImage.fromJson(x)));

String detailImageToJson(List<DetailImage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailImage {
  DetailImage({
    this.img,
    this.hotAreaList,
    this.width,
    this.height,
  });

  String img;
  List<dynamic> hotAreaList;
  String width;
  String height;

  factory DetailImage.fromJson(Map<String, dynamic> json) => DetailImage(
    img: json["img"],
    hotAreaList: List<dynamic>.from(json["hotAreaList"].map((x) => x)),
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "hotAreaList": List<dynamic>.from(hotAreaList.map((x) => x)),
    "width": width,
    "height": height,
  };
}

