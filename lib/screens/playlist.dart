import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/utils/models.dart';
import '../styles.dart';

class PartyPlayList extends StatefulWidget {
  static const String routeName = "/partyPlayList";
  final Event event;

  PartyPlayList({required this.event});

  @override
  _PartyPlayList createState() => _PartyPlayList();
}

class _PartyPlayList extends State<PartyPlayList> {
  SuggestionType playlistType = SuggestionType.Playlist;
  Event get event => widget.event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: getPlaylist(),
          ),
        ),
      );
  }

  List _getList(String type){
    List result = [];
    if(type == 'playing'){
      result = event.suggestions!.where((element) => element['is_playing'] == true).toList();
    }else if(type == 'queued'){
      result = event.suggestions!.where((element) => element['is_playing'] == null).toList();
    }
    else if(type == 'accepted'){
      result = event.suggestions!.where((element) => element['accepted'] != null).toList();
    }else{
      result = event.suggestions!.where((element) => element['is_playing'] == null).toList();
      result = result.isNotEmpty ? [result[0]] : result;
    }
    return result;
  }

  Widget generatePlaylistWidget(Color playlistColor){
    return ListView.separated(
        padding: EdgeInsets.only(top: 30, left: 13, right: 13, bottom: 50),
        itemBuilder: (context, index) {
          switch (index){
            case 0:
              return Container(
                padding: EdgeInsets.only(top: 50, left: 5, right: 5),
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("${event.image}"))),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(IconlyBold.arrow_left, color: Colors.white,),
                              iconSize: 30,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ))),
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context, builder:(context) => PopupWidget(
                                    popup: Popup.playlistFilter,
                                  ));

                                },
                                icon: Icon(
                                    IconlyBold.filter,
                                    color: Colors.white,
                                    size: 25
                                )))),

                  ],
                ),
              );
            case 1:
              return Text("Accepted Suggestions");
          }
          return GestureDetector(
              onTap:(){
                showModalBottomSheet(context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context){
                      return PopupWidget(
                        popup: Popup.nowPlayingFilter,
                      );
                    });

              },child:Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: playlistColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/album_art_${index - 1}.png"))),
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
                                color: Colors.black,
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
                                    color: Colors.black),
                                child: Center(
                                  child: Icon(Icons.more_vert,
                                      size: 20, color: playlistColor),
                                ),
                              ),
                              onPressed: () {},
                              menuItems: <FocusedMenuItem>[
                                FocusedMenuItem(
                                    title: Text(
                                      "Playing Song now",
                                      style: TextStyle(
                                          color: Colors.black),
                                    ),
                                    onPressed: () {}),
                                FocusedMenuItem(
                                    title: Text(
                                        "Playing Song Next",
                                        style: TextStyle(
                                            color: Colors.black)),
                                    onPressed: () {}),
                                FocusedMenuItem(
                                    title: Text(
                                        "I'll add this Song to the Queue",
                                        style: TextStyle(
                                            color: Colors.black)),
                                    onPressed: () {}),
                                FocusedMenuItem(
                                    title: Text(
                                        "Remove this suggestion",
                                        style: TextStyle(
                                            color: Colors.red)),
                                    onPressed: () {})
                              ])
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      Text("Single - Burna Boy",
                          style: TextStyle(
                              color: Colors.black,
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ])));
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
        itemCount: 10);
  }

  Widget getPlaylist(){
    Widget playlist = Container();
    Widget header = Container(
      padding: EdgeInsets.only(top: 50, left: 5, right: 5),
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("${event.image}"))),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(IconlyBold.arrow_left, color: Colors.white,),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context, builder:(context) => PopupWidget(
                          popup: Popup.playlistFilter,
                          height: 0.5,
                          callback: (SuggestionType value){
                            setState(() {
                              playlistType = value;
                            });
                            Navigator.pop(context);
                          },
                        )
                        );
                      },
                      icon: Icon(
                          IconlyBold.filter,
                          color: Colors.white,
                          size: 25
                      ))
              )
          )
        ],
      ),
    );
    switch (playlistType){
      case SuggestionType.Playlist:
        playlist = ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            header,
            SizedBox(height: 50),
            Text('Party Playlist'),
            SizedBox(height: 20),
            SongSuggestionList(
              title: "Currently Playing",
              event: event,
              suggestions: _getList('playing'),
              color: DarkPalette.lightBlue,
            ),
            SizedBox(height: 30),
            SongSuggestionList(
              title: "Up Next",
              event: event,
              suggestions: _getList('next'),
              color: DarkPalette.lightFushia,
            ),
            SizedBox(height: 30),
            SongSuggestionList(
              title: "Queued",
              event: event,
              suggestions: _getList('queued'),
              color: DarkPalette.darkGrey1,
              userType: UserType.partyOrganizer,
            )

          ],
        );
        break;
      case SuggestionType.Accepted:
        playlist = ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            header,
            SizedBox(height: 30),
            SongSuggestionList(
              title: "Accepted Suggested",
              event: event,
              suggestions: _getList('accepted'),
              color: DarkPalette.lightFushia,
              userType: UserType.partyOrganizer,
            )
          ],
        );
        break;
      case SuggestionType.New:
        playlist = ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            header,
            SizedBox(height: 30),
            SongSuggestionList(
              title: "Newly Suggested",
              event: event,
              suggestions: _getList('accepted'),
              color: DarkPalette.lightFushia,
              userType: UserType.partyOrganizer,
            )
          ],
        );
        break;
    }
    return playlist;
  }

}
