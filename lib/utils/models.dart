import 'package:change_notifier/change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserType { partyOrganizer, partyGuest }
const String baseUrl = "https://musicroomweb.herokuapp.com/api";

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
  SongModel({
    required this.title, required this.artist, required this.album_art, required this.previewUrl
    });
}
