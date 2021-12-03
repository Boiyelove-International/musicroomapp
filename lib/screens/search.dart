import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/styles.dart';

class SearchResultScreen extends StatefulWidget {
  static const String routeName = "/search";
  @override
  _SearchResultScreen createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          color: DarkPalette.darkGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Search Results"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Transform.rotate(
              angle: 90 * math.pi / 180,
              child: IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.showBottomSheet(
                        (context) => PopupWidget(
                              popup: Popup.searchFilter,
                            ),
                        backgroundColor: Colors.transparent);
                  },
                  icon: Icon(
                    IconlyBold.filter,
                    color: DarkPalette.darkGold,
                  )))
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 30, left: 18, right: 18),
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: DarkPalette.darkGrey1,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading:
                        Image.asset("assets/images/album_art_${index + 1}.png"),
                    title: Text("Focus"),
                    subtitle: Text("Single - Joe Boy"),
                  ));
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 30);
            },
            itemCount: 5),
      ),
    );
  }
}
