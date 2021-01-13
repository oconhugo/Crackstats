import '../Constants.dart';
import 'package:flutter/material.dart';
import 'SideBarWidgetAdmin.dart';
import 'SideBarWidgetUser.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (globalUserType == "1") {
      return SideBarWidgetAdmin();
    } else {
      return SideBarWidgetUser();
    }
  }
}
