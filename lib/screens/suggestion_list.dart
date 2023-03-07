import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/models.dart';

class SuggestionScreen extends StatefulWidget {
  static const String routeName = "/suggestions";
  SuggestionType suggestionType = SuggestionType.All;
  String? title = "All Suggestions";
  Event event;
  List suggestions;
  UserType userType;
  Function? callBack;

  SuggestionScreen(
      {Key? key,
      required this.title,
      required this.event,
      required this.suggestions,
      this.callBack,
      this.userType = UserType.partyOrganizer})
      : super(key: key);

  @override
  _SuggestionScreen createState() => _SuggestionScreen();
}

class _SuggestionScreen extends State<SuggestionScreen> {
  Future<void> _refreshData() async {
    widget.event = await widget.event.refreshData();
    log("getting data from web");
    setState(() {
      widget.suggestions = widget.suggestions;
    });
  }

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
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Map suggestion = widget.suggestions[index];

                return SongSuggestion(
                  event: widget.event,
                  suggestion: suggestion,
                  userType: widget.userType,
                  suggestionType: SuggestionType.All,
                  callBack: widget.callBack ?? null,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: widget.suggestions.length),
        ),
      ),
    );
  }
}

class SongSuggestion extends StatelessWidget {
  SongSuggestion(
      {this.color = DarkPalette.darkGrey1,
      this.suggestionType = SuggestionType.All,
      this.showTrailing = true,
      this.userType = UserType.partyGuest,
      required this.event,
      required this.suggestion,
      this.callBack});

  Color color;
  SuggestionType suggestionType;
  bool showTrailing;
  UserType userType;
  Event event;
  Map suggestion;
  Function? callBack;
  late List<FocusedMenuItem> menuItems;
  IconData menuIcon = Icons.more_vert;

  @override
  Widget build(context) {
    switch (suggestionType) {
      case SuggestionType.Accepted:
        {
          if (userType == UserType.partyGuest) {
            menuIcon = IconlyBold.plus;
            menuItems = <FocusedMenuItem>[
              FocusedMenuItem(
                  title: Text(
                    "Remove this song",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!();
                    }
                  }),
            ];
          }
        }
        break;
      case SuggestionType.All:
        {
          if (userType == UserType.partyOrganizer) {
            menuItems = <FocusedMenuItem>[
              FocusedMenuItem(
                  title: Text(
                    "Cool! I'm gonna play this",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!(suggestion['id'], true);
                    }
                  }),
              FocusedMenuItem(
                  title: Text("Oops! can't play this song",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!(suggestion['id'], false);
                    }
                  })
            ];
            if (suggestion['accepted'] == true) {
              menuItems.removeAt(0);
            }
          }
          if (userType == UserType.partyGuest) {
            menuIcon = IconlyBold.plus;
            menuItems = <FocusedMenuItem>[
              FocusedMenuItem(
                  title: Text(
                    "Remove this song",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!();
                    }
                  }),
            ];
          }
        }
        break;
      case SuggestionType.New:
        {
          if (userType == UserType.partyOrganizer) {
            menuItems = <FocusedMenuItem>[
              FocusedMenuItem(
                  title: Text(
                    "Playing Song now",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!(suggestion['id'], 'now');
                    }
                  }),
              FocusedMenuItem(
                  title: Text("Playing Song Next",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!(suggestion['id'], 'next');
                    }
                  }),
              FocusedMenuItem(
                  title: Text("I'll add this Song to the Queue",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!(suggestion['id'], 'queued');
                    }
                  }),
              FocusedMenuItem(
                  title: Text("Remove this suggestion",
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!(suggestion['id'], 'remove');
                    }
                  })
            ];
          }
          if (userType == UserType.partyGuest) {
            menuIcon = IconlyBold.plus;
            menuItems = <FocusedMenuItem>[
              FocusedMenuItem(
                  title: Text(
                    "Remove this song",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    if (callBack != null) {
                      callBack!();
                    }
                  }),
            ];
          }
        }
        break;
      default:
        {}
    }

    return GestureDetector(
      child: Container(
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
                      image:
                          NetworkImage("${suggestion['song']['album_art']}"))),
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
                      Text("${suggestion['song']['song_title']}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.w900,
                          )),
                      Spacer(),
                      this.showTrailing
                          ? FocusedMenuHolder(
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
                              menuItems: menuItems)
                          : Container()
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text("${suggestion['song']['artist_name']}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.028)),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 0.26,
                        height: 20,
                        child: Stack(
                            clipBehavior: Clip.none,
                            children: MRbuildAttendeeIcons(event, radius: 12)),
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
          ])),
      onTap: () {
        _buildAudioPlayer(context);
      },
    );
  }

  _buildAudioPlayer(BuildContext context) {
    print(suggestion);
    showModalBottomSheet<void>(
        builder: (BuildContext context) => Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )),
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            height: MediaQuery.of(context).size.height * 0.7,
            child: AudioPlayerScreen(
                song: SongModel(
              title: suggestion['song']['song_title'],
              artist: suggestion['song']['artist_name'],
              album_art: suggestion['song']['album_art'],
              previewUrl: suggestion['song']['song_url'],
              apple_song_id: suggestion['song']['apple_song_id'],
              apple_music_link: suggestion['song']['apple_music_link'],
            ))),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context);
  }

  String _buildSuggestedNumber() {
    String amount = event.suggestersCount.toString();
    if (event.suggestersCount > 3000) {
      amount = "${event.suggestersCount}+";
    }
    return amount;
  }
}

class SongSuggestionList extends StatelessWidget {
  SongSuggestionList(
      {this.isScrollable = false,
      this.title,
      this.color = DarkPalette.darkGrey1,
      this.trailing = false,
      required this.suggestions,
      required this.event,
      this.callBack,
      this.userType = UserType.partyOrganizer});
  bool isScrollable;
  String? title;
  Color color;
  bool trailing;
  Event event;
  List suggestions;
  UserType userType;
  Function? callBack;

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: trailing,
          child: Row(
            children: [
              Text("$title",
                  style: GoogleFonts.workSans(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuggestionScreen(
                                suggestions: event.suggestions ?? [],
                                title: "$title",
                                event: event,
                                userType: UserType.partyGuest,
                              )),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text("See All", style: TextStyle(color: Colors.amber)),
                        Icon(Icons.arrow_right, color: Colors.amber)
                      ],
                    ),
                  ))
            ],
          ),
          replacement: Text("$title",
              style: GoogleFonts.workSans(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Column(
          children: [
            Visibility(
                visible: suggestions.isEmpty,
                child: Center(
                  child: Text(
                    "List's empty",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                )),
            ListView.separated(
                shrinkWrap: true,
                physics: !isScrollable ? NeverScrollableScrollPhysics() : null,
                itemBuilder: (context, index) {
                  print("suggestion index is $index of ${suggestions.length}");
                  Map suggestion = suggestions[index];
                  switch (suggestion['accepted']) {
                    case true:
                      {
                        SuggestionType suggestionType = SuggestionType.Accepted;
                        break;
                      }
                    case false:
                      {
                        SuggestionType suggestionType = SuggestionType.Accepted;
                        break;
                      }
                    case null:
                      {
                        SuggestionType suggestionType = SuggestionType.New;
                        break;
                      }
                  }
                  return SongSuggestion(
                    color: color,
                    event: event,
                    suggestion: suggestion,
                    userType: this.userType,
                    suggestionType: SuggestionType.New,
                    callBack: callBack,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemCount: suggestions.length),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
      ],
    );
  }
}
