import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// 比例适配
class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
