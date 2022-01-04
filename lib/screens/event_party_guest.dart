import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
import 'dart:math' as math;
import '../styles.dart';


class EventDetailPartyGuest extends StatefulWidget {
  static const String routeName = "/evetDetail";

  EventDetailPartyGuest({Key? key,
    this.userType = UserType.partyGuest,
    this.eventStatus = EventStatus.EventPending, required this.event})
      : super(key: key);

  UserType? userType;
  EventStatus? eventStatus;
  Event event;

  @override
  _EventDetailPartyGuest createState() => _EventDetailPartyGuest();
}

class _EventDetailPartyGuest extends State<EventDetailPartyGuest> {
  bool _showAttendees = false;
  bool _showAbout = false;
  List<Widget> _suggestionPlaylist = [];
  late String _timingTitle;
  Event get event=> widget.event;
  List allSuggestions = [];
  List guestSuggestions = [];

  @override
  void initState(){
    super.initState();

    _getSuggestion();
  }

  List _getFewSuggestion(){
    print(event.suggestions!.length);
    List temp = event.suggestions!;
    if(temp.length > 2){
      temp = temp.sublist(0, 3);
    }
    return temp;
  }

  _getSuggestion()async {
    ApiBaseHelper _api = ApiBaseHelper();
    List guestResponse = await _api.get("/event/${event.id}/suggestions/");
    print('guest suggestion');
    print(guestResponse);
    setState(() {
      guestSuggestions = guestResponse;
    });
  }
  Widget get _attendees => ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Map attendee = event.attendees[index];
        return Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:NetworkImage(attendee['profile_photo']?? ''),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${attendee['display_name']}",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text("Attendee",
                      style: TextStyle(
                        fontSize: 10,
                      ))
                ]),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: event.attendees.length
  );
  Widget get _timingBox => Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("",
              style: GoogleFonts.workSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w300
              )
            ),
            Text("24h: 30m",
              style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              )
            )
          ])
      );
  Widget get _backButton => IconButton(
    icon: Icon(IconlyBold.arrow_left),
    color: Colors.white,
    onPressed: () {
      setState(() {
        if (_showAttendees){
          _showAttendees = false;
        }
        if(_showAbout){
          _showAbout = false;
        }
      });
    },
  );
  Widget get _infoBox => IconButton(
    icon: Icon(IconlyBold.info_circle,
        size: 30),
    color: Colors.white,
    onPressed: () {
      setState(() {
        _showAbout = true;
      });
    },
  );


  @override
  Widget build(BuildContext context) {

    switch (widget.eventStatus!){
      case EventStatus.EventPending:{
        _timingTitle = "Starts in";
        _suggestionPlaylist = [
          SongSuggestionList(
            title: "All Suggestions",
            event: event,
            suggestions: _getFewSuggestion(),
            trailing: true,
          ),
          SizedBox(height: 50),
          SongSuggestionList(
            title: "Your Suggestions",
            event: event,
            suggestions: guestSuggestions,
            trailing: true,
          ),
        ];
      }
      break;
      case EventStatus.EventStarted:{
        _timingTitle = "Started";
        _suggestionPlaylist = [
          SongSuggestionList(
            title: "Currently Playing",
            event: event,
            suggestions: [],
          ),
          SizedBox(height: 30),
          SongSuggestionList(
            title: "Up Next",
            event: event,
            suggestions: [],
          ),
          SizedBox(height: 30),
          SongSuggestionList(
              title: "Queued",
              event: event,
              suggestions: [],
              trailing: true
          )
        ];
      }
      break;
      case EventStatus.EventEnded:{
        _timingTitle = "Event Ended";
        _suggestionPlaylist = [
          SongSuggestionList(
              title: "Event Playlist",
              event: event,
              suggestions: [],
              trailing: true
          )
        ];
      }
      break;
    }

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 5, right: 5),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${event.image}")
                  )
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      left: 2,
                      top: 30,
                      child:
                      (_showAttendees || _showAbout) ? _backButton : _timingBox),
                  Positioned(
                      right: 2,
                      top: 30,
                      child:
                      (_showAttendees || _showAbout) ? _timingBox : _infoBox),
                  Positioned(
                    right: 0,
                    bottom: -40,
                    child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) => Wrap(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(40.0),
                                          topRight: const Radius.circular(40.0),
                                        )),
                                    padding: EdgeInsets.only(
                                        top: 30, left: 20, right: 20, bottom: 20),
                                    height: MediaQuery.of(context).size.height * 0.7,
                                    child: SuggestSongForm(
                                      selectedEvent: event,
                                    )
                                  )
                                ]
                            ),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: DarkPalette.borderGradient1,
                          ),
                          child: Center(
                              child: widget.userType == UserType.partyOrganizer
                                  ? Image.asset("assets/images/music.png",
                                  height: 100, width: 100)
                                  : Icon(
                                IconlyBold.plus,
                                color: Colors.white,
                                size: 40,
                              )),
                        )),
                  ),
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width *  0.3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height:3,
                            )
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          '${event.name}'.capitalize(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(
                          "${event.renderDate()}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            NetworkImage("${event.organizer_display_picture}"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${event.organizer}',
                                  style: TextStyle(

                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 3),
                                Text("Organizer",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ))
                              ])
                        ],
                      ),
                      SizedBox(height: 20),
                      _showAttendees
                          ? _attendees
                          : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAttendeeToggle(),
                          Visibility(visible: _showAbout,
                              child: SizedBox(height: 50)),
                          Visibility(visible: _showAbout,
                              child:Text(
                                "About",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              )),
                          Visibility(visible: _showAbout,
                              child:SizedBox(height: 20)),
                          Visibility(visible: _showAbout,
                              child:Text(
                                  "${event.about}".capitalize())),
                          SizedBox(height: 30),
                          Visibility(
                              visible: !_showAbout,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [..._suggestionPlaylist],
                              ))
                        ],
                      )
                    ]))
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeToggle(){
    if(event.attendees.length == 0) return Container();

    Map attendee = event.attendees[0];

    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("${attendee['profile_picture']}"),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${attendee['display_name']}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text("Attendee",
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ]
        ),
        Spacer(),
        InkWell(
          onTap: () {
            setState(() {
              _showAttendees = true;
            });
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: DarkPalette.borderGradient1,
            ),
            child: Center(child: Text("+${event.attendees.length - 1}")),
          ),
        )
      ],
    );
  }
}

