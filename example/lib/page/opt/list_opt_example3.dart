import 'package:keframe/frame_separate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keframe/size_cache_widget.dart';

import '../../item/complex_item.dart';

class ComplexListOptExample3 extends StatefulWidget {
  @override
  _ComplexListOptExample3State createState() => _ComplexListOptExample3State();
}

class _ComplexListOptExample3State extends State<ComplexListOptExample3> {
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
        title: Text('列表优化 3'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizeCacheWidget(
              child: ListView.builder(
                cacheExtent: 500,
                controller: scrollController,
                itemCount: childCount,
                itemBuilder: (c, i) => FrameSeparateWidget(
                  index: i,
                  placeHolder: Container(
                    color: i % 2 == 0 ? Colors.red : Colors.blue,
                    height: 40,
                  ),
                  child: CellWidget(
                    color: i % 2 == 0 ? Colors.red : Colors.blue,
                    index: i,
                  ),
                ),
              ),
            ),
          ),
          FrameSeparateWidget(
            child: operateBar(),
            index: -1,
          )
        ],
      ),
    );
  }

  Widget operateBar() {
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    childCount += 20;
                    setState(() {});
                  },
                  child: Text(
                    "setState增加20",
                    style: TextStyle(fontSize: 14),
                  )),
              RaisedButton(
                  onPressed: () {
                    scrollController.animateTo(scrollPos,
                        duration:
                            Duration(milliseconds: scrollPos == 0 ? 1500 : 600),
                        curve: Curves.easeInOut);
                    scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                    setState(() {});
                  },
                  child: Text(
                    "滚动到$scrollPos位置",
                    style: TextStyle(fontSize: 14),
                  )),
            ],
          ),
          Text(
              '说明：当不确定实际 item 高度的时候，给 placeholder 设置一个近似的高度。并且在将 ListView 嵌套在 SizeCacheWidget 中。参考一些延迟加载方案，如 H5 的做法，对于已渲染过的 widget 设置占位的尺寸。在滚动过程中，已经渲染过的 item 将不会出现跳动情况。')
        ],
      ),
    );
  }
}
