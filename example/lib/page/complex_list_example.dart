import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../item/complex_item.dart';

class ComplexListExample extends StatefulWidget {
  @override
  _ComplexListExampleState createState() => _ComplexListExampleState();
}

class _ComplexListExampleState extends State<ComplexListExample> {
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
        title: Text('listView'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: childCount,
              itemBuilder: (c, i) => CellWidget(
                color: i % 2 == 0 ? Colors.red : Colors.blue,
                index: i,
              ),
            ),
          ),
          operateBar()
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
                      setState(() {});
                      scrollController.animateTo(scrollPos,
                          duration: Duration(
                              milliseconds: scrollPos == 0 ? 1500 : 600),
                          curve: Curves.easeInOut);
                      scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                    },
                    child: Text(
                      "滚动到$scrollPos位置",
                      style: TextStyle(fontSize: 14),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
