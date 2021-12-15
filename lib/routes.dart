import 'package:musicroom/main.dart';
import 'package:musicroom/screens/advert.dart';
import 'package:musicroom/screens/authentication.dart';
import 'package:musicroom/screens/events.dart';
import 'package:musicroom/screens/home.dart';
import 'package:musicroom/screens/notifications.dart';
import 'package:musicroom/screens/playlist.dart';
import 'package:musicroom/screens/premium.dart';
import 'package:musicroom/screens/profile.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/screens/yourRoom.dart';

class Routes {
  // static String splash = OnBoardingPage.routeName;
  static String onboarding = OnBoardingPage.routeName;
  static String organizerHome = EventOrganizerHome.routeName;
  static String guestHome = PartyGuestHome.routeName;
  static String decision = DecisionPage.routeName;
  static String registerOrganizer = RegisterScreen.routeName;
  static String login = LoginScreen.routeName;
  static String forgotPassword = ForgotPassword.routeName;
  static String notifications = NotificationScreen.routeName;
  static String search = SearchResultScreen.routeName;
  static String eventDetail = EventDetail.routeName;
  static String allSuggestions = SuggestionScreen.routeName;
  static String acceptedSuggestions = "/acceptedSuggestions";
  static String partyPlaylist =PartyPlayList.routeName;
  static String profile = ProfileScreen.routeName;
  static String yourRoom = YourRoom.routeName;
  static String advert = Advert.routeName;
  static String premium = PremiumScreen.routeName;
  static String subscription = SubscriptionScreen.routeName;
  static String registerPartyGuest =  RegisterPartyGuest.routeName;
}
