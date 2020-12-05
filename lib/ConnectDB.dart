import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './Constants.dart';

class ConnectDB {
  Future<List> sendData(name, email) async {
    final response = await http.post(INSERTDATAURL, body: {
      "name": name,
      "email": email,
    });
  }
}
