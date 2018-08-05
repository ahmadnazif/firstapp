import 'startscreen-list.dart';
import 'package:flutter/material.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes = false;

  runApp(MaterialApp(
      title: "Nazif's App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainListScreen()));
}
