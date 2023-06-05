import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0; // 状态
  int get count => _count; // 获取状态
  incCount() {
    _count++;
    notifyListeners(); // 标识更新状态
  }
}
