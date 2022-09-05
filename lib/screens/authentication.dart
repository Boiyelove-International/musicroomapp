import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../routes.dart';
import '../utils.dart';
import 'buttons.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/RegisterScreen';
  RegisterScreen({Key? key, this.userType}) : super(key: key);

  UserType? userType;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _organizerName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _showPassword = false;

  _register() async {
    setState(() {
      isLoading = true;
    });
    ApiBaseHelper api = ApiBaseHelper();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    try {
      api
          .post(
              "/register/",
              <String, String>{
                "display_name": _organizerName.text,
                "email": _emailController.text,
                "username": _emailController.text,
                "password": _passwordController.text
              },
              context: context)
          .then((value) {
        Navigator.of(context).pushNamed(Routes.login);
        print("value is $value");
      }).onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
      });

      if (_formKey.currentState!.validate()) {}
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // print("error is $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;

    return Scaffold(
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _organizerName,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        _organizerName.value = TextEditingValue(
                            text: value.trim(),
                            selection: _organizerName.selection);
                      },
                      validator: (value) =>
                          value!.isEmpty ? "Cannot be empty" : null,
                      // textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.4)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7))),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.7)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(16),
                        labelText: "Host",
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      onChanged: (value) {
                        _emailController.value = TextEditingValue(
                            text: value.trim(),
                            selection: _emailController.selection);
                      },
                      validator: (value) =>
                          value!.isEmpty ? "Cannot be empty" : null,
                      // textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.4)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7))),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.7)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(16),
                        labelText: "Email Address",
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      // textCapitalization: TextCapitalization.characters,
                      onChanged: (value) {
                        _passwordController.value = TextEditingValue(
                            text: value.trim(),
                            selection: _passwordController.selection);
                      },
                      validator: (value) =>
                          value!.isEmpty ? "Cannot be empty" : null,
                      // textAlign: TextAlign.center,
                      obscureText: !_showPassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            print("show passwoerd is $_showPassword");
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.4)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7))),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.7)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(16),
                        labelText: "Password",
                      ),
                    ),
                    SizedBox(height: 30),
                    GoldButton(
                        isLoading: isLoading,
                        onPressed: _register,
                        buttonText: "Sign Up"),
                    SizedBox(height: 50),
                    Text(
                      "OR",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image.asset("assets/images/google_icon.png"),
                          onTap: () {
                            _googleSocialLogin();
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          child: Image.asset("assets/images/facebook_icon.png"),
                          onTap: _facebookSocialLogin,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          child: Image.asset("assets/images/apple_icon.png"),
                          onTap: _appleSocialLogin,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.login);
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.workSans(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        Text("to continue",
                            style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w300, fontSize: 16))
                      ],
                    )
                  ],
                ))));
  }

  _appleSocialLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'uk.co.musicalroom.musicalroom',
          redirectUri: Uri.parse(
            'https://app.musicalroom.co.uk/webhooks/signin_with_apple/',
          ),
        ),
      );

      print("credential =>>>>> $credential");
      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      String name = "";
      // if (name.isNotEmpty && credential.familyName != null) {
      //   name += " ";
      //   name += credential.familyName ?? "";
      // } else {
      //   name += credential.familyName ?? "";
      // }

      if (credential.givenName != null && credential.familyName != null) {
        name = credential.givenName! + " " + credential.familyName!;
      } else if (credential.givenName == null ||
          credential.familyName == null) {
        if (credential.givenName != null) {
          name = credential.givenName!;
        } else if (credential.familyName != null) {
          name = credential.familyName!;
        }
      }
      print("name is >>>>>>>>>>> $name");
      Map<String, dynamic> payload = {
        "auth_token": credential.authorizationCode,
        "id_token": credential.identityToken,
        "email": credential.email,
        "name": name,
        "social": "apple"
      };

      _login(payload);
    } catch (e) {
      print("E ============> $e");
    }
  }

  _facebookSocialLogin() async {
    // final facebookLogin = FacebookLogin();
    // final result = await facebookLogin.logIn(['email']);

    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print("facebook accessToken is =====> ${accessToken.toJson()}");
      print("facebook Token is =====> ${accessToken.token}");
      print("facebook Token is =====> ${accessToken.userId}");
    } else {
      print("facebook login status is =====> ${result.status}");
      print("facebook login message is =====> ${result.message}");
    }

    switch (result.status) {
      case LoginStatus.success:
        print(result);
        _getFacebookDetails(result.accessToken!);
        break;
      case LoginStatus.cancelled:
        print('was canceled');
        break;
      case LoginStatus.failed:
        print("Facebook error");
        break;
    }
  }

  _getFacebookDetails(AccessToken accessToken) async {
    setState(() {
      isLoading = true;
    });
    try {
      final token = accessToken;
      final graphResponse = await http.get(Uri.parse(
          "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${accessToken.token}"));
      final profile = jsonDecode(graphResponse.body);
      print(profile);
      Map<String, dynamic> payload = {
        "access_token": accessToken.token,
        "id_token": accessToken.userId,
        "email": profile['email'],
        "name": profile['first_name'] + ' ' + profile['last_name'],
        "image_url": profile['picture']['data']['url'],
        "social": "facebook"
      };

      _login(payload);
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  _googleSocialLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    setState(() {
      isLoading = true;
    });

    try {
      GoogleSignInAccount? data = await _googleSignIn.signIn();
      GoogleSignInAuthentication? userCredential = await data?.authentication;

      print("Access Token >> ${userCredential?.accessToken}");
      print("ID Token >> ${userCredential?.idToken}");
      print("data $data");
      print(data?.id);

      Map<String, dynamic> payload = {
        "access_token": userCredential?.accessToken,
        "id_token": userCredential?.idToken,
        "email": data?.email,
        "name": data?.displayName,
        "image_url": data?.photoUrl,
        "social": "google"
      };

      _login(payload);
    } catch (error) {
      print("an error occured: $error");
    }
    setState(() {
      isLoading = false;
    });
  }

  _login(Map<String, dynamic> payload) async {
    setState(() {
      isLoading = true;
    });

    ApiBaseHelper api = ApiBaseHelper();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    try {
      api.post("/login/", payload, context: context).then((data) async {
        print("value is $data");
        await prefs.setString("token", data["token"]);
        await prefs.setString("email", data["email"]);
        await prefs.setString("display_name", data["display_name"]);
        await prefs.setInt("userType", 1);
        await prefs.setBool("userLoggedIn", true);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.organizerHome, (Route<dynamic> route) => false);
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("error is $e");
    }
  }
}

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _emailController.text = "roland@boiyelove.website";
    // _passwordController.text = "somepassword";
  }

