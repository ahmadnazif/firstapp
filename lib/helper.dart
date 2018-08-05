// written by ahmadnazif

import 'dart:math';

import 'package:flutter/material.dart';

class Helper {
  static Color generateRandomColor() {
    Random random = new Random();
    var r1 = random.nextInt(255);
    var r2 = random.nextInt(255);
    var r3 = random.nextInt(255);

    return Color.fromARGB(255, r1, r2, r3);
  }

  static void showScaffoldInfoDialog(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    var title = "Scaffold key data";
    var content = "KEY: $scaffoldKey\n" +
        "WIDGET: ${scaffoldKey.currentWidget}\n" +
        "STATE: ${scaffoldKey.currentState}\n" +
        "HASHCODE: ${scaffoldKey.hashCode}";
    DialogHelper.showInfoDialog(context, title, content);
  }
}

class DialogHelper {
  static showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}

class SnackbarHelper {
  static Widget showInfoSnackbar(BuildContext context, String infoTxt,
      [int dismissInSecond = 1]) {
    final snackbar = SnackBar(
      content: Text(infoTxt),
      duration: Duration(seconds: dismissInSecond),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackbar);
    return snackbar;
  }

  static Widget showInfoSnackbarKey(
      GlobalKey<ScaffoldState> scaffoldKey, String infoTxt,
      [int dismissInSecond = 1]) {
    final snackbar = SnackBar(
      content: Text(infoTxt),
      duration: Duration(seconds: dismissInSecond),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {
          scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    return snackbar;
  }
}

class ButtonColumnHelper {
  static Column buttonIconAndText(Color color, IconData icon, String label) {
    var style = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: color,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: style,
          ),
        )
      ],
    );
  }
}
