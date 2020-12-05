import 'package:flutter/material.dart';

class ConnectDB extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  ConnectDB(this.email, this.password);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(email.text),
    );
  }
}
