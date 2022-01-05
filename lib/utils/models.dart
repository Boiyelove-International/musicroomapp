
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


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

enum SuggestionType {Accepted, All, New, Playlist}

enum EventDetailViewType {
  DetailView,
  Atendeesview,
  EventPending,
  EventStarted,
  EventEnded
}
enum EventStatus {
  EventPending,
  EventStarted,
  EventEnded
}

class ProfileModel extends ChangeNotifier{
  String display_name = "";
  String email = "";

  void getPrefItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  void setDisplayName(String displayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("display_name", displayName);
    notifyListeners();
  }

}

class SongModel{
  String title;
  String previewUrl;
  String artist;
  String album_art;
  String apple_song_id;

  SongModel({
    required this.title,
    required this.artist,
    required this.album_art,
    required this.previewUrl,
    required this.apple_song_id
    });
}

class Event{
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
  List attendees =  [];
  List? suggestions =[];
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
  String renderDate(){
    return DateFormat("dd MMMM, yyy").format(this.event_date).toString();
  }

  factory Event.fromJson(Map<String, dynamic> data){
    String s  = data["event_time"];
    TimeOfDay _event_time = TimeOfDay(hour:int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    DateFormat format = new DateFormat("yyy-mm-dd");
    DateTime _event_date = format.parse(data["event_date"]);
    _event_date = DateTime(_event_date.year, _event_date.month, _event_date.day, _event_time.hour, _event_time.minute);
    // event_time =
    // data is {'id': 2, 
    // 'organizer_display_picture': None, 
    // 'created': '2021-12-21T13:15:06.019476Z', 
    // 'modified': '2021-12-21T13:15:06.023665Z', 
    // 'name': 'dfghjhgfdsaw', 
    // 'about': 'ertgyhjkjhgfdsa', 
    // 'event_time': '09:37:00', 
    // 'event_date': '2021-12-21', 
    // 'image': '/media/event_images/IMG_0003.jpeg', 
    // 'code': 'ABCD', 
    // 'organizer': 9, 
    // 'attendees': [], 
    // 'suggestions': []}

    DateTime _now = DateTime.now();
    int inMinutes = _event_date.difference(_now).inMinutes;
    int inHours = _event_date.difference(_now).inHours;
    if(inHours < 0) inHours = 0;
    if(inMinutes < 0) inMinutes = 0;
    // print("${_now.day} -- ${_now.hour} -- ${_now.minute}");
    // print("Date time ${_event_date.toString()} >>> ${_event_date.difference(_now).inHours}");
    String startsIn = "${inHours}h: ${(inMinutes - (inHours*60)).abs()}m";



    return Event(
      id : data["id"],
      about: data["about"],
      organizer_display_picture: data["organizer_display_picture"],
      name: data["name"],
      // modified: data["modified"],
      created: data["created"],
      event_time: _event_time,
      event_date: _event_date,
      image: data["image"],
      code: data["code"],
      startsIn: startsIn,
      organizer: data["organizer"].toString(),
      attendees: data["attendees"]?? [],
      suggestions: data["suggestions"]?? [],
      suggestersCount: 0//int.parse(data["suggesters_count"].toString()),
    );
  }

  Future<bool> joinEvent() async{
    ApiBaseHelper _api = ApiBaseHelper();
    Map<String, dynamic> response = await _api.post("/event/join/",
        {"event_code": this.code});
    if (response["joined"] == true ){
      return true;
    }
    return false;
  }

}
