// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firstapp/dummy-data/destination-in-malaysia.dart';
import 'package:firstapp/helper.dart';
import 'package:firstapp/place-screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MalaysiaStatesItem extends StatelessWidget {
  MalaysiaStatesItem({Key key, @required this.malaysiaState, this.shape})
      : assert(malaysiaState != null),
        super(key: key);

  static const double height = 240.0;
  final MalaysiaState malaysiaState;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return new SafeArea(
      top: false,
      bottom: false,
      child: new Container(
        padding: const EdgeInsets.all(2.0),
        height: height,
        child: new Card(
          shape: shape,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // photo and title
              new SizedBox(
                height: 100.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                      child: new Image.asset(
                        malaysiaState.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    new Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                      child: new FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomLeft,
                        child: new Text(
                          malaysiaState.stateName,
                          style: titleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // description and share/explore buttons
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: new DefaultTextStyle(
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // three line description
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            "${malaysiaState.stateName} ${malaysiaState.stateDesc}",
                            style: descriptionStyle.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 13.0,
                                color: Colors.black54),
                          ),
                        ),
                        new Text(
                            "${malaysiaState.totalPlaceInState} total place available"),
                      ],
                    ),
                  ),
                ),
              ),
              // share, explore buttons
              new ButtonTheme.bar(
                child: new ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('EXPLORE'),
                      textColor: Colors.amber.shade500,
                      onPressed: () {
                        var totalLocationCount =
                            PlacesData.countPlaces(malaysiaState.stateName);
                        if (totalLocationCount == 0) {
                          SnackbarHelper.showInfoSnackbar(
                              context,
                              "No places existed in \"${malaysiaState.stateName}\" state yet",
                              3);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceScreen(
                                      data: PlaceScreenData(
                                          appbarColor: Colors.teal,
                                          stateName:
                                              malaysiaState.stateName))));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardListScreen extends StatefulWidget {
  static const String routeName = '/material/cards';

  @override
  _CardListState createState() => new _CardListState();
}

class _CardListState extends State<CardListScreen> {
  ShapeBorder _shape;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text("Wonderful Malaysia"),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.sentiment_very_satisfied),
              onPressed: () {
                setState(() {
                  _shape = _shape != null
                      ? null
                      : const RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: const Radius.circular(16.0),
                            topRight: const Radius.circular(16.0),
                            bottomLeft: const Radius.circular(2.0),
                            bottomRight: const Radius.circular(2.0),
                          ),
                        );
                });
              },
            ),
          ],
        ),
        body: new ListView(
            itemExtent: MalaysiaStatesItem.height,
            padding: const EdgeInsets.only(
                top: 2.0, bottom: 2.0, left: 1.0, right: 1.0),
            children: MalaysiaStatesData
                .getAllState(StateSortType.stateName_asc)
                .map((MalaysiaState malaysiaState) {
              return new Container(
                margin: const EdgeInsets.only(bottom: 9.0),
                child: new MalaysiaStatesItem(
                  malaysiaState: malaysiaState,
                  //shape: _shape,
                ),
              );
            }).toList()));
  }
}
