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

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1921, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        valuesmap[DATEOFBIRTH] = selectedDate.month.toString().padLeft(2,'0') +
                        "-" +
                        selectedDate.day.toString().padLeft(2,'0')+
                        "-" +
                        selectedDate.year.toString().padLeft(2,'0');
                        
      });
  }

  //Allows the user to edit the text field
  void enableField() {
    setState(() {
      if (isEnable)
        isEnable = false;
      else
        isEnable = true;
    });
  }

  _ProfileInTxtWidgetState(this.valuesmap, this.keyvalue){
    String dateNoFormat = valuesmap[DATEOFBIRTH];
    var dateArr = dateNoFormat.split('-');
    String formattedDate = dateArr[2]+dateArr[0]+dateArr[1];
    
    selectedDate = DateTime.parse(formattedDate);
  }

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
          child: (keyvalue != DATEOFBIRTH)? TextField(
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
          ) : Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            ])),
      (keyvalue != EMAIL)
          ? TextButton(
              onPressed: (keyvalue != DATEOFBIRTH) ? enableField : () => _selectDate(context),
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
