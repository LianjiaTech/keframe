import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../item/complex_item.dart';

class ComplexListExample extends StatefulWidget {
  const ComplexListExample({Key key}) : super(key: key);

  @override
  ComplexListExampleState createState() => ComplexListExampleState();
}

class ComplexListExampleState extends State<ComplexListExample> {
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
        title: const Text('Complex ListView'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: childCount,
              itemBuilder: (BuildContext c, int i) => CellWidget(
                color: i.isEven ? Colors.red : Colors.blue,
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
    return SizedBox(
      height: 100,
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
                      'setState increase 20 items',
                      style: TextStyle(fontSize: 14),
                    )),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      scrollController.animateTo(scrollPos,
                          duration: Duration(
                              milliseconds: scrollPos == 0 ? 1500 : 600),
                          curve: Curves.easeInOut);
                      scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                    },
                    child: Text(
                      'Scroll to $scrollPos offset',
                      style: const TextStyle(fontSize: 14),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
