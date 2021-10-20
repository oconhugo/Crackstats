import 'package:flutter/material.dart';
import '../Constants.dart';

class RegisterInTxtWidget extends StatefulWidget {
  final Map<String, Object> valsmap;
  final String valskey;

  RegisterInTxtWidget(this.valsmap, this.valskey);

  @override
  _RegisterInTxtWidgetState createState() =>
      _RegisterInTxtWidgetState(valsmap, valskey);
}

class _RegisterInTxtWidgetState extends State<RegisterInTxtWidget> {
  Map<String, Object> valuesmap;
  String keyvalue;
  bool snackOn = false;
  FocusNode _focus = new FocusNode();
  DateTime selectedDate = DateTime.now();

  _RegisterInTxtWidgetState(this.valuesmap, this.keyvalue);

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  //Will display a snackbar until the password has more than 6 characters
  void _onFocusChange() {
    if (_focus.hasFocus.toString() == 'true' &&
        ((valuesmap[PASSWORD] as String).length < 6) &&
        !snackOn) {
      snackOn = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        content: Text(PASSWORDREQUIREMENTS),
      ));
    } else if (_focus.hasFocus.toString() == 'false' && snackOn) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      snackOn = false;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget displayDate() {
    return Text("Date of birth: " + "${selectedDate.toLocal()}".split(' ')[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: (keyvalue != DATEOFBIRTH)
          ? TextField(
              focusNode: (keyvalue == PASSWORD) ? _focus : null,
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
              obscureText:
                  (keyvalue == (PASSWORD) || keyvalue == (REENTERPASSWORD))
                      ? true
                      : false,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)),
                hintText: keyvalue,
              ),
            )
          : Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0)),
              child: ListTile(
                  title: displayDate(),
                  onTap: () {
                    selectDate(context);
                    valuesmap[keyvalue] = selectedDate.month.toString() +
                        "/" +
                        selectedDate.day.toString() +
                        "/" +
                        selectedDate.year.toString();
                  })),
    );
  }
}
