import 'package:crackstats/ConnectDB.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class AddAnnouncementPopUp {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textEditing = '';
  bool isMessageEmpty = false;

  void newAnnouncement(context, league) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (String value) {
                          _textEditing = value;
                        },
                        decoration: InputDecoration(
                          hintText: ENTERANNOUNCEMENT,
                          errorText: (isMessageEmpty) ? ENTERTEXT : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: RED, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: PRIMARYCOLOR, width: 1.0),
                          ),
                        ),
                      ),
                    ],
                  )),
              title: Text(ADDNEWANNOUNCEMENT),
              actions: <Widget>[
                InkWell(
                  child: Text(ADDTEXT),
                  onTap: () async {
                    if (_textEditing.isNotEmpty) {
                      await new ConnectDB()
                          .insertNewAnnouncement(_textEditing, league);
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        isMessageEmpty = true;
                      });
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
