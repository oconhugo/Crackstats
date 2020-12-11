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
  bool isEnable = false;
  void enableField() {
    setState(() {
      if (isEnable)
        isEnable = false;
      else
        isEnable = true;
    });
  }

  _ProfileInTxtWidgetState(this.valuesmap, this.keyvalue);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text(
          keyvalue,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        width: MediaQuery.of(context).size.width / 4,
      ),
      Expanded(
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TextField(
              obscureText: (keyvalue == PASSWORD) ? true : false,
              decoration: InputDecoration(
                enabled: isEnable,
                hintText: valuesmap[keyvalue],
              ),
            )),
      ),
      FlatButton(
        onPressed: enableField,
        child: Icon(
          Icons.create_rounded,
          color: PENCILCOLOR,
          size: 25.0,
        ),
      ),
    ]);
  }
}
