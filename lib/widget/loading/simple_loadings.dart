import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

Widget get kLoadingWidget => Center(
  child: SpinKitWave(
    color: Get.theme.primaryColor,
    size: 30.0,
  ),
);
