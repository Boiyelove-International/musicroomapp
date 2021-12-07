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

enum SuggestionType { Accepted, All }
enum EventDetailViewType {
  DetailView,
  Atendeesview,
}
