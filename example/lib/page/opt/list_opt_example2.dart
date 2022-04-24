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
        title: const Text('列表优化 2'),
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
      height: 200,
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
                    'setState增加20',
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
                    '滚动到$scrollPos位置',
                    style: const TextStyle(fontSize: 14),
                  )),
            ],
          ),
          const Text(
              '说明：当不确定实际 item 高度的时候，由于 placeHolder 和实际 item 高度不一致。所以会出现列表抖动的情况，参考下一个案例解决：'),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(CupertinoPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ComplexListOptExample3()));
              },
              child: const Text(
                '跳转到 分帧优化3',
                style: TextStyle(fontSize: 14),
              ))
        ],
      ),
    );
  }
}
