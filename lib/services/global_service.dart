import 'package:flutter/material.dart';

class GlobalService {
  GlobalService._internal();
  factory GlobalService() => _instance;
  static final GlobalService _instance = GlobalService._internal();

  final PageController mainPageController = PageController(initialPage: 1);
  final ScrollController homeScrollController = ScrollController();

  final ValueNotifier<int> activePage = ValueNotifier(1);
}
