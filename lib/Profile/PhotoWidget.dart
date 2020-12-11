import 'package:flutter/material.dart';

import '../Constants.dart';

class PhotoWidget extends StatefulWidget {
  final name;
  PhotoWidget(this.name);
  @override
  _PhotoWidgetState createState() => _PhotoWidgetState(name);
}

class _PhotoWidgetState extends State<PhotoWidget> {
  final String name;
  _PhotoWidgetState(this.name);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        (WELCOME + name),
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: TITLESIZE),
      ),
      /*Image.asset(
        'assets/images/MU.png',
        height: 150,
        width: 150,
      ),*/
    ]);
  }
}
