import 'package:example/item/complex_item.dart';
import 'package:flutter/material.dart';
import 'package:keframe/keframe.dart';

class ComplexCommonOptExample extends StatelessWidget {
  const ComplexCommonOptExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Optimization complex common'),
      ),
      body: Column(children: <Widget>[
        rowItem(),
        rowItem(),
        rowItem(),
        rowItem(),
        rowItem(),
        rowItem(),
        const Text('说明：直接给复杂组件嵌套 FrameSeparateWidget，转场动画更加流畅'),
        const Text(
            'Note: Directly to complex components nested FrameSeparateWidget, transition animation more smooth'),
      ]),
    );
  }

  Widget rowItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // It's the complex widget in your business
        FrameSeparateWidget(
          placeHolder: Container(
            color: Colors.lightGreen[300],
            height: 60,
          ),
          child: const CellWidget(
            index: 0,
          ),
        ),
        FrameSeparateWidget(
          placeHolder: Container(
            color: Colors.lightGreen[300],
            height: 60,
          ),
          child: const CellWidget(
            index: 1,
          ),
        )
      ],
    );
  }
}
