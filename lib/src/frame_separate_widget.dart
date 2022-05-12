import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'frame_separate_task.dart';
import 'layout_proxy.dart';
import 'logcat.dart';
import 'size_cache_widget.dart';

/// Copyright 2020 ke.com. All rights reserved.
/// @date   5/7/21 11:48 AM
/// @desc   Framing component, which renders the child node in a separate frame
///         after the placeholder is rendered in the first frame
class FrameSeparateWidget extends StatefulWidget {
  const FrameSeparateWidget({
    Key? key,
    this.index,
    this.placeHolder,
    required this.child,
  }) : super(key: key);

  final Widget child;

  /// The placeholder widget sets components that are as close to the actual widget as possible
  final Widget? placeHolder;

  /// Identifies its own ID, used in a scenario where size information is stored
  final int? index;

  @override
  FrameSeparateWidgetState createState() => FrameSeparateWidgetState();
}

class FrameSeparateWidgetState extends State<FrameSeparateWidget> {
  Widget? result;

  @override
  void initState() {
    super.initState();
    result = widget.placeHolder ??
        Container(
          height: 20,
        );
    final Map<int?, Size>? size = SizeCacheWidget.of(context)?.itemsSizeCache;
    Size? itemSize;
    if (size != null && size.containsKey(widget.index)) {
      itemSize = size[widget.index];
      logcat('cache hit：${widget.index} ${itemSize.toString()}');
    }
    if (itemSize != null) {
      result = SizedBox(
        width: itemSize.width,
        height: itemSize.height,
        child: result,
      );
    }
    transformWidget();
  }

  @override
  void didUpdateWidget(FrameSeparateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    transformWidget();
  }

  @override
  Widget build(BuildContext context) {
    return ItemSizeInfoNotifier(index: widget.index, child: result);
  }

  void transformWidget() {
    SchedulerBinding.instance.addPostFrameCallback((Duration t) {
      FrameSeparateTaskQueue.instance!.scheduleTask(() {
        if (mounted)
          setState(() {
            result = widget.child;
          });
      }, Priority.animation, () => !mounted, id: widget.index);
    });
  }
}
