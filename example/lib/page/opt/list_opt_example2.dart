import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keframe/keframe.dart';

import '../../item/complex_item.dart';
import 'list_opt_example3.dart';

class ComplexListOptExample2 extends StatefulWidget {
  const ComplexListOptExample2({Key key}) : super(key: key);

  @override
  ComplexListOptExample2State createState() => ComplexListOptExample2State();
}

class ComplexListOptExample2State extends State<ComplexListOptExample2> {
  int childCount = 100;

  ScrollController scrollController;
  double scrollPos = 1500;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Optimization example 2'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              cacheExtent: 500,
              controller: scrollController,
              itemCount: childCount,
              itemBuilder: (BuildContext c, int i) => FrameSeparateWidget(
                index: i,
                placeHolder: Container(
                  color: i.isEven ? Colors.red : Colors.blue,
                  height: 40,
                ),
                child: CellWidget(
                  color: i.isEven ? Colors.red : Colors.blue,
                  index: i,
                ),
              ),
            ),
          ),
          operateBar()
        ],
      ),
    );
  }

  Widget operateBar() {
    logcat('operateBar build $scrollPos');
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    childCount += 20;
                    setState(() {});
                  },
                  child: const Text(
                    'setState increase 20 items',
                    style: TextStyle(fontSize: 14),
                  )),
              ElevatedButton(
                  onPressed: () {
                    scrollController.animateTo(scrollPos,
                        duration:
                            Duration(milliseconds: scrollPos == 0 ? 1500 : 600),
                        curve: Curves.easeInOut);
                    scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                    setState(() {});
                  },
                  child: Text(
                    'Scroll to $scrollPos offset',
                    style: const TextStyle(fontSize: 14),
                  )),
            ],
          ),
          const Text(
              '说明：不确定实际 item 高度的时候，由于 placeHolder 和实际 item 高度不一致，所以出现列表抖动，参考下一个案例'),
          const Text(
              'Note: When the actual item height is not certain, due to the placeHolder and the actual item height is inconsistent. Therefore, list jitter will occur. Refer to the next case for solution:'),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(CupertinoPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ComplexListOptExample3()));
              },
              child: const Text(
                'Jump to next case',
                style: TextStyle(fontSize: 14),
              ))
        ],
      ),
    );
  }
}
