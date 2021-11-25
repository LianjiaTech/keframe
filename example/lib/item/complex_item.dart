import 'package:flutter/material.dart';

class CellWidget extends StatefulWidget {
  final Color color;
  final int index;

  const CellWidget({Key key, this.color, this.index}) : super(key: key);

  @override
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  double height = 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: height,
      color: (widget.index % 3 == 0)
          ? Colors.lightGreen[300]
          : (widget.index % 3 == 1)
              ? Colors.lightGreen[500]
              : Colors.lightGreen[700],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: Text('${widget.index}'),
          ),
          Container(
            width: 30,
            height: 30,
            child: TextField(),
            color: Colors.black26,
          ),
          Container(
            width: 30,
            height: 30,
            child: TextField(),
            color: Colors.black26,
          ),
          Container(
            width: 30,
            height: 30,
            child: TextField(),
            color: Colors.black26,
          ),
          Container(
            width: 30,
            height: 30,
            child: TextField(),
            color: Colors.black26,
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
