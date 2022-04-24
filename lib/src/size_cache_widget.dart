import 'package:flutter/cupertino.dart';
import 'frame_separate_task.dart';

import 'logcat.dart';
import 'notification.dart';

/// Copyright 2020 ke.com. All rights reserved.
/// @date     5/7/21 2:13 PM
/// @desc    <int,Size> > Cache child node information
class SizeCacheWidget extends StatefulWidget {
  const SizeCacheWidget({Key? key, required this.child, this.estimateCount = 0})
      : super(key: key);
  final Widget child;

  /// Estimate the number of children on the screen, which is used to set the size of the frame queue
  /// Optimizes the list of items on the current screen for delayed response in fast scrolling scenarios
  final int estimateCount;

  static SizeCacheWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<SizeCacheWidgetState>();
  }

  @override
  SizeCacheWidgetState createState() => SizeCacheWidgetState();
}

class SizeCacheWidgetState extends State<SizeCacheWidget> {
  /// Stores the Size of the child node's report
  Map<int?, Size> itemsSizeCache = <int?, Size>{};

  @override
  void initState() {
    super.initState();
    setSeparateFramingTaskQueue();
  }

  @override
  void didUpdateWidget(SizeCacheWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setSeparateFramingTaskQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext ctx) {
        return NotificationListener<LayoutInfoNotification>(
          onNotification: (LayoutInfoNotification notification) {
            logcat(
                'size info :  index = ${notification.index}  size = ${notification.size.toString()}');
            saveLayoutInfo(notification.index, notification.size);
            return true;
          },
          child: widget.child,
        );
      },
    );
  }

  void saveLayoutInfo(int? index, Size size) {
    itemsSizeCache[index] = size;
  }

  void setSeparateFramingTaskQueue() {
    if (widget.estimateCount != 0) {
      FrameSeparateTaskQueue.instance!.maxTaskSize = widget.estimateCount;
    }
  }

  @override
  void dispose() {
    FrameSeparateTaskQueue.instance!.resetMaxTaskSize();
    super.dispose();
  }
}
