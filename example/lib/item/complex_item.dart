import 'package:flutter/material.dart';

class CellWidget extends StatefulWidget {
  const CellWidget({Key key, this.color, this.index}) : super(key: key);

  final Color color;
  final int index;

  @override
  CellWidgetState createState() => CellWidgetState();
}

class CellWidgetState extends State<CellWidget> {
  double height = 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: height,
      color: (widget.index % 3 == 0)
          ? Colors.lightGreen[300]
          : (widget.index % 3 == 1)
              ? Colors.lightGreen[500]
              : Colors.lightGreen[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 30,
            height: 30,
            child: Text('${widget.index}'),
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.black26,
            child: const TextField(),
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.black26,
            child: const TextField(),
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.black26,
            child: const TextField(),
          ),
          Container(
            width: 30,
            height: 30,
            color: Colors.black26,
            child: const TextField(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
