import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/models.dart';

class SuggestionScreen extends StatefulWidget {
  static const String routeName = "/suggestions";
  SuggestionType suggestionType = SuggestionType.All;
  String? title = "All Suggestions";

  SuggestionScreen({
    Key? key,
    required this.suggestionType,
    required this.title,
  }) : super(key: key);

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
        title: Text("${widget.title}"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 30, left: 13, right: 13, bottom: 50),
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: DarkPalette.darkGrey1,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/album_art_${index + 1}.png"))),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Implication",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.w900),
                              ),
                              Spacer(),
                              FocusedMenuHolder(
                                  openWithTap: true,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: DarkPalette.borderGradient1),
                                    child: Center(
                                      child: Icon(Icons.more_vert,
                                          size: 20, color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {},
                                  menuItems: widget.suggestionType ==
                                          SuggestionType.All
                                      ? <FocusedMenuItem>[
                                          FocusedMenuItem(
                                              title: Text(
                                                "Cool! I'm gonna play this",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {}),
                                          FocusedMenuItem(
                                              title: Text(
                                                  "Oops! can't play this song",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              onPressed: () {})
                                        ]
                                      : <FocusedMenuItem>[
                                          FocusedMenuItem(
                                              title: Text(
                                                "Remove this suggestion",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {}),
                                        ])
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Text("Single - Burna Boy",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.028)),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  child: Container(
                                width: MediaQuery.of(context).size.width * 0.26,
                                height: 20,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundImage: AssetImage(
                                              "assets/images/circle_avatar_1.png"),
                                        )),
                                    Positioned(
                                        left: 15,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundImage: AssetImage(
                                              "assets/images/circle_avatar_2.png"),
                                        )),
                                    Positioned(
                                        left: 35,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundImage: AssetImage(
                                              "assets/images/circle_avatar_3.png"),
                                        )),
                                    Positioned(
                                        left: 55,
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundImage: AssetImage(
                                              "assets/images/circle_avatar_1.png"),
                                        )),
                                  ],
                                ),
                              )),
                              Text(
                                "3000+ people suggested",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]));
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemCount: 5),
      ),
    );
  }
}
