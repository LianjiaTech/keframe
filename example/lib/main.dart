import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fps_monitor/util/collection_util.dart';
import 'package:fps_monitor/widget/custom_widget_inspector.dart';

import 'page/complex_common_example.dart';
import 'page/complex_list_example.dart';
import 'page/opt/common_opt_example.dart';
import 'page/opt/list_opt_example1.dart';
import 'page/opt/list_opt_example2.dart';
import 'page/opt/list_opt_example3.dart';
import 'page/opt/list_opt_example4.dart';
import 'page/opt/list_opt_example5.dart';

void main() {
  kFpsInfoMaxSize = 200;
  runApp(const MyApp());
}

GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
        (Duration t) => overlayState = globalKey.currentState.overlay);

    return MaterialApp(
      navigatorKey: globalKey,
      title: 'Keframe example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (BuildContext ctx, Widget child) {
        if (kIsWeb) return child;
        return CustomWidgetInspector(
          child: child,
        );
      },
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keframe example'),
      ),
      body: ListView(
        children: <Widget>[
          const ListTile(
            title: Text('before optimization（优化前）：',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('Complex ListView（复杂列表）'),
            onTap: () => open(context, const ComplexListExample()),
          ),
          ListTile(
            title: const Text('Complex common（非列表复杂页面）'),
            onTap: () => open(context, const ComplexCommonExample()),
          ),
          const ListTile(
            title: Text(
              'After the optimization（分帧优化后）：',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Optimization ListView（列表分帧优化）1'),
            subtitle: const Text(
                'Given the actual height of the item widget(已知实际 Widget 高度的情况)'),
            onTap: () => open(context, const ComplexListOptExample1()),
          ),
          ListTile(
            title: const Text('Optimization ListView（列表分帧优化) 2'),
            subtitle: const Text(
                'Unknown height of the actual item widget (jitter)（实际 Widget 高度未知的情况(出现抖动)）'),
            onTap: () => open(context, const ComplexListOptExample2()),
          ),
          ListTile(
            title: const Text('Optimization ListView（列表分帧优化）3'),
            subtitle: const Text(
                'Unknown height of the actual Widget (no jitter for secondary rendering)（实际 Widget 高度未知的情况(二次渲染不抖动)）'),
            onTap: () => open(context, const ComplexListOptExample3()),
          ),
          ListTile(
            title: const Text('Optimization ListView（列表分帧优化）4'),
            subtitle: const Text(
                'If you can predict the number of list items on a screen, rendering performance is better（ 如果可以预估一屏上的列表项数，渲染性能会更优）'),
            onTap: () => open(context, const ComplexListOptExample4()),
          ),
          ListTile(
            title: const Text('Optimization ListView（列表分帧优化）5'),
            subtitle: const Text(
                'By nesting gradients, shifts and other animations, let the frame change more smoothly（通过嵌套渐变、位移等动画，让分帧变化更流畅）'),
            onTap: () => open(context, const ComplexListOptExample5()),
          ),
          ListTile(
            title: const Text('Optimization common（非复杂列表优化）1'),
            subtitle: const Text(
                'Non - list page, optimize the transition process（非列表页面，优化转场过程）'),
            onTap: () => open(context, const ComplexCommonOptExample()),
          )
        ],
      ),
    );
  }

  void open(BuildContext context, Widget widget) {
    Navigator.of(context).push<void>(
        CupertinoPageRoute(builder: (BuildContext context) => widget));
  }
}
