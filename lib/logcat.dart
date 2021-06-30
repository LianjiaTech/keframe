import 'package:flutter/cupertino.dart';

/// You can customize the component's log tag to make it easy to quickly define your own log
const String bkFrame = 'BKFrame';

void logcat(String info) {
  debugPrint(bkFrame + "  " + info);
}
