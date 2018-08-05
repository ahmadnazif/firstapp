// written by ahmadnazif
// place-screen.dart

import 'dummy-data/destination-in-malaysia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'helper.dart';

class PlaceScreenData {
  Color appbarColor;
  final String stateName;
  PlaceScreenData({this.appbarColor, this.stateName});
}

class PlaceScreen extends StatelessWidget {
  final PlaceScreenData data;
  PlaceScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Content(key: this.key, data: this.data);
  }
}

// =====================================
// Main Stateful widgets
// =====================================

class _Content extends StatefulWidget {
  final PlaceScreenData data;
  _Content({Key key, this.data}) : super(key: key);
  @override
  _ContentState createState() => _ContentState(key: this.key, data: this.data);
}

class _ContentState extends State<_Content> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final PlaceScreenData data;
  _ContentState({Key key, this.data});
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    var stateName = this.data.stateName;
    var appbarColor = this.data.appbarColor;

    this.currentIndex++;
    var maxIndex = PlacesData.countPlaces(stateName) - 1;
    this.currentIndex = this.currentIndex > maxIndex ? 0 : this.currentIndex;

    var data = PlacesData.getData(stateName, currentIndex);
    var imagePath = data.imagePath;
    var placeName = data.placeName;
    var placeDesc = data.placeDesc;

    Widget bannerSection(BuildContext context) {
      return Image.asset(
        imagePath,
        width: 600.0,
        height: 240.0,
        fit: BoxFit.cover,
      );
    }

    Widget titleSection(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      placeName,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    stateName + ", Malaysia",
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            FavWidget()
          ],
        ),
      );
    }

    Widget descriptionSection(BuildContext context) {
      return Container(
          padding: const EdgeInsets.all(32.0),
          child: Text(placeDesc, softWrap: true));
    }

    void showAlertForNavigation(
        BuildContext context, String title, String content) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("YES"),
                  onPressed: () {},
                ),
              ],
            );
          });
    }

    Widget buttonSection(BuildContext context) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: ButtonColumnHelper.buttonIconAndText(
                  appbarColor, Icons.search, "GOOGLE THIS"),
              onPressed: () =>
                  SnackbarHelper.showInfoSnackbar(context, "GOOGLE"),
            ),
            FlatButton(
              child: ButtonColumnHelper.buttonIconAndText(
                  appbarColor, Icons.map, "SHOW ON MAP"),
              onPressed: () => showAlertForNavigation(context, "Navigation",
                  "Are you sure to navigate to this location? You will be able to choose your prefered navigation apps"),
            ),
            FlatButton(
              child: ButtonColumnHelper.buttonIconAndText(
                  appbarColor, Icons.share, "SHARE OUT"),
              onPressed: () =>
                  SnackbarHelper.showInfoSnackbar(context, "SHARE"),
            )
          ],
        ),
      );
    }

    Widget body(BuildContext context) {
      return ListView(children: [
        bannerSection(context),
        titleSection(context),
        buttonSection(context),
        descriptionSection(context),
      ]);
    }

    Widget fab(BuildContext context) {
      var isExtended = true;
      if (isExtended) {
        return FloatingActionButton.extended(
            backgroundColor: appbarColor,
            isExtended: true,
            label: Text("NEXT PLACE"),
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {});
            });
      } else {
        return FloatingActionButton(
            backgroundColor: appbarColor,
            tooltip: "Next",
            child: Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {});
            });
      }
    }

    List<PopupMenuItem<String>> appbarMenu(BuildContext context) {
      return <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          value: "SKD",
          child: Text("Scaffold key data"),
        ),
        PopupMenuItem<String>(
          value: "Help",
          child: Text("Help"),
        ),
        PopupMenuItem<String>(
          value: "About",
          child: Text("About"),
        ),
      ];
    }

    void selectMenu(String menu) {
      if (menu == "SKD")
        Helper.showScaffoldInfoDialog(context, this.scaffoldKey);
      else
        SnackbarHelper.showInfoSnackbarKey(
            this.scaffoldKey, "Menu selected: $menu");
    }

    // MAIN
    return Scaffold(
      key: this.scaffoldKey,
      appBar: AppBar(
        title: Text("Wonderful $stateName"),
        backgroundColor: appbarColor,
        actions: <Widget>[
          IconButton(
              tooltip: "Reload accent color",
              icon: Icon(Icons.color_lens),
              onPressed: () {
                setState(() {
                  this.data.appbarColor = Helper.generateRandomColor();
                  this.currentIndex--;
                });
              }),
          PopupMenuButton(
            onSelected: selectMenu,
            itemBuilder: (context) => appbarMenu(context),
          )
        ],
      ),
      body: Builder(builder: body),
      floatingActionButton: Builder(builder: fab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //bottomNavigationBar: BottomNavBarWidget()
    );
  }
}

// ==================================
// ==================================

class FavWidget extends StatefulWidget {
  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget> {
  var isFav = false;
  var favCount = 20;

  void toggleFav() {
    setState(() {
      if (isFav) {
        isFav = false;
        favCount--;

        SnackbarHelper.showInfoSnackbar(
            context, "Unfavourited at ${DateTime.now()}", 3);
      } else {
        isFav = true;
        favCount++;
        SnackbarHelper.showInfoSnackbar(
            context, "Favourited at ${DateTime.now()}", 3);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        padding: EdgeInsets.all(0.0),
        child: IconButton(
            icon: isFav ? Icon(Icons.star) : Icon(Icons.star_border),
            color: Colors.red,
            onPressed: toggleFav),
      ),
      SizedBox(
        width: 18.0,
        child: Text(favCount.toString()),
      )
    ]);
  }
}

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  var navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: navIndex,
        onTap: (i) {
          setState(() => navIndex = i);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.info), title: Text("Info"))
        ]);
  }
}