// G4EBA0

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Welcome Back",
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w700, textStyle: headline4)),
        SizedBox(height: 20),
        Text(
            'Kindly provide the necessary details to  return to your activities',
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300, fontSize: 16, height: 1.8)),
        SizedBox(height: 60),
        TextFormField(
          controller: _emailController,
          // textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _emailController.value = TextEditingValue(
                text: value.trim(), selection: _emailController.selection);
          },
          validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(16),
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: 40),
        TextFormField(
          controller: _passwordController,
          // textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _passwordController.value = TextEditingValue(
                text: value.trim(), selection: _passwordController.selection);
          },
          validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
          obscureText: !_showPassword,
          autocorrect: false,
          enableSuggestions: false,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(16),
            labelText: "Password",
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.forgotPassword);
                },
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white),
                )),
          ],
        ),
        SizedBox(height: 10),
        GoldButton(
            buttonText: "Sign In",
            isLoading: isLoading,
            onPressed: () {
              _login({
                "username": _emailController.text.toLowerCase(),
                "password": _passwordController.text
              });
            }),
        SizedBox(height: 50),
        Text(
          "OR",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _googleSocialLogin();
              },
              child: Image.asset("assets/images/google_icon.png"),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: Image.asset("assets/images/facebook_icon.png"),
              onTap: _facebookSocialLogin,
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: Image.asset("assets/images/apple_icon.png"),
              onTap: _appleSocialLogin,
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w300, fontSize: 16)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.decision, (Route<dynamic> route) => false);
                },
                child: Text("Sign Up",
                    style: GoogleFonts.workSans(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            Text("to continue",
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w300, fontSize: 16))
          ],
        )
      ],
    )));
  }

  _appleSocialLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'uk.co.musicalroom.musicalroom',
          redirectUri: Uri.parse(
            'https://app.musicalroom.co.uk/webhooks/signin_with_apple/',
          ),
        ),
      );

      print("credential =>>>>> $credential");
      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      String name = "";
      // if (name.isNotEmpty && credential.familyName != null) {
      //   name += " ";
      //   name += credential.familyName ?? "";
      // } else {
      //   name += credential.familyName ?? "";
      // }

      if (credential.givenName != null && credential.familyName != null) {
        name = credential.givenName! + " " + credential.familyName!;
      } else if (credential.givenName == null ||
          credential.familyName == null) {
        if (credential.givenName != null) {
          name = credential.givenName!;
        } else if (credential.familyName != null) {
          name = credential.familyName!;
        }
      }
      print("name is >>>>>>>>>>> $name");
      Map<String, dynamic> payload = {
        "auth_token": credential.authorizationCode,
        "id_token": credential.identityToken,
        "email": credential.email,
        "name": name,
        "social": "apple"
      };

      _login(payload);
    } catch (e) {
      print("E ============> $e");
    }
  }

  _facebookSocialLogin() async {
    //     FacebookAuth.instance
    //     .login(permissions: ["public_profile", "email"]).then((value) {
    //   FacebookAuth.instance.getUserData().then((userData) {
    //     print("userData =====> $userData");
    //   });
    // });
    // if (kIsWeb) {
    //   // initialiaze the facebook javascript SDK
    //   await FacebookAuth.i.webInitialize(
    //     appId: "471028527989498",
    //     cookie: true,
    //     xfbml: true,
    //     version: "v13.0",
    //   );
    // }
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
    } else {
      print(result.status);
      print(result.message);
    }
    // final facebookLogin = FacebookLogin();
    // final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case LoginStatus.success:
        print(result);
        _getFacebookDetails(result.accessToken!);
        break;
      case LoginStatus.cancelled:
        print('was canceled');
        break;
      case LoginStatus.failed:
        print("Facebook error");
        break;
    }
  }

  _getFacebookDetails(AccessToken accessToken) async {
    setState(() {
      isLoading = true;
    });
    try {
      final token = accessToken.token;
      final graphResponse = await http.get(Uri.parse(
          "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${accessToken.token}"));
      final profile = jsonDecode(graphResponse.body);
      print(profile);
      Map<String, dynamic> payload = {
        "access_token": accessToken.token,
        "id_token": accessToken.userId,
        "email": profile['email'],
        "name": profile['first_name'] + ' ' + profile['last_name'],
        "image_url": profile['picture']['data']['url'],
        "social": "facebook"
      };

      _login(payload);
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  _googleSocialLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    setState(() {
      isLoading = true;
    });

    try {
      GoogleSignInAccount? data = await _googleSignIn.signIn();
      GoogleSignInAuthentication? userCredential = await data?.authentication;

      print("Access Token >> ${userCredential?.accessToken}");
      print("ID Token >> ${userCredential?.idToken}");
      print(data?.id);

      Map<String, dynamic> payload = {
        "access_token": userCredential?.accessToken,
        "id_token": userCredential?.idToken,
        "email": data?.email,
        "name": data?.displayName,
        "image_url": data?.photoUrl,
        "social": "google"
      };

      _login(payload);
    } catch (error) {
      print(error);
    }
    setState(() {
      isLoading = false;
    });
  }

  _login(Map<String, dynamic> payload) async {
    setState(() {
      isLoading = true;
    });

    print("login started");

    ApiBaseHelper api = ApiBaseHelper();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    try {
      api.post("/login/", payload, context: context).then((data) async {
        print("value is $data");
        await prefs.setString("token", data["token"]);
        await prefs.setString("email", data["email"]);
        await prefs.setString("display_name", data["display_name"]);
        await prefs.setBool("userLoggedIn", true);
        await prefs.setInt("userType", 1);
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.organizerHome, (Route<dynamic> route) => false);
      }).onError((error, stackTrace) {
        print("error is ===> $error");
        print("stackTrace is ===>  $stackTrace");
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      // print("error is ===> ${e}");
      // print("stackTrace is ===>  ${stackTrace}");
      setState(() {
        isLoading = false;
      });
      print("error is $e");
    }

    print("login started");
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}

class ForgotPassword extends StatefulWidget {
  static const String routeName = "/forgotPassword";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  PageController _forgotPasswordPageController = PageController(initialPage: 0);

  bool _showPassword = false;
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  bool _isLoading = false;

  static final _emailFormKey = GlobalKey<FormState>();
  static final _resetCodeFormKey = GlobalKey<FormState>();
  static final _newPasswordFormKey = GlobalKey<FormState>();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _codeFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _codeFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  _submitFPData() async {
    if (_newPasswordFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      log("code is ${_codeController.text}");
      log("code is ${_emailController.text}");
      await ApiBaseHelper()
          .post(
              "/forgot-password/change_password/",
              {
                "email": _emailController.text,
                "code": _codeController.text,
                "new_password": _passwordController.text
              },
              context: context)
          .then((value) {
        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text(
            'Your password has been updated successfully. Kindly login',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pushReplacementNamed(Routes.login);

        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  _requestPasswordReset() async {
    if (_emailFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      log("code is ${_codeController.text}");
      log("code is ${_emailController.text}");
      await ApiBaseHelper()
          .post(
        "/forgot-password/send_code/",
        {
          "email": _emailController.text,
        },
        context: context,
      )
          .then((value) {
        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text(
            'A password reset code has been sent to your inbox',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ));
        //go to next page

        _forgotPasswordPageController.nextPage(
            curve: Curves.easeIn, duration: Duration(milliseconds: 350));
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        log("${error.toString()}");
        log("${stackTrace.toString()}");
      });
    }
  }

  _submitRequestCode() async {
    if (_resetCodeFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await ApiBaseHelper()
          .post("/forgot-password/verify_code/",
              {"email": _emailController.text, "code": _codeController.text},
              context: context)
          .then((value) {
        //go to next page
        _forgotPasswordPageController.nextPage(
            curve: Curves.easeIn, duration: Duration(milliseconds: 350));
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        log("${error.toString()}");
        log("${stackTrace.toString()}");
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _page1 = ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      shrinkWrap: true,
      children: [
        Text("Forgot Password?",
            style: GoogleFonts.workSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 20),
        Text(
            'Having issues signing in to your account? provide your email and let’s fix this issue. '),
        SizedBox(height: 30),
        Form(
          key: _emailFormKey,
          child: TextFormField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            onChanged: (value) {
              _emailController.value = TextEditingValue(
                  text: value.trim(), selection: _emailController.selection);
            },
            validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
            // textAlign: TextAlign.center,
            // autofocus: true,
            decoration: new InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.all(16),
              labelText: "Email Address",
            ),
          ),
        ),
        SizedBox(height: 30),
        GoldButton(
            isLoading: _isLoading,
            onPressed: _requestPasswordReset,
            buttonText: "Get Password Reset Code"),
        SizedBox(height: 20),
        TextButton(
            onPressed: () {
              if (_emailFormKey.currentState!.validate()) {
                _forgotPasswordPageController.nextPage(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeIn);
              }
            },
            child: Text("I already have a reset code")),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Remember your details? Go back to ",
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                child: Text("Log In")),
          ],
        )
      ],
    );
    Widget _page2 = ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 20, right: 20),
      children: [
        Text("Forgot Password?",
            style: GoogleFonts.workSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 20),
        Text('Enter the code you received below'),
        SizedBox(height: 30),
        Form(
          key: _resetCodeFormKey,
          child: TextFormField(
            focusNode: _codeFocusNode,
            controller: _codeController,
            onChanged: (value) {
              _codeController.value = TextEditingValue(
                  text: value.trim(), selection: _codeController.selection);
            },

            validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
            // textAlign: TextAlign.center,
            decoration: new InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.all(16),
              labelText: "Forgot Password Reset Code",
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(height: 30),
        GoldButton(
            isLoading: _isLoading,
            onPressed: _submitRequestCode,
            buttonText: "Verify"),
        SizedBox(height: 30),
        TextButton(
            onPressed: () {
              _codeController.text = '';
              _forgotPasswordPageController.previousPage(
                  curve: Curves.easeIn, duration: Duration(milliseconds: 350));
            },
            child: Text("Start Over")),
      ],
    );
    Widget _page3 = ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Set Your New Password",
            style: GoogleFonts.workSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 30),
        SizedBox(height: 5),
        Text("""
Requirements
- Should contain at least one upper case \n
- Should contain at least one lower case \n
- Should contain at least one digit \n 
- Should contain at least one Special character \n
- Must be at least 8 characters in length. 
        """),
        SizedBox(height: 20),
        Form(
          key: _newPasswordFormKey,
          child: TextFormField(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            validator: (value) {
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              } else {
                if (!regex.hasMatch(value)) {
                  return 'Enter valid password';
                } else {
                  return null;
                }
              }
            },
            obscureText: !_showPassword,
            enableSuggestions: false,
            autocorrect: false,
            decoration: new InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  print("show passwoerd is $_showPassword");
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.all(16),
              labelText: "Password",
            ),
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: _passwordAgainController,
          validator: (value) {
            RegExp regex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            } else {
              if (!regex.hasMatch(value)) {
                return 'Enter valid password';
              } else {
                if (_passwordController.text != _passwordAgainController.text) {
                  return "Your passwords do not match";
                } else {
                  return null;
                }
              }
            }
          },
          obscureText: !_showPassword,
          enableSuggestions: false,
          autocorrect: false,
          decoration: new InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                print("show passwoerd is $_showPassword");
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(16),
            labelText: "Repeat Password",
          ),
        ),
        SizedBox(height: 30),
        GoldButton(
            isLoading: _isLoading,
            onPressed: _submitFPData,
            buttonText: "Submit New Password"),
        SizedBox(height: 20),
        SizedBox(height: 30),
        TextButton(
            onPressed: () {
              _codeController.text = '';
              _forgotPasswordPageController.previousPage(
                  curve: Curves.easeIn, duration: Duration(milliseconds: 350));
            },
            child: Text("Start Over")),
      ],
    );
    return Scaffold(
        body: SafeArea(
            child: PageView(
      onPageChanged: (int value) {
        log("page changed to  $value");
        switch (value) {
          case 0:
            _emailFocusNode.requestFocus();
            break;
          case 1:
            _codeFocusNode.requestFocus();
            break;
          case 2:
            _passwordFocusNode.requestFocus();
        }
      },
      physics: NeverScrollableScrollPhysics(),
      controller: _forgotPasswordPageController,
      children: [_page1, _page2, _page3],
    )));
  }
}

