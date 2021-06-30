import 'package:flutter/material.dart';

class OpacityTansWidget extends StatefulWidget {
  final Widget child;

  const OpacityTansWidget({Key key, this.child}) : super(key: key);

  @override
  _OpacityState createState() => _OpacityState();
}

class _OpacityState extends State<OpacityTansWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 500),
        lowerBound: 0.5,
        upperBound: 1.0,
        vsync: this);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
