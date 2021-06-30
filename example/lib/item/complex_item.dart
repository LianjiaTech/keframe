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
      height: height,
      color: widget.index % 2 == 0 ? Colors.red : Colors.blue,
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 20,
            child: Text('${widget.index}'),
          ),
          Container(
            width: 30,
            height: 20,
            child: TextField(),
          ),
          Container(width: 30, height: 20, child: TextField()),
          Container(width: 30, height: 20, child: TextField()),
          Container(width: 30, height: 20, child: TextField()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
