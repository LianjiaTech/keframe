import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keframe/frame_separate_widget.dart';

import '../../animation/opacity_animation.dart';
import '../../item/complex_item.dart';

class ComplexListOptExample5 extends StatefulWidget {
  const ComplexListOptExample5({Key key}) : super(key: key);

  @override
  ComplexListOptExample5State createState() => ComplexListOptExample5State();
}

class ComplexListOptExample5State extends State<ComplexListOptExample5> {
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
        title: const Text('列表优化 5'),
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
                  color: Colors.white,
                  height: 60,
                ),
                child: OpacityTansWidget(
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
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Wrap(
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
                          duration: Duration(
                              milliseconds: scrollPos == 0 ? 1500 : 600),
                          curve: Curves.easeInOut);
                      scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                      setState(() {});
                    },
                    child: Text(
                      '滚动到$scrollPos位置',
                      style: const TextStyle(fontSize: 14),
                    )),
                const Text('说明：结合渐变，位移等动画，可以让替换过程更加流畅'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
