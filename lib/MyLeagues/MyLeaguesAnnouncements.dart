import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';


class MyLeaguesAnnouncements extends StatefulWidget {

  final List tempList;
  
  MyLeaguesAnnouncements(this.tempList);

  @override
  _MyLeaguesAnnouncementsState createState() => _MyLeaguesAnnouncementsState(tempList);
}

class _MyLeaguesAnnouncementsState extends State<MyLeaguesAnnouncements> {

  String leagueSelected;
  List userAdminLeagues;
  bool isEnable=false;
  final _formKey = GlobalKey<FormState>();

  _MyLeaguesAnnouncementsState(this.userAdminLeagues);

  addAnnouncementPopUp(){
    return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submitß"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
  }

  getLeagueAnnouncements(){

  }

  showSnackLeague(){
     Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(SELECTLEAGUE),
                ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery.of(context).size.width / 1.5,
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(MYLEAGUESTITLE),
              value: leagueSelected,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 24,
              style: TextStyle(color: PRIMARYCOLOR),
              underline: Container(
                height: 2,
                color: PRIMARYCOLOR,
              ),
              onChanged: (String newValue) {
                setState(() {
                  isEnable=true;
                  leagueSelected = newValue;
                  getLeagueAnnouncements();
                });
              },
              items: userAdminLeagues.map((list) {
                return DropdownMenuItem<String>(
                  value: list,
                  child: Text(list),
                );
              }).toList(),
            ),
          ),
        ),
        RaisedButton(
          child: Text(ADDANNOUNCEMENT,),
          textColor: WHITE,
          color: PRIMARYCOLOR,
          disabledColor: Colors.grey,
          onPressed: (){
            isEnable?addAnnouncementPopUp():showSnackLeague();
          }
          )
      ],
    );
  }
}