import 'package:example/animation/opacity_animation.dart';
import 'package:keframe/frame_separate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../item/complex_item.dart';

class ComplexListOptExample5 extends StatefulWidget {
  @override
  _ComplexListOptExample5State createState() => _ComplexListOptExample5State();
}

class _ComplexListOptExample5State extends State<ComplexListOptExample5> {
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
        title: Text('列表优化 5'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              cacheExtent: 500,
              controller: scrollController,
              itemCount: childCount,
              itemBuilder: (c, i) => FrameSeparateWidget(
                index: i,
                placeHolder: Container(
                  color: Colors.white,
                  height: 60,
                ),
                child: OpacityTansWidget(
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
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Wrap(
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
                          duration: Duration(
                              milliseconds: scrollPos == 0 ? 1500 : 600),
                          curve: Curves.easeInOut);
                      scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                      setState(() {});
                    },
                    child: Text(
                      "滚动到$scrollPos位置",
                      style: TextStyle(fontSize: 14),
                    )),
                Text('说明：结合渐变，位移等动画，可以让替换过程更加流畅'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
