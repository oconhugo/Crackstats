import 'package:flutter/material.dart';

class PhotoWidget extends StatefulWidget {
  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            '/assets/images/MU.png',
            height: 150,
            width: 150,
          ),
        ]);
  }
}
