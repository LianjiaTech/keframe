import 'dart:ui';

import 'package:flutter/material.dart';

/// Copyright 2020 ke.com. All rights reserved.
/// @date     5/7/21 2:12 PM
class LayoutInfoNotification extends Notification {
  final Size size;
  final int? index;

  LayoutInfoNotification(this.index, this.size);
}
