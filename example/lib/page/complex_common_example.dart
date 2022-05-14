import 'package:example/item/complex_item.dart';
import 'package:flutter/material.dart';

class ComplexCommonExample extends StatelessWidget {
  const ComplexCommonExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Complex common'),
      ),
      body: Column(children: <Widget>[
        rowItem(),
        rowItem(),
        rowItem(),
        rowItem(),
        rowItem(),
        rowItem(),
        const Text(
            '说明：实际业务中，对于非列表的复杂页面。卡顿可能发生在打开页面的转场动画中，你可以仔细观察下这个页面打开的打开过程。'),
        const Text(
            'Note: In actual business, for non - list complex pages. Jank may occur during a transition animation that opens a page, so you can watch the opening process of the page carefully'),
      ]),
    );
  }

  Widget rowItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        // It's the complex widget in your business
        CellWidget(
          index: 0,
        ),
        CellWidget(
          index: 1,
        )
      ],
    );
  }
}
