import 'package:flutter/material.dart';

import '../Constants.dart';

class ProfileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      iconSize: kToolbarHeight - 15,
      tooltip: MENUTITLE,
      onPressed: () {
        print(MENUTITLE);
      },
    );
  }
}
