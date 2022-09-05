import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserType { partyOrganizer, partyGuest }

class User {
  UserType userType;
  User(this.userType);
}

class RegistrationForm {
  UserType userType;
  String? email;
  String? password;
  String? nickname;

  RegistrationForm(this.userType);
}

enum SuggestionType { Accepted, All, New, Playlist }

enum EventDetailViewType {
  DetailView,
  Atendeesview,
  EventPending,
  EventStarted,
  EventEnded
}
enum EventStatus { EventPending, EventStarted, EventEnded }

class ProfileModel extends ChangeNotifier {
  String display_name = "";
  String email = "";

  void getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  void setDisplayName(String displayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("display_name", displayName);
    notifyListeners();
  }
}

class SongModel {
  String title;
  String previewUrl;
  String artist;
  String album_art;
  String apple_song_id;

  SongModel(
      {required this.title,
      required this.artist,
      required this.album_art,
      required this.previewUrl,
      required this.apple_song_id});
}

class Event {
  int id;
  String? organizer_display_picture;
  String? created;
  String? modified;
  String? name;
  String? about;
  TimeOfDay event_time;
  DateTime event_date;
  String? image;
  String? code;
  String? organizer;
  String? startsIn;
  List attendees = [];
  List? suggestions = [];
  int suggestersCount = 0;

  Event({
    required this.id,
    this.organizer_display_picture,
    required this.about,
    required this.name,
    this.modified,
    required this.created,
    required this.event_time,
    required this.event_date,
    required this.image,
    required this.code,
    required this.organizer,
    required this.attendees,
    this.startsIn,
    this.suggestions,
    required this.suggestersCount,
  });
  String renderDate() {
    return DateFormat("dd MMMM, yyy").format(this.event_date).toString();
  }

  factory Event.fromJson(Map<String, dynamic> data) {
    log("event data is $data");
    String s = data["event_time"];
    // 2022-08-31T00:00:00.000000Z,
    //,
    // event_date:

    log("${DateTime.parse(data['event_date'])}");

    TimeOfDay EventTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    DateTime EventDate = DateTime.parse(data['event_date'])
        .add(Duration(hours: EventTime.hour, minutes: EventTime.minute))
        .toLocal();
    log("Datetime of event is $EventDate");
    var something = new DateFormat("dd MMMM, yyyy").format(EventDate);
    log("Formatted date is $something");

    // log("Formatted Datetime of event is $EventDate");

    // EventDate = DateTime.utc(EventDate.year, EventDate.month, EventDate.day,
    //     .toLocal();

    log("Datetime of event is $EventDate");

    EventTime = TimeOfDay.fromDateTime(EventDate);
    log("time of day is $EventTime");

    // event_time =
    // data is {'id': 2,
    // 'organizer_display_picture': None,
    // 'created': '2021-12-21T13:15:06.019476Z',
    // 'modified': '2021-12-21T13:15:06.023665Z',
    // 'name': 'dfghjhgfdsaw',
    // 'about': 'ertgyhjkjhgfdsa',
    // 'event_time': '09:37:00',
    // 'event_date': '2022-08-31T00:00:00.000000Z',
    // 'image': '/media/event_images/IMG_0003.jpeg',
    // 'code': 'ABCD',
    // 'organizer': 9,
    // 'attendees': [],
    // 'suggestions': []}

    DateTime _now = DateTime.now();
    int inMinutes = EventDate.difference(_now).inMinutes;
    int inHours = EventDate.difference(_now).inHours;
    if (inHours < 0) inHours = 0;
    if (inMinutes < 0) inMinutes = 0;
    // print("${_now.day} -- ${_now.hour} -- ${_now.minute}");
    // print("Date time ${_event_date.toString()} >>> ${_event_date.difference(_now).inHours}");
    String startsIn = "${inHours}h: ${(inMinutes - (inHours * 60)).abs()}m";

    return Event(
        id: data["id"],
        about: data["about"],
        organizer_display_picture: data["organizer_display_picture"],
        name: data["name"],
        // modified: data["modified"],
        created: data["created"],
        event_time: EventTime,
        event_date: EventDate,
        image: data["image"],
        code: data["code"],
        startsIn: startsIn,
        organizer: data["organizer"].toString(),
        attendees: data["attendees"] ?? [],
        suggestions: data["suggestions"] ?? [],
        suggestersCount: 0 //int.parse(data["suggesters_count"].toString()),
        );
  }

  Future<bool> joinEvent() async {
    ApiBaseHelper _api = ApiBaseHelper();
    Map<String, dynamic> response =
        await _api.post("/event/join/", {"event_code": this.code});
    if (response["joined"] == true) {
      return true;
    }
    return false;
  }

  Future<Event> refreshData() async {
    ApiBaseHelper _api = ApiBaseHelper();
    Map<String, dynamic> response = await _api.get("/event/${this.id}/");
    return Event.fromJson(response);
  }
}
