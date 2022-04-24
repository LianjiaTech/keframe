import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keframe/keframe.dart';


import '../../item/complex_item.dart';

class ComplexListOptExample3 extends StatefulWidget {
  const ComplexListOptExample3({Key key}) : super(key: key);

  @override
  ComplexListOptExample3State createState() => ComplexListOptExample3State();
}

class ComplexListOptExample3State extends State<ComplexListOptExample3> {
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
        title: const Text('列表优化 3'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizeCacheWidget(
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
          ),
          FrameSeparateWidget(
            index: -1,
            child: operateBar(),
          )
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
              '说明：当不确定实际 item 高度的时候，给 placeholder 设置一个近似的高度。并且在将 ListView 嵌套在 SizeCacheWidget 中。参考一些延迟加载方案，如 H5 的做法，对于已渲染过的 widget 设置占位的尺寸。在滚动过程中，已经渲染过的 item 将不会出现跳动情况。')
        ],
      ),
    );
  }
}
