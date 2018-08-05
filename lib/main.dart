// written by ahmadnazif

import 'startscreen-list.dart';
import 'package:flutter/material.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes = true;

  runApp(MaterialApp(
      title: "Nazif's App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainListScreen()));
}
