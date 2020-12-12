import 'package:flutter/material.dart';
import 'Constants.dart';

class LoadingSpinner extends StatefulWidget {
  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(PRIMARYCOLOR),
      ),
    );
  }
}
