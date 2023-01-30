import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:musicroom/screens/playlist.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/screens/yourRoom.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';

import '../styles.dart';

class EventDetail extends StatefulWidget {
  static const String routeName = "/eventDetail";

  EventDetail(
      {Key? key,
      this.userType = UserType.partyGuest,
      this.url,
      this.data,
      required this.event})
      : super(key: key);

  UserType? userType;
  Map<dynamic, dynamic>? data;
  String? url;
  Event event;

  @override
  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  bool _showAttendees = false;
  bool _showAbout = false;
  late Widget _rightContext = Container();
  Event get _event => widget.event;
  Map _callbackData = {};

  set _event(Event value) {
    widget.event = value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.event.refreshData().then((Event refreshedData) {
      if (!identical(widget.event, refreshedData)) {
        setState(() {
          widget.event = refreshedData;
          _callbackData["shouldRefresh"] = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.userType) {
      case UserType.partyGuest:
        {
          _rightContext = _contextMenuDots;
          _showAbout = false;
        }
        break;
      case UserType.partyOrganizer:
        {
          _rightContext = _contextMenuDots;
          _showAbout = true;
        }
        break;
    }
    log("Event Date and Time is ${widget.event.event_date} ${widget.event.event_date}");
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
                      image: NetworkImage(_event.image ?? ''))),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      left: 2,
                      top: 30,
                      child: _showAttendees ? _backButton : _timingBox),
                  Positioned(
                      right: 2,
                      top: 30,
                      child: _showAttendees ? _timingBox : _rightContext),
                  Positioned(
                    right: 0,
                    bottom: -40,
                    child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(Routes.partyPlaylist);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PartyPlayList(event: _event)));
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: DarkPalette.borderGradient1,
                          ),
                          child: Center(
                              child: Image.asset("assets/images/music.png",
                                  height: 100, width: 100)),
                        )),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 3,
                        )),
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
                          '${_event.name}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(
                          "${DateFormat("dd MMMM, yyyy").format(_event.event_date)}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                _event.organizer_display_picture ?? ''),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "You",
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
                                SizedBox(height: 70),
                                Text(
                                  "Party Stats",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                            "suggestions are ${_event.suggestions}");
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => SuggestionScreen(
                                                suggestions:
                                                    _event.suggestions ?? [],
                                                title: "All Suggestion",
                                                event: _event,
                                                callBack:
                                                    _allSuggestionActionHandler)));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkGrey1,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/waving_hand.png",
                                              height: 30,
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                                "${_event.suggestions?.length ?? 0}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w900)),
                                            SizedBox(height: 15),
                                            Text(
                                              "Total Suggestions",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 8),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => SuggestionScreen(
                                                  suggestions: _event
                                                          .suggestions
                                                          ?.where((element) =>
                                                              element[
                                                                  'accepted'] ==
                                                              true)
                                                          .toList() ??
                                                      [],
                                                  title: "Accepted Suggestion",
                                                  event: _event,
                                                  callBack:
                                                      _allSuggestionActionHandler)));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              gradient:
                                                  DarkPalette.borderGradient1,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/thumbs_up.png",
                                                height: 30,
                                              ),
                                              SizedBox(height: 15),
                                              Text(_getAcceptedSuggestion(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                              SizedBox(height: 15),
                                              Text(
                                                "Accepted Suggestions",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          )),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 50),
                                Text(
                                  "About",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(height: 20),
                                Text("${_event.about}"),
                                SizedBox(height: 20),
                              ],
                            )
                    ]))
          ],
        ),
      ),
    );
  }

  _allSuggestionActionHandler(int suggestionId, bool action) async {
    print(action);
    Map<String, dynamic> payload = {
      "suggestion_id": suggestionId,
      "accept_suggestion": action
    };
    ApiBaseHelper _api = ApiBaseHelper();
    _api.patch("/event/${_event.id}/suggestions/", payload);
  }

  String _getAcceptedSuggestion() {
    int accepted = 0;
    accepted = _event.suggestions!
        .where((element) => element['accepted'] == 'accepted')
        .toList()
        .length;
    return accepted.toString();
  }

  Widget _buildAttendeeToggle() {
    if (_event.attendees.length == 0) return Container();

    Map attendee = _event.attendees[0];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${attendee['display_name']}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text("Attendee",
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ]),
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
            child: Center(child: Text("+${_event.attendees.length - 1}")),
          ),
        )
      ],
    );
  }

  Widget get _attendees => ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Map attendee = _event.attendees[index];
        return Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(attendee['profile_photo'] ?? ''),
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
      itemCount: _event.attendees.length);
  Widget get _timingBox => Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Starts in"), Text("${_event.startsIn}")]));

  Widget get _backButton => IconButton(
        icon: Icon(IconlyBold.arrow_left),
        color: Colors.white,
        onPressed: () {
          setState(() {
            _showAttendees = false;
          });
        },
      );

  toggleEditEvent() {
    showModalBottomSheet<void>(
            builder: (BuildContext context) => Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                height: MediaQuery.of(context).size.height * 0.6,
                child: CreateEventForm(
                  event: _event,
                  callback: (Event updateEvent) {
                    setState(() {
                      _event = updateEvent;
                    });
                    Navigator.pop(context);
                  },
                )),
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true)
        .whenComplete(() {});
  }

  _deleteEvent() async {
    ApiBaseHelper _api = ApiBaseHelper();
    _api.delete("/event/${_event.id}/", {});
    _callbackData["rm_event"] = _event.id;
    Navigator.pop(context, _callbackData);
  }

  Widget get _contextMenuDots => FocusedMenuHolder(
          openWithTap: true,
          menuWidth: MediaQuery.of(context).size.width * 0.4,
          child: Icon(Icons.more_vert, color: Colors.white, size: 50),
          onPressed: () {},
          menuItems: <FocusedMenuItem>[
            FocusedMenuItem(
                title: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      "Share Event",
                      style: TextStyle(color: Colors.black),
                    )),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YourRoom(
                            event: _event,
                          )));
                }),
            FocusedMenuItem(
                title:
                    Text("Edit Event", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  toggleEditEvent();
                }),
            FocusedMenuItem(
                title:
                    Text("Delete Event", style: TextStyle(color: Colors.red)),
                onPressed: _deleteEvent)
          ]);
}
