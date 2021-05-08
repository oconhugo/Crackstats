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
  bool snackOn = false;

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
        padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
        child: Text(
          keyvalue,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        width: MediaQuery.of(context).size.width / 4,
      ),
      Container(
          width: MediaQuery.of(context).size.width / 2,
          child: TextField(
            obscureText: (keyvalue == PASSWORD) ? true : false,
            onChanged: (String value) {
              valuesmap[keyvalue] = value;
              if (keyvalue == PASSWORD && (value.length < 6) && !snackOn) {
                snackOn = true;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(days: 1),
                  content: Text(PASSWORDREQUIREMENTS),
                ));
              } else if (keyvalue == PASSWORD && (value.length >= 6)) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                snackOn = false;
              }
            },
            decoration: InputDecoration(
              enabled: isEnable,
              hintText:
                  (keyvalue == PASSWORD) ? PASSWORDHIDER : valuesmap[keyvalue],
            ),
          )),
      (keyvalue != EMAIL)
          ? TextButton(
              onPressed: enableField,
              child: Icon(
                Icons.create_rounded,
                color: PENCILCOLOR,
                size: 25.0,
              ),
            )
          : Text(EMPTYSTR),
    ]);
  }
}
