import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/apiServices.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = "/notifications";

  @override
  _NotificationScreen createState() => _NotificationScreen();
}

class _NotificationScreen extends State<NotificationScreen> {
  ApiBaseHelper _api = ApiBaseHelper();

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
        child: FutureBuilder<dynamic>(
          future: _api.get("/notifications/"),
          builder: (context, snapshot){
            if(snapshot.data == null) return Container();
            List notifications = snapshot.data ?? [];
            return Flexible(
                child: ListView.separated(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    itemBuilder: (context, index) {
                      Map notification = notifications[index];
                      return Container(
                          padding: EdgeInsets.all(40),
                          child: Text(
                            "${notification['content']}",
                            textAlign: TextAlign.center,
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        color: Colors.white,
                      );
                    },
                    itemCount: notifications.length
                )
            );
          },
        ),
      ),
    );
  }
}
