import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = "/notifications";

  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          color: DarkPalette.darkGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Notifications"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView.separated(
            padding: EdgeInsets.only(left: 18, right: 18),
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "Suggested the song for the event",
                    textAlign: TextAlign.center,
                  ));
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.white,
              );
            },
            itemCount: 10),
      ),
    );
  }
}
