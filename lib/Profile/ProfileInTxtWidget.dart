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
    return Row(children: [
      Container(
        child: Text(keyvalue),
        width: MediaQuery.of(context).size.width / 4,
      ),
      Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: TextField(
          obscureText: (keyvalue==PASSWORD)?true:false,
          decoration: InputDecoration(
                enabled: false,
                labelText: valuesmap[keyvalue],
          ),
        )),
      ),
      FlatButton(
        onPressed: () => print("edit"),
        child: Icon(Icons.create_rounded,
        color: Colors.orange[700],
        size: 25.0,),
      ),
    /* RaisedButton.icon(
        icon: Icon(
      Icons.create_rounded,
      //color: Colors.blue,
      size: 36.0,
      ),
        label: "",
        color: YELLOW,
        textColor: BLACK,
        onPressed: () => print("edit"),
      ),*/
    ]);
  }
}
