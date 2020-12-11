import 'Constants.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
            color: PRIMARYCOLOR,
            )),
            ListTile(
        title: Text('Item 1'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
          ],
        ),
      ),
    );
  }
}
