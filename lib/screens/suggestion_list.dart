import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/apiServices.dart';
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

class SongSuggestion extends StatelessWidget{
  SongSuggestion({
    this.color=DarkPalette.darkGrey1,
    this.suggestionType = SuggestionType.All,
    this.showTrailing = true,
    this.userType = UserType.partyGuest,
    required this.event,
    required this.suggestion
  });

  Color color;
  SuggestionType suggestionType;
  bool showTrailing;
  UserType userType;
  Event event;
  Map suggestion;
  late List<FocusedMenuItem> menuItems;
  IconData menuIcon = Icons.more_vert;


  @override
  Widget build(context){
    switch (suggestionType){
      case SuggestionType.Accepted: {
        if (userType == UserType.partyGuest){
          menuIcon = IconlyBold.plus;
          menuItems = <FocusedMenuItem>[
            FocusedMenuItem(
                title: Text(
                  "Remove this song",
                  style: TextStyle(
                      color: Colors.white),
                ),
                onPressed: () {}),
          ];
        }
      }
      break;
      case SuggestionType.All:{
        if (userType == UserType.partyOrganizer){
          menuItems = <FocusedMenuItem>[
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
          ];
        }
        if (userType == UserType.partyGuest){
          menuIcon = IconlyBold.plus;
          menuItems = <FocusedMenuItem>[
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
          ];
        }
      }
      break;
      case SuggestionType.New:{
      }
      break;
      default:{}
    }

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
                    image: NetworkImage("${suggestion['song']['album_art']}"))),
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
                      "${suggestion['song']['song_title']}",
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width *
                              0.05,
                          fontWeight: FontWeight.w900),
                    ),
                    Spacer(),
                    this.showTrailing ? FocusedMenuHolder(
                        openWithTap: true,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: DarkPalette.borderGradient1),
                          child: Center(
                            child: Icon(menuIcon,
                                size: 15, color: Colors.white),
                          ),
                        ),
                        onPressed: () {},
                        menuItems: menuItems
                    ) : Container()
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02),
                Text("${suggestion['song']['artist_name']}",
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
                            children: MRbuildAttendeeIcons(
                                event, radius: 12
                            )
                          ),
                        )),
                    Text(
                      "${_buildSuggestedNumber()} people suggested",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          )
        ]));
  }

  String _buildSuggestedNumber(){
    String amount = event.suggestersCount.toString();
    if(event.suggestersCount > 3000){
      amount = "${event.suggestersCount}+";
    }
    return amount;
  }
}


class SongSuggestionList extends StatelessWidget{
  SongSuggestionList({
    this.isScrollable = false,
    this.title,
    this.color=DarkPalette.darkGrey1,
    this.trailing = false,
    required this.suggestions,
    required this.event
  });
  bool isScrollable;
  String? title;
  Color color;
  bool trailing;
  Event event;
  List suggestions;

  @override
  Widget build(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: trailing,
            child: Row(
              children: [
                Text("$title", style: GoogleFonts.workSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                )),
                Spacer(),
                InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchResultScreen(
                          title: "$title",
                        )),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text("See All", style: TextStyle(
                              color: Colors.amber
                          )),
                          Icon(Icons.arrow_right,
                              color: Colors.amber)
                        ],
                      ),
                    )
                )
              ],
            ),
            replacement: Text("$title", style: GoogleFonts.workSans(
                fontSize: 18,
                fontWeight: FontWeight.bold
            )),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Column(
          children: [
            Visibility(
                visible: suggestions.isEmpty,
                child: Center(
                  child: Text("List's empty", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12),),
                )
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: !isScrollable ? NeverScrollableScrollPhysics() : null,
                itemBuilder: (context, index){
                Map suggestion = suggestions[index];
                  return SongSuggestion(
                    color: color,
                    event: event,
                    suggestion: suggestion,
                  );
                },
                separatorBuilder: (context, index){
                  return SizedBox(height:20);
                },
                itemCount: suggestions.length
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
      ],
    );
  }
}
