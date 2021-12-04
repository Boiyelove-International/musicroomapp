import 'package:musicroom/main.dart';
import 'package:musicroom/screens/authentication.dart';
import 'package:musicroom/screens/events.dart';
import 'package:musicroom/screens/home.dart';
import 'package:musicroom/screens/notifications.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/screens/suggestion_list.dart';

class Routes {
  // static String splash = OnBoardingPage.routeName;
  static String onboarding = OnBoardingPage.routeName;
  static String home = HomeScreen.routeName;
  static String decision = DecisionPage.routeName;
  static String registerOrganizer = RegisterScreen.routeName;
  static String login = LoginScreen.routeName;
  static String forgotPassword = ForgotPassword.routeName;
  static String notifications = NotificationScreen.routeName;
  static String search = SearchResultScreen.routeName;
  static String eventDetail = EventDetail.routeName;
  static String allSuggestions = SuggestionScreen.routeName;
  static String acceptedSuggestions = "/acceptedSuggestions";
}
