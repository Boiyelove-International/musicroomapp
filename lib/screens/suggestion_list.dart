
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';


class SuggestionScreen extends StatefulWidget {
  static const String routeName = "/suggestions";

  @override
  _SuggestionScreen createState() => _SuggestionScreen();
}

class _SuggestionScreen extends State<SuggestionScreen> {
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
        title: Text("All Suggestions"),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 30, left: 5, right: 5),
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: DarkPalette.darkGrey1,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        color: Colors.red
                      ),
                      SizedBox(width: 10,),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Implication"),
                                Spacer(),
                                FocusedMenuHolder(
                                  openWithTap: true,
                                    child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: DarkPalette.borderGradient1
                                  ),
                                  child: Center(
                                    child: Icon(Icons.more_vert, size: 30, color: Colors.white),
                                  ),
                                ), onPressed: (){}, menuItems: <FocusedMenuItem>[
                                        FocusedMenuItem(title: Text("Cool! I'm gonna play this", style: TextStyle(
                                          color: Colors.black
                                        ),), onPressed: (){}),
                                  FocusedMenuItem(title: Text("Oops! can't play this song", style: TextStyle(
                                      color: Colors.black
                                  )), onPressed: (){})
                                    ])
                              ],
                            ),
                            SizedBox(height:10),
                            Text("Single - Burna Boy"),
                            SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.3,
                                      height: 30,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              right: 50,
                                              child: CircleAvatar(
                                                backgroundImage:
                                                AssetImage(
                                                    "assets/images/circle_avatar_2.png"),
                                              )),
                                          Positioned(
                                              right: 25,
                                              child: CircleAvatar(
                                                backgroundImage:
                                                AssetImage(
                                                    "assets/images/circle_avatar_3.png"),
                                              )),
                                          Positioned(
                                              right: 0,
                                              child: Container(
                                                height: 30,
                                                decoration:
                                                BoxDecoration(
                                                  shape: BoxShape
                                                      .circle,
                                                  gradient: DarkPalette
                                                      .borderGradient1,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                        "+500")),
                                              ))
                                        ],
                                      ),
                                    )),
                                SizedBox(width:6),
                                Text("3000+ people suggested", style: TextStyle(fontSize: 10),)
                              ],
                            )
                          ],
                        ),
                      )
                    ]
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
