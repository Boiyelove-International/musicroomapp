import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/styles.dart';

import '../routes.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homeScreen";

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showFab = true;
  @override
  Widget build(BuildContext context) {
    // FocusScopeNode currentFocus = FocusScope.of(context);

    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Hello,"), SizedBox(width: 5), Text("PartyMixers")],
          ),
          actions: [
            Row(
              children: <Widget>[
                InkWell(
                    onTap: () {},
                    child: Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                            "assets/images/organizer-profile-icon.png"))),
                IconButton(
                    icon: Icon(IconlyBold.notification),
                    color: DarkPalette.darkGold,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.notifications);
                    })
              ],
            )
          ],
        ),
        body: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/home-gradient-bg.png"),
                              fit: BoxFit.cover,
                            )),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              Text(
                                "Find your hits and favourties and add them to events, let's go.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    height: 2),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Find those hits",
                                  hintStyle: TextStyle(fontSize: 13),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      IconlyBold.search,
                                      color: DarkPalette.darkGold,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.search);
                                    },
                                  ),
                                ),
                              ),
                            ]))),
                  ),
                  SliverAppBar(
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      flexibleSpace: Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 10),
                          child: Row(
                            children: [
                              Text("Your Events"),
                              Spacer(),
                              Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: IconButton(
                                      onPressed: () {
                                        scaffoldKey.currentState!
                                            .showBottomSheet(
                                                (context) => PopupWidget(
                                                      popup: Popup.searchFilter,
                                                    ),
                                                backgroundColor:
                                                    Colors.transparent);
                                      },
                                      icon: Icon(
                                        IconlyBold.filter,
                                        color: DarkPalette.darkGold,
                                      )))
                            ],
                          ))),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return // Container(
                            //   child:
                            //       Column(mainAxisSize: MainAxisSize.min, children: [
                            //     Image.asset("assets/images/empty_event_icon.png"),
                            //     Text(
                            //         "Ooops, there doesn't seem to be an event at the moment, create one to see it appear here")
                            //   ]),
                            // ),
                            Container(
                          height: 300,
                          width: 300,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("Starts in"),
                                                Text("24h: 30m")
                                              ])))),
                              Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              bottom: 20,
                                              left: 20,
                                              right: 20),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      Text("Owambe Party",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900)),
                                                      SizedBox(height: 10),
                                                      Text(
                                                          "Hosted by - Owambe Hitz",
                                                          style: TextStyle(
                                                              fontSize: 10))
                                                    ])),
                                                Flexible(
                                                    child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: 35,
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
                                                            height: 35,
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
                                                ))
                                              ]))))
                            ],
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/party_people_${index + 1}.png"))),
                        );
                      },
                      childCount: 4, // 1000 list items
                    ),
                  ),
                ]))),
        floatingActionButton: Visibility(
            visible: showFab,
            child: FloatingActionButton.extended(
                backgroundColor: DarkPalette.darkGold,
                onPressed: () {
                  setState(() {
                    showFab = false;
                  });
                  showModalBottomSheet<void>(
                          builder: (BuildContext context) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                  )),
                              padding: EdgeInsets.only(
                                  top: 30, left: 20, right: 20, bottom: 20),
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: CreateEventForm()),
                          backgroundColor: Colors.transparent,
                          context: context)
                      .whenComplete(() => setState(() {
                            showFab = true;
                          }));
                },
                label: Text("Create an Event",
                    style: TextStyle(color: Colors.black)))));
  }
}
