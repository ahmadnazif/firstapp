import 'package:firstapp/startscreen-card.dart';

import 'dummy-data/destination-in-malaysia.dart';
import 'package:firstapp/place-screen.dart';
import 'helper.dart';
import 'package:flutter/material.dart';

enum _MaterialListType {
  /// A list tile that contains a single line of text.
  oneLine,

  /// A list tile that contains a [CircleAvatar] followed by a single line of text.
  oneLineWithAvatar,

  /// A list tile that contains two lines of text.
  twoLine,

  /// A list tile that contains three lines of text.
  threeLine,
}

class MainListScreen extends StatefulWidget {
  const MainListScreen({Key key}) : super(key: key);

  static const String routeName = '/material/list';

  @override
  _MainListState createState() => new _MainListState();
}

class _MainListState extends State<MainListScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PersistentBottomSheetController<Null> _bottomSheet;
  _MaterialListType _itemType = _MaterialListType.twoLine;
  bool _dense = false;
  bool _showAvatars = true;
  bool _showIcons = false;
  bool _showDividers = true;
  bool reverseSort = false;
  List<String> items = <String>[
    'Perak',
    'Johor',
    'Selangor',
    'Pulau Pinang',
    'Kedah',
    'Kelantan',
    "Sabah",
    "Pahang",
    "Kuala Lumpur"
  ];

  void changeItemType(_MaterialListType type) {
    setState(() {
      _itemType = type;
    });
    _bottomSheet?.setState(() {});
  }

  void _showConfigurationSheet() {
    final PersistentBottomSheetController<Null> bottomSheet = scaffoldKey
        .currentState.showBottomSheet((BuildContext bottomSheetContext) {
      return new Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black26)),
        ),
        child: new ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            new MergeSemantics(
              child: new ListTile(
                  dense: true,
                  title: const Text('One-line'),
                  trailing: new Radio<_MaterialListType>(
                    value: _showAvatars
                        ? _MaterialListType.oneLineWithAvatar
                        : _MaterialListType.oneLine,
                    groupValue: _itemType,
                    onChanged: changeItemType,
                  )),
            ),
            new MergeSemantics(
              child: new ListTile(
                  dense: true,
                  title: const Text('Two-line'),
                  trailing: new Radio<_MaterialListType>(
                    value: _MaterialListType.twoLine,
                    groupValue: _itemType,
                    onChanged: changeItemType,
                  )),
            ),
            new MergeSemantics(
              child: new ListTile(
                dense: true,
                title: const Text('Three-line'),
                trailing: new Radio<_MaterialListType>(
                  value: _MaterialListType.threeLine,
                  groupValue: _itemType,
                  onChanged: changeItemType,
                ),
              ),
            ),
            new MergeSemantics(
              child: new ListTile(
                dense: true,
                title: const Text('Show avatar'),
                trailing: new Checkbox(
                  value: _showAvatars,
                  onChanged: (bool value) {
                    setState(() {
                      _showAvatars = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
            new MergeSemantics(
              child: new ListTile(
                dense: true,
                title: const Text('Show icon'),
                trailing: new Checkbox(
                  value: _showIcons,
                  onChanged: (bool value) {
                    setState(() {
                      _showIcons = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
            new MergeSemantics(
              child: new ListTile(
                dense: true,
                title: const Text('Show dividers'),
                trailing: new Checkbox(
                  value: _showDividers,
                  onChanged: (bool value) {
                    setState(() {
                      _showDividers = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
            new MergeSemantics(
              child: new ListTile(
                dense: true,
                title: const Text('Dense layout'),
                trailing: new Checkbox(
                  value: _dense,
                  onChanged: (bool value) {
                    setState(() {
                      _dense = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });

    setState(() {
      _bottomSheet = bottomSheet;
    });

    _bottomSheet.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheet = null;
        });
      }
    });
  }

  Widget buildListTile(BuildContext context, String item) {
    var totalLocationCount = PlacesData.countPlaces(item);

    var avatarColor = Helper.generateRandomColor();
    return MergeSemantics(
      child: ListTile(
        isThreeLine: _itemType == _MaterialListType.threeLine,
        dense: _dense,
        leading: _showAvatars
            ? ExcludeSemantics(
                child: CircleAvatar(
                child: Text(item.substring(0, 1),
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold)),
                backgroundColor: avatarColor,
                foregroundColor: Colors.white,
              ))
            : null,
        title: Text("$item, Malaysia"),
        subtitle: Text("$totalLocationCount total places"),
        trailing: _showIcons
            ? new Icon(Icons.info, color: Theme.of(context).disabledColor)
            : null,
        onTap: () {
          if (totalLocationCount == 0) {
            SnackbarHelper.showInfoSnackbarKey(
                scaffoldKey, "No places existed in \"$item\" state yet", 3);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaceScreen(
                        data: PlaceScreenData(
                            appbarColor: avatarColor, stateName: "$item"))));
          }
        },
        onLongPress: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getList(BuildContext context) {
      Iterable<Widget> list = items.map((item) => buildListTile(context, item));

      if (_showDividers) {
        list = ListTile.divideTiles(context: context, tiles: list);
      }

      return list.toList();
    }

    Widget fab(BuildContext context) {
      return FloatingActionButton(
          tooltip: "Reload",
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {});
          });
    }

    List<PopupMenuEntry<String>> appbarMenu(BuildContext context) {
      return <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "Card",
          child: Text("Change Appearance to Card"),
        ),
        PopupMenuDivider(),
        PopupMenuItem<String>(
          value: "Key",
          child: Text("Scaffold key data"),
        ),
        PopupMenuItem<String>(
          value: "Setting",
          child: Text("Show Setting"),
        ),
        PopupMenuItem<String>(
          value: "About",
          child: Text("About"),
        ),
      ];
    }

    void selectMenu(String menu) {
      if (menu == "Key") {
        Helper.showScaffoldInfoDialog(context, this.scaffoldKey);
      } else if (menu == "Setting") {
        if (_bottomSheet == null) {
          this._showConfigurationSheet();
        }
      } else if (menu == "Card") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CardListScreen()));
      } else {
        SnackbarHelper.showInfoSnackbarKey(
            this.scaffoldKey, "Menu selected: $menu");
      }
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Wonderful Malaysia"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: "Sort",
            onPressed: () {
              setState(() {
                reverseSort = !reverseSort;
                items.sort((String a, String b) =>
                    reverseSort ? b.compareTo(a) : a.compareTo(b));
              });
            },
          ),
          PopupMenuButton(
            onSelected: selectMenu,
            itemBuilder: (context) => appbarMenu(context),
          )
        ],
      ),
      body: Scrollbar(
          child: new ListView(
              padding: new EdgeInsets.symmetric(vertical: _dense ? 4.0 : 8.0),
              children: getList(context))),
      floatingActionButton: Builder(builder: fab),
    );
  }
}
