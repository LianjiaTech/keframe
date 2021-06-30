import 'package:example/page/opt/list_opt_example4.dart';
import 'package:example/page/opt/list_opt_example5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fps_monitor/util/collection_util.dart';
import 'package:fps_monitor/widget/custom_widget_inspector.dart';
import 'page/complex_list_example.dart';
import 'page/opt/list_opt_example1.dart';
import 'page/opt/list_opt_example2.dart';
import 'page/opt/list_opt_example3.dart';

void main() {
  kFpsInfoMaxSize = 200;
  runApp(MyApp());
}

GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
        (t) => overlayState = globalKey.currentState.overlay);

    return MaterialApp(
      navigatorKey: globalKey,
      title: 'Keframe example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (ctx, child) => CustomWidgetInspector(
        child: child,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keframe example'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('优化前：', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('ListView'),
            onTap: () => open(context, ComplexListExample()),
          ),
          ListTile(
            title: Text(
              '分帧优化后：',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('列表分帧优化 1'),
            subtitle: Text('已知实际 Widget 高度的情况'),
            onTap: () => open(context, ComplexListOptExample1()),
          ),
          ListTile(
            title: Text('列表分帧优化 2'),
            subtitle: Text('实际 Widget 高度未知的情况(出现抖动)'),
            onTap: () => open(context, ComplexListOptExample2()),
          ),
          ListTile(
            title: Text('列表分帧优化 3'),
            subtitle: Text('实际 Widget 高度未知的情况(二次渲染不抖动)'),
            onTap: () => open(context, ComplexListOptExample3()),
          ),
          ListTile(
            title: Text('列表分帧优化 4'),
            subtitle: Text('进阶用法，预估一屏上的列表项数'),
            onTap: () => open(context, ComplexListOptExample4()),
          ),
          ListTile(
            title: Text('列表分帧优化 5'),
            subtitle: Text('通过嵌套渐变、位移等动画，让分帧变化更流畅'),
            onTap: () => open(context, ComplexListOptExample5()),
          )
        ],
      ),
    );
  }

  void open(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }
}
