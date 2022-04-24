import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keframe/keframe.dart';


import '../../item/complex_item.dart';

class ComplexListOptExample4 extends StatefulWidget {
  const ComplexListOptExample4({Key key}) : super(key: key);

  @override
  ComplexListOptExample4State createState() => ComplexListOptExample4State();
}

class ComplexListOptExample4State extends State<ComplexListOptExample4> {
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
        title: const Text('列表优化 4'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizeCacheWidget(
              estimateCount: 20,
              child: ListView.builder(
                controller: scrollController,
                itemCount: childCount,
                itemBuilder: (BuildContext c, int i) => FrameSeparateWidget(
                  index: i,
                  placeHolder: Container(
                    color: i.isEven ? Colors.red : Colors.blue,
                    height: 60,
                  ),
                  child: CellWidget(
                    color: i.isEven ? Colors.red : Colors.blue,
                    index: i,
                  ),
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
              '说明：如果能粗略估计一屏上列表项的最大数量如 10，将 SizeCacheWidget 的 estimateCount 设置为 10*2。快速滚动场景构建响应更快，并且内存更稳定')
        ],
      ),
    );
  }
}
