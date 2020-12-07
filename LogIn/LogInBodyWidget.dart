import '../Constants.dart';
import './LogInButtonsWidget.dart';
import 'package:flutter/material.dart';

class LogInBodyWidget extends StatefulWidget {
  @override
  _LogInInputWidgetState createState() => _LogInInputWidgetState();
}

class _LogInInputWidgetState extends State<LogInBodyWidget> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black)),
              hintText: EMAIL,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black)),
              hintText: PASSWORD,
            ),
          ),
        ),
        LogInButtonsWidget(emailController, passwordController),
      ],
    ));
  }
}
