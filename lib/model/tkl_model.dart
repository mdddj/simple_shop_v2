// To parse this JSON data, do
//
//     final tklModel = tklModelFromJson(jsonString);

import 'dart:convert';

TklModel tklModelFromJson(String str) => TklModel.fromJson(json.decode(str));

String tklModelToJson(TklModel data) => json.encode(data.toJson());

class TklModel {
  TklModel({
    this.model,
    this.longTpwd,
  });

  String? model;
  String? longTpwd;

  factory TklModel.fromJson(Map<String, dynamic> json) => TklModel(
    model: json['model'],
    longTpwd: json['longTpwd'],
  );

  Map<String, dynamic> toJson() => {
    'model': model,
    'longTpwd': longTpwd,
  };
}
