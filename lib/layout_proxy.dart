import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'notification.dart';

/// Copyright 2020 ke.com. All rights reserved.
/// @date     5/7/21 11:53 AM
/// @desc    Pass up the Size information of the child node
class ItemSizeInfoNotifier extends SingleChildRenderObjectWidget {
  final int? index;

  const ItemSizeInfoNotifier({
    Key? key,
    required this.index,
    required Widget? child,
  }) : super(key: key, child: child);

  @override
  _InitialRenderSizeChangedWithCallback createRenderObject(
      BuildContext context) {
    return _InitialRenderSizeChangedWithCallback(
        onLayoutChangedCallback: (size) {
      LayoutInfoNotification(index, size).dispatch(context);
    });
  }
}

class _InitialRenderSizeChangedWithCallback extends RenderProxyBox {
  _InitialRenderSizeChangedWithCallback({
    RenderBox? child,
    required this.onLayoutChangedCallback,
  })  : assert(onLayoutChangedCallback != null),
        super(child);

  final Function(Size size) onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (size != _oldSize) onLayoutChangedCallback(size);
    _oldSize = size;
  }
}
