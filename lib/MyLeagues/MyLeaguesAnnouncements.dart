//Show the announcmenets for a league and be able to edit/remove/add
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';

class MyLeaguesAnnouncements extends StatefulWidget {
  final List tempList;

  MyLeaguesAnnouncements(this.tempList);

  @override
  _MyLeaguesAnnouncementsState createState() =>
      _MyLeaguesAnnouncementsState(tempList);
}

class _MyLeaguesAnnouncementsState extends State<MyLeaguesAnnouncements> {
  String leagueSelected;
  List userAdminLeagues;
  bool isEnable = false;
  List leagueAnnouncements;
  var leagueAnn = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textEditing = '';
  bool isMessageEmpty = false;

  _MyLeaguesAnnouncementsState(this.userAdminLeagues);

//get announcements from database
  getLeagueAnnouncements() async {
    var announcementsDB = new ConnectDB();
    leagueAnn = await announcementsDB.getLeagueAnnouncements(leagueSelected);
    setState(() {});
  }

//show snackbar when league has not been selected
  showSnackLeague() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                  isEnable = true;
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
        Container(
            height: MediaQuery.of(context).size.height / 1.6,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: leagueAnn.length,
              itemBuilder: (context, index) {
                final item = leagueAnn[index];
                return Dismissible(
                    background: Container(color: RED),
                    key: Key(item[2]),
                    onDismissed: (direction) async {
                      var result =
                          await new ConnectDB().dismissAnnouncement(item[0]); //remove announcement
                      setState(() {
                        leagueAnn.removeAt(index);
                      });
                      if (result == ANNOUNCEMENTDISMISSED) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(ANNOUNCEMENTDISMISSED)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(ANNOUNCEMENTNOTDISMISSED)));
                      }
                    },
                    child: Card(
                        child: ListTile(
                            title: Center(child: Text(item[2])),
                            subtitle: Center(child: Text(item[3])))));
              },
            )),
        ElevatedButton(
            child: Text(
              ADDANNOUNCEMENT,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return PRIMARYCOLOR; // Use the component's default.
                },
              ),
            ),
            onPressed: () {
              if (isEnable) {
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
                                      errorText:
                                          (isMessageEmpty) ? ENTERTEXT : null,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: RED, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: PRIMARYCOLOR, width: 1.0),
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
                                  await new ConnectDB().insertNewAnnouncement( //insert new announcement
                                      _textEditing, leagueSelected);
                                  Navigator.of(context).pop();
                                  getLeagueAnnouncements();
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
              } else {
                showSnackLeague();
              }
            })
      ],
    );
  }
}
