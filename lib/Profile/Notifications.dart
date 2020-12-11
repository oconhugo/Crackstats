import 'package:flutter/material.dart';

import '../Constants.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: const Icon(Icons.add_alert),
        iconSize: kToolbarHeight - 15,
        tooltip: NOTIFICATIONS,
        onPressed: () {
          print(NOTIFICATIONS);
        },
      ),
    );
  }
}
