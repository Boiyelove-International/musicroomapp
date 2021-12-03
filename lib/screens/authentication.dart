import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/models.dart';

import '../routes.dart';

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
  late Widget _registrationForm;

  @override
  Widget build(BuildContext context) {
    final _userType = ModalRoute.of(context)!.settings.arguments;
    switch (_userType) {
      case UserType.partyOrganizer:
        {
          _registrationForm = Container();
        }
        break;
      case UserType.partyGuest:
        {
          _registrationForm = Container();
        }
        break;
    }

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Let's get you setup",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(
            'Kindly provide the necessary details to get your account up and running'),
        SizedBox(height: 30),
        TextFormField(
          controller: _organizerName,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _organizerName.value = TextEditingValue(
                text: value.trim(), selection: _organizerName.selection);
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
            labelText: "DJ/Event Organizer Name",
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: _emailController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _emailController.value = TextEditingValue(
                text: value.trim(), selection: _emailController.selection);
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
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: _passwordController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _passwordController.value = TextEditingValue(
                text: value.trim(), selection: _passwordController.selection);
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
            labelText: "Password",
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0)
              ],
              gradient: DarkPalette.borderGradient1,
              // color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(50, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                // elevation: MaterialStateProperty.all(3),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text("Sign Up",
                    style: TextStyle(color: DarkPalette.darkDark)),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "OR",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google_icon.png"),
            SizedBox(
              width: 30,
            ),
            Image.asset("assets/images/facebook_icon.png"),
            SizedBox(
              width: 30,
            ),
            Image.asset("assets/images/apple_icon.png"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?"),
            SizedBox(width: 10),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                child: Text("Sign In")),
            SizedBox(width: 10),
            Text("to continue")
          ],
        )
      ],
    )));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Welcome Back",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(
            'Kindly provide the necessary details to get your account up and running'),
        SizedBox(height: 30),
        TextFormField(
          controller: _emailController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _emailController.value = TextEditingValue(
                text: value.trim(), selection: _emailController.selection);
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
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: _passwordController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _passwordController.value = TextEditingValue(
                text: value.trim(), selection: _passwordController.selection);
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
                child: Text("Forgot Password?")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0)
              ],
              gradient: DarkPalette.borderGradient1,
              // color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(50, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                // elevation: MaterialStateProperty.all(3),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.home);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text("Sign In",
                    style: TextStyle(color: DarkPalette.darkDark)),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "OR",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google_icon.png"),
            SizedBox(
              width: 20,
            ),
            Image.asset("assets/images/facebook_icon.png"),
            SizedBox(
              width: 20,
            ),
            Image.asset("assets/images/apple_icon.png"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?"),
            SizedBox(width: 5),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.decision);
                },
                child: Text("Sign Up")),
            SizedBox(width: 5),
            Text("to continue")
          ],
        )
      ],
    )));
  }
}

class ForgotPassword extends StatefulWidget {
  static const String routeName = "/forgotPassword";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
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
        TextFormField(
          controller: _emailController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _emailController.value = TextEditingValue(
                text: value.trim(), selection: _emailController.selection);
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
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: InkWell(
            onTap: () {},
            child: Ink(
              decoration: const BoxDecoration(
                gradient: DarkPalette.borderGradient1,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 13, bottom: 13.0),
                constraints: BoxConstraints(
                    minWidth: 88.0,
                    minHeight: 36.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: Text(
                  'OK',
                  style: TextStyle(color: DarkPalette.darkDark),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ))
        ]),
        SizedBox(height: 20),
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
    )));
  }
}
