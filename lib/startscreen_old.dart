import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Demo App",
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new MyHomePage(title: "My Apps"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int counter = 0;
  double x;
  List<String> list = new List();
  List<String> list2 = new List(2);
  var type = "Init";

  void increase() {
    setState(() {
      this.type = "Increase";
      this.counter++;
    });
  }

  void decrease() {
    setState(() {
      this.type = "Decrease";
      this.counter--;
    });
  }

  Widget nextIntent() {
    final snackbar = SnackBar(
      content: Text("Will be implemented"),
      action: SnackBarAction(
        label: "OK",
        onPressed: this.increase,
      ),
    );

    return snackbar;
  }

  Widget showAlert() {
    final alert = AlertDialog(
      title: Text("Sorry"),
      content: Text("Unavailable yet"),
    );
    return alert;
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    var x = "App built by Nazif";

    return MaterialApp(
        title: widget.title,
        home: Scaffold(
          key: key,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug paint" (press "p" in the console where you ran
              // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
              // window in IntelliJ) to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("$x\n\n"),
                Text("TYPE: ${this.type}\n"),
                Text("Current number value: "),
                Text(
                  "${this.counter}",
                  style: Theme.of(context).textTheme.display1,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Increase Value"),
                      onPressed: this.increase, // method
                    ),
                    RaisedButton(
                      child: Text("Decrease Value"),
                      onPressed: this.decrease,
                    ),
                    RaisedButton(
                      child: Text("Next"),
                      onPressed: () {
                        final snackbar = SnackBar(
                          content: Text(
                              "This action Will be implemented on the next release. Please be patient!"),
                          duration: Duration(seconds: 10),
                          action: SnackBarAction(
                            label: "OK",
                            onPressed: () {
                              key.currentState.hideCurrentSnackBar();
                            },
                          ),
                        );

                        key.currentState.showSnackBar(snackbar);
                        //Scaffold.of(context).showSnackBar(snackbar);
                      },
                    )
                  ],
                ),
                ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("New"),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        child: Text("NEXT PAGE"),
                        onPressed: () {},
                      )
                    ])
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
            },
            tooltip: "Alert",
            child: new Icon(Icons.navigate_next),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}