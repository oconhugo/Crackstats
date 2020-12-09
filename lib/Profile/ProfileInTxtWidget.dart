import 'package:flutter/material.dart';
import '../Constants.dart';

class ProfileInTxtWidget extends StatefulWidget {
  final Map<String, Object> valsmap;
  final String valskey;

  ProfileInTxtWidget(this.valsmap, this.valskey);

  @override
  _ProfileInTxtWidgetState createState() =>
      _ProfileInTxtWidgetState(valsmap, valskey);
}

class _ProfileInTxtWidgetState extends State<ProfileInTxtWidget> {
  Map<String, Object> valuesmap;
  String keyvalue;

  _ProfileInTxtWidgetState(this.valuesmap, this.keyvalue);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: TextField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black)),
          hintText: keyvalue,
        ),
      ),
    );
  }
}