class RegisterPartyGuest extends StatefulWidget {
  static const routeName = "/registerPartyGuest";

  @override
  _RegisterPartyGuest createState() => _RegisterPartyGuest();
}

class _RegisterPartyGuest extends State<RegisterPartyGuest> {
  FilePickerResult? result;
  TextEditingController _displayNameController = TextEditingController();
  final _displayNameKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Time to party",
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w700, textStyle: headline4)),
        SizedBox(height: 20),
        Text(
            'Kindly provide the necessary details to  return to your activities',
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300, fontSize: 16, height: 1.8)),
        SizedBox(height: 60),
        Center(
            child: GestureDetector(
          onTap: () async {
            result = await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null) {
              setState(() {});
            } else {
              // User canceled the picker
            }
          },
          child: result == null
              ? CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/avatar_upload.png"),
                  radius: 50,
                )
              : Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                              File("${result!.files.single.path}"))))),
        )),
        SizedBox(height: 20),
        Text('Upload an image of yourself party style',
            textAlign: TextAlign.center,
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300, fontSize: 16, height: 1.8)),
        SizedBox(height: 30),
        Form(
            key: _displayNameKey,
            child: TextFormField(
              controller: _displayNameController,
              textCapitalization: TextCapitalization.characters,

              validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
              // textAlign: TextAlign.center,
              decoration: new InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white.withOpacity(0.7))),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.all(16),
                labelText: "Display Name",
              ),
            )),
        SizedBox(height: 30),
        GoldButton(
            isLoading: isLoading,
            onPressed: _registerGuest,
            buttonText: "Let's Party.")
      ],
    )));
  }

  _registerGuest() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    if (_displayNameKey.currentState!.validate()) {
      try {
        ApiBaseHelper api = ApiBaseHelper();
        var data = <String, dynamic>{
          "device_id": await getDeviceId(),
          "display_name": _displayNameController.text,
        };
        if (result != null) {
          Map image = {
            "file": base64Encode(
                File("${result!.files.single.path}").readAsBytesSync()),
            "filename": result!.files.single.path!.split("/").last
          };
          data["image"] = image;
        }

        api.post("/register/guest/", data).then((data) async {
          prefs.setString("display_name", _displayNameController.text);
          prefs.setBool("userLoggedIn", true);
          prefs.setInt("userType", 2);
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.guestHome, (Route<dynamic> route) => false);
        }).onError((error, stackTrace) {
          print("error is ===> $error");
          print("stackTrace is ===>  $stackTrace");
          setState(() {
            isLoading = false;
          });
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("error is $e");
      }
    }
  }
}
